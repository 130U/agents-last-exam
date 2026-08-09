# UniPat 动态粒子散点背景复刻报告

更新日期：2026-08-03  
目标页面：[UniPat Join Us](https://unipat.ai/joinus)  
目标脚本：[particles.js](https://cdn.unipat.ai/static/js/particles.js?v=bf17abbc)

## 1. 结论先行

这个效果不是数据可视化意义上的“动态散点图”，而是一个 **Three.js/WebGL 粒子点云 Morph 系统**：约 4,000 个点在“随机散开、文字轮廓、Logo 轮廓”几组目标坐标之间插值，同时叠加缓慢漂浮、鼠标排斥、相机视差、滚动淡出和跨页面状态衔接。

推荐采用以下方案复刻：

- 页面框架：Sites 默认的 React/Vinext 站点结构。
- 图形层：`three@0.160.0`，与目标站公开脚本的 Three.js 修订版一致。
- 渲染对象：一个 `THREE.Points`，不是 4,000 个 DOM 节点，也不是 4,000 个独立 Mesh。
- 数据结构：`Float32Array + BufferGeometry`。
- 形状来源：离屏 Canvas 渲染文字或图片，再进行像素采样。
- 动画方式：`requestAnimationFrame` 驱动状态机和逐粒子插值。
- 交互方式：鼠标坐标投射到 Three.js 世界坐标的 `z=0` 平面，再运行弹簧—阻尼排斥模型。
- 页面集成：粒子 Canvas 固定在最底层，正文保持正常语义化 HTML。
- 无障碍：必须补上目标站当前脚本没有显式实现的 `prefers-reduced-motion` 降级。

第一版不要上自定义 Shader。4,000 点的 CPU 更新和单次 `Points` draw call 足以达到相近效果；只有性能测试不达标时，才把漂浮或 Morph 迁移到 GPU Shader。

## 2. 已确认的原站实现

### 2.1 渲染环境

原站运行时结构：

```text
body
├── canvas：position: fixed，铺满视口，z-index: 0
├── header：position: relative，z-index: 1
├── main：position: relative，z-index: 1
└── footer：position: relative，z-index: 1
```

核心 Three.js 配置：

| 项目 | 原站参数 |
| --- | ---: |
| Three.js | r160 |
| 粒子数 | 4,000 |
| 相机 | `PerspectiveCamera(55, aspect, 0.1, 1000)` |
| 相机 Z | 130 |
| 粒子尺寸 | 1.4 |
| 粒子透明度 | 0.70 |
| 像素比上限 | `min(devicePixelRatio, 2)` |
| Canvas | WebGL、透明背景、抗锯齿 |
| 最大帧步长 | 0.05 秒 |

Three.js 官方定义中，`Points` 用一份 `BufferGeometry` 和一个材质显示点云；`BufferGeometry` 通过连续缓冲区保存顶点属性，正适合这类批量粒子更新：[Points](https://threejs.org/docs/pages/Points.html)、[BufferGeometry](https://threejs.org/docs/pages/BufferGeometry.html)、[PointsMaterial](https://threejs.org/docs/pages/PointsMaterial.html)。

### 2.2 粒子数据

对每个粒子，原站至少维护下面几层数据：

```ts
position  // 最终发送给 GPU 的位置 = base + repulsion
base      // 当前纯形状位置，不含鼠标扰动
source    // 本次 Morph 的起点
target    // 本次 Morph 的终点
delay     // 单粒子错峰延迟
color     // RGB
repX/Y    // 鼠标排斥造成的附加位移
repVX/VY  // 排斥位移的速度
```

建议继续使用 Typed Array：

```ts
const position = new Float32Array(count * 3);
const base     = new Float32Array(count * 3);
const source   = new Float32Array(count * 3);
const target   = new Float32Array(count * 3);
const color    = new Float32Array(count * 3);
const delay    = new Float32Array(count);
const repX     = new Float32Array(count);
const repY     = new Float32Array(count);
const repVX    = new Float32Array(count);
const repVY    = new Float32Array(count);
```

这样有三个好处：

1. 内存连续，适合每帧顺序扫描。
2. 可以直接作为 `THREE.BufferAttribute` 的底层数据。
3. 不会每帧创建成千上万个 `{x, y, z}` 对象并触发垃圾回收。

### 2.3 状态循环

桌面端目标状态：

```text
scatter → UniPat → scatter → logo → scatter → AI → repeat
```

移动端目标状态：

```text
scatter → logo → scatter → AI → repeat
```

原站参数：

```ts
desktopSequence = [0, 1, 0, 3, 0, 5];
desktopTimes    = [3.5, 8.0, 3.0, 8.0, 3.0, 8.0];
mobileSequence  = [0, 3, 0, 5];
mobileTimes     = [3.5, 8.0, 3.0, 8.0];
transitionTime  = 3.2;
maxDelay        = 0.38;
```

这里有一个复刻时值得修正的细节：原站同一个 `stateTimer` 同时覆盖变形时间和稳定展示时间。因此“8 秒”实际包含 3.2 秒变形；而“3 秒 scatter”可能刚完成变形就进入下一状态。建议我们的实现拆成 `transitionElapsed` 与 `holdElapsed` 两只时钟，让配置中的 `hold` 真正代表形状完成后的停留时间。若目标是逐帧完全一致，再保留原逻辑。

## 3. 文字和 Logo 为什么能由散点组成

### 3.1 文字像素采样

文字并不是 Three.js 字体几何，也不是 SVG Path。原站流程是：

1. 创建一个不显示在页面上的 2D Canvas。
2. 使用与页面一致的字体把文字画成白色。
3. 调用 `getImageData()` 读取像素。
4. 每隔 4 像素检查一次 Alpha。
5. Alpha 大于阈值的像素被转换为世界坐标。
6. 这些坐标成为粒子的目标点。

最小实现：

```ts
export function sampleText(
  text: string,
  font: string,
  width = 640,
  height = 240,
  step = 4,
) {
  const canvas = document.createElement('canvas');
  canvas.width = width;
  canvas.height = height;

  const ctx = canvas.getContext('2d', { willReadFrequently: true });
  if (!ctx) return [];

  ctx.clearRect(0, 0, width, height);
  ctx.fillStyle = '#fff';
  ctx.font = font;
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(text, width / 2, height / 2);

  const pixels = ctx.getImageData(0, 0, width, height).data;
  const points: Array<[number, number]> = [];

  for (let y = 0; y < height; y += step) {
    for (let x = 0; x < width; x += step) {
      const alpha = pixels[(y * width + x) * 4 + 3];
      if (alpha > 128) {
        points.push([
          (x / width - 0.5) * 240,
          -(y / height - 0.5) * 85,
        ]);
      }
    }
  }
  return points;
}
```

必须在 `document.fonts.ready` 之后采样，否则浏览器可能先用后备字体采样，等真实字体加载后粒子轮廓与页面字形不一致。

### 3.2 图片像素采样

Logo 使用同样原理：把 PNG 绘制到约 `192 × 192` 的离屏 Canvas，每隔 3 像素采样一次。优先选择暗色像素；如果暗色像素太少，则退回到所有不透明像素。

注意 CORS：如果图片来自另一域，服务端必须允许跨域，且要在赋值 `src` 之前设置：

```ts
const image = new Image();
image.crossOrigin = 'anonymous';
image.src = '/brand/mark.png'; // 最稳妥是同源 public 文件
```

否则 Canvas 会被标记为 tainted，`getImageData()` 将抛出安全错误。

### 3.3 将采样点扩充到 4,000 粒子

采样得到的轮廓点数量通常不是 4,000。处理方式是先打乱轮廓点，再循环分配：

```ts
for (let i = 0; i < count; i++) {
  const [x, y] = shapePoints[i % shapePoints.length];
  target[i * 3]     = x + random(-1, 1);
  target[i * 3 + 1] = y + random(-1, 1);
  target[i * 3 + 2] = random(-5, 5);
}
```

少量 XY 抖动避免多个粒子完全重合，Z 抖动让透视和相机移动时出现细微层次。打乱请用 Fisher–Yates，不建议照抄 `array.sort(() => Math.random() - 0.5)`。

## 4. Morph 动画的数学

### 4.1 全局进度

每帧使用真实时间差，而不是“每帧移动固定距离”：

```ts
const dt = Math.min(clock.getDelta(), 0.05);
transitionT = Math.min(1, transitionT + dt / transitionDuration);
```

限制 `dt <= 0.05` 是为了防止切换标签页或设备卡顿后，下一帧产生巨大的物理跳跃。

### 4.2 粒子错峰

每个粒子有 `delay[i] ∈ [0, 0.38]`。全局进度为 `t` 时，第 i 个粒子的局部进度为：

```text
localTᵢ = clamp((t - delayᵢ) / (1 - delayᵢ), 0, 1)
```

这就是粒子不会同时出发，而像一阵雾逐渐聚拢的原因。

### 4.3 五次缓动

原站使用五次 ease-in-out：

```ts
function easeQuintic(t: number) {
  return t < 0.5
    ? 16 * t ** 5
    : 1 - (-2 * t + 2) ** 5 / 2;
}
```

最终基础坐标：

```text
baseᵢ = sourceᵢ + (targetᵢ - sourceᵢ) × ease(localTᵢ)
```

五次曲线在起点和终点附近速度更接近零，比线性或普通二次缓动更柔和。它适合自动播放的形状 Morph；不要把固定缓动误用于鼠标排斥，因为交互部分应该是连续可打断的物理系统。

### 4.4 静止时的漂浮

散开状态漂浮幅度较大，形状状态较小：

```ts
const phase = i * 0.05;

if (isScatter) {
  x = targetX + Math.sin(time * 0.18 + phase) * 1.8;
  y = targetY + Math.cos(time * 0.14 + phase * 1.3) * 1.8;
  z = targetZ + Math.sin(time * 0.30 + phase * 0.7) * 8.0;
} else {
  x = targetX + Math.sin(time * 0.50 + phase) * 0.30;
  y = targetY + Math.cos(time * 0.40 + phase) * 0.30;
  z = targetZ + Math.sin(time * 0.60 + phase) * 1.20;
}
```

Morph 完成后不要立刻开启满幅漂浮，否则位置会跳一下。使用约 0.6 秒把漂浮权重从 0 淡入到 1。

## 5. 鼠标排斥如何实现

### 5.1 从屏幕坐标映射到三维世界

鼠标坐标先转成标准设备坐标：

```ts
ndc.x =  (clientX / width)  * 2 - 1;
ndc.y = -(clientY / height) * 2 + 1;
```

然后通过 `Raycaster.setFromCamera()` 生成从摄像机穿过鼠标位置的射线，与 `z=0` 平面求交，得到世界坐标 `mouseWorld`。Raycaster 的官方用途正是将屏幕指针映射到三维场景：[Raycaster](https://threejs.org/docs/pages/Raycaster.html)。

```ts
raycaster.setFromCamera(ndc, camera);
raycaster.ray.intersectPlane(planeZ0, mouseWorld);
```

### 5.2 排斥力

对每个粒子，计算基础位置到鼠标世界位置的距离 `d`。半径内的粒子受到径向力：

```text
falloff = 1 - d / radius
acceleration = normalize(delta) × falloff² × force
```

原站参数：

| 参数 | 数值 | 含义 |
| --- | ---: | --- |
| `radius` | 55 | 世界坐标影响半径 |
| `force` | 90 | 最大推力 |
| `springK` | 10 | 回位弹簧刚度 |
| `dampingC` | 8 | 线性阻尼 |

### 5.3 弹簧—阻尼回位

排斥不是直接改 `base`，而是维护一层可恢复的附加位移：

```text
a = mouseForce - kx - cv
v(t+dt) = v(t) + a × dt
x(t+dt) = x(t) + v(t+dt) × dt
renderPosition = base + x
```

代码骨架：

```ts
repVX[i] += (mouseAX - springK * repX[i] - dampingC * repVX[i]) * dt;
repVY[i] += (mouseAY - springK * repY[i] - dampingC * repVY[i]) * dt;
repX[i] += repVX[i] * dt;
repY[i] += repVY[i] * dt;

position[i3]     = base[i3]     + repX[i];
position[i3 + 1] = base[i3 + 1] + repY[i];
position[i3 + 2] = base[i3 + 2];
```

关键原则：鼠标扰动绝不能写回 `base`。否则下一轮 Morph 会从已经被鼠标破坏的形状出发，形成漂移和反馈回路。

### 5.4 Apple 式“物理感”要求

交互要从当前画面值继续，而不是重置到逻辑目标值。这一层必须满足：

- 指针移动时当帧响应，不等待节流计时器结束。
- Morph 正在进行时，鼠标排斥仍可叠加；不要锁住输入。
- 鼠标移开后保留当前位移和速度，由弹簧连续回位。
- 相机视差使用平滑追随，不做突变。
- 不使用会忽略当前速度的 CSS keyframe 来处理互动粒子。

相机视差可以使用指数追随：

```ts
camera.position.x += (mouseNX * 8 - camera.position.x) * 0.04;
camera.position.y += (-mouseNY * 5 - camera.position.y) * 0.04;
camera.lookAt(0, 0, 0);
```

## 6. 推荐的工程结构

当前 `Prework` 是一个尚无提交、无远端的空 Git 仓库，并且没有 `.openai/hosting.json`。正式实施时，先用 Sites 初始化一次，不要同时手工再创建另一个 Next/Vite 工程。

建议结构：

```text
Prework/
├── .openai/
│   └── hosting.json
├── app/
│   ├── components/
│   │   └── particle-background/
│   │       ├── ParticleBackground.tsx
│   │       ├── particle-config.ts
│   │       ├── particle-engine.ts
│   │       ├── shape-samplers.ts
│   │       └── particle-types.ts
│   ├── globals.css
│   ├── layout.tsx
│   └── page.tsx
├── public/
│   ├── brand-mark.png
│   └── fonts/
├── package.json
└── package-lock.json
```

职责边界：

- `ParticleBackground.tsx`：React 生命周期、Canvas 容器、减少动态偏好。
- `particle-engine.ts`：Three.js 场景、缓冲区、状态机、动画循环和清理。
- `shape-samplers.ts`：文字、图片、散开目标坐标生成。
- `particle-config.ts`：所有可调参数，不把魔法数字散在算法里。
- `page.tsx`：页面内容，不直接操作 Three.js。

如果站点会有多个路由，把 `ParticleBackground` 放在根 `layout.tsx`，这样页面切换时 Canvas 不卸载，粒子状态天然连续。只有传统整页刷新时才需要原站那套 `sessionStorage + JPEG snapshot` 方案。

## 7. 实施步骤

### 阶段 A：建立可验收的最小版本

1. 用 Sites 在空工作区初始化单一路由站点。
2. 固定 `three@0.160.0`，先追求与目标站一致，不在第一天升级依赖。
3. 创建客户端组件和全屏 Canvas，正文层设置正确的 stacking context。
4. 建立 Scene、PerspectiveCamera、WebGLRenderer。
5. 生成 4,000 个随机点，并用单个 `THREE.Points` 渲染。
6. 验收基础指标：Canvas 不挡点击、视口缩放正确、正文可正常选择和阅读。

完成标准：能看到静态灰色点云，且只产生一个粒子 draw call。

### 阶段 B：加入形状采样和 Morph

1. 等字体加载完成。
2. 实现 `sampleText()`。
3. 实现 `sampleImage()`。
4. 为散开、品牌文字、Logo、短文字生成目标坐标。
5. 实现 `source → target` 插值和粒子延迟。
6. 实现桌面／移动端状态序列。

完成标准：每个目标轮廓清晰、无明显空洞，形状切换两端不抽动。

### 阶段 C：加入物理互动

1. 监听 Pointer Events，而不是只监听 Mouse Events。
2. 把指针坐标投射到 `z=0` 平面。
3. 添加排斥半径和平方衰减。
4. 添加独立 X/Y 弹簧—阻尼状态。
5. 添加相机视差。
6. 在 Morph 过程中测试鼠标交互，确保可叠加、可打断。

完成标准：鼠标扫过点云时立即散开，移开后连续回位，无跳帧和永久偏移。

### 阶段 D：页面级完成度

1. 加入首帧淡入，避免白屏后突然闪现粒子。
2. 加入滚动透明度变化。
3. 多路由站点把背景保持在根布局。
4. 添加页面隐藏暂停和恢复。
5. 添加移动端粒子数量和交互降级。
6. 添加无障碍媒体查询。
7. 运行正式构建，再做浏览器视觉与性能验收。

## 8. React 生命周期骨架

Three.js 必须只在客户端初始化，并且完整清理：

```tsx
'use client';

import { useEffect, useRef } from 'react';
import { createParticleEngine } from './particle-engine';

export function ParticleBackground() {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const reducedMotion = window.matchMedia(
      '(prefers-reduced-motion: reduce)',
    ).matches;

    const engine = createParticleEngine({ canvas, reducedMotion });
    engine.start();

    return () => engine.dispose();
  }, []);

  return <canvas ref={canvasRef} className="particle-canvas" aria-hidden="true" />;
}
```

`dispose()` 至少要做：

```ts
cancelAnimationFrame(frameId);
window.removeEventListener('pointermove', onPointerMove);
window.removeEventListener('resize', onResize);
document.removeEventListener('visibilitychange', onVisibilityChange);
geometry.dispose();
material.dispose();
renderer.dispose();
```

开发模式下 React 可能执行额外的挂载／卸载检查。如果清理不完整，会出现双动画循环、重复 Canvas、GPU 资源泄漏和鼠标力被计算两次。

## 9. CSS 与页面层

```css
.particle-canvas {
  position: fixed;
  inset: 0;
  width: 100%;
  height: 100%;
  z-index: 0;
  pointer-events: none;
  opacity: 0;
  transition: opacity 600ms ease;
}

.particle-canvas[data-ready='true'] {
  opacity: 1;
}

.site-header,
main,
.site-footer {
  position: relative;
  z-index: 1;
}

@media (prefers-reduced-motion: reduce) {
  .particle-canvas {
    transition: opacity 200ms ease;
  }
}
```

Canvas 设置 `pointer-events: none` 不会妨碍交互，因为指针事件监听在 `window`；同时它不会遮住导航、链接或表单。

## 10. 推荐参数配置

```ts
export const PARTICLE_CONFIG = {
  count: {
    desktop: 4000,
    mobile: 2200,
    reducedMotion: 900,
  },
  camera: {
    fov: 55,
    near: 0.1,
    far: 1000,
    z: 130,
  },
  point: {
    size: 1.4,
    opacity: 0.7,
  },
  morph: {
    duration: 3.2,
    maxDelay: 0.38,
    floatFade: 0.6,
  },
  repulsion: {
    radius: 55,
    force: 90,
    spring: 10,
    damping: 8,
  },
  renderer: {
    maxPixelRatio: 2,
  },
} as const;
```

视觉不匹配时按这个顺序调参：

1. 先调相机 Z 与文字世界宽度，决定整体构图。
2. 再调粒子数与采样步长，决定轮廓密度。
3. 再调粒子尺寸和透明度，决定视觉重量。
4. 再调 Morph 时长和错峰范围，决定节奏。
5. 最后调排斥力、弹簧和阻尼，决定手感。

不要同时改五组参数，否则无法判断是哪一项改善或破坏了效果。

## 11. 性能策略

### 必做

- 只创建一个 `THREE.Points`。
- 所有粒子属性使用 Typed Array。
- 每帧原地改数组，不创建临时 Vector 或对象。
- 每帧修改后只设置 `positionAttribute.needsUpdate = true`。
- `devicePixelRatio` 上限为 2。
- `dt` 上限为 0.05 秒。
- 页面隐藏时暂停 RAF，恢复时重置时钟。
- Resize 时只更新相机投影与 Renderer 尺寸。
- 移动端降低粒子数。

### 不建议照抄的原站选择

原站开启 `preserveDrawingBuffer: true` 来制作跨页面快照。它会增加显存／带宽压力。如果 React 根布局能让 Canvas 跨路由常驻，应关闭它：

```ts
new THREE.WebGLRenderer({
  canvas,
  alpha: true,
  antialias: true,
  preserveDrawingBuffer: false,
  powerPreference: 'high-performance',
});
```

### 升级路线

只有当移动设备上的 CPU 更新不达标时，才考虑：

1. 把 idle float 移入 Vertex Shader。
2. 把 source、target、delay 作为 Buffer Attribute。
3. 用 uniform `uMorphT` 在 GPU 插值。
4. 鼠标排斥可先继续留在 CPU；再不够才迁移 Shader。

不要一开始就写复杂 Shader，因为调试成本、跨设备差异和可维护性都会显著增加。

## 12. 无障碍和移动端

目标站的公开粒子脚本没有显式处理 `prefers-reduced-motion`。复刻时建议：

```ts
if (reducedMotion) {
  // 只生成一次静态散点或品牌轮廓
  // 禁用持续漂浮、相机视差和鼠标排斥
  // 不启动循环 Morph；仅在必要时重绘
}
```

理由：全视口慢速循环背景和视差可能引发眩晕或注意力负担。减少动态不等于隐藏内容；保留静态粒子轮廓或短淡入即可。

移动端策略：

- 使用 Pointer Events 统一鼠标、触控笔和触摸。
- 默认不做持续触摸排斥，避免与页面滚动争夺手势。
- 粒子数降到约 1,800–2,500。
- 状态序列省略长品牌文字。
- 在低性能或 WebGL 初始化失败时回退为 CSS 渐变／静态图片。

Canvas 应设置 `aria-hidden="true"`，因为它只是装饰；职位、导航和联系方式仍应是可读、可聚焦的 HTML。

## 13. 视觉设计改进建议

从 Apple 式流体界面原则看，建议保留原站的克制感，但做四项改进：

1. **反馈立即发生**：指针进入半径后当帧施力，不人为 debounce。
2. **互动可打断**：Morph 与排斥同时运行，排斥从当前位移和速度继续。
3. **运动有层级**：内容层稳定清晰，背景粒子透明且不抢正文焦点。
4. **尊重用户控制**：减少动态、触摸滚动、窗口失焦都应有明确降级。

原站的视觉魅力来自“轻、慢、克制”，不是来自更大的弹性或更强的爆炸力。不要给自动 Morph 添加明显 overshoot；有用户动量输入时才允许轻微弹性。页面标题保持高对比度，粒子不应穿透到让字变脏的程度。

## 14. 浏览器与性能验收

### 功能矩阵

| 场景 | 验收点 |
| --- | --- |
| Chrome / Edge 桌面 | Morph、排斥、视差、滚动淡出正常 |
| Firefox 桌面 | 字体采样和 Canvas 像素读取正常 |
| Safari / iOS | WebGL、DPR、页面恢复正常 |
| 390 × 844 | 内容不被粒子干扰，移动状态序列正确 |
| 1440 × 900 | 与参考站构图接近 |
| DPR 1 / 2 / 3 | Renderer 实际上限保持 2 |
| `prefers-reduced-motion` | 无循环 Morph、无视差 |
| 标签页隐藏再恢复 | 不跳跃、不累计巨量 dt |
| 连续切换路由 10 次 | 不增加 Canvas、RAF 或监听器 |
| WebGL 不可用 | 页面内容仍完整，出现静态回退 |

### 性能预算

- 桌面目标：接近 60 FPS，P95 帧时长小于 16.7ms。
- 中端移动设备目标：至少 30 FPS，P95 帧时长小于 33.3ms。
- 首屏正文不等待粒子引擎加载。
- 粒子脚本失败不影响导航、文本和表单。
- 10 次挂载／卸载后 JS Heap 和 WebGL 资源不持续增长。

### 视觉验收方式

1. 固定相同视口截图对比 scatter、文字、Logo 三种状态。
2. 录制 60 FPS 视频，逐帧检查 Morph 起止是否跳动。
3. 以慢速回放检查排斥回位是否出现速度断层。
4. 在正文上方移动鼠标，确认互动不影响链接点击。
5. 用系统减少动态设置重新检查页面。

## 15. Sites 与 GitHub 落地流程

### Sites

当进入实施阶段：

1. 在当前空工作区只运行一次 Sites 初始化。
2. 保留生成的包管理器、锁文件和 `.openai/hosting.json`。
3. 完成粒子组件与页面后运行正式构建。
4. 使用内置浏览器在明确视口下验证桌面与移动端。
5. 构建和视觉验收通过后再部署。

当前请求是“出复刻报告”，因此本轮不初始化、不部署，也不改变站点结构。

### GitHub

当前仓库状态：

- 分支：`master`
- 尚无提交
- 尚无远端
- `tmp/` 是现有未跟踪内容，应视为用户文件，不纳入或删除

实施时推荐：

1. 先建立干净的站点基线提交。
2. 创建 `codex/particle-morph-replica` 分支。
3. 按“引擎、互动、无障碍与 QA”分为小提交。
4. 只提交本项目文件，不碰 `tmp/`。
5. 用户指定 GitHub 仓库后再添加远端、推送和建 Draft PR。

## 16. 时间与风险估算

以下为单人、有 Three.js/React 经验时的估算：

| 阶段 | 预计时间 |
| --- | ---: |
| 静态点云与页面集成 | 2–4 小时 |
| 文字／Logo 采样与 Morph | 4–6 小时 |
| 鼠标物理与相机视差 | 3–5 小时 |
| 响应式、减少动态、回退 | 3–5 小时 |
| 多浏览器性能与视觉 QA | 4–8 小时 |
| 合计 | 2–4 个工作日 |

主要风险：

- 字体未加载完成导致轮廓变化。
- 跨域图片导致离屏 Canvas 无法读像素。
- React 清理不完整导致双循环和 GPU 泄漏。
- 移动端 DPR 与粒子数过高导致耗电／掉帧。
- 全屏持续运动未提供减少动态降级。
- 为了跨页截图开启 `preserveDrawingBuffer`，但项目其实不需要。

## 17. 知识产权边界

可以复刻技术机制和交互思想，但不要直接复制 UniPat 的品牌文字、Logo、招聘内容或整份 `particles.js`。Three.js 自身按其开源许可使用；业务动画代码应根据本报告独立实现，换成你自己的品牌资产、文字、配色和节奏。这能同时降低版权／品牌混淆风险，也让代码结构更适合你的站点。

## 18. 完成定义

只有同时满足以下条件，才算“复刻完成”：

- 单个 Three.js 点云完成散开、文字、Logo Morph。
- Morph 具有逐粒子错峰和柔和起止。
- 鼠标排斥当帧响应，移开后弹簧回位。
- 交互不污染 Morph 的基础坐标。
- 桌面、移动端、减少动态都有明确行为。
- Canvas 不阻塞正文交互，正文在 WebGL 失败时仍可用。
- React 卸载后无 RAF、监听器或 GPU 资源泄漏。
- 正式构建通过，并完成固定视口的视觉和性能验收。
- 使用自己的品牌资产，没有直接复制原站业务代码或标识。

## 19. 最推荐的下一步

先做一个单页 MVP，只包含：自有标题、一个自有 Logo、scatter → 标题 → scatter → Logo 四态，以及鼠标排斥。MVP 验收通过后，再加入跨路由连续性、滚动淡出和更复杂的状态序列。这样最容易定位视觉和性能问题，也避免在引擎尚未稳定时过早处理部署细节。

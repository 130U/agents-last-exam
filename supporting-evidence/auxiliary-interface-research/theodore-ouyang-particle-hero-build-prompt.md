# Theodore / Ouyang 粒子文字网页：可直接交付给网页设计与开发代理的主提示词

> 使用方式：把下面“主提示词”从头到尾复制给后续负责网页设计与实现的代理。它不是灵感描述，而是设计图纸、技术规格和验收合同。除非用户后续明确修改，不要偏离其中的四态循环、视觉克制和无障碍要求。

---

## 主提示词开始

你是一名资深网页视觉设计师、交互动效设计师和 Creative Developer。请在当前工作区内设计并实现一个高完成度的个人网站首屏，其中最重要的视觉元素是一个全视口 Three.js 粒子文字背景。

### 一、项目目标

创建一个安静、理性、精确、具有生命感的个人身份首屏。设计理念可以说明为：

> 粒子动效的视觉理念参考了 [UniPat Join Us](https://unipat.ai/joinus) 的点云聚散方式，但本项目必须针对 Theodore Ouyang 的个人身份重新设计，不复制 UniPat 的品牌、Logo、页面内容或业务源码。

核心叙事是：

> Identity emerges from possibility. 同一片开放的粒子场先凝聚成名字 `THEODORE`，重新释放后再凝聚成姓氏 `OUYANG`，然后回到开放状态并持续循环。

这不是数据散点图，也不是 Logo 动画。它是一个只包含两个文字目标的粒子 Morph 系统。

### 二、不可更改的状态序列

状态机必须严格按照下面的顺序循环：

```text
SCATTER
   ↓
THEODORE
   ↓
SCATTER
   ↓
OUYANG
   ↓
REPEAT FROM SCATTER
```

不得增加以下状态：

- Logo
- 图标
- 首字母缩写
- AI 字样
- 第三个单词
- 粒子连线网络
- 其他随机图案

文字必须准确拼写为：

```text
THEODORE
OUYANG
```

全部使用大写。不要写成 `Theodore`、`Ouyang`，不要拼写成其他形式。

### 三、时间轴

使用独立的“变形计时器”和“稳定停留计时器”，不要让变形时间侵占稳定展示时间。

推荐完整循环：

| 阶段 | 时长 | 行为 |
| --- | ---: | --- |
| 初始 SCATTER 稳定 | 1.8s | 粒子缓慢漂浮，页面完成首帧进入 |
| SCATTER → THEODORE | 3.0s | 粒子错峰聚合，无弹跳 |
| THEODORE 稳定 | 4.0s | 保持清晰字形，仅有极轻微呼吸 |
| THEODORE → SCATTER | 3.0s | 沿相同空间逻辑释放 |
| SCATTER 稳定 | 1.6s | 给视觉留出呼吸空间 |
| SCATTER → OUYANG | 3.0s | 粒子错峰聚合，无弹跳 |
| OUYANG 稳定 | 4.0s | 保持清晰字形，仅有极轻微呼吸 |
| OUYANG → SCATTER | 3.0s | 回到开放粒子场 |
| 后续 SCATTER 稳定 | 1.6s | 然后重新进入 THEODORE |

循环必须连贯。页面第一次打开时不能直接闪现文字，应先让用户看到约 1.8 秒的粒子场，再逐步形成 `THEODORE`。

自动 Morph 使用平滑的五次 ease-in-out 或视觉等价曲线，起止速度接近零，不产生 overshoot。自动播放不是用户手势，不要添加弹簧回弹或“果冻感”。

### 四、视觉设计图纸

#### 4.1 整体气质

关键词：

```text
quiet / intelligent / precise / editorial / monochrome / restrained / alive
```

目标感受是“安静的自信”，不是炫技、赛博朋克、游戏启动页或粒子爆炸。

#### 4.2 画布和层级

```text
viewport
├── WebGL canvas：全屏固定，z-index: 0，pointer-events: none
└── semantic page content：z-index: 1
```

- Canvas 铺满整个视口，页面滚动时保持固定。
- 页面正文必须是普通语义化 HTML，不能把所有内容都画进 Canvas。
- Canvas 是装饰性视觉层，使用 `aria-hidden="true"`。
- 粒子层不能挡住链接、按钮、文本选择或页面滚动。

#### 4.3 色彩

默认亮色方案：

```text
Page background:  #FAFAF8 或接近的暖白
Primary text:     #111318
Secondary text:   #666A73
Particles:        从 #8F939B 到 #D1D3D6 的低饱和灰阶
Hairline:         rgba(17, 19, 24, 0.10)
```

要求：

- 粒子整体透明度约 0.62–0.72。
- 不使用彩虹渐变、霓虹蓝紫、发光 Bloom 或彩色噪声。
- 粒子不能降低正文的阅读对比度。
- 如果设计暗色模式，保持同样的单色与克制，不要自动变成赛博风。

#### 4.4 粒子文字排版

- `THEODORE` 和 `OUYANG` 共享相同的字号、字重和大写字高。
- 两个词都严格以视口中心为视觉锚点。
- 不要为了让两者宽度相同而横向拉伸 `OUYANG`；姓氏较短是自然差异。
- 推荐使用 `Space Mono Bold`、`IBM Plex Mono Bold` 或具有类似机械精度的等宽粗体。
- 生产环境优先自托管字体，并等待 `document.fonts.ready` 后再采样。
- 大写字形需要清晰、宽松但不松散；不要使用装饰性手写字体。
- 桌面端文字点云的目标宽度应自然落在约 48–64vw 范围内；两侧至少保留安全边距。
- 移动端可降低字号和采样密度，但必须完整显示全部字母，不裁切 `THEODORE`。

#### 4.5 粒子静态表现

- 点的视觉尺寸约为 1.2–1.6px，目标值 1.4。
- 使用圆点或视觉上接近小圆点的点精灵；不要用大方块。
- SCATTER 状态具有较宽的 X/Y/Z 分布，中心区域可以略密，但不能形成明显圆球。
- 文字状态 Z 深度很浅，使字形易读；只保留轻微空间层次。
- SCATTER 的漂浮幅度明显大于文字状态。
- 文字稳定时只能有极轻微“呼吸”，不能让字母边缘持续抖动。

### 五、粒子技术规格

使用 `three@0.160.0`，以便与参考效果的 Three.js 代际一致。第一版不要上自定义 Shader；先用 `THREE.Points + BufferGeometry + PointsMaterial` 完成。

#### 5.1 数量和设备策略

```ts
desktopParticles = 4000;
mobileParticles = 2200;
reducedMotionParticles = 900;
maxPixelRatio = 2;
```

#### 5.2 相机和材质基线

```ts
cameraFov = 55;
cameraNear = 0.1;
cameraFar = 1000;
cameraZ = 130;
pointSize = 1.4;
pointOpacity = 0.68;
```

#### 5.3 必须维护的数据层

对所有粒子使用 `Float32Array`，不要每帧创建 4,000 个对象：

```text
position   最终 GPU 坐标
base       当前无交互扰动的形状坐标
source     本次 Morph 起点
target     本次 Morph 终点
delay      单粒子错峰延迟
color      RGB 灰阶
repX/Y     鼠标排斥附加位移
repVX/VY   排斥速度
```

最终坐标必须满足：

```text
renderPosition = baseShapePosition + interactiveRepulsionOffset
```

鼠标互动不得写回 `base`，否则下一次 Morph 会从被破坏的字形开始。

#### 5.4 文字采样

使用离屏 2D Canvas：

1. 等字体加载完成。
2. 在离屏 Canvas 中分别绘制 `THEODORE` 和 `OUYANG`。
3. 读取 `getImageData()`。
4. 每隔约 3–4 像素采样 Alpha 大于 128 的像素。
5. 把 Canvas 坐标归一化为 Three.js 世界坐标。
6. 打乱轮廓点，并循环分配给全部粒子。
7. 每个目标点加入极小 XY 抖动和少量 Z 深度，避免粒子完全重叠。

使用 Fisher–Yates 洗牌，不要使用有偏的 `sort(() => Math.random() - 0.5)`。

#### 5.5 Morph 数学

每个粒子具有：

```text
delayᵢ ∈ [0, 0.38]
localTᵢ = clamp((globalT - delayᵢ) / (1 - delayᵢ), 0, 1)
baseᵢ = sourceᵢ + (targetᵢ - sourceᵢ) × easeQuintic(localTᵢ)
```

使用真实 `dt` 驱动，并限制：

```ts
dt = Math.min(clock.getDelta(), 0.05);
```

形状切换开始时，`source` 必须复制当前画面中的纯基础坐标 `base`，不能从旧 target 硬切，也不能从包含鼠标扰动的最终 position 开始。

### 六、鼠标与物理互动

互动只作为第二层细节，不能破坏名字的可读性。

#### 6.1 坐标映射

- 使用 Pointer Events。
- 把屏幕指针转换到标准设备坐标。
- 使用 `THREE.Raycaster` 从相机投射射线。
- 与 `z=0` 平面求交，得到鼠标世界坐标。

#### 6.2 推荐参数

```ts
repulsionRadius = 48;
repulsionForce = 80;
springK = 12;
dampingC = 9;
```

排斥力使用平方衰减：

```text
falloff = 1 - distance / radius
force = direction × falloff² × repulsionForce
```

回位使用独立 X/Y 弹簧—阻尼：

```text
acceleration = pointerForce - springK × displacement - dampingC × velocity
velocity += acceleration × dt
displacement += velocity × dt
```

#### 6.3 Apple 式交互原则

- 指针进入半径后当帧响应，不做明显 debounce。
- 动画始终从当前画面状态和当前速度继续。
- Morph 过程中鼠标仍然有效，不锁定输入。
- 鼠标移开后由弹簧连续回位，不突然 snap。
- 自动 Morph 不弹跳；只有指针造成的物理扰动有自然回位。
- 相机视差保持非常轻：X 方向约 ±5 世界单位，Y 方向约 ±3，平滑追随。
- 不添加声音、震动或无意义的粒子爆炸反馈。

移动端不要让粒子互动抢占页面滚动。粗指针设备默认关闭持续触摸排斥，只保留自动 Morph。

### 七、页面内容与粒子层的关系

这个提示词主要定义粒子身份首屏，不要擅自发明大量产品模块或 Dashboard。

如果当前站点尚无其他内容，建立极简个人首屏：

- 一个语义化的 `<h1>Theodore Ouyang</h1>`，保证搜索引擎和辅助技术获得完整名字。
- 粒子 Canvas 作为装饰层，不作为唯一的信息来源。
- 最多加入一句简短身份描述和非常克制的导航占位；不要编造工作经历、公司、项目或联系方式。
- 如果仓库已有页面内容，保留既有信息架构，只将粒子背景整合到首屏。

视觉上，语义 H1 可以根据页面方案正常显示，或者在非减少动态模式下视觉隐藏；但在 `prefers-reduced-motion` 模式中必须清晰显示 `Theodore Ouyang`。

### 八、响应式与无障碍

必须处理：

```text
prefers-reduced-motion: reduce
prefers-reduced-transparency: reduce（如页面使用半透明层）
prefers-contrast: more
fine pointer / coarse pointer
mobile viewport
WebGL unavailable
```

`prefers-reduced-motion: reduce` 时：

- 停止循环 Morph。
- 关闭相机视差和鼠标排斥。
- 可以渲染一次静态、低密度的粒子场。
- 使用普通 HTML 明确显示 `Theodore Ouyang`。
- 仅保留不超过约 200ms 的淡入反馈。

WebGL 初始化失败时：

- 页面内容仍然完整可用。
- 显示暖白背景和普通 HTML 名字。
- 不弹出错误提示，不让首屏崩溃。

### 九、性能与生命周期

必须做到：

- 只用一个 `THREE.Points`，避免 4,000 个 Mesh 或 DOM 节点。
- 每帧原地更新 Typed Array。
- 更新完成后设置 position attribute 的 `needsUpdate = true`。
- 标签页隐藏时暂停 RAF，恢复时重置时间差。
- Resize 时更新相机 aspect、projection matrix 和 Renderer 尺寸。
- React 卸载时取消 RAF、移除全部监听器并 dispose geometry、material、renderer。
- 开发模式反复挂载时不能产生双 Canvas 或双动画循环。
- 如果粒子背景需要跨路由持续存在，把组件放在根 layout，避免不必要的 sessionStorage 序列化。
- 除非必须做传统整页跳转快照，否则不要开启 `preserveDrawingBuffer: true`。

性能目标：

```text
Desktop: 接近 60 FPS，P95 frame < 16.7ms
Mid-range mobile: 至少 30 FPS，P95 frame < 33.3ms
```

### 十、工程结构

推荐：

```text
app/
├── components/
│   └── particle-background/
│       ├── ParticleBackground.tsx
│       ├── particle-engine.ts
│       ├── particle-config.ts
│       ├── shape-samplers.ts
│       └── particle-types.ts
├── globals.css
├── layout.tsx
└── page.tsx
```

- React 组件只负责生命周期和 Canvas。
- Three.js 场景、状态机和物理放在 engine。
- 文字采样独立放在 sampler。
- 所有参数集中在 config。
- 不把数百行 Three.js 逻辑直接塞进 `page.tsx`。

### 十一、Sites 工作方式

在开始实现前先检查当前项目：

- 如果已经存在站点，保留其包管理器、锁文件、架构和 `.openai/hosting.json`。
- 如果当前工作区仍为空，使用 Sites 初始化流程一次，不要重复初始化，也不要同时创建第二套框架。
- 使用 Sites 生成结构时，替换掉临时 starter 内容和 metadata。
- 完成实现后运行正式 build，修复真实构建错误。
- 使用内置浏览器进行桌面、移动端、减少动态和鼠标互动的视觉 QA。
- 如果用户没有要求仅本地运行，则在最终验证通过后按 Sites 流程部署。

### 十二、GitHub 与仓库边界

- 在当前仓库内工作，不删除、移动或提交与本项目无关的用户文件。
- 当前工作区中的 `tmp/` 属于用户已有内容，不要修改、删除或纳入提交。
- 不要擅自添加 GitHub 远端。
- 不要擅自 commit、push 或创建 PR；只有用户明确要求发布时才进入 GitHub 发布流程。
- 如果用户要求建立分支，使用 `codex/particle-morph-replica`。
- 提交时保持变更聚焦，避免把无关文件混入。

### 十三、明确禁止的设计偏移

不要做：

- 复制 UniPat 的 Logo、招聘页面、品牌文字或源码。
- 增加 Logo Morph 或第三个单词。
- 粒子之间画连线。
- 黑底霓虹、星云、Bloom、Lens Flare、彩虹渐变。
- 鼠标接近时发生大规模爆炸。
- 文字形成后持续明显抖动。
- 自动 Morph 出现弹跳 overshoot。
- 使用 CSS keyframes 代替粒子坐标状态机。
- 用 4,000 个 DOM 元素模拟粒子。
- 让 Canvas 成为唯一可访问的姓名信息。
- 为了“丰富页面”而编造项目、职位、公司或社交链接。

### 十四、验收标准

完成后逐项验证：

#### 状态与文字

- 循环严格为 `SCATTER → THEODORE → SCATTER → OUYANG → repeat`。
- 页面中不存在 Logo 或其他 Morph 目标。
- `THEODORE` 与 `OUYANG` 拼写完全正确。
- 两个词共享同一字高、字重和中心锚点。
- 文字边缘清晰，粒子密度均衡，无明显空洞。

#### 动效

- 变形约 3 秒，粒子错峰到达。
- 自动 Morph 起止柔和，无弹跳。
- 文字稳定期间不明显抖动。
- 鼠标扰动当帧发生，移开后自然回位。
- Morph 与鼠标互动可同时发生，没有跳变。

#### 页面和设备

- Canvas 不挡住任何链接、文本或滚动。
- 390×844 视口完整显示 `THEODORE`。
- DPR 3 设备的实际 Renderer DPR 不超过 2。
- 减少动态模式停止循环并显示 HTML 姓名。
- WebGL 失败时页面仍完整。

#### 工程质量

- 正式 build 通过。
- 连续挂载／卸载或切换路由 10 次后只有一个 Canvas 和一个 RAF 循环。
- 不存在不断增长的事件监听器或 GPU 资源。
- 没有修改用户无关文件。

### 十五、最终交付

交付时提供：

1. 完整运行的网站，而不是静态设计稿。
2. 简洁说明粒子状态机、文字采样和物理互动分别位于哪些文件。
3. 报告实际测试过的桌面与移动端视口。
4. 报告减少动态和 WebGL 回退是否验证通过。
5. 报告构建结果。
6. 若已获得用户授权并部署，提供最终 Sites URL；若未授权发布，不要擅自推送或建立 PR。

不要只描述计划。完成实现、验证和必要修正后再交付。

## 主提示词结束

---

## 给 Theodore 的设计摘要

这套设计的核心不是“粒子能变成两个词”，而是：

```text
开放状态 → 名字出现 → 重新开放 → 姓氏出现
```

`SCATTER` 代表尚未被固定的可能性；`THEODORE` 和 `OUYANG` 依次从同一系统中出现，意味着名字与姓氏不是两个贴上去的标题，而是同一个身份的两次显现。视觉语言参考 UniPat 的粒子聚散，但叙事、节奏、文字目标和工程实现都围绕 Theodore Ouyang 重做。

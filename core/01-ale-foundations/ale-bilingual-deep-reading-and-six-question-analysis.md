# *Agents’ Last Exam*（ALE）中英对照精读与六问解读

> 工作译名：**《智能体的终极考试》**  
> 论文：Yiyou Sun et al., arXiv:2606.05405v2, 2026-06-11  
> 主源：[arXiv HTML v2](https://arxiv.org/html/2606.05405v2) · [arXiv v2 版本页](https://arxiv.org/abs/2606.05405v2) · [Hugging Face Paper](https://huggingface.co/papers/2606.05405) · [官方 taxonomy](https://agents-last-exam.org/taxonomy)  
> 核对日期：2026-08-06

## 阅读说明

这不是对英文论文的逐字重印。下面的英文是按论文结构写成的 **faithful English paraphrase（忠实英文改写）**，中文与其逐节对应；正文、实验和附录的核心论点、流程、术语与数字均保留。作者/单位长名单和参考文献目录不重复翻译，原始引文关系请回到论文页面查看。

文中使用三种证据标签：

- **[事实]**：论文直接报告的设计、流程、数字或实验结果。
- **[作者主张]**：论文作者对意义、原因或未来影响的解释。
- **[本文归纳]**：基于论文设计作出的审阅性总结，不冒充论文原话。

## 先给结论：六个问题各用一句话回答

| 问题 | 最短回答 |
|---|---|
| 为什么做 ALE？ | 作者认为，现有 benchmark 的高分没有稳定转化为核心行业中的经济产出；缺的是对真实、长程、专业数字工作流的持续且可验证的测量。 |
| ALE 测什么？ | 它评估由 **foundation model + harness** 构成的完整 agent，在固定 task、prompt/tool configuration、environment、budget 与 evaluator 条件下完成专业数字项目、交付可验收结果的表现；不是裸 LLM 的知识问答能力。 |
| task 怎么筛？ | 入库先看三条：**代表性、复杂度、可验证性**；进入生产后还要通过真实性、规格完整、技术可执行、reference 正确、grader 校准、上下文充分等检查。 |
| taxonomy 是什么？ | 以 SOC 2018 与 O*NET 为职业骨架，筛出可数字执行且可客观验收的工作流；论文报告 **13 个 domain、55 个 subdomain**，但 Figure 2 视觉上是 13 个具名行业带，另有 `Other → Sports`。它不是按 GDP 排名抽样。 |
| 专家怎么生产 task？ | external-submission 路线由从业者提交过去做过、通常需数天或数周的项目；corpus 另含 530 个 commissioned/internally authored variants。平台补齐五项规格，再经自动/agent-assisted 初审、工程实现和专家委员会 QC。 |
| QC 怎么做？ | 五道 gate：专家招募 → 提交/编辑 → first-pass review → 工程实现与 dry-run → 专家委员会 final QC；最后重点查可复现性、reference、评分边界和信息充分性。 |

## 关键术语先分清

| 英文 | 中文工作译法 | 在 ALE 中的准确含义 |
|---|---|---|
| task workflow | 任务工作流 | 一个可复用的端到端专业程序，通常对应一个 `main.py` 和一套共享 evaluator。 |
| task instance | 任务实例 | 某个 workflow 下的一组具体 input/reference；不同实例可共用同一个 `evaluate()`。 |
| task | 任务 | 论文偶尔使用的简写；多数实验语境指可运行的 instance。 |
| agent | 智能体系统 | harness 与 foundation model 的组合，不等于模型本身。 |
| harness | 智能体编排层 | 负责 prompt、工具路由、action loop、context、sub-agent、GUI 接入等。 |
| reference | 隐藏参考产物 | 运行时不让 agent 读取，结束后供 grader 比较。 |
| grader / judge | 评分器 / 判定器 | 对文件、字段、几何、状态、行为或窄 rubric 评分的代码或模型。 |
| Mean Score | 平均分 | task-specific evaluator 返回的 `[0,1]` 归一化分数之平均，表示平均部分信用；没有统一的“完成了多少评分项”语义。论文表格按 `×100` 显示。 |
| Full Pass Rate | 满分通过率 | evaluator 编码分数恰好为 `1.0` 的任务比例；表示满足了该 evaluator 的全部编码条件，不等同于现实中的完整专业验收。 |
| GCUA | 通用计算机使用智能体 | 联合 Brain（推理/规划）、Eyes（视觉）、Body（编排）、Hands（结构化工具）和 Feet（运行环境）的 Generalist Computer-Use Agent。 |

---

# 第一部分：按论文结构的中英对照精读

## Abstract / 摘要

**English faithful paraphrase**

Modern AI systems perform strongly on many established tests, but those gains have not produced equally strong deployment across professional domains. The authors argue that this discrepancy is largely an evaluation problem: common benchmarks rarely test sustained work on authentic and economically useful workflows. ALE is introduced to evaluate agents on long-horizon, real-world tasks whose outcomes can be verified. The benchmark was developed with more than 250 domain experts, uses 13 industry clusters and 55 subfields, and contains more than one thousand tasks. In arXiv v2, the average full-pass rate on the hardest tier is below one percent across the tested mainstream model–harness configurations. ALE is intended to remain a living benchmark whose task pool grows over time.

**中文对照**

现代 AI 系统已经在许多既有测评上取得高分，但这些进展并没有在大量专业领域中形成同等强度的真实部署。作者主张，这一落差**主要**是“评测问题”：常用 benchmark 很少持续测量 AI 能否完成真实且有经济价值的完整工作流。ALE 因此被提出，用来评估智能体在长程、现实、结果可验证的任务上的表现。论文称，ALE 与 250 多名领域专家协作构建，包含 13 个行业集群、55 个子领域和 1,000 多项任务。arXiv v2 报告，在最难的 Last-Exam 层级上，所测主流模型—harness 配置的平均满分通过率低于 1%。ALE 被设计为 living benchmark，任务池会继续扩张。

**证据边界**

- **[事实]** v2 摘要的 headline 是 `<1%`，不是 HF paper metadata 中仍显示的旧 `2.6%`。
- **[作者主张]** benchmark 与经济部署之间的落差“主要是评测问题”。论文没有用实验把评测不足与其他部署障碍做因果分解。
- **[本文归纳]** ALE 更像“AI 工作交付测试”，不是一套更难的问答题。

## 1 Introduction / 引言

**English faithful paraphrase**

The paper contrasts rapid benchmark progress in games, mathematics, and programming with slower measurable transformation in major industries. The authors call this a utility problem: evaluations capture abstract competence more readily than the ability to perform valuable professional work over long horizons. Benchmarks also shape research priorities, so a verifiable evaluation can make a domain easier to optimize and eventually deploy.

Constructing such a benchmark is difficult for three structural reasons. Authentic long workflows are expensive to collect and reproduce; broad coverage requires sustained access to specialists; and professional outputs are heterogeneous, ranging from spreadsheets and reports to media, designs, software states, and scientific models. Existing evaluations often sacrifice at least one of realism, breadth, or verifiability. ALE attempts to combine all three by sourcing completed projects from practitioners and turning their final artifacts or milestones into structured automated checks.

The target system is a Generalist Computer-Use Agent that can combine visual perception, code execution, file handling, tool use, and long-horizon planning in one action loop. The authors position this surface as broader than GUI-only or CLI-only benchmarks.

**中文对照**

论文把两种现象放在一起比较：一边是 AI 在游戏、数学和编程 benchmark 上快速进步，另一边是核心行业中可测量的转型相对缓慢。作者把这称为“utility problem（效用问题）”：现有评测更容易测抽象能力，却较少测系统能否在长时间跨度内完成有价值的专业工作。由于 benchmark 会塑造研究注意力和工程目标，一个领域一旦拥有可验证、被广泛采用的测评，也更容易被持续优化并走向部署。

但这种 benchmark 很难建，原因有三类：第一，真实长工作流收集和复现都很贵；第二，广泛行业覆盖需要长期接触大量专家；第三，专业交付物高度异质，可能是表格、报告、媒体、设计、软件状态或科学模型。过去的评测往往必须在真实性、广度和可验证性之间牺牲至少一项。ALE 的尝试，是从从业者已经完成的项目出发，再把交付物或里程碑改造成结构化、可自动执行的检查。

被测对象是 GCUA：它需要在一个 action loop 中联合视觉感知、代码执行、文件操作、工具使用和长程规划。作者因此把 ALE 的操作面描述为比纯 GUI benchmark 或纯 CLI benchmark 更广。

**证据边界**

- **[作者主张]** 论文把真实性、广度、可验证性列为既有评测难以同时满足的三个方向；这是作者的文献比较判断，不是 ALE 实验本身证明的事实。
- **[作者主张]** 一旦类似 ALE 的 benchmark 被“做饱和”，就可能代表足以支撑真实工业采用的能力。
- **[本文归纳]** 论文并没有测 GDP，也没有匹配条件下的人类基线，所以“GDP-relevant”是研究愿景，不是已经验证的预测关系。

## 2 Benchmark Design and Dataset Construction / Benchmark 设计与数据集构建

### 2.1 Design Principles / 任务准入原则

**English faithful paraphrase**

ALE admits workflows according to three top-level requirements. First, a task should be representative of real professional practice and use the tools that specialists would normally use. Second, it should require substantial expert time and be complex enough to form an end-to-end deliverable rather than a local action or a few interface operations. Third, the result must be verifiable through deterministic checking or an unambiguous rubric attached to observable artifacts.

The paper illustrates complexity by contrasting a single video color adjustment with transferring a running animal into another video, which couples tracking, rotoscoping, compositing, and color matching. It illustrates verifiability by contrasting an unconstrained request to invent a game with reproduction of a specified game whose map, character attributes, and event state can be compared against a reference.

**中文对照**

ALE 用三条顶层要求决定一个 workflow 能否入库。

1. **Representativeness（代表性）**：任务应符合真实专业实践，并使用该领域专家实际会用的软件与工具。
2. **Complexity（复杂度）**：原任务应占用专家显著时间，并形成一个端到端交付，而不是一个局部动作或几次界面操作。关键区别是 workflow，不是 action。
3. **Verifiability（可验证性）**：结果必须能用确定性检查，或用绑定到可观察 artifact 的明确 rubric 验收。

论文用视频任务说明复杂度：只加一个滤镜太窄；把奔跑动物移入另一段比赛视频则需要跟踪、转描、合成和调色，是耦合工作流。论文用游戏任务说明可验证性：泛泛地“设计一个有怪物的 RPG”没有客观目标；复现一个指定游戏，则能检查地图结构、角色属性和事件状态。

**这里要区分两种“筛选”**

- 上述三条是 **task admission principles**，决定什么类型的 workflow 值得进入生产漏斗。
- Near-Term / Full-Spectrum / Last-Exam 是 **evaluation tier selection**，决定公开评测时用哪一组任务；它不是同一件事。

### 2.2 Scope and Taxonomy / 范围与分类体系

**English faithful paraphrase**

The taxonomy is not built by selecting industries informally or ranking them by economic size. ALE starts from SOC 2018 and O*NET records, removes occupations whose core work cannot be represented meaningfully in a digital environment, and groups occupations that share software-mediated, artifact-producing workflows. The paper reports 13 domains and 55 subdomains; Figure 2 visually shows 13 named industry bands plus an additional `Other` band containing Sports.

Appendix B describes the derivation in more detail. A fixed GPT-4o mini prompt at temperature zero screened 1,016 O*NET 30.2 occupation entries. Variants were consolidated into 117 SOC base codes. Workflow similarity across field, method, and work product was then used to create 51 SOC-anchored subdomains. Four frontier subdomains were added, while seven extensions modified existing subdomains rather than adding seven more, producing 55 subdomains in total.

The paper maps categories from 16 earlier benchmarks into this coordinate system with an LLM-assisted classifier and reports that their union still leaves 13 of the 55 ALE subdomains uncovered.

**中文对照**

ALE 的 taxonomy 不是凭感觉挑行业，也不是按行业 GDP 排名。它从 SOC 2018 与 O*NET 的职业、任务、工作活动和工具记录出发，排除核心工作无法有意义地放入数字环境的职业，再把具有相近软件媒介工作流和可交付 artifact 的职业组织到一起。论文报告 13 个 domain 与 55 个 subdomain；Figure 2 视觉上则列出 13 个具名行业带，另有一个包含 Sports 的 `Other` 条带。

附录 B 给出更细的推导：团队使用固定的 GPT-4o mini prompt、temperature 0，对 O*NET 30.2 的 1,016 条职业记录进行初筛；合并变体后保留 117 个 SOC base code；再按 field、methodology 和 work product 的相似性整理出 51 个以 SOC 为锚点的 workflow subdomain。对于传统职业分类没有充分覆盖的新兴工作，又加入 4 个 frontier subdomain，并扩展 7 个既有 subdomain，最终得到 55 个 subdomain。

论文随后用 LLM-assisted classifier 把 16 个既有 benchmark 的公开类别映射到同一坐标系，并报告：即使把这些 benchmark 合起来，仍有 13/55 个 ALE 子领域完全未覆盖。

**v2 图表口径的例外：**正文和 Figure 2 图注都概括为“13 domains / 55 subdomains”，但 Figure 2 视觉上实际列出 **13 个具名 industry domain，外加一个 `Other (3)` 条带；其下只有 `Sports (3)`**。论文没有单独解释 `Other` 的分类地位；只有把 Sports 计入，冻结的 v2 图才得到 55 个 subdomain 与 1,490 个 instance。官方 living taxonomy 页面后来仍标为 13/55，但 subdomain 组合已经重排，因此不能用今天的网页目录静默改写 v2 论文快照。

**证据边界**

- **[事实]** taxonomy 的确以 SOC/O*NET 为骨架，并明确排除核心工作不适合数字执行的职业。
- **[作者主张]** 这种设计提供了“广泛且有代表性”的行业覆盖。
- **[本文归纳]** 它是 broad coverage，不是 labor-market representative sample；没有按就业人数、工资、工时、GDP 权重或失误后果加权。

### 2.3 Task Construction Pipeline / Task 构建流水线

**English faithful paraphrase**

ALE does not treat task production as ordinary crowd work. In the external-submission route, domain practitioners contribute projects from their real routines, often projects that originally took days or weeks. The corpus also contains 530 commissioned-build variants that are internally authored. A web portal and AI-assisted editing help complete five required components: a natural-language description, input files, target software, expected deliverables, and an evaluation specification.

Proposals then receive conference-style first-pass decisions, including major revision, minor revision, borderline accept, accept, and strong accept. Accepted specifications are converted by engineers into runnable assets, provisioned software environments, and executable evaluation logic. Engineers perform dry runs and return incomplete specifications to the expert. A final expert-committee review checks reference correctness, evaluator bounds, reproducibility, and whether enough context is supplied for a valid solution.

Figure 5 describes 1,490 variants/instances: 150 public, 1,017 private, and 323 still pending verification/QC. By source, these are 960 external-submission variants and 530 commissioned-build variants. Only about ten percent is public, and private instances are intended to rotate into future evaluations to reduce contamination and task-specific optimization. Figure 5's “960 external-submission variants” must not be silently equated with the Conclusion's “960 task workflows”: the paper reuses the number under different unit labels without showing a one-to-one mapping.

**中文对照**

ALE 不把 task 生产当成普通众包标注。在 external-submission 路线中，任务来自领域从业者的真实工作例程，通常是专家过去花过数天甚至数周完成的项目；corpus 还包含 530 个 commissioned-build、internally authored variants。专家通过网页 portal 提交材料，AI-assisted editing 帮助把五项核心规格补齐：自然语言描述、输入文件、目标软件、预期交付物、评测规范。

提案随后接受类似学术会议的 first-pass decision：major revision、minor revision、borderline accept、accept、strong accept。通过的规格由工程团队转成可运行 asset、配置好软件的环境和可执行评分逻辑。工程师会 dry-run；若发现依赖缺失或逻辑空洞，任务日志会被退回专家修订。最终，专家委员会复核 reference 是否正确、评分边界是否合理、任务是否可复现、以及上下文是否足够支撑一个有效解。

Figure 5 给出 1,490 个 variant/instance：150 个公开、1,017 个私有、323 个仍待验证/QC；按来源分成 960 个 external-submission variants 和 530 个 commissioned-build variants。公开比例约 10%，私有实例计划在后续评测中轮换，以减少污染和针对公开题的定向优化。这里的“960 个 external-submission variants”不能直接等同于结论所称“960 个 task workflows”：论文对同一个数字使用了不同单位标签，却没有展示一一对应关系。

```mermaid
flowchart LR
    A["1. Expert sourcing<br/>按 taxonomy 缺口招专家"] --> B["2. Submission and editing<br/>补齐五项核心规格"]
    B --> C["3. First-pass review<br/>修订或接受"]
    C --> D["4. Engineering implementation<br/>环境、资产、grader、dry-run"]
    D --> E["5. Final expert QC<br/>可复现性与评测完整性"]
    C -->|revision| B
    D -->|gap found| B
    E -->|final adjustments| B
    E -->|accepted| F["Runnable task instance"]
```

## 3 Evaluation Pipeline / 评测流水线

### 3.1 Pipeline Architecture / 系统架构

**English faithful paraphrase**

Each runnable benchmark instance separates three components: a task specification, an agent, and an environment. The task specification is an executable `main.py` containing the instruction, input assets, required software, hidden references, and evaluation criteria. It exposes `load()` as a pure declaration of task metadata and compute requirements, `start()` to provision a deterministic initial state, and `evaluate()` to retrieve outputs or invoke a VM-side verifier and then score the result in `[0,1]` against isolated references or rubrics.

The agent is a harness orchestrating a foundation model. It observes screenshots, shell output, and file contents; chooses mouse, keyboard, command-line, file, or API actions; and repeats until it delivers or…8870 tokens truncated…研发。**可验证、广泛采用的 metric 会集中工程注意力，让系统更快针对该能力进步。
4. **专业工作 benchmark 缺三者合一。**真实长程任务收集贵、跨行业专家难组织、异质交付物难自动验收，所以既有工作往往在 realism、breadth、verifiability 中至少牺牲一项。
5. **ALE 的方案。**用专家既有项目支撑来源真实性，用 SOC/O*NET taxonomy 组织覆盖范围，用 artifact/state grader 提供可执行、可重复的验收代理；这些机制都不能自动保证真实性、劳动市场代表性或完整专业有效性。

### 哪些是事实，哪些只是作者的解释

- **[事实]** ALE 的 task 确实是长、多步、软件媒介、artifact-producing 的工作；论文也确实构建了自动评分与专家生产线。
- **[作者主张]** 当前经济部署落差“largely”是 evaluation problem；benchmark 饱和会指向工业采用与 GDP-relevant impact。
- **[本文归纳]** ALE 证明的是一种更贴近专业数字交付的测量机制已经可以构建；它没有证明评测不足是部署迟缓的主要因果来源。

## 问题 2：ALE 到底测什么？

### 操作性定义

ALE 直接测量：

> 在一个指定 task、sandbox、software、tool surface、time budget 和 evaluator 下，一套完整 agent configuration 能否把专业数字工作从说明与输入推进到满足该 evaluator 编码条件的最终 artifact 或 application/system state。

因此 leaderboard 的最小正确标签应是：

`task manifest + task/evaluator version + model + harness + prompt/tool config + environment + time/retry policy`

### 被测系统与影响结果的评测条件

| 类别 | 组件 | 对结果的作用 |
|---|---|---|
| **被测 agent** | Foundation model | 领域知识、推理、规划、视觉/文本理解和 action proposal。 |
| **被测 agent** | Harness | system prompt、action loop、tool routing、sub-agent、context compaction、结束条件；可接入 GUI/CLI tool surface。 |
| **评测条件** | Task + prompt/tool configuration | 任务说明、inputs、可用截图/鼠标键盘/shell/code/file/web/API 等接口。 |
| **评测条件** | Runtime/environment | Windows/Linux、预装专业软件、依赖、算力、应用状态和延迟。 |
| **评测条件** | Budget/policy | 5 小时上限、重试、并发、成本与 token 约束。 |
| **评测条件** | Task-specific evaluator | 哪些 artifact、字段、gate、容差、reference 和 judge prompt 被计分。 |

### 它联合施压哪些能力

这些能力是 task **要求或施压** 的能力，不是 ALE 分别辨识出的独立 latent score：

- 读懂目标、文件、约束和验收条件；
- 长程规划、依赖管理与状态保持；
- 领域知识与专业方法选择；
- GUI 感知与桌面交互；
- CLI、代码、自动化、文件和 API 编排；
- 错误诊断、恢复、重试和策略切换；
- context 管理与 sub-agent 协作；
- 格式、路径、完整性、证据与最终自检；
- 在硬 gate 下满足 evaluator 编码的全部验收条件。

### 它不直接测什么

- 不是裸 LLM 知识或“智商”分数；
- 不把规划、视觉、领域知识等能力分别隔离打分；
- 不覆盖核心为物理、现场、人际、政治或组织协调的全部工作；
- 不直接测安全的中间过程，除非 grader 明确编码 provenance/safety gate；
- 没有匹配条件的人类专家 baseline；
- 不能把 Full Pass Rate 换算成岗位替代率、全职员工可靠率或 GDP 影响。

## 问题 3：Task 的筛选标准是什么？

这要分四层回答，混在一起就会失真。

### A. Workflow 是否值得收：三条 admission principle

| 原则 | 通过条件 | 典型拒绝原因 |
|---|---|---|
| Representativeness | 来自真实专业实践；使用专家通常会用的工具；输入与交付物符合行业语境。 | 合成玩具题；使用不符合实践的软件；与真实工作脱节。 |
| Complexity | 是多步骤、相互依赖、端到端交付；原始项目通常需要显著专家时间。 | 单击、单次局部编辑、几步 UI 操作或孤立 action。 |
| Verifiability | 能通过确定性 reference、observable artifact 或无歧义 rubric 验收。 | 开放式审美题；目标不唯一；只能笼统问模型“看起来对不对”。 |

### B. Proposal 能否进入 review：五项核心规格

1. natural-language description；
2. input files/assets；
3. target software/tools；
4. expected output/deliverable；
5. evaluation specification。

这五项是 task package 的“最低完整合同”，不是五个 QC gate。

### C. 能否变成 runnable instance：工程与 QC 条件

- 环境、软件、依赖和启动状态可复现；
- 指令与输入没有阻断性缺口；
- expert reference 本身正确；
- evaluator 能检查真正重要的结果，而不是易被投机的 proxy；
- tolerance / bound 不会窄到正确解也过不了，也不会宽到错误解轻松通过；
- 输出缺失、错误路径、错误形状、解析失败等情况有定义明确的分数；
- 若能代码判定，就不接受泛化 LLM judge；
- 若必须用 VLM/LLM，只能用窄、reference-grounded probe，并由代码聚合。

### D. 公开评测时放进哪个 tier

| Tier | 设计意图 | 公开说明的选择逻辑 |
|---|---|---|
| Near-Term | 快速、较低成本迭代 | 当前前沿系统已经能部分完成；top pass 接近 40%。 |
| Full-Spectrum | 测覆盖广度 | 55 个 subdomain 每个至少一个 instance。 |
| Last-Exam | 保留长期 headroom | 选最难 workflow，多数当前配置 full pass 为 0。 |

论文公开了 tier 的设计理由和 manifest，但没有给出一个可独立重算、预注册的统一难度公式或自动阈值。更稳妥的表述是：tier selection 含专家/经验性判断，公开材料不足以把它还原成纯算法规则。

## 问题 4：Taxonomy 是怎么来的，具体有哪些类？

### 构建方法

1. 用 SOC 2018 作为美国职业分类骨架，用 O*NET 提供 task、work activity、tools/technology 描述。
2. 从 O*NET 30.2 的 1,016 条 occupation entry 中筛选核心工作可以在电脑中执行、依赖领域知识、并产生可客观评估 artifact 的职业。
3. 合并 occupation variant，得到 117 个 unique SOC base code。
4. 按 field、methodology、work product 组织 workflow 边界；一个 SOC code 若包含可分离工作流，可以进入多个 subdomain。
5. 得到 51 个 SOC-anchored subdomain。
6. 再加入 4 个 frontier subdomain，并对 7 个既有 subdomain 做 frontier extension，形成论文所称的 55 个 subdomain。

### arXiv v2 Figure 2 的冻结 taxonomy 与实例数

下表根据论文 Figure 2 的标签与计数整理，并对少数缩写做最小展开；没有用后来更新的网页 taxonomy 覆盖论文快照。

| v2 顶层域（instance 数） | v2 subdomain（instance 数） |
|---|---|
| **Engineering & Architecture（368）** | Manufacturing & Industrial Systems（173）；Aerospace & Mechanical Engineering（47）；Civil, Architectural & Geospatial Engineering（33）；Robotics & Autonomous Systems（29）；Semiconductor & Microelectronics Design（28）；Electronics Engineering（23）；Chemical & Process Engineering（17）；Mining, Petroleum & Geological Engineering（9）；Urban & Spatial Planning（5）；Energy, Power & Nuclear Engineering（4） |
| **Computing & Mathematical Sciences（237）** | Data & Analytics Engineering（57）；AI Engineering & CS Research（50）；Software Engineering（38）；Mathematical & Operations Research（35）；Cybersecurity & Forensics（28）；Quantum Computing（16）；Infrastructure Engineering & Cloud Operations（13） |
| **Visual & Media Arts（226）** | 3D, Animation & Interactive Media（133）；Audio, Music & Post-Production（69）；Graphic, Visual & Product（24） |
| **Business & Finance（189）** | Accounting & Finance（115）；Enterprise Analytics & Planning（42）；Sales & Marketing（8）；Actuarial & Risk Modeling（7）；Compliance & Regulatory（5）；HR & Project Management（5）；Quantitative Finance & Trading（5）；Supply Chain & Logistics（2） |
| **Health & Medicine（155）** | Clinical Diagnostics & Imaging（71）；Clinical Informatics & Care（27）；Therapeutic & Oncology（25）；Public Health & Epidemiology（19）；Clinical Research & Trial Operations（13） |
| **Life Sciences（111）** | Biomolecular Structure & Design（55）；Genomics & Sequence Analysis（30）；Cell & Imaging Biology（13）；Systems & Microbial Biology（13） |
| **Physical Sciences（46）** | Chemistry & Materials Computation（17）；Physics（14）；Earth & Atmospheric Sciences（10）；Astronomy & Astrophysics（5） |
| **Transportation & Safety（35）** | Fire Science & Public Safety（19）；Aviation & Airspace Operations（13）；Maritime & Port Operations（3） |
| **Education & Information（33）** | Educational Technology（18）；Library & Information Science（9）；Translation & Localization（6） |
| **Psychology & Neuroscience（27）** | Experimental Psychology & Neuroimaging（19）；Computational Neuroscience（8） |
| **Social Sciences（26）** | Economics & Quantitative Social Research（26） |
| **Agriculture & Environment（19）** | Environmental Modeling & Water Resources（11）；Precision Agriculture（8） |
| **Legal（15）** | Litigation Support & Discovery（11）；Doctrinal Legal Research（4） |
| **Other（Figure 2 额外可见条带，3）** | Sports（3） |

**算术核对：**13 个具名行业域合计 1,487 个 instance；加 `Other → Sports` 的 3 个，共 1,490。具名行业域内有 54 个 subdomain；加 Sports 后为 55。

### 为什么官网 taxonomy 与论文可能对不上

ALE 是 living benchmark。2026-08-06 的官方 taxonomy 页面仍写 13 domains / 55 subdomains，但已经加入或重排 Marine & Naval Engineering、Fashion & Apparel 等条目，并不再以 v2 Figure 2 的 `Other → Sports` 形式展示。同理，当前 HF metadata 有 153 rows，而论文实验正文/附录分别出现 152/150 public task。研究和复现实验时必须固定版本、manifest 和日期。

## 问题 5：专家怎样生产 task？

### 参与角色

| 角色 | 主要责任 |
|---|---|
| Advisory committee | 画出各 domain 的 workflow landscape；识别 taxonomy 空缺；招募合适从业者。 |
| Domain practitioner / contributor | 提供过去做过的项目、input、软件、交付物、reference、标准与验收知识。 |
| AI-assisted portal | 降低结构化成本，提示专家补齐五项 task contract；不能替代领域责任。 |
| Automated / agent-assisted first-pass review | Figure 4 标为 `Auto-Review w. Agent`，检查代表性、复杂度、可验证性和规格完整度，给 revision/accept verdict；论文没有说明该 gate 是否另有独立人类 reviewer。 |
| Engineering team | 把文字方案变成 VM、assets、dependencies、`main.py`、grader 和 runnable variants；执行 dry-run。 |
| Final expert committee | peer review reference、reproducibility、evaluation bounds、context sufficiency，决定接受或返工。 |

### 从专家项目到 benchmark instance

1. external-submission 路线中，专家上传自己过去完成的项目，而不是从空白 prompt 开始“编难题”；corpus 另有 530 个 commissioned-build、internally authored variants。
2. 将真实项目压缩为一个可在 sandbox 中执行的明确范围，保留真实工具、输入与交付结构。
3. 补齐 instruction、inputs、target software、deliverable、evaluation specification。
4. 提供或协助构建 hidden reference、rubric、tolerance 与 anti-gaming gate。
5. 自动/agent-assisted first-pass review 提出 revision；专家补充隐含知识、依赖和正确结果。
6. 工程师实现 deterministic start state、文件 staging、software environment 与 evaluator。
7. 工程 dry-run 暴露 task-logic gap 与 missing dependency；grader bug、bounds 和 anti-gaming 等另由后续 QC/评分工程机制处理。
8. 专家委员会 final QC；不合格则返修，满足标准后才接收。
9. 通过后形成 runnable task instance，并按 release/contamination policy 进入 public 或 private pool。

### 来源口径的限制

不能把全部 1,490 个 instance 都描述成“外部专家原样提交”。Figure 5 明确分为：

- 960 external-submission variants；
- 530 commissioned-build variants（internally authored）。

此外，1,490 中还有 323 个 pending QC。最安全的说法是：ALE 的 task design 由领域专家来源与审核驱动，但 corpus 同时包含外部投稿和 commissioned 生产路线，并非所有收集项都已最终接收。Figure 5 的 960 external-submission variants 也不能直接等同于 C.3.7/Conclusion 的 960 workflows；论文使用了相同数字和不同单位标签，却没有给出映射。

## 问题 6：QC 流程到底检查什么？

### 五道 gate

| Gate | 核心问题 | 判定／反馈回路 |
|---|---|---|
| 1. Expert sourcing | 人是否真的熟悉该 workflow？taxonomy 覆盖是否有缺口？ | 定向招募；若不匹配则调整人选是本文合理归纳。 |
| 2. Submission & editing | 五项规格是否完整？是否来自真实工作？ | AI-assisted + 人工迭代补齐。 |
| 3. First-pass review | 是否满足代表性、复杂度、可验证性？ | Major/minor revision、borderline、accept、strong accept。 |
| 4. Implementation & dry-run | 环境能否启动？依赖是否齐全？grader 能否执行？任务逻辑是否闭合？ | 日志自动退回专家；工程返工。 |
| 5. Final expert QC | reference、reproducibility、bounds、context、evaluation integrity 是否合格？ | 最终调整后再审；合格才 admission。 |

### Appendix B.2 对 Final QC 明示的检查项

- **Reference correctness**：专家参考产出是否根本正确、完整、与 prompt 一致；
- **Reproducibility**：同一 spec 能否从确定初始状态稳定执行和重新评分；
- **Evaluation-bound calibration**：阈值既不能不可能地窄，也不能虚假地宽；
- **Context sufficiency**：agent 是否获得达到目标所必需的信息，而不是靠猜隐藏前提；

以上四项共同服务于 **reproducibility 与 evaluation integrity**。它们是最终委员会在 B.2 中明确写出的项目。

### Appendix C 另述的 evaluator/runtime 稳健性机制

- **Artifact shape and failure handling**：文件缺失、错误路径、格式/结构不符、解析失败时给定义明确的结果；
- **Reference isolation**：reference 在整个执行期间对 agent 不可访问，仅由 evaluator 在评分时读取；
- **Judge discipline**：能代码化就用代码；必须用模型时采用窄、reference-grounded probe，并记录 judge model/prompt；
- **Auditability**：保留 artifact、trajectory、logs 与评分元数据以供复核；
- **Task-specific gates**：碰撞、unsafe state、placeholder、provenance 或是否真正使用目标软件等，是若干任务的具体 gate 示例，不能当作所有 Final QC 委员会统一逐项检查的 checklist。

### Figure 5 的 QC/yield 快照

外部提交的 first-pass 状态：

| Verdict | Public | Private | Unverified | 合计 |
|---|---:|---:|---:|---:|
| Strong Accept | 42 | 86 | 0 | 128 |
| Accept | 25 | 344 | 0 | 369 |
| Borderline Accept | 35 | 122 | 0 | 157 |
| Minor Revision | 0 | 49 | 109 | 158 |
| Major Revision | 0 | 0 | 148 | 148 |
| **External subtotal** | **102** | **601** | **257** | **960** |
| Commissioned | 48 | 416 | 66 | 530 |
| **Total** | **150** | **1,017** | **323** | **1,490** |

`public + private = 1,167`，约占 1,490 的 78.3%；Figure 5 把它们呈现为 implemented，并把 323 单列为 unverified/pending QC。这个比例不是简单的“外部投稿 acceptance rate”，因为分母混合了 external 与 commissioned 路线，且 public/private 是 release state。

### QC 的局限

- deterministic grader 只意味着同一 artifact/code 下更可重复，不自动保证它完整代表专业质量；
- 对 open-sourced reference task tree 中 `main.py` 的静态分析显示，6.8% workflow 涉及 model judge，judge version/prompt 会漂移；这不是 960 workflow 或 1,490-item 全池的统计。
- outcome-oriented scoring 可能漏掉未编码的安全性、维护性、协作质量或不专业过程；
- 没有公开的独立全套 grader audit 或全任务 human inter-rater study；
- public task、grader 与代码仍可能被定向优化，private rotation 只能缓解污染。

---

# 第三部分：如何正确引用 ALE 结论

## 可以说

- ALE 评估的是配置完整的 agent stack，而不是裸 LLM。
- 它要求 agent 在 Windows/Linux 专业软件环境中做端到端数字交付，并按最终 artifact/state 评分。
- 任务准入原则是代表性、复杂度、可验证性。
- v2 Figure 5 显示 960 external + 530 commissioned，共 1,490 instance，其中 323 仍待 QC。
- v2 的 Last-Exam 是 38 题；大多数配置满分通过 0 题，少数 1 题；主流配置平均 Full Pass Rate `<1%`。
- 当前系统经常取得部分 rubric 分，却不能完整通过严格验收。

## 不应说

- “ALE 单独测出了模型的推理能力。”
- “1,490 个任务都已经通过 QC 并公开。”
- “2.6% 是 v2 中所有主流系统的平均 Last-Exam 通过率。”
- “ALE 证明 AI 已达到/未达到人类专家的某个百分比。”
- “ALE Full Pass Rate 就是岗位自动化率或现实可靠率。”
- “13/55 覆盖是按劳动市场权重得到的代表性样本。”
- “93.2% deterministic grader 说明所有评分都客观且无误。”

## 复现或比较时必须固定

1. paper/repository/dataset 版本与访问日期；
2. task workflow/instance manifest 与 tier membership；
3. evaluator、reference 与 judge model/prompt；
4. model + harness + system prompt + tools；
5. OS、VM image、software、hardware、network/credential policy；
6. 五小时上限、retry、并发、attempt selection；
7. Mean Score 还是 Full Pass Rate，以及聚合单位。

---

# 主源与版本记录

- [论文全文：arXiv HTML, 2606.05405v2](https://arxiv.org/html/2606.05405v2)
- [版本页：arXiv v2，2026-06-11](https://arxiv.org/abs/2606.05405v2)
- [Hugging Face Paper metadata](https://huggingface.co/papers/2606.05405) — 当前 metadata 的 headline 仍保留旧 `2.6%`，不可覆盖 v2 摘要的 `<1%`。
- [官方 living taxonomy](https://agents-last-exam.org/taxonomy) — 当前页面仍称 13/55，但内容已相对 v2 Figure 2 重组。
- [官方 Hugging Face dataset](https://huggingface.co/datasets/agents-last-exam/agents-last-exam) — 2026-08-06 页面显示 v1.0、153 rows；这不是 v2 冻结实验的 150/152 口径。
- [官方 repository](https://github.com/rdi-berkeley/agents-last-exam)
- [官方 framework docs](https://agents-last-exam.org/docs/ale/index.html)

## 最后一句话

ALE 真正追问的不是“LLM 知道多少”，而是：

> 一套完整 AI agent 能否在陌生的真实电脑环境里，把一项专业数字工作从任务说明推进到满足隐藏、严格且可复核验收条件的最终交付。

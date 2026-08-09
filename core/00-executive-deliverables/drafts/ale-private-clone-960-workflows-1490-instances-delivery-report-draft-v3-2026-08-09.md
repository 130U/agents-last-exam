# 从 Benchmaxxing 到客户私有 ALE-style Benchmark

## 客户私有 ALE-style Benchmark：960–1,000 个 Workflows / 1,490+ 个 Instances 的生产与交付方案

**文档状态：** 可交付初稿 v3，已按“单一客户私有 ALE 结构性复刻”收紧产品定义
**用途：** UniPat 面试作业 / 内部技术决策报告
**研究冻结日：** 2026-08-09
**ALE 冻结源：** arXiv `2606.05405v2`；GitHub `1e615e456de7cef57706680613cb80ee13c7fc76`；Hugging Face `a8c1fd174a1f6cfa76526572a2e3ebece1276be2`
**变更边界：** 本文件由 v2 复制后修改；v1、v2 与所有既有研究保持不变，可随时回退。

### 阅读标签

- **[F] 来源事实：** 固定论文、代码、数据、政府或方法文件直接支持。
- **[C] 作者/机构主张：** 来源对自身工作的描述，不等于独立验证。
- **[I] 研究者推断：** 把多项证据映射到本项目的分析。
- **[R] 项目建议：** 本方案建议采用的设计或流程。
- **[P] 待客户/Pilot：** 公开资料不能决定，必须由客户输入或 pilot 数据冻结。

---

## 开场：从公开榜单失真，到客户为什么需要私有 benchmark

这份方案的起点不是“再造一个榜单”，而是回答：当公开榜单越来越容易被训练、定向优化和反复试探时，客户还能怎样获得可信的模型能力信号？Surge AI 的 VP of RL Environments Nick Heiner 在 **2026 年 6 月 30 日 14:50–15:10**于旧金山 AI Engineer World’s Fair 发表 *When Will The Benchmaxxing Plague End?*；官方录像于 **8 月 2 日**上线，截至本报告 8 月 9 日冻结时刚好公开一周。[F] 因此，这不是一场“8 月举行的会议”，而是一份在本周刚进入公开传播、并已被本方案吸收的最新行业材料。把现场日期与公开视频日期分开，既保留时效性，也不制造事实错误。

Heiner 用 *benchmaxxing* 描述一种测量失真：团队围绕 benchmark reward 攀升，结果却可能偏离用户真正关心的能力；自动英文字幕将其概括为 **“benchmarks don’t always equal reality.”** [C] 我把他的论证归纳成六个控制点——这不是演讲者自行编号的“六条定律”：用真正的领域专家定义任务与成功；使用来自真实工作的高保真输入；保证 agent 所需工具可用；让题面要求与 verifier 双向对齐；进行严格的端到端 QC；保留私有 holdout，并在写作等主观任务上选择性使用专业盲评。[I] 这些观点是产业演讲者的主张，不是 ALE 有效性的独立证明；但它们准确提出了客户为什么愿意购买私有 benchmark 的问题。

**ALE 能够解决公开题长期暴露后，分数越来越难代表“未见任务能力”的问题。** 当题面、答案、reference 或 grader 长期公开时，材料可能进入训练语料，团队也可以围绕固定评分逻辑反复调参。ALE 的关键回应不是让题面“更神秘”，而是把大量 concrete instances、hidden references 和 evaluators 留在受控访问边界内。客户购买的因此不是一批稀缺 prompt，而是一套只有自己可以访问、能够隔离 development 与 sealed final、并在暴露或污染后轮换的测量资产。[F/I]

**ALE 能够解决 benchmark task 与真实专业工作脱节的问题。** 它要求专家提供端到端 workflow，明确 Description、Input、Software、Output 与 Evaluation；agent 必须在 Windows/Linux 环境和真实软件中形成文件或系统状态，随后由 task-specific evaluator 检查实际交付物，而不是只对一段自然语言答案打分。[F] 这把“真实输入、可用工具、verifier 对齐和 QC”从口号变成了可交付组件，也正是私有化复刻时最值得继承的部分。

ALE 仍不是 benchmaxxing 的完整解药。Private 不等于零污染；近重复泄露、grader gaming、harness 差异、版本漂移、领域抽样偏差和不充分 QC 仍会扭曲结果。[I] 因此，本项目复刻的是 ALE 的 coverage architecture、任务结构、环境、evaluator、专家生产链和 instance 配额，而不是复制 ALE 的公开题面、reference、代码或第三方受许可资产。[R]

> **Operating principle：Manage this as a private measurement-system build, not an annotation batch.**

Hook 只承担问题框定；六点与 ALE 的逐项映射见 2.7。演讲来源为 YouTube 自动英文字幕，中文为本报告翻译；演讲中的工时与成本示例不构成本项目预算证据。会议日期来自[官方 2026 archive](https://www.ai.engineer/worldsfair/2026)，场次来自[官方日程](https://www.ai.engineer/worldsfair/schedule?view=list)。详见[面试 Hook 研究](../../00-project-context/benchmaxxing-interview-hook-brief-2026-08-08.md)。

---

# 1. Executive Decision Memo

## 1.1 已冻结的产品定义

**[R] 本报告直接采用以下交付口径：**

> 为单一客户建设一套原创、封闭、可运行的 ALE-style 私有 benchmark 仓库与评测服务。基础层按 ALE arXiv v2 的量级和结构生产 **960 个通过最终验收的 distinct workflow packages，以及 1,490 个通过最终验收的 runnable instances**。每个 workflow 至少含一个 canonical instance；其余 530 个 instances 必须提供新的测量信息。根据客户特有的语言、地区、软件、监管或高风险能力缺口，可另增最多 40 个 gap-fill workflows。因此最终交付为 **960–1,000 workflows、至少 1,490 instances**，全部在商业访问意义上归客户私有，不设 public release。

这里的“复刻”是结构性复刻，不是内容复制：复刻 13/55 taxonomy、Figure 2 的 1,490-instance 分布、workflow→environment→reference→evaluator 任务骨架、生产 QC 与私有治理；题面、输入、reference、grader 和环境实现必须原创或合法授权。[R] ALE v2 的 1,490 inventory 含 323 个 pending-QC 条目；本合同要求交付的 1,490 个均须 final-QC accepted，因此验收标准比论文 inventory 状态更严格。[F/R]

## 1.2 建议批准的生产策略

1. **Freeze blueprint：** 把 ALE v2 Figure 2 的 55 个 subdomain instance 数固定为基础配额；不再重新讨论要不要采用 ALE 的总体分布。
2. **Design workflow map：** 在这 1,490 个 instances 下原创设计 960 个 parent workflows；ALE 没有公布逐 subdomain workflow 表，因此本项目必须交付自己的 `workflow_id → instance_id` crosswalk。
3. **Pilot：** 用跨领域、跨软件、跨 evaluator family 的分层样本验证这张蓝图是否可执行，而不是用 pilot 重新投票决定总体分布。
4. **Calibrate：** 测量 cycle time、返工、acceptance yield、evaluator 误判、环境失败、重复运行方差和人类对照可行性。
5. **Scale：** 只对通过 advance gate 的生产单元分波次扩产；每个 workflow 与 instance 均须独立通过最终验收。
6. **Operate：** 保留 artifact、trajectory、版本、权限和审批证据，并建立 private final、rotation reserve、quarantine、repair 与 retirement。

## 1.3 已经定下来的内容，与必须实测的内容

**承诺建立的能力：**

- 定义清楚、可运行、可验证、可审计的 benchmark asset；
- 从专家 workflow 到 runnable instance 的受控生产线；
- 分离 authoring、engineering、scoring、blind solve 与 final approval；
- 能区分 agent、evaluator、environment 和 integrity failure；
- 用 pilot 数据形成可审计的 staffing、成本、排期和扩产决策。

**产品层面已经定下：** 单一客户私有；960 个 base workflows；1,490 个 base instances；按 Figure 2 的 55-subdomain instance 分布复刻；最多 40 个 customer-specific gap-fill workflows；全部资产以 manifest 验收，不设 public release。

**仍需由 pilot 实测，而不是凭空填数：**

- 人数、周期、预算、各角色 throughput、acceptance yield 与返工率；
- 1,490 个 instances 在内部 development、validation、sealed final 与 rotation reserve 之间的用途分配；
- 所有 task 都使用 deterministic evaluator；
- benchmark score 代表 human parity、岗位替代、经济影响或真实部署可靠性；
- 客户私有资产绝对没有污染或内部泄漏；
- refresh 后的新旧分数天然可比。

## 1.4 立项时只需确认的执行参数

1. **主要使用场景与 claims：** 模型选型、供应商验收、能力研究或内部风险门禁；结果默认只描述冻结配置下的私有 benchmark 表现。
2. **客户差异层：** 是否启用最多 40 个 gap-fill workflows，以及优先语言、地区、软件、监管和风险场景。
3. **Operating envelope：** 数据、license、credential、network、retention、单次运行预算和允许的专业软件。
4. **Ownership：** Benchmark Owner、Rights/Security Owner、Final Approver，以及是否采购持续托管、运行、refresh 与 incident SLA。

---

# 2. ALE 到底测什么

## 2.1 评测对象是 configured agent system

**[F]** ALE 的运行单位不是裸 foundation model。一次可比较结果由以下整体共同决定：

```text
model/provider snapshot
× agent harness and prompts/context
× tools and GUI/CLI bridge
× environment, software and network policy
× time/token/cost budget and retry policy
× task, hidden reference and evaluator revision
```

官方固定代码把一次 run 组织为 `agent × environment × task`：创建 sandbox、注入 input、运行 agent、结束后注入 hidden reference、评分并保存日志、trajectory 与 artifact。[F] 因此，任何结果表必须发布完整 configuration card；“某模型得分”只是简写，不能隐藏 harness、budget 或 evaluator 差异。

## 2.2 冻结来源与单位台账

| Surface | 冻结版本 | 数量与单位 | 在本报告中的用途 |
|---|---|---|---|
| ALE paper | arXiv `2606.05405v2` | 1,490 task instances；150 public、1,017 private、323 pending QC；13 domains、55 subdomains | 论文设计、生产与 release-state 事实 |
| Paper Figure 5 | 同上 | 960 external submissions、530 commissioned tasks | 来源/provenance 分解；不是 workflow 数 |
| ALE workflow 叙述 | 同上 | 960 workflows | workflow 口径；与 Figure 5 的 960 无公开 row-level crosswalk |
| GitHub | commit `1e615e4…` | selected split 152 paths；task tree 165 folders | 固定可执行实现审计 |
| Hugging Face | revision `a8c1fd1…` | 153 metadata rows | 固定 task-card metadata 审计 |
| 本项目代码路径审计 | 上述 Git/HF 快照 | 141 deterministic、7 hybrid、5 LLM-judge | “谁实质决定最终分数”的审计分类，不是生产配额 |

这些数字回答不同问题，不能平均、相加或互相“纠错”。特别是 pending-QC 不应计入 accepted inventory；metadata row、task folder 和 runnable instance 也不是同义词。论文快照中的 public 比例若以全部 1,490 instances 为分母是 `150 / 1,490 = 10.1%`；若只以已经标成 public 或 private 的 1,167 条为分母，则是 `150 / 1,167 = 12.9%`。两种口径都不是 20%，报告必须同时写清分母。[F] 完整解释见[技术蓝图](../../02-1000-task-delivery-design/02-ale-blueprint-and-version-audit/technical-blueprint-2026-08-08.md)和[公开 corpus 审计](../../02-1000-task-delivery-design/03-public-task-corpus-audit/public-corpus-audit-report.md)。

## 2.3 Workflow 与 instance：不能简化成“母题换数字”

**[F]** ALE v2 将 workflow 定义为端到端专业工作，把 task instance/variant 作为共享 evaluator、但 inputs 与 reference 不同的具体可运行案例。因而，“960 个母题、1,490 个改数据版本”可以作为直觉起点，却不是足够精确的产品定义：合法 variant 可以改变输入、reference、约束、状态、难度机制或失败模式；只换姓名、日期、seed 或表面数值的 cosmetic variant 不应增加付费数量。[R]

论文的两个 `960` 也不能互换：一处是 workflow 总量；Figure 5 的 `960 external submissions` 是来源/provenance 计数。公开论文没有提供逐行 crosswalk。[F] 同样，1,490 包含 323 个 pending QC，不能声称全部都是 final-QC accepted assets。

## 2.4 13、14 与 55：冻结 taxonomy 的完整解释

**结论：正式口径是 13 domains、55 subdomains。** arXiv v2 Figure 2 视觉上显示 13 个具名行业域，另有一个 `Other → Sports` 条带；只有把 Sports 计入才得到 55 个 subdomains 和 1,490 instances。论文没有把 `Other` 明确定义为第 14 个正式 domain。当前官网则已更新为严格的 13×55×100 living taxonomy，不再显示 `Other/Sports`。[F]

下表使用本报告的冻结主版本——arXiv `2606.05405v2` Figure 2。对本项目而言，它不只是背景材料，而是 **1,490 个 base instances 的直接生产配额**：每一个数字都进入基础交付 manifest。需要同时强调，它给出的是 instance 数，不是 workflow 数。

| v2 顶层域（instance 数） | v2 subdomains（instance 数） |
|---|---|
| Engineering & Architecture（368） | Manufacturing & Industrial Systems（173）；Aerospace & Mechanical Engineering（47）；Civil, Architectural & Geospatial Engineering（33）；Robotics & Autonomous Systems（29）；Semiconductor & Microelectronics Design（28）；Electronics Engineering（23）；Chemical & Process Engineering（17）；Mining, Petroleum & Geological Engineering（9）；Urban & Spatial Planning（5）；Energy, Power & Nuclear Engineering（4） |
| Computing & Mathematical Sciences（237） | Data & Analytics Engineering（57）；AI Engineering & CS Research（50）；Software Engineering（38）；Mathematical & Operations Research（35）；Cybersecurity & Forensics（28）；Quantum Computing（16）；Infrastructure Engineering & Cloud Operations（13） |
| Visual & Media Arts（226） | 3D, Animation & Interactive Media（133）；Audio, Music & Post-Production（69）；Graphic, Visual & Product（24） |
| Business & Finance（189） | Accounting & Finance（115）；Enterprise Analytics & Planning（42）；Sales & Marketing（8）；Actuarial & Risk Modeling（7）；Compliance & Regulatory（5）；HR & Project Management（5）；Quantitative Finance & Trading（5）；Supply Chain & Logistics（2） |
| Health & Medicine（155） | Clinical Diagnostics & Imaging（71）；Clinical Informatics & Care（27）；Therapeutic & Oncology（25）；Public Health & Epidemiology（19）；Clinical Research & Trial Operations（13） |
| Life Sciences（111） | Biomolecular Structure & Design（55）；Genomics & Sequence Analysis（30）；Cell & Imaging Biology（13）；Systems & Microbial Biology（13） |
| Physical Sciences（46） | Chemistry & Materials Computation（17）；Physics（14）；Earth & Atmospheric Sciences（10）；Astronomy & Astrophysics（5） |
| Transportation & Safety（35） | Fire Science & Public Safety（19）；Aviation & Airspace Operations（13）；Maritime & Port Operations（3） |
| Education & Information（33） | Educational Technology（18）；Library & Information Science（9）；Translation & Localization（6） |
| Psychology & Neuroscience（27） | Experimental Psychology & Neuroimaging（19）；Computational Neuroscience（8） |
| Social Sciences（26） | Economics & Quantitative Social Research（26） |
| Agriculture & Environment（19） | Environmental Modeling & Water Resources（11）；Precision Agriculture（8） |
| Legal（15） | Litigation Support & Discovery（11）；Doctrinal Legal Research（4） |
| Other（额外可见条带，3） | Sports（3） |

算术校验：13 个具名域合计 54 个 subdomains、1,487 instances；加 `Other → Sports` 后为 55 和 1,490。[F] Current live taxonomy 新增/重排了 Marine & Naval Engineering、Fashion & Apparel 等成员，因此不能用今天的网页目录静默改写论文快照。

## 2.5 Taxonomy 如何转化为专家招募结构

不同 subdomain 不能只靠一个“domain 通才”覆盖。建议把 taxonomy 转成三层专家组织：[R]

1. **Domain Group Lead：** 负责 workflow landscape、能力边界、scenario matrix、guideline、升级规则和跨 subdomain 去重；不必是每个软件的最终权威。
2. **Subdomain Author / Reviewer：** 按具体职业实践、软件、法域或科研方法匹配，分别负责真实任务来源和独立专业复核。
3. **横向工程角色：** environment、evaluator、rights/security 和 QA 跨 domain 复用框架，但必须在每个 task 上与相应 SME 共同签字。

| Domain lane | 需要覆盖的典型专家画像 | 招募与验收重点 |
|---|---|---|
| Engineering & Architecture | CAD/CAE、制造、电子、半导体、能源、土木/地理、机器人等从业者 | 软件与版本高度碎片化；单位、标准、几何和物理边界必须可验证 |
| Computing & Mathematical Sciences | 软件、数据、AI 安全、运筹、网络安全、云基础设施、量子计算专家 | repository/infra 权利、可执行 tests、security sandbox 与 alternate solution |
| Visual & Media Arts | 3D/动画、视听后期、平面/产品设计从业者 | 资产版权、主观质量与结构化/视觉 evaluator 的边界 |
| Business & Finance | 会计/FP&A、精算、风控、合规、HR/PM、营销、量化、供应链专家 | 数据口径、审计链、监管地域和多种合法决策方案 |
| Health & Medicine | 临床影像、诊疗、医疗信息化、公卫、临床试验专业人员 | 患者隐私、执业边界、高风险 claims 和人工仲裁 |
| Life Sciences | 结构生物、基因组、成像、系统/微生物研究人员 | 数据库版本、实验假设、科学软件和 reference provenance |
| Physical Sciences | 物理、计算化学/材料、天文、地球/大气科学研究者 | 数值方法、单位、收敛性、观测/模拟数据版本 |
| Transportation & Safety | 航空空域、港航、消防与公共安全人员 | 安全关键规则、区域法规、仿真与操作状态证据 |
| Education & Information | 教育技术、图情、翻译与本地化专家 | 语言/地区、内容授权、检索 provenance 与语义评价 |
| Psychology & Neuroscience | 计算神经、实验心理、神经影像研究人员 | 人体数据伦理、统计 protocol、分析工具链与结果解释 |
| Social Sciences | 经济与定量社会研究人员 | sampling、因果/相关边界、敏感数据和政策语境 |
| Agriculture & Environment | 水资源/环境建模、精准农业、农艺专家 | 地域与季节、地理数据、传感器/模型、环境许可 |
| Legal | 诉讼支持/e-discovery、法 doctrinal research 专家 | 法域、有效日期、保密特权、citation 与不可执业声明 |

这个表定义的是 sourcing lanes，不是固定 headcount。最终 roster、每个 subdomain 的 author/reviewer 数量和软件覆盖由 pilot 中的 candidate supply、分歧、返工和工程长尾决定。[P]

## 2.6 ALE 的贡献与边界

**[I] 更准确的贡献定位：** ALE 并非首创 GUI task、专家出题、private test 或自动 grader；它的差异在组合层——跨 13 个行业集群的专业 workflow、Windows/Linux 实际软件环境、task-specific executable evaluator、专家生产链，以及 public/private/pending/rolling 的长期运营设想。

**[I] 仍未自动解决：**

- deterministic scorer 仍可能漏检要求、误拒合法多解或奖励 shortcut；
- hidden reference 的 post-run staging 是时序控制，不一定构成独立信任边界；
- private 并不能排除 pretraining exposure、search-time contamination 或内部泄漏；
- fixed benchmark aggregate 不代表目标职业总体；
- agent system 在 benchmark 上成功不等于组织部署中创造同等经济价值。

因此，本方案继承 ALE 的工程骨架，但把 validity、integrity、统计不确定性、人类基线与生命周期治理提升为独立工作流。

## 2.7 演讲六点与 ALE 的对应关系

| 演讲提出的 benchmark 控制 | ALE 已工程化的部分 | 私有复刻仍需补强的部分 |
|---|---|---|
| 领域专家定义任务与成功 | 250+ 专家来源；五项 task specification；专家 final QC | 资格证据、COI、author/reviewer 分离与客户领域适配 |
| 真实工作的高保真输入 | 真实职业 workflow、专业软件、文件与环境状态 | 原创/脱敏输入的权利、地区与时间有效性 |
| 工具必须真正可用 | Windows/Linux sandbox、GUI/CLI、task setup | license、credential、network policy、health/reset SLA |
| 题面与 verifier 双向对齐 | task-specific `evaluate()`、hidden reference、部分 credit | alternate-correct、near-miss、tamper、shortcut 与 mutation tests |
| 严格端到端 QC | first-pass review、engineering implementation、dry-run、expert final QC | 独立 blind solve、缺陷仲裁、版本变更和 incident ledger |
| 私有 holdout；主观任务可用专家盲评 | 论文保留 private inventory，运行时评分以代码/窄 judge 为主 | 客户内部用途分池；写作/设计/高风险任务选择性盲评 |

这个映射说明 ALE 回应了 benchmaxxing 的两个核心机制——公开暴露与任务失真——但没有让 evaluator validity、内部泄漏或主观价值判断自动消失。也因此，本项目交付的是可运营的私有测量系统，而不是把 1,490 个题面放进一个文件夹。[I/R]

---

# 3. 我们究竟交付什么

## 3.1 七个独立计数器

```text
S = expert submissions / candidate ideas entering review
C = commissioned source packages or projects
W = final-accepted distinct workflow packages
I_canonical = one canonical runnable instance per accepted workflow
I_variant = additional accepted instances with marginal measurement value
G = accepted customer-specific gap-fill workflows, 0 ≤ G ≤ 40
I_total = I_canonical + I_variant + I_gap
R = agent runs used for dry-run, validation, calibration or evaluation
```

基础合同为：

```text
W_base = 960
I_canonical = 960
I_variant = 530
I_base_total = 1,490
0 ≤ G ≤ 40
W_total = 960 + G
I_total ≥ 1,490 + G
R = Σ_(configuration × accepted instance × planned trials)
```

这些计数器不可互换。同一 instance 的 repeated trial、retry、best-of-k、regrade 和 repaired execution 均不增加 `W` 或 `I_total`。基础层直接采用 960/1,490 的 ALE-v2-matched 结构，但这不是说 ALE 的每个 workflow 平均必须有 1.55 个 instances；530 个 additional instances 必须逐条证明边际测量价值。Gap-fill workflow 至少附带一个 accepted canonical instance，单独标为 `customer_specific_extension`。

## 3.2 Workflow package contract

每个计入 960–1,000 的 workflow package 至少包含：

1. **Workflow identity：** 唯一 `workflow_id`、professional goal、target capability、process boundary、output contract、evaluator contract、去重与 identity adjudication。
2. **Task spec：** 目标能力、participant-visible instruction、constraints、allowed resources、output contract 和结束条件。
3. **Input pack：** 固定 bytes/hash、schema、provenance、授权、异常约定和可见性。
4. **Environment pack：** OS/image、软件及插件、license、locale/timezone、network、accounts、start/reset 和 health checks。
5. **Reference pack：** hidden reference、合法等价空间、rubric/invariants、provenance、review 与 custody。
6. **Evaluator pack：** executable scorer、score semantics、版本、component evidence、失败语义与 regression tests。
7. **Protocol manifest：** harness、prompt/context、tools、budget、attempt/retry、seed/trial policy 和 telemetry。
8. **QA pack：** author demo、blind solve、engineering dry-run、evaluator red team、domain review、rights/security clearance 与 final approval。
9. **Governance pack：** pool/access、incident、repair、regrade、rotation、retirement 和 lineage。
10. **Run evidence：** immutable artifacts、logs、trajectory、environment attestation、raw score 与 failure label。

## 3.3 Definition of Done

一个 workflow package 只有同时满足以下条件才计入 960–1,000：

- 至少一个 canonical runnable instance 在 clean environment 中可重建，start/reset/health contract 可重复执行；
- participant-visible packet 足以让未见 reference 的 solver 完成任务；
- hidden reference 与 execution plane 隔离，input/reference/evaluator 均有 hash 和版本；
- evaluator 接受 gold 与合法 alternate-correct，拒绝针对性 known-bad、near-miss、mutation 与 shortcut；
- domain、engineering、rights/security 与 final approval 均完成，且不存在硬性角色冲突；
- release、access、refresh、incident 和 retirement owner 已登记；
- 所有 mandatory defect 已关闭，任何 residual risk 均有书面例外与补偿控制。

## 3.4 不计入交付数量的对象

- task idea、prompt、task card、metadata row、只有 specification 而没有 canonical runnable instance 的 workflow，或未经实现的 submission；
- pending-QC、rights blocked、无法重建或 evaluator 未验证的条目；
- 只替换名字、文件名、seed 或表面数值的 pseudo-variant；任何 extra variant 均不增加 workflow count；
- 同一 instance 的 trial、retry、resume、regrade 或 best-of-k；
- 因 reference leakage、grader defect 或环境漂移而被 quarantined 的旧版本；
- 只在作者机器或污染状态下通过、无法在 clean holdout 重现的结果。

## 3.5 Pool architecture

**商业访问边界只有一个：全部属于客户私有资产。** 在这个边界内，再按“是否已被客户开发团队看过、能否支持 unseen claim”分成五种用途；这里没有 public pool，也没有对外发布比例。

| 用途 | 主要目的 | 允许反馈 | 关键边界 |
|---|---|---|---|
| Client-private Development / Integration | 示例、工具接入、内部调试 | 高 | 仍是商业机密，但分数不代表 unseen final |
| Restricted Validation | 迭代、校准、内部比较 | 受控 | 明确属于 adaptive evaluation |
| Sealed Private Final | 冻结配置的最终 unseen 测量 | 极低 | 不作为 debug oracle |
| Private Rotation Reserve | 替换、freshness、事故恢复 | 默认无 | 有 burn/disposition rule |
| Client-private Training purpose | 仅在合同明确允许时训练 | 由合同定义 | concrete instance 一旦用于训练，永久失去 final 身份 |
| Retired archive | 历史审计、回放、bounded regrade | 只读 | 不静默恢复为 unseen |

内部用途分配在 pilot 后写入 access manifest；它不是“public/private 比例”。全部客户私有也不等于全部都是未见 holdout：被客户看过、训练过或反复查询过的实例仍属商业机密，却不能再支持 unseen-generalization claim。[R]

---

# 4. 怎样把 ALE 的 960-workflow / 1,490-instance blueprint 复刻成客户私有仓库

## 4.1 不再开放式选题：基础配额直接冻结

**[R]** 基础层不再做“怎样选出最优 1,000 个”的 portfolio 优化。项目直接冻结 ALE v2 Figure 2 的 55 个 subdomain 与 1,490 个 instance counts，逐项生产原创、可运行、通过 final QC 的对应资产。这既回答了面试题的 ALE 复刻语境，也避免在没有客户业务分布时凭空发明另一套配额。

## 4.2 从 1,490 个 instance 配额重建 960 个 workflows

ALE 公开材料没有给出 960 个 workflows 在 55 个 subdomain 中的逐项分布。因此，本项目采用以下明确规则重建，而不把推导结果冒充为 ALE 官方表：

1. 每个 subdomain 的 `instance_quota` 必须与 Figure 2 完全一致，总和为 1,490。
2. 每个 subdomain 至少有一个独立 workflow；每个 workflow 至少有一个 canonical instance。
3. 先为 1,490 个 instances 建立 workflow identity clusters，再在全局完成 `W_base = 960` 的合并/拆分仲裁。
4. 同一 workflow 的 additional instances 必须共享 professional goal、process boundary 和 evaluator contract，同时改变关键输入、状态、约束、失败模式或 reference；cosmetic variant 不得计数。
5. 最终交付完整的 `subdomain → workflow_id → instance_id → evaluator/environment` crosswalk。该 crosswalk 是本项目原创的生产设计，也是付款与去重依据。

为了使 workflow 分布不是“拍脑袋”，本方案采用一条可复算的 Hamilton largest-remainder rule：

```text
q_s = 960 × I_s / 1,490
W_s = Hamilton_largest_remainder(q_s)
```

先取每个 subdomain 的 `floor(q_s)`，再把余下 23 个 workflow slots 分配给小数余数最大的 subdomains；余数相同时按 Figure 2 顺序处理。由此得到的 domain-level 生产账如下：

| Figure 2 grouping | Instances | 重建 workflows | Additional instance slots |
|---|---:|---:|---:|
| Engineering & Architecture | 368 | 238 | 130 |
| Life Sciences | 111 | 70 | 41 |
| Education & Information | 33 | 22 | 11 |
| Agriculture & Environment | 19 | 12 | 7 |
| Computing & Mathematical Sciences | 237 | 153 | 84 |
| Health & Medicine | 155 | 99 | 56 |
| Transportation & Safety | 35 | 22 | 13 |
| Psychology & Neuroscience | 27 | 17 | 10 |
| Other → Sports | 3 | 2 | 1 |
| Visual & Media Arts | 226 | 147 | 79 |
| Business & Finance | 189 | 121 | 68 |
| Physical Sciences | 46 | 30 | 16 |
| Social Sciences | 26 | 17 | 9 |
| Legal | 15 | 10 | 5 |
| **总计** | **1,490** | **960** | **530** |

这意味着可以精确“照抄”的是 1,490-instance mix；上表的 960-workflow map 是本项目对公开 instance vector 的透明重建，并非 ALE 官方公布的 workflow-by-subdomain manifest。完整 55 项 workflow 配额见附录 E。

## 4.3 硬门槛与合法替换

每个 workflow/instance 仍须通过不可补偿的硬门槛：

1. **Runnable：** 能在可支持的 substrate 中重建和执行。
2. **Legally usable：** input、reference、软件和输出有可记录的使用权。
3. **Minimally verifiable：** 成功标准可以转成 artifact/state evidence。
4. **Safe and privacy compliant：** 不需要不可接受的个人、客户或高危数据暴露。
5. **Identity-resolved：** 能判断它是新 workflow、合法 variant 还是重复/伪变体。

任一硬门槛失败，候选不得用高商业价值或低成本“补分”。

若某个 ALE-style 配额需要的软件、数据或工作方式无法合法复现，供应方不能直接删除该槽位，也不能把它移到更容易的领域。必须在同一 frozen subdomain 内做等 construct 替换，记录原始 intent、阻断原因、替代 workflow、能力等价性和 Final Approver 签字。若无法维持 construct，则触发 rescope/stop，而不是静默改变分布。

## 4.4 Workflow identity 与合法 instance

**合法 variant 必须改变至少一种有测量意义的结构：** 重要状态、信息可得性、失败模式、约束组合、artifact 结构、决策边界或难度机制；并且共享 evaluator 仍能证明 validity。

识别流程应把 task/input/reference/evaluator/environment hashes、exact/fuzzy/multimodal near-duplicate 检测、semantic/graph workflow comparison、external benchmark overlap、candidate systems 的 response vector，以及 blind expert identity adjudication 组合起来；任何单一信号都不能独自证明 workflow identity。

只改姓名、日期、随机种子、文件名或无实质意义的数字，不得作为新 instance 计数。

## 4.5 最多 40 个 gap-fill workflows

40 个扩展位不是为了把 960 “凑成一个好看的整数”。只有出现以下证据之一才启用：客户特有的语言/地区/监管/软件缺口；pilot 发现的关键未测失败模式；重要结论过度依赖单一 workflow/evaluator/software；或 ALE 蓝图与客户 intended use 存在可证明的 decision loss。每项扩展须有 Benchmark Owner 的 gap statement、Rights/Security clearance、完整 QA 和 Final Approver 批准。供应方因重复、权利失败、evaluator 缺陷或未过 QC 导致的 base rejection，必须免费替换到 960 个 accepted workflows，不能计作 gap-fill。

---

# 5. 从专家 workflow 到 accepted asset

## 5.1 对 Micro1 经验的继承与增强

我在 Micro1 参与过一条相似的数据生产链：group lead 先阅读业务材料、公开研究与真实 raw data，提炼 capability、关键变量和误判场景；再把 Golden case 拆成 scenario matrix、rubric、ranking、checklist 与答疑材料；标准稳定后才进行专家筛选和人员配置；少量最匹配专家进入 batch zero，分歧后判断是 guideline、专家理解还是 case 本身的问题；表现最好的专家可以进入 reviewer pipeline，日常问题交给运营，例外升级给 lead。

**[I] 这套经验的顺序逻辑与 ALE 的 expert sourcing → first-pass review → engineering dry-run → expert final QC 相容，但公开来源不能证明 Micro1 的人数、产能或阈值适用于本项目。**

本方案保留上述方法，并增加六个控制：

1. owner mandate 与 claim boundary；
2. rights/security/COI 在任务实现前置；
3. author、blind solver、reviewer、reference custodian 与 final approver 分离；
4. Golden 从“一个标准答案”升级为 executable evidence pack；
5. 所有答疑与 tolerance 进入 versioned change control；
6. 上线后持续抽审、incident、repair、rotation 和 retirement。

## 5.2 G0–G8 production gates

| Gate | 核心工作 | 放行证据 | 主要负责角色 |
|---|---|---|---|
| G0 Owner mandate | intended use、construct、unit、claim、risk appetite | scope memo、unit ledger、open decisions | Benchmark Owner |
| G1 Rights/security envelope | data、license、PII、COI、custody | rights map、access matrix、incident route | Rights/Security |
| G2 Lead calibration | scenario matrix、Golden、guideline、FAQ | demo + blind evidence；ambiguity ledger | Group Lead |
| G3 Qualification & assignment | 身份/claim、结构化面试、blind work sample | role-specific qualification packet | Group Lead / Ops |
| G4 Authoring & engineering | spec、input、reference、environment、evaluator | versioned runnable package | Task / Env / Eval Engineers |
| G5 Batch zero | crossed blind runs 与六类根因诊断 | artifact、trace、disagreement 与修复证据 | Group Lead |
| G6 Release assurance | domain、technical、rights/security 集成复核 | release memo、limitations、独立签字 | Final Approver |
| G7 Controlled production | 波次生产、抽审、funnel 与 drift monitoring | 批次 ledger、quality/integrity dashboard | Benchmark Owner / Ops |
| G8 Refresh/incident | quarantine、repair、invalidate、rotate、retire | impact analysis、new version、closure | Owner + Rights/Security |

## 5.3 专家资格不是“看简历”

角色资格使用证据链，而不是单一 seniority：

```text
identity and critical-claim verification
→ structured interview
→ blind role-relevant work sample
→ role-specific Golden task
→ shadow production and calibration
→ time-bounded authority with requalification
```

- **Domain expert：** 当前专业判断、法规/变量/反例与合理多解。
- **Practitioner author：** 在目标软件中完成真实 workflow，并能拆成 spec/reference/evaluation。
- **Group lead：** 建 guideline、诊断歧义、维护变更与 escalation。
- **Independent solver：** 未见 reference，仅凭 participant-visible packet 在 clean environment 执行。
- **Domain reviewer：** 判断领域正确性、alternate-correct 和实质错误，并给出可审计理由。

简历、学历、证书和作品可以证明 identity、scope 与历史 claim，但不能单独证明当前项目能力。[I]

## 5.4 Batch zero 是 fault-isolation experiment

Batch zero 不追求数量，而是定位六类根因：

```text
guideline/spec
expert/solver understanding
case/input
environment
reference
evaluator
```

通过 blind solve、component swap、clean reset、artifact/trajectory 保留与独立仲裁判断 primary cause 与 contributing causes。Agreement 是症状指标，不是 validity 本身。只有完成修复、回归并形成稳定 decision rules 的 strata 才进入 controlled production。

## 5.5 RACI 与硬性角色冲突

完整 RACI 需要在 pilot 前填入具体人员。初稿的最小责任结构如下：

| Activity | Accountable | Responsible | 必须咨询/独立复核 |
|---|---|---|---|
| Construct、scope、acceptance policy | Benchmark Owner | Owner / Research Lead | Domain、Engineering、Rights、Final Approver |
| Guideline 与 Golden | Group Lead | Lead + Author | Solver、Reviewer、Evaluator Engineer |
| Runnable package | Task Engineer | Task / Environment Engineers | Author、Evaluator、Rights |
| Evaluator validity | Evaluator Engineer | Evaluator Engineer | Domain Reviewer、independent technical accepter |
| Blind solve | Group Lead | Independent Solver | Ops；不得见 reference |
| Domain disposition | Domain Reviewer | Domain Reviewer | Author 可答疑但不表决 |
| Rights/security clearance | Rights/Security Owner | Rights/Security | Ops、Reference Custodian |
| Release readiness | Final Approver | Final Approver | 各工作流 owner；独立签字 |
| Incident/repair/retire | Benchmark Owner | Root-cause owners + Ops | Rights/Security、Final Approver |

硬性不兼容至少包括：`Author ≠ Blind Solver`；author 不得是 sole domain reviewer；task/environment/evaluator builder 不得 final-approve 自己的资产；solver 不审自己的 run；reference custodian 不参与 blind solve；incident subject 不担任独立 investigator 或 closure approver。小团队无法完全分离时，必须记录 compensating control、范围、有效期与 independent countersignature。

---

# 6. 怎样证明分数可信

## 6.1 Evaluator mode 不等于 validity

`deterministic / hybrid / LLM-judge` 只说明 scorer 怎样执行。Validity 要回答：这个冻结的 task/reference/evaluator/protocol 产生的分数，是否支持计划中的能力解释和业务用途。

每个 atomic requirement 建立双向链：

```text
prompt clause
→ intended construct
→ reference element / legitimate equivalence
→ executable check
→ retained evidence
→ positive and negative fixtures
```

Forward coverage 防止题面要求未评分；backward coverage 防止 scorer 奖励题面没有授权的捷径。只有既接受合法答案、又拒绝针对性错误的 check 才算有 discrimination evidence。

## 6.2 Minimum evaluator test library

每个 evaluator 至少覆盖以下 failure mechanisms，数量由风险和 pilot 决定：[R/P]

- gold；
- known-bad；
- alternate-correct；
- near-miss 与 boundary；
- corrupt / missing artifact；
- mutation 与 metamorphic relation；
- surface-compliant-but-wrong；
- shortcut / reward gaming；
- grader tampering 与 prompt injection；
- environment / dependency failure；
- cross-version replay；
- minimized counterexample 与 targeted regression。

Exact/hash 只适用于 identity 本身就是要求的对象；schema 证明结构，不能替代语义；visual similarity 不能证明可编辑、功能正确或业务有效；开放等价空间应组合 invariants、functional/property/metamorphic tests、multiple golds、专家 rubric 与仲裁。

## 6.3 关键诊断量

```text
C_forward  = covered applicable requirements / all applicable requirements
C_backward = authorized checks / all checks
FAR        = targeted invalid fixtures accepted / all targeted invalid fixtures
FRR        = targeted valid fixtures rejected / all targeted valid fixtures
```

这些指标没有跨任务通用阈值。财务、医疗、法律、高安全风险任务的错误代价与创意/探索任务不同；放行阈值必须由 intended use 与 pilot 冻结。[P]

## 6.4 Integrity、failure attribution 与 arbitration

Integrity 与 task score 分开记录。最低控制链为：evaluator locking、execution/judge/audit trust zones、post-run reference staging、content-addressed handoff、file/network/process access log、patch lineage、full trajectory 与 independent recomputation。

对外至少区分：

- `FAIL_AGENT`；
- `INVALID_EVALUATOR`；
- `INVALID_ENV`。

内部另保留 task-spec、reference、harness、integrity 与 indeterminate。Evaluator/environment fault 不得静默记 agent 0。

以下情况触发 blind human arbitration：alternate-correct 被拒、mode 冲突、judge instability/injection、environment ambiguity、near-boundary 高影响结果、integrity suspicion、可复现 appeal 或 scorer repair。两名独立 reviewer 分别判断 correctness、integrity、environment 和 root cause；必要时由 senior tie-breaker 裁决，也允许 `UNRESOLVED`。

Scorer repair 创建新版本，并用 executable affected-run selector 对所有受影响 frozen artifacts 重评；不只重评投诉者，也不覆盖 original score view。

---

# 7. 怎样可靠运行

## 7.1 Reference architecture

采用五个 plane：[R]

```text
control plane   — scheduling, identity, policy, provisioning
execution plane — agent-visible task environment
evidence plane  — immutable artifacts, logs, hashes, trajectory
judge plane     — hidden reference and scoring
external plane  — licensed/live services under scoped access
```

默认信任边界：hidden reference 和 evaluator secret 不进入 execution plane；agent worker 不读取 scoring material，scoring worker 不持有 agent tool credentials 或修改 handoff artifact 的权限。

## 7.2 Hybrid substrate routing

- Linux CLI/build 类任务优先作为受限 container candidate；
- Windows GUI、驱动敏感、GPU graphics 和 licensed professional software 默认进入 full VM 或资格验证的 remote workstation VM；
- nested virtualization 逐宿主验证；
- existing/static sandbox 默认仅用于 debug，不作为 production identity。

一种万能 sandbox 会在 realism、隔离、license、GPU/GUI 与成本之间制造不可见妥协。

## 7.3 一次 run 的可复现身份

不是一个 image tag，而是：

```text
release manifest
+ resolved launch attestation
+ task/harness/evaluator bundle
```

Manifest 同时保存 declared 与 observed 状态及结构化 diff。Image digest、signature、provenance、SBOM、scan 和 acceptance test 分别回答不同问题，不能互相替代。`latest`/image family 只能是 promotion channel，不能作为 run identity；任何 patch 或 rollback 都需要 rebuild/requalify 或重新验证。

## 7.4 Credentials、license 与 network

- cloud provisioner credential 留在 control plane；
- agent model key 尽量留在 host gateway；
- guest 只获得 run/audience/action-scoped capability；
- task account、license session、storage capability 与 evaluator secret 分 principal；
- manifest 只存 opaque binding 与审计引用，不存 secret value。

每个 instance 选择一种 versioned network profile：`offline`、`allowlist`、`simulated_or_mirrored` 或 `controlled_open`。Controlled-open 只有在 live/current web 属于 construct 时才启用，并阻断 control/judge/reference/metadata/相邻 run。Allowlist 不能完全消除 indirect prompt injection 或 search-time contamination。

## 7.5 Retry 与 reproducibility SLA

只有独立 telemetry 证明为外部基础设施故障，且 agent 未获得新 observation、第二次策略机会，state 与剩余预算可验证等价时，才允许同一 trial 的 infrastructure continuation。Agent 已行动后从头重启是新 trial；judge failure 只触发 regrade，不增加 agent trial。

Start-state integrity、software launch、input integrity、judge repeatability、artifact completeness、cleanup、revocation、incident recovery 和 cross-provider equivalence 的 SLA 只能由分层 pilot 与客户 measurement error budget决定。[P]

---

# 8. 怎样报告结果与人类基线

## 8.1 先写 estimand，再写 estimator

必须区分：

- 单 instance 一次 fresh trial 的 full-success probability；
- instance mean partial quality；
- workflow/domain aggregate；
- frozen release 的 Full Pass Rate 与 Mean Score；
- 给定 cost/time budget 的端到端 reliability；
- 与特定人类人群、特定 affordance 的比较。

这套 960–1,000-workflow 私有 release 的 aggregate 可以描述这些 accepted workflow packages 及其 1,490+ 个实际运行 instances；若要外推到未来同类工作、整个职业或经济结果，仍必须另有目标 sampling frame、权重与 between-workflow uncertainty。

## 8.2 Run、trial、attempt、retry、regrade

- **Run：** 编排容器，不是统计重复单位。
- **Trial：** `(instance, frozen configuration, planned trial slot)` 的 fresh stochastic realization。
- **Attempt：** trial 内 agent 可见的行动链，累计消耗同一 budget。
- **Agent retry：** 属于 configuration/policy，不增加 trial 分母但不得获得免费预算。
- **Infrastructure continuation：** 只有满足外因、无新信息、state/budget 等价等条件时保持 trial ID。
- **Evaluator rerun/regrade：** 对 immutable artifact 再评分，不增加 agent trial。

## 8.3 Repeats、区间与 MDE

同一 instance 的 repeats 主要识别 trial stochasticity；新增 workflows/instances 主要识别 task heterogeneity。增加 repeats 不能修复 sampling frame 不代表目标总体，item bootstrap 也不能补回没有 repeats 的 run-to-run uncertainty。

设计筛选公式可写为：

```text
SE(p_hat) ≈ sqrt[p(1-p)/R]
R ≈ z² p(1-p) / h²

D = Y_A - Y_B
N ≈ (z_(1-α/2)+z_(1-β))² Var(D) / δ*²

Design effect ≈ 1 + (m-1)ρ
N_effective ≈ N / Design effect
```

`p、h、α、β、δ*、ρ` 都必须来自客户 decision loss、variance pilot 或预注册选择；公式不提供本项目现成样本量。[P]

## 8.4 主结果包

每个关键 configuration 同时报告：

1. frozen release 的 single-trial Full Pass Rate 与 Mean Score，附 workflow-clustered interval；
2. 相同 tasks、provider/time blocks 的 paired difference 与区间；
3. cost-constrained reliability、wall time/cost distribution；
4. agent/infra/evaluator/integrity failure ledger；
5. leave-domain/workflow-out、seed、provider、harness、prompt/tools、budget/retry、evaluator sensitivity；
6. pairwise sign-reversal probability、top-k recovery、rank interval 与 decision-relevant rank flips。

单一 leaderboard 顺序不能替代上述结果。

## 8.5 Matched-human baseline

主臂应招募与目标 workflow 匹配、近期仍在实践、且未参与该 task 创作的 practicing experts。Generalist、task author 与 human+AI 是不同 arms，分别报告；task author 适合诊断 rubric/scorer，不是默认 human upper bound。

匹配的是可操作 affordances：instruction、input/state、software、internet/docs、time、attempts、hardware/resources、feedback 与 output contract，而不是声称人和 agent 的认知或界面负担完全相同。

主分析使用 all-assigned success、score-at-budget 和 censor-aware time-to-success；只分析成功者会产生选择偏差。人类数据同时记录 expertise/familiarity、冲突、质量、时间、报酬/成本、退出原因与 reviewer agreement。

即使 matched-human subset 上 agent 接近专家，也不能推出总体 human-level、岗位替代或生产率。[I]

---

# 9. 怎样长期维护

## 9.1 Private 不等于 clean

威胁模型至少覆盖：

1. pretraining exposure；
2. post-training/task-specific optimization；
3. public solution 与 near-duplicate；
4. search-time contamination；
5. reference/evaluator leakage；
6. internal/vendor leakage；
7. repeated-query hill climbing；
8. grader tampering、shortcut 和 feedback exploitation。

Private、gated evaluation 或 evaluation-as-a-service 只能缩小部分暴露面，同时引入 operator trust、集中式服务、日志与内部权限风险。Canary/watermark 是传感器；未触发不能证明无污染。

## 9.2 Lifecycle 与事件账本

原子 lifecycle：

```text
proposed → implemented → validated → accepted
                                 ↘ quarantined
quarantined → repaired(new version) → revalidated → accepted
quarantined → retired
```

Public/private/rotation/training 是 purpose/access/release 维度，不要塞进一个复合 status 字段。Quarantine 是保全证据的暂停状态；repair 创建新 version；旧 identity、旧 score 和旧 exposure 采用 append-only 记录，禁止静默覆写。

## 9.3 Refresh、repair 与可比性

Refresh triggers 包括 saturation、discrimination drift、contamination、environment/software drift、license change、grader defect、客户目标变化、安全事件和 reserve depletion。

跨版本只允许三种结果：

- native release score；
- 带假设与不确定性的 bridge-linked estimate；
- `not comparable`。

每个 release 运行 common-agent paired bridge；historical snapshot、current live 与 bridge analysis 分开展示。Scorer repair 可以新增 corrected score view，但不能恢复泄漏任务的 unseen validity。

## 9.4 Incident response

发现 reference/grader leak、污染或高严重度 defect 后：暂停受影响 submission/score use；保存证据；确定 asset/version/config/run 影响面；quarantine；根据原因选择 repair、replacement 或 retirement；对所有受影响 frozen artifacts 做一致处理；发布不泄漏 hidden material 的 broken-task disclosure；复核 access、rotation 与 reserve。

---

# 10. 从 pilot 扩展到 960 / 1,490 基础交付

## 10.1 Pilot 的目的

Pilot 不是展示几个漂亮 demo，而是估计生产和测量系统中的关键随机变量。Strata 至少覆盖：domain/workflow type、artifact、software/substrate、evaluator mode、equivalence openness、risk/rights 与 expert scarcity。

## 10.2 必测变量

**生产：** candidate supply、qualification yield、service hours、cycle time、queue/wait、rework cycles、acceptance yield、defect escape。
**Evaluator：** forward/backward coverage、FAR/FRR、mutation/metamorphic detection、judge variance、arbitration rate。
**Environment：** build/launch/reset 成功、cross-run drift、infra-invalid、cleanup/revoke、license/network friction。
**Statistics：** trial variance、workflow heterogeneity、configuration interaction、paired discordance、ranking stability。
**Governance：** exposure、appeal、incident response、reserve burn、repair/retirement burden。
**Human：** recruitment、completion、quality、time/cost、attrition、agreement 与 affordance mismatch。

## 10.3 生产漏斗

```text
N_idea
→ N_spec_ready
→ N_engineered
→ N_evaluator_validated
→ N_independent_solve
→ N_domain_accept
→ N_rights_security_clear
→ N_release
```

每个 stage 的 conditional yield：

```text
p_s = N_s / N_(s-1)
```

按 domain、software、evaluator family 与 expert role 分层，并记录 numerator、denominator、missing reason 和 uncertainty。用于 scenario planning 的候选需求量为：

```text
N_workflow_ideas_required ≈ (960 + N_workflow_replacement_buffer) / Π_s p_s
```

Pilot 前不得假定 `p_s`。

## 10.4 工时、成本、运行量与关键路径

```text
H_total = Σ_(role, stage, asset) service_hours

C_total = C_platform
        + Σ_workflow(C_scope + C_eval + C_env + C_QA)
        + Σ_instance(C_input + C_reference + C_instance_QA)
        + C_runs + C_license + C_legal + C_security
        + C_maintenance + C_rotation + C_contingency

N_runs = Σ_(configuration, instance, planned trial) 1
       + separately reported infrastructure continuations

T_release = T_pilot
          + max(T_sourcing, T_evaluator, T_environment_and_legal)
          + T_integration_QA + T_rework + T_freeze

Capacity_stage = available_role_hours / service_hours_per_accepted_unit
```

排期由最小有效 capacity 与串行关键路径共同决定，不能用“960 × 平均工时 ÷ 总人数”代替，更不能忽略额外 530 个 instance references、evaluator fixtures 与 QA 的成本。

## 10.5 付款与验收 manifests

采购合同必须把 base workflow、base additional instance、gap-fill、run/service 和 change/repair 分账；否则供应方可能用重复 variants、重跑或缺陷修复增加“交付量”。[R]

| Manifest | 计费/验收对象 | 必备字段 | 不得混入 |
|---|---|---|---|
| Base Workflow Acceptance | 960 个 distinct workflow packages | `workflow_id/version`、identity statement、canonical instance、component hashes、全部 gates、client-private purpose/access、limitations、Final Approver | idea、submission、spec-only、pending QC、cosmetic variant |
| Base Additional Instance | 530 个 accepted instances | parent workflow、variation dimension、marginal measurement value、instance hashes、完整 runnable/QC 状态、private pool purpose | 只换名字/seed/数字、重复 run |
| Gap-fill | 0–40 个 customer-specific workflow packages | gap statement、客户缺口、canonical instance、rights/security、完整 QA、change approval | 供应方缺陷替换、为凑整新增、重复 workflow |
| Run & Service | QA、repeats、正式评价、托管和算力服务 | configuration、instance、trial、budget、infra status、artifacts、raw score | workflow 或 variant 数量 |
| Change / Repair / Retirement | version bump、defect repair、replacement、regrade/rerun | old/new version、change authority、affected scores、warranty/change-order、lineage | 把供应商缺陷修复当新 workflow |

Base workflow 的付款资格为：

```text
payment_eligible(w)
  iff identity_disposition(w) = distinct
  and canonical_instance(w) = final_QC_accepted
  and every_mandatory_gate(w) = pass
  and unresolved_blocker_count(w) = 0
```

530 个 base additional instances 只有证明带来 state、constraint、failure-mode、difficulty 或 information delta，并完成与 canonical instance 相同强度的 runnable/QC 验收后，才可计数。价格可以按专业、environment、evaluator 与 reference 复杂度划分 price band，但具体带宽与费率只能由 pilot 和商业谈判冻结。[P]

```text
Payment = Σ_(960 accepted base workflows) BasePriceBand_w
        + Σ_(530 accepted additional instances) InstancePriceBand_i
        + Σ_(approved gap-fill workflows) GapFillPriceBand_g
        + C_runs_and_service
        + C_licensed_environment
        + C_maintenance_and_approved_change_orders
```

同一 `workflow_id` 的 defect repair、version bump 或 replacement 默认不增加 workflow count。客户改变 construct、软件、法域或 output/evaluator contract 时，是否形成 change order 由预先写明的 identity/change policy 决定，不能由供应方单方面重命名。

## 10.6 Advance / Repair / Rescope / Stop

**Advance：** 所有 hard gates 通过；mandatory defects 为零；pilot 的精度、稳定性、产能和成本进入预先冻结的接受区域；无未解决的高严重度 rights/security/integrity 问题。

**Repair：** construct 与 asset identity 仍成立，问题可以限定到 environment、reference、evaluator、guideline 或局部实现；修复后 version bump、全套 regression 与独立复验。

**Rescope：** 原目标在候选供给、权利、软件、可验证性、成本或时间上系统性不可行，但缩小 domain、claim 或 environment scope 后仍能形成有效产品；不得用低质任务填满数量。

**Stop：** construct 无法可靠操作化；合法权利无法取得；evaluator 无法区分合法多解与错误；环境不可复制；泄漏/安全不可控；或合理 pilot scenarios 下不存在满足质量与预算的可行设计。

---

# 11. 原创 Worked Task：B2B SaaS 营销绩效与预算重分配

## 11.1 为什么选择这个任务

该例与我过去消费/marketing 数据项目的经验相连，同时能展示 spreadsheet、数据清洗、专业判断、memo、合法多解与 evaluator 工程。它不是 ALE 现有公开 task 的复制，而是用于说明本方案如何把真实业务 workflow 转成 runnable asset。[R]

## 11.2 Workflow 与 concrete instance

**Domain：** Business Operations / Marketing Analytics
**Workflow：** 对广告平台、CRM、订阅/退款与财务确认收入进行跨源核对，建立渠道绩效模型，并在约束下生成下一期预算方案。
**Instance objective：** 交付一份可审计 `.xlsx` 和一页决策 memo，使结果可从 raw inputs 重新计算，并满足预算与业务约束。

### Participant-visible inputs

- `ad_spend.csv`：channel/campaign/day/currency/spend/clicks；
- `crm_opportunities.csv`：lead、opportunity、stage、close date、campaign keys；
- `subscriptions_and_refunds.csv`：customer、plan、invoice、refund、effective dates；
- `campaign_taxonomy.xlsx`：渠道与 campaign 的 canonical mapping；
- `attribution_and_budget_policy.pdf`：attribution window、currency rule、渠道上下限、禁投与总预算；
- `task_instructions.md`：交付字段、输出路径和业务问题。

所有业务数据使用 synthetic/de-identified records，并预埋多对多 join、缺失 UTM、跨时区、退款滞后、重复 ID 与币种边界。

## 11.3 Environment contract

- Fresh Windows VM；Microsoft Excel 或经客户批准的等价 spreadsheet lane；
- 可选 Python，但不得依赖外网；
- 固定 locale、timezone、currency rounding、software build 与 font；
- input directory 只读，output directory 可写；
- 禁止外部 workbook links、宏和未批准的数据上传；
- 每次 trial 从 clean snapshot 开始，运行后提交 artifact hash 与 calculation state。

若客户不提供 Excel license，可建立 LibreOffice-compatible lane，但不得默认宣称两条 lane 的行为等价；必须做 cross-lane qualification。[P]

## 11.4 Required outputs

`marketing_performance_and_budget.xlsx` 至少包含：

1. Raw input imports 与 source hashes；
2. Canonical campaign mapping 和 exception ledger；
3. Reconciled event/customer ledger；
4. Spend、attributed revenue、refund、pipeline、CAC、ROAS、conversion 与 cohort metrics；
5. 数据质量与未匹配记录表；
6. 约束满足的下一期 channel budget；
7. Assumptions 与 sensitivity sheet。

`decision_memo.md` 或 `.docx`：说明主要发现、推荐分配、关键不确定性和需要业务 owner 决定的问题，并引用 workbook 中可复核的指标。

## 11.5 Hidden reference pack

Reference 不只是一份“标准 workbook”，而是：

- canonical normalized event ledger；
- 正确 join/matching relations；
- source reconciliation totals；
- metric invariants、单位与 tolerance；
- budget constraint set 与多个合法 feasible solutions；
- gold、known-bad、near-miss、alternate-correct artifacts；
- memo factual-claim anchors；
- evaluator version、fixtures 与 known limitations。

## 11.6 Evaluator design

建议采用 deterministic core + narrow evidence-anchored judgment：[R]

1. **Artifact integrity：** 文件可打开，要求的 sheets/fields 存在；无宏、外链、损坏或 hidden payload。
2. **Reconciliation：** spend、revenue、refund 与 source totals 在有依据的 tolerance 内闭合。
3. **Transformation validity：** 日期、时区、币种、重复、漏斗 join 与 attribution window 可从 raw inputs 重算。
4. **Metric validity：** CAC、ROAS、conversion、retention 等有正确分母、单位和 lineage。
5. **Budget feasibility：** 总额、渠道上下限、禁投、增减幅与 policy constraints 全部满足。
6. **Decision consistency：** memo 引用的数字来自 workbook，建议与 constraint/sensitivity 不矛盾。
7. **Equivalence：** 不要求唯一预算分配；任何满足约束并达到预先定义决策条件的方案都可接受。
8. **Judgment boundary：** 专家或窄 judge 只审查不确定性披露与建议逻辑，不让写作风格决定主要得分。

具体 component weights、tolerance 与 pass threshold 必须由 domain lead、客户 consequence 和 pilot fixtures 校准。[P]

## 11.7 Red-team cases

- 不同平台出现相同 campaign ID；
- UTC 与本地日边界导致 attribution 偏移；
- 两种币种被直接相加；
- 退款落在后续月份；
- missing UTM 被错误全部归入最大渠道；
- opportunity 与 subscription 多对多导致 revenue duplicate；
- hard-code summary，不保留 lineage；
- 复制 reference workbook 外观但内部公式/数据错误；
- 隐藏行、filter 或格式掩盖异常；
- 外部 workbook link 在作者机器上有效、clean VM 中失效；
- 总预算正确但违反渠道下限或禁投约束；
- workbook 正确但 memo 引用错误；
- output 嵌入对 LLM judge 的 prompt injection；
- corrupted XLSX 被应用自动修复后表面可打开；
- 非标准但业务合理的 alternate-correct allocation 被误拒。

## 11.8 从 authored example 到 accepted instance

该题只有在以下证据完成后才可计入 production：domain expert 确认 workflow 与规则；rights/security 批准 synthetic data 和软件 lane；independent solver 在 clean VM 完成；evaluator fixtures 通过；alternate-correct 与 shortcut 被验证；environment replay 达到 pilot gate；final approver 独立签字；实例被分配到明确 pool 并配置 refresh trigger。

---

# 12. 风险、Claim Boundary 与待确认事项

## 12.1 可支持的表述

- “该 agent configuration 在冻结的 ALE-style release 和注册 protocol 上取得某项结果。”
- “该结果经过版本化 environment、evaluator QA、重复运行/区间和 failure attribution。”
- “在已说明的人类样本与 affordance 条件下，观察到某种差异。”
- “本私有仓库按 ALE v2 Figure 2 的 frozen instance mix 达到已披露的 13/55 coverage。”

## 12.2 不可自动支持的表述

- “模型达到人类水平”；
- “模型可以替代某一职业”；
- “benchmark 改进等于经济价值或生产率提升”；
- “private 数据完全没有污染”；
- “deterministic scorer 完全客观”；
- “新 release 分数与旧 release 可以直接纵向比较”；
- “960–1,000 个 workflow packages 覆盖全部真实工作”。

## 12.3 主要风险与控制

| 风险 | 主要控制 | 残余边界 |
|---|---|---|
| Construct 与业务价值错位 | intended-use frame、专家场景、human subset、claim firewall | 仍需部署与经济因果证据 |
| ALE mix 与客户业务不一致/伪变体 | frozen blueprint、identity/dedup、gap-fill rule、pilot | 复刻 ALE 不等于代表客户或职业总体 |
| Evaluator shortcut/误判 | 双向 traceability、fixture library、red team、arbitration | 不能穷尽所有攻击 |
| Environment drift | immutable manifest、attestation、replay、separate judge | live services 仍可能非平稳 |
| Leakage/contamination | pool/access、gating、logging、sensor、rotation、incident | private 与 canary 均非证明 |
| 排名不稳定 | paired design、repeats、clustered interval、sensitivity | 统计稳定不修复 validity bias |
| 专家 COI/标准漂移 | role qualification、blind solve、COI、calibration、deboarding | 小团队仍有 collusion/override 风险 |
| 成本/周期失控 | instrumented pilot、funnel、capacity、critical path、rescope gate | 稀缺软件/专家有长尾 |

## 12.4 不得在 pilot 前填入常数的变量

人数、专家池规模、渠道转化率、资格通过率、throughput、cycle time、返工、acceptance yield、review span、audit ratio、交付周数、费率、单位成本、总预算、内部用途分池、repeats、seed 数、CI half-width、MDE、power、环境 SLA、license 席位、FAR/FRR、human sample/attrition/agreement、污染率、query limit、refresh cadence、退役率和 reserve burn rate。**960 workflows、1,490 base instances 与 Figure 2 subdomain instance 配额不在这份待填清单中，它们已由本报告冻结。**

## 12.5 下一轮需要确认的问题

1. intended use 与允许的 claims；
2. 最多 40 个 gap-fill 的客户语言、地区、软件、监管和风险优先级；
3. training、development、sealed final 与 rotation reserve 的内部权利隔离；
4. 数据、license、credential、network 与 retention 约束；
5. 是否需要 matched-human、哪些职业/人群、何种 affordance；
6. 允许的运行预算、维护期、refresh/incident SLA；
7. 谁担任 Benchmark Owner、Rights/Security Owner 与 Final Approver；
8. pilot 的 decision loss、stop condition 与采购限制；
9. 交付是否包含 benchmark service、源码、环境镜像、私有资产托管与持续运营。

---

# 结论

ALE 的真正启发不是“如何出更难的题”，而是如何把专业工作转化为可运行、可验证、可隐藏、可轮换和可审计的 measurement asset。这里的产品不是公共榜单，也不是等待客户替我们定义的开放研究：它是一座客户独占的 ALE-style 私有仓库，基础层明确为 960 个 workflows、1,490 个 final-QC instances，并按 Figure 2 的 55-subdomain instance mix 结构性复刻。

项目执行上先按公开 instance vector 透明重建 960-workflow map，再用 instrumented pilot 验证生产良率、环境和 evaluator，而不是重新决定总体配额。只有客户特有缺口才启用最多 40 个 gap-fill workflows。这样既尊重“照 ALE 做”的作业语境，又不会把 ALE 没公开的 workflow-by-subdomain manifest 伪装成已知事实：结构有依据，内容保持私有，付款单位可审计，所有交付实例都必须真正做得出来并通过 final QC。

---

# 附录 A：关键数据对象

```yaml
asset_identity:
  workflow_id: wf_...
  workflow_version: wf_...@v...
  canonical_instance_id: inst_...
  canonical_instance_version: inst_...@v...
  taxonomy_version: ...
  lifecycle: proposed|implemented|validated|accepted|quarantined|repaired|retired

workflow_identity:
  professional_goal: ...
  target_capability: ...
  process_boundary: ...
  output_contract: ...
  evaluator_contract: ...
  duplicate_cluster_ids: []
  identity_disposition: distinct|merged|rejected
  identity_approver: ...

task_contract:
  intended_construct: ...
  visible_instruction: ...
  input_manifest: ...
  output_contract: ...
  allowed_resources: ...

execution_contract:
  environment_manifest_hash: sha256:...
  observed_launch_attestation: ...
  harness_and_prompt_hash: ...
  network_profile: offline|allowlist|simulated_or_mirrored|controlled_open
  budget_and_retry_policy: ...

evaluation_contract:
  reference_version: ...
  evaluator_version: ...
  score_semantics: ...
  fixture_pack_version: ...
  failure_and_arbitration_policy: ...

governance:
  purpose: client_private_development|restricted_validation|sealed_private_final|private_rotation_reserve|client_private_training
  access_class: client_internal|identity_gated|sealed_service|audit_only
  owner_reviewer_approver: ...
  rights_and_coi: ...
  lineage_and_incidents: ...

acceptance_and_payment:
  domain_gate: pass|fail
  runnable_gate: pass|fail
  evaluator_gate: pass|fail
  reproducibility_gate: pass|fail
  rights_security_gate: pass|fail
  independent_solve_gate: pass|fail
  final_approval_gate: pass|fail
  price_band: ...
  payment_eligible: true|false
```

# 附录 B：Pilot measurement sheet

每条记录至少包含：

```text
stratum/domain/workflow/software/evaluator/risk
candidate → spec → engineered → validated → accepted funnel
role service-hours, wait-hours, cycle time and rework cycles
root-cause and defect severity
environment build/start/reset/replay and infra-invalid
FAR/FRR/mutation/metamorphic/judge/arbitration
trial variance and configuration interaction
human recruitment/completion/quality/time/cost/agreement
rights/license/security friction
maintenance/refresh/incident burden
advance|repair|rescope|stop decision and rationale
```

# 附录 C：内部证据索引

- [Scope 与产品定义](../../02-1000-task-delivery-design/01-scope-and-product-definition/decision-report-2026-08-08.md)
- [ALE 技术蓝图与版本审计](../../02-1000-task-delivery-design/02-ale-blueprint-and-version-audit/technical-blueprint-2026-08-08.md)
- [公开 task corpus 与 evaluator 审计](../../02-1000-task-delivery-design/03-public-task-corpus-audit/public-corpus-audit-report.md)
- [邻近 benchmark landscape](../../02-1000-task-delivery-design/04-adjacent-benchmark-landscape/landscape-report-2026-08-08.md)
- [Portfolio 与 sampling strategy](../../02-1000-task-delivery-design/05-portfolio-and-sampling-strategy/portfolio-and-sampling-strategy-report.md)
- [专家生产、校准与治理](../../02-1000-task-delivery-design/06-expert-production-governance/expert-production-governance-report-2026-08-09.md)
- [Evaluator validity 与 scoring integrity](../../02-1000-task-delivery-design/07-evaluator-validity-and-integrity/evaluator-validity-and-scoring-integrity-report-2026-08-09.md)
- [Environment & execution reference architecture](../../02-1000-task-delivery-design/08-environment-execution-reference-architecture/environment-execution-reference-architecture-report-2026-08-09.md)
- [Living benchmark governance](../../02-1000-task-delivery-design/09-living-benchmark-governance/living-benchmark-governance-report-2026-08-09.md)
- [统计评估与 matched-human protocol](../../02-1000-task-delivery-design/10-statistical-and-matched-human-protocol/statistical-and-matched-human-protocol-2026-08-09.md)
- [初稿 v1 补充研究与反方审查](../../../supporting-evidence/draft-v1-research-refresh/)
- [初稿 v2 计数、taxonomy 与 hook 增量研究](../../../supporting-evidence/draft-v2-count-taxonomy-hook-research/)
- [初稿 v3 私有复刻、会议日期与 workflow 配额研究](../../../supporting-evidence/draft-v3-private-clone-hook-and-allocation-research/)

# 附录 D：精选外部来源

1. Sun et al., [*Agents’ Last Exam*, arXiv:2606.05405v2](https://arxiv.org/html/2606.05405v2).
2. Berkeley RDI, [ALE official repository at frozen commit](https://github.com/rdi-berkeley/agents-last-exam/tree/1e615e456de7cef57706680613cb80ee13c7fc76).
3. Hugging Face, [ALE paper page](https://huggingface.co/papers/2606.05405). 该页面为可变 surface，不用于替代冻结论文数字。
4. NIST CAISI, [*Practices for Automated Benchmark Evaluations of Language Models*, Initial Public Draft](https://www.nist.gov/news-events/news/2026/01/towards-best-practices-automated-benchmark-evaluations).
5. NIST, [*Expanding the AI Evaluation Toolbox with Statistical Models*](https://www.nist.gov/news-events/news/2026/02/new-report-expanding-ai-evaluation-toolbox-statistical-models).
6. NIST, [AI Risk Management Framework 1.0](https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-ai-rmf-10).
7. Nick Heiner, [*When Will The Benchmaxxing Plague End?*](https://www.youtube.com/watch?v=-npY6XjM8CQ), AI Engineer World’s Fair 2026.

更完整的逐来源证据、短引、评分与 refresh targets 见 `supporting-evidence/draft-v1-research-refresh/`、`supporting-evidence/draft-v2-count-taxonomy-hook-research/` 与 `supporting-evidence/draft-v3-private-clone-hook-and-allocation-research/`。本初稿将同一 ALE 项目的 paper/code/HF surfaces 视为版本互补证据，而不是三个独立机构的三角验证。

# 附录 E：由 Figure 2 instance vector 重建的 55-subdomain workflow 配额

**证据边界：** `Instances` 来自 ALE arXiv v2 Figure 2；`重建 workflows` 由本项目按 Hamilton largest-remainder rule 计算，合计 960，不是 ALE 官方 workflow manifest。

| Subdomain | Instances | 重建 workflows |
|---|---:|---:|
| Manufacturing & Industrial Systems | 173 | 112 |
| Aerospace & Mechanical Engineering | 47 | 30 |
| Civil, Architectural & Geospatial Engineering | 33 | 21 |
| Robotics & Autonomous Systems | 29 | 19 |
| Semiconductor & Microelectronics Design | 28 | 18 |
| Electronics Engineering | 23 | 15 |
| Chemical & Process Engineering | 17 | 11 |
| Mining, Petroleum & Geological Engineering | 9 | 6 |
| Urban & Spatial Planning | 5 | 3 |
| Energy, Power & Nuclear Engineering | 4 | 3 |
| Biomolecular Structure & Design | 55 | 35 |
| Genomics & Sequence Analysis | 30 | 19 |
| Cell & Imaging Biology | 13 | 8 |
| Systems & Microbial Biology | 13 | 8 |
| Educational Technology | 18 | 12 |
| Library & Information Science | 9 | 6 |
| Translation & Localization | 6 | 4 |
| Environmental Modeling & Water Resources | 11 | 7 |
| Precision Agriculture | 8 | 5 |
| Data & Analytics Engineering | 57 | 37 |
| AI Engineering & CS Research | 50 | 32 |
| Software Engineering | 38 | 25 |
| Mathematical & Operations Research | 35 | 23 |
| Cybersecurity & Forensics | 28 | 18 |
| Quantum Computing | 16 | 10 |
| Infrastructure Engineering & Cloud Operations | 13 | 8 |
| Clinical Diagnostics & Imaging | 71 | 46 |
| Clinical Informatics & Care | 27 | 17 |
| Therapeutic & Oncology | 25 | 16 |
| Public Health & Epidemiology | 19 | 12 |
| Clinical Research & Trial Operations | 13 | 8 |
| Fire Science & Public Safety | 19 | 12 |
| Aviation & Airspace Operations | 13 | 8 |
| Maritime & Port Operations | 3 | 2 |
| Experimental Psychology & Neuroimaging | 19 | 12 |
| Computational Neuroscience | 8 | 5 |
| Sports | 3 | 2 |
| 3D, Animation & Interactive Media | 133 | 86 |
| Audio, Music & Post-Production | 69 | 45 |
| Graphic, Visual & Product | 24 | 16 |
| Accounting & Finance | 115 | 74 |
| Enterprise Analytics & Planning | 42 | 27 |
| Sales & Marketing | 8 | 5 |
| Actuarial & Risk Modeling | 7 | 5 |
| Compliance & Regulatory | 5 | 3 |
| HR & Project Management | 5 | 3 |
| Quantitative Finance & Trading | 5 | 3 |
| Supply Chain & Logistics | 2 | 1 |
| Chemistry & Materials Computation | 17 | 11 |
| Physics | 14 | 9 |
| Earth & Atmospheric Sciences | 10 | 7 |
| Astronomy & Astrophysics | 5 | 3 |
| Economics & Quantitative Social Research | 26 | 17 |
| Litigation Support & Discovery | 11 | 7 |
| Doctrinal Legal Research | 4 | 3 |
| **总计** | **1,490** | **960** |

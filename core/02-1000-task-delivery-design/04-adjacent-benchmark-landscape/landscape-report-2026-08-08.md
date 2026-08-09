# ALE 邻近 benchmark landscape：面向 1,000-task 生产决策

- 研究日期 / 访问截止：**2026-08-08**
- 固定对象：**UC Berkeley RDI Agents’ Last Exam（ALE）**，论文固定为 arXiv `2606.05405v2`
- 排除：其他同名 ALE / ALE-Bench
- 决策对象：约 1,000 个 ALE-style benchmark assets 的产品范围、task selection、专家组织、生产流程、evaluation、基础设施、QA、成本、排期和交付标准
- 证据包：`sources/` 中逐源 source cards；`sources.csv` 为索引；`findings/` 为原子综合结论；`refresh_targets.md` 为更新清单

> 证据标签：**[事实]** = 论文、代码、数据或版本化页面明确陈述；**[作者/机构主张]** = benchmark 创建方的效度/价值陈述，尚未独立验证；**[研究员推断]** = 由多源证据得出的综合判断；**[项目建议]** = 面向本项目的决策。

## Executive summary

1. **[研究员推断] 不应把“1,000 tasks”直接当作一个生产配额。** 第一项决策必须是它指 1,000 个 workflows、1,000 个 runnable instances，还是二者组合。ALE v2 同时报告 960 workflows 与 1,490 instances；Figure 5 的另一个 960 是 external-submission instances，不是同一单位。
2. **[研究员推断] ALE 的主要新增是系统级组合，不是每个部件的首创。** **[事实]** ALE把广域专业 workflow、Windows/Linux 可执行环境、task-specific `load/start/evaluate`、隐藏 references/evaluators、partial credit、专家生产漏斗与 public/private/pending-QC 生命周期放进同一架构；WebArena/OSWorld已有状态 evaluator，SWE-bench/Terminal-Bench已有executable contract，RLI/GDPval已有专业deliverable，GAIA已有private evaluation。
3. **[研究员推断] H1 supported。** 高职业真实性和广覆盖通常把生产与判分推向专业人工；高自动化通常依赖窄域、稳定结构或合成状态。ALE 缓解了 trade-off，但未消除 evaluator FP/FN、等价解与维护成本。
4. **[研究员推断] H2 supported。** turns、clicks、apps、tokens 或把短 GUI 操作串联起来，都不是 long-horizon 的充分条件。较强定义需要 coherent goal、跨阶段依赖、持久状态、专业判断、错误恢复与可审计 deliverable。
5. **[事实 + 研究员推断] H3 strongly supported。** ALE、Harness-Bench、OSWorld/WAA、Terminal-Bench 与多个 grader audits 共同显示：观察分数属于 model × harness × tools × environment × budget × evaluator 的联合配置；环境脆弱或严格 grader 可制造“难度”。
6. **[研究员推断] H4 的机制 supported，但“快速下降”的速度 underdetermined。** 静态公开集有污染、solution retrieval、grader gaming 和 benchmark-specific tuning 的明确机制；公开资料尚无统一纵向研究给出衰减速度。公开集仍适合开发和回归，不适合作唯一 final exam。
7. **[项目建议] 产品范围应是 living benchmark program，而不是 1,000 个 prompts。** 每个交付资产必须包括 versioned spec、inputs、environment、reference、evaluator、run protocol、QA evidence、rights、release state 和 known limitations。
8. **[项目建议] 不从 ALE 或相邻 benchmark 抄人数、工期、成本、通过率或领域比例。** 公开数字多是特定 snapshot、不同单位或不完整成本。公开资料不足时，用 pilot 测量各 gate yield、专家/工程人时分布、evaluator FP/FN、环境 failure、run variance、license/compute 与 refresh burden。

## 1. 关键定义与单位合同

| 单位 | 本报告定义 | 绝不能等同为 |
|---|---|---|
| benchmark | 资产集合 + harness/environment + evaluation protocol + governance/version | 单一论文、leaderboard 或 dataset row count |
| domain / subdomain | taxonomy 节点；只在同一版本 taxonomy 内解释 | workflow 或 instance 数 |
| workflow | coherent end-to-end professional process；可产生多个受控 variants | prompt、GUI step、submission |
| runnable task instance | 固定输入、环境、目标、reference/evaluator 后可实际运行的一例 | workflow family、agent run |
| expert submission | 上游专家提案/材料包；可能被拒绝、合并或拆分 | accepted/implemented instance |
| commissioned task | 按委托路线生产的上游项目/实例；需说明计数层 | external submission 或自动等于 workflow |
| public/private/pending-QC instance | 同一 inventory 的 release/QC state | 三套可相加的 benchmark 或运行次数 |
| agent run | 一个已固定 agent configuration 对一个 instance 的一次执行 | task asset |
| repeated trial | 为估计随机性而重复的 run | variant 或新 task |

**[项目建议]** 所有看板、合同和周报均同时保留 `workflow_id`、`instance_id`、`submission_id/commission_id`、`release_state`、`run_id`、`trial_index`，禁止只显示一个含义漂移的 `task_count`。

## 2. 研究假设与可证伪标准

| Hypothesis | 可证伪条件 | 最终判定 |
|---|---|---|
| H1：真实性、广覆盖、完全自动验证有结构性 trade-off | 广域真实任务上，自动 evaluator 对专家 gold 低 FP/FN、覆盖等价解、跨版本稳定，且无需显著人工 adjudication | **Supported**，但不是不可能性定理 |
| H2：短 GUI 串联不自动成为真实 long-horizon | 真实工作样本与 matched human study 证明该串联具有 coherent dependency、不可平凡分解、持久状态与专业交付 | **Supported** |
| H3：难度可能来自环境/工具/evaluator | factorial 控制 harness、budget、environment、evaluator 后排序和能力解释稳定，非能力 failure 可忽略 | **Strongly supported** |
| H4：无 holdout/轮换会长期衰减 | 长期独立审计显示公开静态 exposure 不提高分数、无 solution/grader exploitation，且对 fresh tasks 外推稳定 | **Mechanism supported；速度 underdetermined** |

详细证据与反方审查见 `findings/F1_...` 至 `F4_...`。

## 3. ALE canonical evidence 与版本矩阵

以下表面各自固定，不合并为“当前统一数字”。逐源证据分别见 [01 paper](sources/01_ale_arxiv_v2.md)、[02 homepage](sources/02_ale_official_live_site.md)、[03 submit](sources/03_ale_submit_page.md)、[04 GitHub](sources/04_ale_github_pinned.md)、[05 HF](sources/05_ale_huggingface_pinned.md)、[06 RDI blog](sources/06_ale_rdi_blog.md) 与 [14 leaderboard](sources/14_ale_live_leaderboard.md)。

| Surface | 固定版本 / 访问日期 | 该 surface 报告的规模/单位 | 使用边界 |
|---|---|---|---|
| arXiv | `2606.05405v2`，修订 2026-06-11 | 1,490 runnable instances；960 workflows；Figure 5 为 150 public/1,017 private/323 pending-QC；另有 960 external-submission instances + 530 commissioned instances | 两个 960 是不同标签/单位；paper snapshot 是主方法基线 |
| official homepage | live snapshot，访问 2026-08-08 | 1.5K+ tasks、300+ experts、55 sub-industries | marketing counter；无 manifest 与单位定义 |
| submit page | live snapshot，访问 2026-08-08 | 五部分 expert submission；无 corpus count | submission schema，不是 runnable asset |
| GitHub | commit `1e615e456de7cef57706680613cb80ee13c7fc76`；README blob `5b21e3f...` | around 150 public tasks；framework/task tree | 开源代码快照，不代表 private inventory |
| Hugging Face | revision `a8c1fd174a1f6cfa76526572a2e3ebece1276be2`；card v1.0 | 153 metadata rows | metadata row，不含完整 input/reference/evaluator |
| RDI blog | 2026-06 page；访问 2026-08-08 | 1,500+ tasks、300+ experts、55 occupations | 机构 narrative/claim surface |
| leaderboard | ALE-V1；访问 2026-08-08；best-per-task dated 2026-07-04；runtime method 2026-07-10 | live agent-system rows、cost/runtime/token totals | results surface，不是 corpus manifest；best-per-task 是 oracle envelope，不是可部署单一 agent |

### 3.1 论文内部也必须保留的边界

- **[事实]** `150 selected public`、`152-task public set`、HF `153 rows` 与 tier 标称 `67/55/38` 来自不同 selection/metadata 表面，不能为消除差异而自行改写。
- **[事实]** open reference tree 的 `93.2% code-based / 6.8% LLM-judge workflows` 只适用于可分析的开放树，不是 1,490 private/pending instances 的全池比例。
- **[事实]** Table `±` 的 3 runs 只覆盖部分 configurations，不是全 benchmark 的统一 repeated-run policy。
- **[作者/机构主张]** “real-world”“economically valuable”“broad”“public subset representative”“hardest tier unsaturated”属于作者效度解释；尚无 full private-pool independent provenance audit 或 matched human baseline。

## 4. 邻近 benchmark 选集与版本边界

最终统一矩阵纳入 **16 个 benchmark/family rows**。family 的 subset/version 是版本面，不另算 benchmark 数。完整 17 字段矩阵见 [benchmark_matrix_16.md](benchmark_matrix_16.md)。

| # | Benchmark row | 固定主版本面 | 必须保留的 count/unit 边界 |
|---:|---|---|---|
| 1 | ALE | arXiv `2606.05405v2` + pinned live/repo/HF surfaces | 960 workflows ≠ 1,490 instances；submission/commission/release/run 分列 |
| 2 | OSWorld / OSWorld2 family | OSWorld paper v2 + Verified repo snapshot；OSWorld2 paper v2/release | v1/v2/Verified/current manifests不合并；task count 与 runs分开 |
| 3 | WebArena | arXiv `2307.13854v4` + pinned repo | 812 runnable instances由241 templates实例化；二者不等同 |
| 4 | WorkArena++ / BrowserGym | WorkArena++ arXiv v2 + pinned WorkArena/BrowserGym repos | 341 workflows各有L2/L3，共682 level-specific task presentations；paper curriculum另采235/level=470 runnable evaluation instances；framework不是task set |
| 5 | GAIA | paper arXiv `2311.12983v1` + current HF revision | paper 466 total 与当前可访问 validation 165 保持分离 |
| 6 | AssistantBench | arXiv v2 + pinned repo/HF/HAL | paper overall 214 与当前 HAL 33 validation subset 分离 |
| 7 | SWE-bench family | Original arXiv `2310.06770v3`; repo `cd37836...`; Verified snapshot/audits | Original 2,294；Lite 534；Verified 500；不是求和后的 inventory |
| 8 | Terminal-Bench | TB2 arXiv `2601.11868v1`; repo `2fd12b8...` | v1 Core-v0 80 ≠ TB2 89；93 contributors、229 submissions、32,155 trials 分列 |
| 9 | CRAB | arXiv `2407.01511v4`; repo `c0790b...` | abstract/site 120 vs正文 composition 100 未消解；不得自行选一个 |
| 10 | Windows Agent Arena | arXiv `2409.08264v2`; repo `6d39ed...` | paper 154；“150+”近似；post-paper harder mode是另一 protocol |
| 11 | Remote Labor Index | arXiv `2510.26787v1`; pinned repo/HF | paper 240 = 10 public/230 private；project、deliverable、rating、run分开 |
| 12 | GDPval | arXiv `2510.04374v1`; HF `11e7900...` | paper full 1,320 ≠ current public gold 220；HF “v2”不是论文 v2 |
| 13 | SpreadsheetBench 2 | arXiv `2606.29955v1`; repo `599b24a...`; HF `9dea600...` | V1 912、后续400 subset、V2 321不可求和 |
| 14 | OfficeBench | arXiv `2407.19056v1`; repo `b978b80...` | 300 synthetic API tasks；不是2007同名PC benchmark，也不自动等于 workflows |
| 15 | Harness-Bench | arXiv `2605.27922v1` | 106 tasks；5,194 trajectories是runs，不是assets |
| 16 | MBABench | arXiv `2605.22664v4` | canonical title统一；408 annotations与task/run数不是同一单位 |

**增删理由。** Windows Agent Arena补充真实 Windows/app 与 measured human baseline；Harness-Bench直接隔离 harness confound；MBABench补充专业 spreadsheet 多维 evaluator。OdysseyBench只作为 synthetic long-term counterpoint，不进入16项主矩阵。OfficeBench保留为 synthetic cross-app API control，而不是专业文件真实性代表。

## 5. 主要发现

### 5.1 自动评分不是自动效度

- **[事实]** SWE-bench、Terminal-Bench、WebArena/OSWorld、SpreadsheetBench 等均能自动执行 evaluator。
- **[事实]** 独立/官方审计仍发现 underspecified tests、等价解误拒、过宽测试误收、final-state false negative、grader leakage、timeout modification、public solution retrieval 和 infrastructure errors。
- **[研究员推断]** `deterministic` 描述可重复执行方式，不证明 construct validity。交付标准必须含 FP/FN gold cases、near miss、alternate valid solutions、shortcut/red-team cases 与 incident adjudication。

### 5.2 “真实”至少有四层，不能用一个标签

| Layer | 问题 | 典型例子 |
|---|---|---|
| source realism | 任务是否来自真实历史工作/工单/文件 | RLI marketplace、SWE-bench GitHub history、SpreadsheetBench public finance files |
| environment realism | 是否使用真实软件/OS/数据结构 | OSWorld/WAA、ALE VMs、Terminal-Bench containers |
| workflow realism | 是否保留真实阶段依赖、澄清、恢复与交付 | ALE author criteria；RLI long project但被self-contained筛选；WorkArena++依赖图 |
| population realism | task分布是否代表目标职业/客户 | GDPval职业/sector frame；多数GUI/coding benchmarks不具 labor weighting |

**[研究员推断]** 一个 benchmark 可以环境真实但任务合成（CRAB/OfficeBench），来源真实但只截取生命周期一段（SWE-bench），或职业任务真实但运行条件不匹配原工作（RLI/GDPval）。项目 schema 应分别记录四层证据。

### 5.3 Human baseline 必须与 gold/reference 分开

- **[事实]** WAA 有 measured 74.5% human success；RLI/GDPval 有人类专业 deliverables，但未必与 agent 同 runtime/budget重跑；SWE Verified annotators、Terminal task-author time estimates、CRAB expert validation、SpreadsheetBench independent solving 都不是统一 human baseline。
- **[项目建议]** baseline 表需记录人员资历、brief/input、软件/工具、网络、时间、是否可澄清、成功定义、样本和不确定性。creator gold 与 matched participant run 分列。

### 5.4 成本证据多为局部快照

- **[事实]** ALE按configuration/tier报告total API cost；Terminal-Bench paper的full-run model price、WAA FAQ、RLI agent API cost、GDPval推算human value、SpreadsheetBench专家小时各自口径不同。任何per-instance均值都必须固定denominator重算。
- **[研究员推断]** 它们不能相加、换算为 1,000-task 总预算，或变成人员/排期配额。常见遗漏包括 task sourcing、reference/evaluator工程、license、environment rebuild、失败重试、专家 adjudication、安全、PM 与 rotation。

### 5.5 排名变化未必等于 foundation model 变化

- **[事实]** ALE定义 agent为 harness+model；Harness-Bench直接观察 pairing effect；WAA、RLI、GDPval/MBABench显示 CUA/API/CLI/proprietary tool路径产生不同失败面。
- **[研究员推断]** 只有固定 manifest 或 factorial design 才能把差异归因到某个因子。跨 leaderboard 直接比较模型名是 protocol confound。

## 6. ALE 真正新增的设计

**[研究员推断]** “真正新增”是跨benchmark landscape的比较结论。下列组件在ALE中的存在是**[事实]**；把它们视为ALE的新增组合，而非各组件的首创，是**[研究员推断]**。

1. **[事实] 广域 executable professional workflow architecture。** 13 clusters/55 subdomains与真实软件环境、reference/evaluator在同一资产合同下组织。
2. **[事实] workflow–instance 两层。** 共享 goal/evaluate logic 的 workflow 可有输入/输出变体；生产规模和运行规模因此可分账。
3. **[事实] evaluator portfolio。** exact/hash、tabular、geometry、visual、behavioral、free text、executable artifacts与partial credit并存。
4. **[事实] 专家—工程—QC生产链。** 外部 submission 与 commissioned路线，经reference/evaluator设计、工程实现、dry run和committee QC形成runnable assets。
5. **[事实] public/private/pending-QC + planned rotation。** 把资产生命周期和污染控制纳入benchmark产品，而不是只发布静态dataset。
6. **[研究员推断] 真正创新在组合、广度与运营化。** 上述单个部件各有先例；ALE没有理由被描述为这些部件的唯一首创者。

## 7. ALE 继承或尚未解决的问题

1. **[研究员推断] 联合系统构念**：不能把分数单独归因给foundation model。
2. **[研究员推断] evaluator weakness**：task-specific evaluator仍可能漏掉专业质量、等价解或被gaming。
3. **[事实 + 研究员推断] 公开集代表性**：作者只用一个configuration作cluster-level内部相关性检验；这不能证明对所有systems代表private pool。
4. **[事实 + 研究员推断] 无matched human baseline**：公开材料没有full-pool matched baseline；历史专家耗时/复杂度准入不是受控成功率，也不能直接定义automation。
5. **[公开资料不足 + 研究员推断] 真实性/经济价值**：full private pool provenance、labor weighting和真实组织依赖尚未独立验证。
6. **[研究员推断] 环境与license漂移**：GUI、browser、licensed software、provider、timeout/resource会改变可重复性。
7. **[事实 + 公开资料不足] rotation实效**：planned rotation存在；cadence、曝光ledger、泄漏响应与长期因果证据未公开充分披露。
8. **[事实 + 项目建议] 版本/数字漂移**：paper、site、GitHub、HF、leaderboard数字确有差异；项目必须做manifest级pinning。
9. **[事实 + 研究员推断] 重复运行不统一**：仅部分配置3 runs；单次完整通过率可能受stochastic path影响。
10. **[公开资料不足 + 研究员推断] 成本/生产率**：没有公开的全成本、gate yield、rework和维护分布，因此不能反推本项目。

## 8. 反方证据与不确定性

### 8.1 当前结论在什么条件下失效

**[研究员推断]** 以下是预先规定的反驳条件，不是已经发生的事实。

- 若广域真实任务的自动 evaluator 经职业专家盲测显示低 FP/FN、充分覆盖等价解且跨版本稳定，H1会被削弱。
- 若真实工作采样和matched human study证明某短操作串联确有不可分解依赖，H2不适用于该任务。
- 若跨 harness/environment/evaluator 的factorial实验保持系统排序与failure taxonomy稳定，H3的confound解释会减弱。
- 若多年独立审计显示公开静态集没有 exposure benefit、grader gaming或fresh-task泛化损失，H4会被反驳。

### 8.2 哪些数字只是特定 snapshot，不能成为生产配额

以下计数均为**[事实] snapshot**；“不得直接成为生产配额”是**[项目建议]**。

- ALE 的250+/300+ experts、960 workflows、1,490 instances、960 external instances、530 commissioned、150/1,017/323 release states、150/152/153 public surfaces。
- WebArena 241 templates/812 instances；WorkArena++ 341 workflows/682 L2/L3 task presentations，另有235/level=470 sampled evaluation instances。
- SWE Original/Lite/Verified 2,294/534/500；Terminal v1 80、TB2 89、93 contributors、229 submissions、32,155 trials。
- RLI 240与10/230；GDPval 1,320与220；SpreadsheetBench V1 912/400 subset/V2 321；OfficeBench 300。
- 任一论文的模型run cost、专家hour、acceptance yield、human time或通过率。

### 8.3 哪些成功可能来自 evaluator weakness、泄漏或 harness差异

以下均为**[研究员推断]**的替代解释；部分机制有直接incident/audit证据，但不等于相关leaderboard entry已被证明作弊。

- 公开issue/gold/test history的solution reproduction；公开grader/test被读取、修改或针对性优化。
- final-state evaluator对合法路径false negative，或测试过宽接受错误artifact。
- best-of-N、retry/effort、tool schema、parser、browser/OS image、network、resource limits不同。
- LLM judge自偏好、顺序/风格偏差或prompt/version变化。
- live leaderboard的best-per-task oracle envelope，不是单一deployable agent。

### 8.4 合理但公开数据不足的建议

以下均为**[项目建议]**需要pilot决定的变量。

- 本项目应有多少public/private、多少repeated trials、多少matched human tasks、每种evaluator占比、rotation周期、各领域配额。
- 每种专家角色人数、每task工时/成本、一次通过率、rework轮次、总工期。
- 可接受的evaluator FP/FN、environment failure与run variance阈值。

以上均应先由pilot和intended-use risk定义，不在本报告编造精确值。

## 9. 对 1,000-task 项目的具体决策影响

### 9.1 产品范围

**[项目建议]** 把产品定义为 `living, executable, versioned professional-work benchmark program`。交付单位以runnable instance计数时，合同仍必须同时给出workflow数与variant分布。范围可包含四类portfolio，但比例必须来自客户sampling frame和pilot：

1. professional deliverables（ALE/RLI/GDPval启发）；
2. GUI/web/OS workflows（OSWorld/WebArena/WorkArena++启发）；
3. coding/terminal/cross-environment（SWE/TB/CRAB启发）；
4. structured professional files（SpreadsheetBench2/MBABench启发）。

### 9.2 Task selection

**[项目建议]** 先写 intended use、target user/population、不可声称的结论，再建立 `domain → subdomain → workflow family → instance` sampling frame。每个候选同时打四层realism、business/occupational relevance、workflow dependency、rights、environment feasibility与evaluator feasibility；真实性高但暂不可可靠验证的项目可进入research queue，而非用弱grader强行上线。

### 9.3 专家组织

**[项目建议]** 按职责隔离，不预设精确人数：domain/workflow creator、independent domain solver、evaluator/rubric designer、environment engineer、independent QC reviewer、adversarial evaluator reviewer、rights/security reviewer、incident adjudicator、benchmark scientist和program manager。关键规则是creator不能独自完成final QC；reference、evaluator和release approval至少有独立审查路径。

### 9.4 生产流程与gate

```text
sampling-frame approval
  → source/rights intake
  → workflow spec + construct map
  → independent solvability review
  → reference deliverable
  → environment/evaluator implementation
  → oracle + alternate-solution + near-miss tests
  → agent dry runs + failure taxonomy
  → cross-review + red team + leakage scan
  → release-state decision
  → monitored evaluation / incident / rotation / retirement
```

**[项目建议]** 每个gate记录 accepted/rejected/rework及reason code。公开ALE或其他项目的funnel只能作为流程证据，不能作为本项目yield目标。

### 9.5 Evaluation（以下均为[项目建议]）

- 输出层：硬gate（文件存在/可打开/安全）+ component partial credit +专业quality rubric。
- evaluator层：deterministic checks优先；LLM/VLM只用于难形式化维度，并固定model/prompt/revision、测agreement与bias；高风险样本human adjudication。
- protocol层：固定agent manifest、预算、network、retry与failure codes；pilot repeated trials决定正式次数和aggregation。
- validity层：matched human subset、alternate valid solutions、shortcut tests、environment health与fresh-task generalization。

### 9.6 基础设施

**[项目建议]** 需要immutable asset/evaluator revision、OS/container/image digest、software/license registry、reset与health check、sealed reference/evaluator storage、network policy、run scheduler、trace/artifact/usage capture、incident replay、role-based access、public/private promotion与retirement。单一Docker并不能覆盖ALE-style licensed GUI任务；需按environment archetype管理。

### 9.7 QA 与交付标准

**[项目建议]** 每个accepted runnable instance至少交付：identity/revision、construct map、source/rights、task spec、inputs、reference、environment rebuild、evaluator及测试、oracle success、alternate/near-miss/shortcut cases、run protocol、dry-run traces、review approvals、release state、known limitations和refresh/retirement rule。缺少任一关键部分的是proposal或prompt，不是completed asset。

### 9.8 成本与排期

**[项目建议]** 用变量模型，不给无证据点估计：

```text
N_workflows = |W|
N_instances = Σ(w∈W) V_w
N_runs = Σ(c∈C) Σ(i∈Instances) R_ci

H_total = Σw(H_source + H_spec + H_reference + H_eval_design + H_env + H_workflow_QC)
        + Σi(H_variant + H_instance_dryrun + H_instance_QC)
        + H_platform + H_security + H_program_management + H_refresh

Cost_total = Σrole(H_role × Rate_role)
           + Cost_compute + Cost_storage + Cost_licenses + Cost_external_data
           + Cost_review/adjudication + Cost_refresh/retirement
```

`Calendar_time ≠ H_total / headcount`：专业专家、licensed environment、reference→evaluator、rework与security review有串行/稀缺依赖。pilot应输出按workflow family和evaluator archetype分层的中位数、尾部、yield与rework分布，再做Monte Carlo或情景排期，而不是一个全局平均。

## 10. 生产 1,000 个任务时应采用的 10 条做法（[项目建议]）

1. 先签单位合同，workflow、instance、submission、commissioned、release state、run、trial分列。
2. 先写construct/intended use/claim boundary，再选任务和指标。
3. 从客户目标职业/用户workflow landscape取样，不抄任何benchmark快照比例。
4. workflow-first；variant必须有独立测量价值，禁止为凑数改输入。
5. 使用executable asset contract：spec、inputs、environment、reference、evaluator、logs、revision、rights齐全。
6. evaluator defense in depth：hard gate、partial credit、hidden reference、alternate/near-miss/shortcut tests、FP/FN audit。
7. public/dev、private/test、pending-QC、retired-contaminated分离，并在workflow family/source/evaluator exposure层切分。
8. 固定完整agent-system manifest：model、harness、tools、prompt、context、budget、retry、provider、environment、evaluator。
9. pilot repeated trials、failure codes、health checks、matched human subset与uncertainty；据此定正式protocol。
10. 建立living governance：revision、rotation、incident、leak response、software/license refresh、rights recheck与retirement。

## 11. 应避免的 10 个 benchmark design anti-patterns（[项目建议]）

1. **Prompt counting**：把自然语言想法或expert submission当runnable asset。
2. **Unit laundering**：把workflow、instance、submission、run、trial都叫“task”。
3. **Snapshot quota copying**：从paper/site/HF/leaderboard抄数变成客户配额。
4. **Step-count horizon**：用clicks/apps/turns冒充long-horizon。
5. **Difficulty by breakage**：靠坏依赖、缺工具、低预算、严tolerance制造低通过率。
6. **Evaluator = truth**：把deterministic误当construct-valid、无FP/FN、不可gaming。
7. **Public-set final exam**：同一静态公开集同时用于训练、调参、回归和最终宣称。
8. **Single-run leaderboard**：忽略随机性、retry、best-of-N、cost与failure taxonomy。
9. **Bare-model attribution**：跨harness/tool/provider/environment把分差全归给foundation model。
10. **Automation erases humans**：因runtime自动判分而删除专家、QC、adjudication、license和maintenance。

## 12. 可直接复用的 schema 与 checklist（[项目建议]）

完整YAML、pilot变量表和acceptance checklist见 [reusable_production_framework.md](reusable_production_framework.md)。最小workflow gate：

- [ ] provenance、目标用户/职业与rights可审计；
- [ ] coherent end-to-end goal，阶段有真实依赖且不可平凡拆分；
- [ ] software/affordances与实践一致，环境可重建；
- [ ] reference和至少一条可靠判分路径可实现；
- [ ] construct→metric显式映射，known exclusions已写；
- [ ] creator、independent solver、evaluator、QC职责分离；
- [ ] oracle、alternate valid、partial、near-miss、empty/wrong-shape、shortcut cases通过；
- [ ] public/private/pending/retired状态与rotation/retirement rule记录。

## 13. 尚需向客户/面试官确认的问题

以下均为**[项目建议]**的scope/decision questions。

1. “约1,000 tasks”最终按workflows还是runnable instances验收？允许的workflow→instance multiplicity是什么？
2. intended use是模型研发回归、系统采购、对外leaderboard、能力研究还是劳动力/经济推断？哪些claim明确禁止？
3. 目标用户/职业/地区/语言/软件栈是什么？配额按业务价值、使用频率、风险还是职业分布加权？
4. public/private/pending/retired的业务要求、访问权限、保密期和泄漏响应是什么？
5. 是否允许proprietary data、licensed software、live web、外部API和PII？谁承担rights/security审批？
6. 运行对象是裸model还是指定agent product？允许哪些tools、network、memory、budget、retry和human-in-the-loop？
7. headline metric偏向full success、partial quality、reasonable-client acceptance、cost/time还是多目标frontier？
8. 哪些artifact/domain必须职业专家人工评价？可接受的adjudication latency与预算是什么？
9. human baseline是否为交付要求？需要matched experts、同affordances和何种置信度？
10. benchmark维护期多久？软件/image刷新、fresh challenge、rotation、incident和retirement由谁负责？
11. 对evaluator FP/FN、environment failure、run variance、重现率的risk tolerance是什么？
12. 最终交付是asset包、可运行平台、leaderboard服务、审计报告，还是四者组合？

## 14. 证据包与可复核性

- [sources.csv](sources.csv)：逐源索引；source cards记录标题、作者/机构、URL、发布日期、访问日期、version/revision、直接证据、Credibility/Recency/Bias与支持/反驳结论。
- [benchmark_matrix_16.md](benchmark_matrix_16.md)：16项、17统一字段矩阵。
- [findings](findings/)：H1–H4及ALE新增/继承问题的原子证据链、反方与失效条件。
- [refresh_targets.md](refresh_targets.md)：mutable surfaces与incident-triggered refresh。
- [reusable_production_framework.md](reusable_production_framework.md)：YAML schema、公式、pilot变量、checklists。

## 15. 最终假设判定

以下判定均为**[研究员推断]**，证据与失效条件见原子findings。

- **H1 — Supported。** 跨ALE/RLI/GDPval、SWE/Terminal、spreadsheet/office与NIST validity guidance均出现同一压力；反例说明可局部优化，不构成普遍反驳。
- **H2 — Supported。** ALE/METR的定义、WorkArena++/CRAB的依赖表达与WAA人类数据共同反对step-count proxy；真实短任务仍可纳入，但不得伪称long-horizon。
- **H3 — Strongly supported。** 原始paper、repo/runtime evidence、独立grader/infra audits和Harness-Bench三类来源一致；应把结果归因到完整configured system。
- **H4 — Supported for mechanism；“快速”underdetermined。** 污染、solution retrieval与benchmark-specific优化有实证机制，private/rotation有设计理由；公开资料不足以给跨benchmark统一衰减速度。

本报告没有把任何公开人数、工期、成本、通过率或benchmark比例转换为本项目精确配额。主要决策缺口已进入pilot变量或客户确认问题。

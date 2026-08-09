# ALE-style 1,000-task Portfolio Selection Framework

**研究对象：** UC Berkeley RDI, *Agents’ Last Exam*（ALE）  
**研究截止与访问日期：** 2026-08-08  
**决策问题：** 如何选择、组合并验收约 1,000 个 ALE-style benchmark assets，而不是复制 ALE 当前分布  
**报告目录：** `ale_05_portfolio_and_sampling_strategy`

## 阅读约定：事实、主张、推断与建议

全文使用以下标签，避免把证据与设计决定混在一起：

- **[E] Evidence-backed fact：** 论文、代码、数据或正式标准在所列版本/快照中明确陈述或可直接检查的事实。
- **[C] Author/institution claim：** ALE 作者或机构的解释、宣传或效果主张；尚未视为独立验证。
- **[I] Researcher inference：** 由多项证据推导，但不是来源原文直接结论。
- **[A] Assumption/input：** 需要客户给定或 pilot 测得的输入；不是已知事实。
- **[P] Proposal/recommendation：** 本项目的设计选择。所有示例性 allocation 数字均为 proposal，除非明确标为 [E]。

数字标签适用于整张表时，表头会写明；否则逐项标注。**任何未标为 [E] 的数字都不得对外宣称为 ALE 的经验比例。**

## Executive summary

结论不是“在 55 个 subdomains 中每类约 18 个”，而是一个**先过硬门槛、再做多目标约束优化、最后用 pilot 的区分度与稳定性校准**的 portfolio assembly process。

1. **先冻结交付单位。** [E] ALE v2 把 *workflow* 定义为端到端专业过程，把 *instance* 定义为带具体输入、初始状态和 reference 的可运行变体；一轮 *agent run* 则是 agent × environment × instance 的一次执行。`1,000 runnable instances` 与 `1,000 distinct workflows` 是成本、覆盖、evaluator 数量和训练价值都不同的产品，不能共用一个数字口径。
2. **O*NET/SOC 只负责 coverage frame，不负责配额。** [E] ALE v2 使用 O*NET 30.2/SOC 形成 51 个职业锚定 subdomains，再加入 4 个 frontier subdomains；[I] 这能发现盲区，却不能说明客户需求、经济价值、软件可执行性或最优权重。配额应由客户 workflow map、需求/风险数据、专家判断和 evaluator feasibility 共同产生。
3. **Runnable、Legally usable 与 minimum Verifiable 是硬门槛。** [P] 不能用“经济价值高”补偿无法稳定启动的软件、权利不清的输入、或不可审计的 evaluator。过门后再以 100 分 rubric 排序。
4. **多实例的正当性来自新增评测信息，而非换数字。** [P] 同一 evaluator/capability contract 下，只有当新 instance 改变有效状态空间、失败模式、难度或统计可靠性，才计为合法 instance；仅替换人名、数字、文件名且解题路径和判分边界不变的是 pseudo-variant。
5. **分配不是单一答案。** 本报告给出 Coverage-first、Client/commercial-first、Frontier/training-first 三套权重与示例性 1,000 allocation。所有数字都是 [P]，必须经 pilot、客户需求权重和法律/软件审查重算。
6. **ALE 自身也显示 evaluator 与 harness 会改变测量结果。** [E] ALE 公开 evaluator 以 deterministic code 为主但存在少量 LLM judging；2026-08-05 的仓库修复记录明确提到 false-zero 与 evaluator repair。[I] 因此“模型失败”必须与 evaluator defect、环境失败、泄漏和 harness 差异分开记录。
7. **公开资料不足以给出精确人力、工期、成本、通过率或项目配比。** 本报告给公式与需要 pilot 的变量，不编造 production quote。最先做的不是承诺 1,000，而是建立一个小而分层的 calibration pilot，测 admission yield、evaluator defect rate、expert/engineering time、运行方差、授权成功率和多实例边际价值。

## 研究开始时的可证伪假设

| ID | 假设 | 可证伪观测 |
|---|---|---|
| H1 | ALE 的 taxonomy 更适合作为 coverage frame，而不是 production allocation rule。 | 若公开证据证明 55 个 subdomains 的比例由业务价值、总体工作频率和测量信息量共同估计且可迁移到本客户，则反驳。 |
| H2 | Runnable、Legally usable、minimum Verifiable 应是硬门槛，而不是可被总分补偿的软项。 | 若 pilot 显示门槛失败的任务仍能稳定、合法、可重复地交付有效分数，则反驳。 |
| H3 | `1,000 distinct workflows` 与 `1,000 runnable instances` 是实质不同的产品；ALE 的 workflow/instance 比率不能当生产配额。 | 若两种 scope 在 evaluator 复用、成本、覆盖和信息量上没有显著差异，或该比率被证明可迁移，则反驳。 |
| H4 | 合法多实例必须提供可测的 marginal information gain；表面换值通常不提供。 | 若 pseudo-variant 在 blinded expert review、failure-mode coverage 或 item information 上稳定增加独立信息，则反驳。 |

## 关键定义与计数规则

| 单位 | 本报告操作性定义 | 不可混入 |
|---|---|---|
| benchmark | 一个版本化 manifest、运行 harness、环境策略、task assets、evaluator、指标和报告协议的整体。 | 不能把一个 task、一次 run 或网站名称当 benchmark 数量。 |
| domain / subdomain | coverage taxonomy 的分层标签；同一 workflow 可有主标签和次标签，但 quota 只按冻结规则计一次。 | 不是 workflow，也不天然代表经济规模。 |
| workflow | 一个稳定的专业目标、过程边界、核心 capability、输出 contract 与 evaluator contract 的组合。多个具体 inputs 可共享它。 | 不能把换输入或重复运行算新 workflow。 |
| runnable task instance | 某 workflow 的一个具体可启动单位：输入、初始状态、依赖、reference/evaluator 配置和终止条件均已冻结。 | 不是 task card 摘要，也不是一次 agent run。 |
| expert submission | 专家提交的 task idea/specification；可能被拒绝、合并、拆分、工程化为一个或多个 workflow/instance。 | 不能直接等于 commissioned task、workflow 或 released instance。 |
| commissioned task | 项目方定向委托生产的 task asset；其计数口径必须在 contract 中注明是 idea、workflow 还是 instance。 | 不能与 external submission 静默相加。 |
| public/private/pending-QC instance | 同一版本 manifest 中按可见性/质检状态分类的 runnable instances。 | pending-QC 不是已验收交付；public task card 也不等于完整 public runnable asset。 |
| agent run / repeated trial | 一次 agent configuration 在一个 instance 和固定环境上的执行；重复 trial 用于估计随机性。 | 不能增加 portfolio 的 asset 数或 workflow 数。 |

**[P] 唯一主键：** `benchmark_version / workflow_id / instance_id / run_id`。`submission_id`、`commission_id`、`domain_id` 与 `subdomain_id` 独立存储，禁止从命名猜单位。

## 证据与版本矩阵

| Surface | 冻结版本/revision | 访问日 | 该快照能证明什么 | 不能推出什么 |
|---|---|---:|---|---|
| arXiv HTML | **2606.05405v2**, 2026-06-11 [E] | 2026-08-08 | [E] 论文口径下 13 domains、55 subdomains、250+ experts；Figure 5 的 960 workflows、1,490 instances、960 external-submission instances、530 commissioned instances，以及 release-state 150 public/1,017 private/323 pending QC；workflow/instance 与 `main.py` contract。 | 不能当作 2026-08-08 官网、GitHub 或 HF 的“当前总数”；也不能从 1,490/960 推导本项目 variants 配额。两个 `960` 分属 workflow 总数与 external-submission instance provenance，不能合并。 |
| Official homepage | mutable live page，无公开 commit [E] | 2026-08-08 | [C] 页面显示 300+ experts、1,500+ undefined “tasks” collected、toward 5,000、55 sub-industries。 | 宣传数字没有冻结 manifest；“tasks”不能自动解释为 workflows 或 runnable instances；也不能与 paper 的 250+ experts 静默对齐。 |
| Submission page | mutable live page，无公开 commit [E] | 2026-08-08 | [C] Complex / Representative / Verifiable 提交标准及 Description/Input/Software/Output/Evaluation 结构。 | 不是验收阈值、生产良率或 evaluator validity 数据。 |
| GitHub repository | commit **1e615e456de7cef57706680613cb80ee13c7fc76**, committed 2026-08-05 [E] | 2026-08-08 | [E] public task code、runner/environment、license 与 grader repairs。Pinned audit：165 个 `main.py`+`task_card` pairs（含 8 demos）；`selected_tasks/full.txt` 为 152 distinct paths；tier files 67/55/38 但 union=152，因 8 paths overlap；licensed/unlicensed lists 为 7/145。 | 目录数、tier entries 与 selected manifest 不是同一计数；repository partition labels 也不是逐项法律结论。不能代表 paper/private/pending-QC 总量；grader 修复后不等于历史 leaderboard 已重算。 |
| Hugging Face dataset | commit **a8c1fd174a1f6cfa76526572a2e3ebece1276be2**, viewer v1.0, 153 rows [E] | 2026-08-08 | [E] 153 unique task-card metadata rows/paths；split 为 67/47/38/1-null；14 category codes（含 `other`）、51 represented subdomain-name values；一个 bridge-model row 不在 pinned repo 的 selected full list。 | task card 不含完整 private input/reference/VM/evaluator；HF splits 不等于 GitHub tier files；14 categories/51 represented names 不改写 paper 13/55 taxonomy；153 rows 不是 ALE 总 portfolio。 |
| RDI blog | June 2026, mutable article [E] | 2026-08-08 | [C] 真实项目、1,500+ tasks、55 occupations、300+ experts、100+ institutions、可复现、无需人工 judge 等机构叙述。 | 不是独立验证；`occupations` 不是 paper `subdomains` 或 homepage `sub-industries`；“No human judges”不应扩张解释为所有评价都纯 deterministic code。 |
| HF paper companion | mutable generated page [E] | 2026-08-08 | [E] 与论文关联的二级页面及生成摘要。 | 它的摘要数字不能覆盖版本固定的 arXiv v2；已观察到 hardest-tier/abstract 表述漂移。 |
| Official taxonomy | mutable live page，无公开 commit [E] | 2026-08-08 | [E] live hierarchy 标为 13 domains、55 subdomains、100 benchmark leaves；本报告示例表使用该快照的 13 domain labels。 | 100 leaves 不是 100 tasks/workflows/instances；live labels 不能静默回填 arXiv/HF 历史 taxonomy。 |
| O*NET | database 30.3 [E]；ALE v2 使用 30.2 [E] | 2026-08-08 | [E] occupation、tasks、work activities、tools/technology 等 coverage metadata。 | occupation prevalence 不等于 workflow prevalence、客户价值或 evaluator feasibility。 |
| SOC | 2018 SOC [E] | 2026-08-08 | [E] 以工作职责而非职位名称分类，主要服务统计目的。 | 不是行业 taxonomy，也不是 benchmark sampling frame 的完整答案。 |

**版本纪律 [P]：** 每次 release 生成 `manifest_sha`，同时固定 paper version、Git SHA、HF revision、taxonomy revision、task/evaluator hashes、环境 image digest、agent/harness version、预算、重试策略和 leaderboard snapshot。任何 surface 变化进入新的 matrix row，不回填旧数字。

## 主要发现 1：Portfolio 的目标函数不是一个比例表

九类目标都合理，但必须区分**价值项、测量项与可交付约束**。

| 目标 | 推荐可观测量 | 作用 | 主要误用风险 |
|---|---|---|---|
| 广覆盖 | domain/subdomain/workflow-cell coverage；capability × software × artifact × evaluator 组合覆盖；coverage entropy | 发现盲区、支持横向比较 | 把 taxonomy leaf 平均分配，制造大量低价值 slots |
| 经济价值 | 客户加权频次 × 专家时间/成本 × 错误损失/风险 × 可自动化比例 | 价值排序 | 用工资或就业人数单变量代替 workflow value |
| frontier failure rate | 多个冻结 agent-system 的 pass probability、item discrimination、failure-mode diversity | 保留有区分度的任务 | 只选 0% pass 的任务，可能选到坏 evaluator 或不可解任务 |
| 客户行业相关性 | 客户 workflow frequency、spend、SLA/risk、产品 roadmap、用户请求 | 产品适配 | 单个大客户完全吞掉公共 benchmark 的代表性 |
| evaluator 可实现性 | 可自动检查的 criteria share、FP/FN、repeatability、审计成本、exploit resistance | 测量有效性与规模化 | 为了易判分只选窄、人工化的任务 |
| 软件可获得性 | 环境可重建率、license/seat/region 可用性、版本 pin、自动化许可、离线能力 | runnable gate 与运维风险 | 把“能下载”误认为允许再分发/自动化/商业使用 |
| 数据生产成本 | expert、engineering、reference、QA、run、license、维护成本 | 预算效率 | 低成本任务过多造成 validity dilution |
| 未来训练价值 | 高质量轨迹/中间状态、failure diversity、可生成 variants、泄漏控制、rights | 训练/诊断复用 | benchmark test 泄漏进训练；用高重复 variants 扩大数据量 |
| 商业可销售性 | 目标 buyer 覆盖、可解释 KPI、权利完整、可部署环境、更新服务 | 产品收入与续费 | 将客户愿意买误称为职业总体代表性 |

**[P] 目标函数结构：**

\[
\max_{x}\; \sum_i x_i\Big(\sum_k w_k z_{ik}-\lambda_c C_i-\lambda_r R_i\Big)
-\lambda_d\sum_{i<j} y_{ij}\,sim(i,j)
+\lambda_I\,Info(S)
\]

其中 `x_i` 表示是否选 candidate，`z_ik` 为归一化价值/测量分数，`C_i` 是成本，`R_i` 是法律/软件/维护风险，`sim(i,j)` 是 pairwise redundancy，`Info(S)` 是集合层面的覆盖或 item information；所有权重与归一化均为 [A]，由客户和 pilot 冻结。

### O*NET/SOC、行业地图、客户需求与专家判断的分工

| 输入 | 应做什么 | 不应做什么 |
|---|---|---|
| O*NET/SOC | [E→P] 建 occupation/work-activity coverage frame，检查职业盲区，提供标准职业代码和工具背景。 | 不直接决定行业优先级、task 难度、配额、经济价值或软件可跑性。 |
| 行业 workflow map | [P] 把 occupation 分解为“触发→输入→决策/操作→artifact/state→验收→异常处理”，形成可评测单元。 | 不把职位描述整段变成一个超大 prompt；不忽略跨职位、跨系统流程。 |
| 客户需求 | [A] 给目标行业、usage frequency、loss severity、采购意愿、部署/合规约束与 6–12 个月 roadmap 权重。 | 不伪装成全经济体代表性；客户特供 benchmark 必须显式命名 scope。 |
| 专家判断 | [A/P] 验证现实性、关键步骤、正常与异常路径、reference、边界条件、acceptable alternatives。 | 专家单人直觉不能替代 evaluator tests、rights review、运行复现或市场证据。 |

**推荐流程 [P]：** O*NET/SOC 找 coverage holes → 行业地图形成 candidate workflows → 客户信号排序 → 双专家确认真实性/价值 → evaluator engineer 和 legal/infra 做 gates → pilot data 调整 allocation。

## 主要发现 2：八个 admission 概念的可测定义

所有阈值先标为 [A]，由 pilot 建分布后冻结；不要在 pilot 前宣称 universal cutoff。

| 概念 | 操作性定义 | Candidate-level measures | 验收证据 |
|---|---|---|---|
| **Complex** | 完成需要多个相互依赖的专业判断/操作，错误会传播，不能由单步查找或机械转换完成。 | 专家 active/elapsed time；dependency depth；工具/文件/状态数；异常分支；返工点；不可并行的 critical steps。 | 专家 walk-through、process graph、trivial baseline、步骤依赖审查。时长只是一个信号，不是定义本身。 |
| **Representative** | 目标用户在声明 scope 内真实执行，且输入、工具、输出、约束与质量标准相符。 | 客户/专家证据数；workflow frequency；O*NET/work-map alignment；正确工具与 artifact；scope 内 SME agreement。 | 去标识的工作样本、SOP、访谈、ticket/usage aggregate、至少两角色审查；记录 provenance。 |
| **Verifiable** | 对核心成功条件有可审计、可重复、抗投机的评分；能区分 agent failure、环境失败和 evaluator failure。 | criteria coverage；deterministic share；evaluator FP/FN；run-to-run scorer repeatability；reference uncertainty；exploit tests。 | gold/reference cases、known-bad mutations、metamorphic tests、双实现 spot check、error taxonomy。 |
| **Economically valuable** | 在声明客户/市场 scope 内，正确完成可节省重要资源、增加收入或降低错误/安全/合规风险。 | `frequency × expert time/cost × automatable share`；error-loss severity；decision consequence；buyer priority。 | 客户数据或明确 [A]；工资/就业数只作 context，不能单独定分。 |
| **Long-horizon** | 目标需跨多个有依赖的阶段保存/更新状态，并在较长交互中恢复或验证中间结果。 | dependency depth；state persistence；tool transitions；files/artifacts；checkpoints；recovery branches；expert elapsed time。 | event/state graph 与 checkpoint rubric。不是简单用 token 数、click 数或 wall time 定义。 |
| **Non-redundant** | 相对已选集合，在 capability、decision boundary、input state、software/artifact、evaluator criteria、failure mode 或 item information 上有增量。 | exact/near-duplicate score；结构图距离；error correlation；marginal coverage；item information；新 edge/criterion 数。 | 多视图 dedup、blinded SME pair review、pilot response vectors；embedding 仅作召回。 |
| **Runnable** | 从干净、版本固定环境中可自动 `start`，允许 agent 操作，随后 `evaluate`，并能重放和归因失败。 | clean-start success；image/dependency pin；timeout rate；network reliance；seed/control；log completeness；replay success。 | 至少两个独立 fresh-image executions、negative/timeout tests、artifact/hash/log manifest。重复次数为 [A]。 |
| **Legally usable** | 生产、托管、自动化、评测、商业交付和所声明的再分发/训练用途均有可追溯权利基础。 | provenance completeness；license/EULA/ToS status；commercial/redistribution/automation/derivative rights；PII/confidentiality；region/seat limits。 | rights ledger、contract/license snapshot、data consent/DPA、counsel disposition。SPDX ID 只能标准化身份，不能替代法律判断。 |

### 推荐的证据数据结构 [P]

每个 candidate 至少保存：

```yaml
identity:
  submission_id: "..."         # expert idea，不等于 workflow_id
  workflow_id: "..."           # 通过 workflow identity review 后才分配
  instance_id: "..."           # 仅 runnable unit
  primary_domain: "..."
  primary_subdomain: "..."
  secondary_tags: []
scope:
  target_users: []
  client_segments: []
  professional_goal: "..."
workflow_contract:
  trigger: "..."
  inputs: []
  state_transitions: []
  tools_and_software: []
  required_outputs: []
  evaluator_contract: []
  failure_modes: []
evidence:
  representativeness: []
  economic_value: []
  source_provenance: []
rights:
  input_rights: "pending|approved|rejected"
  software_terms: "pending|approved|rejected"
  commercial_use: "pending|approved|rejected"
  redistribution: "pending|approved|rejected|not_planned"
evaluation:
  mode: "deterministic_structured|deterministic_simulator|hybrid|judge_dominant"
  criteria: []
  gold_cases: []
  known_bad_mutations: []
  fp_rate: null                 # pilot result, not guessed
  fn_rate: null
runtime:
  os_family: "..."
  image_digest: "..."
  software_versions: []
  network_policy: "..."
  replay_status: "pending"
p…5957 tokens truncated…条产线的 admission yield、cycle-time 分布、并行 WIP、rework loop 和 bottleneck capacity。

## Evaluation、基础设施、QA 与交付标准

### Evaluation contract [P]

每个 instance 的 evaluator 至少返回：

```json
{
  "score": 0.0,
  "criteria": [{"id": "...", "weight": 0.0, "result": "pass|fail|unknown", "evidence": "..."}],
  "failure_origin": "agent|evaluator|infrastructure|reference|policy|unknown",
  "artifacts": [{"path": "...", "sha256": "..."}],
  "evaluator_version": "...",
  "environment_digest": "...",
  "valid_run": true,
  "audit_log": "..."
}
```

- deterministic checks 优先检查可观察 outcome，不只检查文件存在/schema；
- simulator/geometry/behavioral scorer 固定版本、seed 和 tolerance；
- hybrid 模式先做 deterministic gates，再把狭窄、证据定位的 criteria 交给 judge；
- judge-dominant task 必须有 rubric、anchor outputs、position/order randomization、judge version、重复/仲裁策略；
- evaluator change 触发 version bump、regression suite 与 leaderboard comparability review。

### 基础设施 minimum [P]

- immutable images 与 software/dependency lock；Windows/Linux/macOS 或 specialized simulator 明确 provider 与 license；
- task data、private references、secrets 与 public code 分层访问；
- network egress policy、API snapshot/mock、time/locale/font/GPU/seed controls；
- structured run manifest、trajectory、screenshots/artifacts、stdout/stderr、resource/time accounting；
- agent adapter 与 environment driver 分离；同一 instance 可跨允许的 harness 运行；
- evaluator sandbox、timeout/crash isolation、retry semantics；invalid run 不变成 agent fail；
- manifest-level rollback、retirement、rotation 与 contamination response。

### 四道 QA gate [P]

| Gate | Owner | Exit criteria |
|---|---|---|
| Q1 Domain/editorial | lead SME + independent SME | workflow 真实、scope/identity 清楚、inputs/outputs/alternatives/failure modes 完整 |
| Q2 Evaluator | evaluator engineer + red-team reviewer | gold/negative/metamorphic/exploit tests 通过；FP/FN 在 pilot 阈值内；crash 不误记失败 |
| Q3 Environment & legal | infra + rights owner | fresh-image replay、version/license/provenance/PII/ToS disposition 完整；concentration caps 通过 |
| Q4 Portfolio/release | research lead + QA lead | floors/caps/difficulty/dedup/overlap/audit 通过；manifest 冻结；例外签字；rollback/retirement ready |

### Definition of Done [P]

一个 asset 只有在以下全部满足时才计入交付：unit identity 已裁决；所有 gates approved；admission/portfolio selection 通过；至少一个 runnable instance；reference/evaluator/inputs/environment hashes 完整；regression tests 和 fresh replay 通过；rights ledger 与用途范围明确；failure attribution 可用；source card/provenance 完整；owner、refresh trigger、retirement rule 已分配。`pending-QC`、metadata-only task card、失败 run、重复 trial 和 pseudo-variant 均不计。

## 反方证据、失败条件与不确定性

### 1. 当前结论在什么条件下会失效？

- 若产品是单一客户、单一软件的封闭 acceptance suite，“广覆盖”权重和 OS/vendor caps 可能不合适；应改名为 client-scoped suite，并披露集中度。[I/P]
- 若不可直接判分的高价值任务可获得可靠 human panel 或经验证的 judge，硬性的 deterministic 优先顺序可放宽；但成本、可重复性和 bias protocol 要进入 contract。[P]
- 若 pilot 证明某些参数化 family 在边界条件上产生低相关、高信息 response，family cap 应提高；反之，即使输入看起来不同也应削减。[I/P]
- 若客户只采购训练资产而非 benchmark，public/private、reference secrecy、trajectory rights 与 sampling objective 都会改变；不得沿用评测 split。[P]
- 若软件供应商禁止自动化、再分发或商用，任务即使技术上 runnable 也失败；容器化不能解决法律问题。[I]

### 2. 哪些数字只是特定快照，不能作为生产配额？

- arXiv v2 的 13/55 taxonomy、960 workflows、1,490 instances、960 external、530 commissioned、150 public、1,017 private、323 pending QC 均是 [E] paper snapshot；
- live homepage 的 300+ experts、1,500+ collected、5,000 target 是 [C] mutable promotion；
- HF 153 rows 是 [E] pinned task-card dataset snapshot，不是完整 ALE portfolio；
- public evaluator 的 deterministic/LLM 比例是 [E] 开源子集分析，不能外推 private 或作为项目 quota；
- 任何 leaderboard pass rate 绑定当时 task manifest、agent、harness、预算、重试和 evaluator 版本，不能跨快照静默比较。

### 3. 哪些“成功/失败”可能来自 evaluator weakness、leakage 或 harness？

- evaluator 只检查 schema、文件存在或弱 proxy，可出现 false pass；grader crash/过严 tolerance/reference bug 可 false zero。[E/I]
- ALE 2026-08-05 repair commit 记录了 schema-only false-zero prevention、partial-grading repair 和 visual-media evaluator fixes。[E] 这不是 ALE 无效，而是说明 evaluator 本身需要 versioning 和 regression audit。
- public inputs/prompts/reference clues 或相似训练数据可能造成 contamination；private holdout 也需要 provenance、access logs、rotation 和近重复扫描。[I/P]
- Harness-Bench 与其他 agent-eval 研究把性能视为 model–harness pairing，并观察 scaffold/tooling 可改变结果。[E] 因此报告必须写“agent system”，不能只写 base model。
- agentic eval 的单次运行存在随机性；跨 benchmark 研究报告 single-run 指标可有百分点级波动。[E] 该具体幅度不可直接外推 ALE，结论是需 repeated trials 与 power analysis，而不是复制重复次数。
- ALE v2 的 public/full 对比只对一个 agent configuration 报告 `r=0.89`，且 public set 包含完整 hardest tier、因此偏难。[E] 这支持“可用于调试且在该配置相关”的有限结论，不支持把 public subset 当比例抽样或对所有 harness 外推。
- ALE v2 的 five-hour run cap 与 3.8% hit-cap 比例绑定论文快照。[E] 它们可提示 long-horizon infra 设计，但不能直接变成本项目 time budget 或 timeout quota。
- LLM-as-judge 研究显示 position bias 等风险。[E] ALE 的狭窄 artifact probe 不等于开放文本比较，但所有 judge criteria 仍需 anchoring、顺序控制和审计。[I/P]

### 4. 哪些建议合理但没有公开数据支持？

本报告的 100 分权重、70/60 thresholds、domain allocations、subdomain/domain floors、20/55/25 difficulty mix、600/220/150/30 evaluator mix、60% OS cap、8% application cap、15% vendor cap、5% high-risk dependency cap **全部是 [P]**。它们是可操作 starting points，不是 ALE empirical best practice。公开资料也不足以支持精确 headcount、calendar、成本、admission yield、expert throughput、evaluator defect rate、合法 instance/workflow ratio或商业 demand weights；这些均需 pilot [A]。

### 5. 代表性与有效性的反对意见

- O*NET/SOC 是职业统计基础，不覆盖全部前沿或跨职业 workflows；occupation 与 industry 也不是同一维度。[E/I]
- 只保留 frontier failures 会产生 floor effect，无法排序；只保留中档 task 又会低估未来能力边界。[I]
- “真实项目”来源并不自动等于总体代表性；自愿 expert submissions、可获得软件和可自动判分任务都有 selection bias。[I]
- evaluator 易实现性与 professional fidelity 可能冲突；要报告被拒绝的高价值但难判分 cells，而不是让它们从 taxonomy 消失。[P]
- 公开 benchmark 的优化可能促成 benchmark overfitting；需要 private rotation、fresh instances 和 external validity checks。[I/P]

## 对 1,000-task 项目的具体决策影响

| 决策 | 若选 1,000 instances | 若选 1,000 workflows |
|---|---|---|
| 产品承诺 | 1,000 个独立 runnable units；同时披露 distinct `W` | 1,000 个通过 identity review 的 workflows；至少 1,000 instances，额外 `M` 单列 |
| 核心复用 | evaluator、environment 与 workflow family 可复用，但须证明每个 instance 的 marginal value | 可复用 evaluator components/framework，不可用 parameter swap 复用 workflow identity |
| 专家组织 | domain leads + family designers + instance/reference production | 更广的 workflow SMEs + taxonomy/identity board + evaluator architects |
| 最大质量风险 | variant inflation、family concentration、相关样本虚增精度 | evaluator 工程面过宽、admission yield 低、维护/授权长尾 |
| 成本模型 | workflow fixed cost + instance marginal cost 都要算 | workflow fixed cost 占比更高；额外 instances/rotation 另算 |
| 交付表 | 1,000-row instance manifest + workflow family table | 1,000-row workflow manifest + instance child table |
| 验收主键 | `instance_id` | `workflow_id`；每行链接至少一个 accepted `instance_id` |

**[P] 建议在 SOW 第一页写一句不可歧义的话：** “Task 指 accepted runnable instance”或“Task 指 distinct workflow；每 workflow 至少一个 accepted runnable instance”。不要只写“1,000 tasks”。

## F. 示例性的 1,000-task allocation table

本报告 C2 表即 domain-level 示例。为满足 scope 计数纪律，使用时必须选下面**其中一张表头**；不能把两种 scope 的同一数字合并。

| Field | 1,000-instance contract | 1,000-workflow contract |
|---|---|---|
| `allocation_unit` | `runnable_instance` [P contract choice] | `distinct_workflow` [P contract choice] |
| C2 每个 domain count | 解释为 accepted runnable instances [P] | 解释为 accepted distinct workflows [P] |
| Total | 1,000 instances [P] | 1,000 workflows [P] |
| Distinct workflows | `W`, pilot/output fact [A→E after production] | 1,000 [P contract target] |
| Runnable instances | 1,000 [P contract target] | `1,000 + M`, `M` 由 pilot/rotation needs [A] |
| Agent runs | 不计 asset；按 run formula [A] | 不计 asset；按 run formula [A] |

### Machine-readable allocation row [P schema]

```yaml
allocation_version: "proposal-v0"
evidence_label: "P"
profile: "coverage_first|client_commercial_first|frontier_training_first"
allocation_unit: "runnable_instance|distinct_workflow"
domain_id: "..."
subdomain_id: "..."
target_count: 0
floor_count: 0
cap_count: null
objective_contributions:
  breadth: 0.0
  economic_value: 0.0
  frontier_discrimination: 0.0
  client_relevance: 0.0
  evaluator_feasibility: 0.0
  software_availability: 0.0
  production_cost: 0.0
  future_training_value: 0.0
  commercial_sellability: 0.0
constraints:
  difficulty_band: null
  evaluator_mode: null
  os_family: null
  application: null
  vendor: null
  license_risk_tier: null
status: "proposal|pilot_calibrated|frozen|delivered"
rationale_evidence_ids: []
```

## 建议

1. **先签 scope/unit decision，再招专家。** 明确是 1,000 instances 还是 1,000 workflows、客户 scope、public/private/rotation 与 training reuse；否则所有 throughput 与报价都不可靠。[P]
2. **建立四个 owner tracks：** portfolio research/taxonomy、domain SMEs、evaluator+infra engineering、rights+QA；identity board 处理 workflow/instance/pseudo disputes。[P]
3. **先 pilot 后规模化。** pilot 应覆盖高/低软件风险、不同 evaluator modes、不同 domain 与预期 difficulty；以 admission yield、cycle-time、FP/FN、replay、rights lead time、run variance 校准。[P]
4. **把 verifiability 从 task 尾部移到 design 开头。** submission spec 同时写 evaluator contract、reference strategy、known-bad mutations 与 failure attribution，避免完成 task 后才发现不可判分。[P]
5. **用 optimizer 生成 portfolio，不用 domain 负责人各自领 quota。** 先硬 gates，再约束优化；同时输出 rejected/high-value-but-unverifiable gaps，指导 evaluator R&D。[P]
6. **建立 variant budget 和 evidence burden。** 同一 family 的每个新增 instance 都要证明边际信息；默认不把参数化输出当新 workflow。[P]
7. **版本化整个 agent system。** task manifest、agent/harness、environment、budget、retry、evaluator 与 leaderboard 一起冻结；evaluator repair 后明确是否重跑历史结果。[P]
8. **把法律可用性拆成用途矩阵。** internal evaluation、客户托管、公开再分发、commercial resale、training reuse 分开批准；“开源”或 SPDX ID 不等于所有用途都许可。[P]
9. **保持一份 substitution portfolio。** 对高 license、vendor、network 或 maintenance risk 的 cells 预留通过 gates 的替代 candidates；不要等供应商变化后临时补题。[P]
10. **每次 release 都做 validity report。** 报告 coverage、难度、evaluator mode、软件集中度、invalid runs、grader defects、harness sensitivity、contamination findings、retired/repaired tasks 与未知项。[P]

## 尚需向客户/面试官确认的问题

1. “1,000 tasks”在合同中究竟指 runnable instances、distinct workflows，还是两者各有 target？
2. benchmark 是公共通用、某行业、某客户，还是训练数据产品？哪些代表性 claims 必须成立？
3. 九个目标的优先级与不可妥协 constraints 是什么？谁有最终权重/例外审批权？
4. 哪些 industries、occupations、geographies、languages、risk tiers、software ecosystems 是 in/out of scope？
5. 经济价值有何客户证据：usage、tickets、labor time、error loss、spend、revenue、SLA 或 roadmap？哪些只能作为 assumption？
6. 允许哪些 OS、commercial software、cloud/API、网络访问、GPU、seat/license budget？是否允许公开再分发或只允许托管运行？
7. 数据/轨迹是否会用于训练？public、private、rotation、customer-confidential pools 的隔离规则是什么？
8. 对 human review、LLM judge、deterministic evaluator 的可接受比例和 audit 标准是什么？
9. 排名需要什么精度、置信区间、模型/agent 数、harness 数、repetitions 与运行预算？
10. 什么算 accepted alternative？谁是 domain gold authority？专家冲突如何仲裁？
11. 需要支持哪些商业承诺：SLA、更新频率、可重放年限、bug bounty、leaderboard comparability、客户审计？
12. 若某 domain 高价值但短期不可合法运行或可靠判分，是收窄 claim、投入 evaluator R&D，还是用人工 panel？
13. 单一 vendor/client 专用占比是否允许超过本报告 proposal caps？如何标注例外和替代方案？
14. 谁承担法律结论、软件采购、数据保护、security review 和 incident response？

## 可直接复用的 release checklist

### Unit & scope

- [ ] SOW 明确 `task = instance` 或 `task = workflow`
- [ ] benchmark version、taxonomy revision、in/out-of-scope claims 冻结
- [ ] submission / commission / workflow / instance / run 使用独立 IDs
- [ ] public / private / pending-QC / rotation 状态互斥且可追溯

### Admission & identity

- [ ] Runnable、Legal、Minimum Verifiable、Safety、Identity gates 全 approved
- [ ] 100-point rubric 有证据链接、双人 review 和版本
- [ ] multi-view duplicate/overlap scan 完成
- [ ] 每个 variant 有 marginal-information 理由；pseudo-variants 已剔除

### Evaluation & runtime

- [ ] gold、known-bad、metamorphic、exploit 与 crash/timeout tests 通过
- [ ] evaluator FP/FN、repeatability 与 failure attribution 达 pilot-frozen thresholds
- [ ] fresh-image start/evaluate/replay 通过，image/dependency hashes 完整
- [ ] agent/harness/budget/retry/network/seed/locale/time policy 冻结
- [ ] invalid run 不被计为 agent fail

### Portfolio & rights

- [ ] domain/subdomain floors 对应真实 coverage claim，不是平均分配
- [ ] difficulty、evaluator mode、OS/application/vendor/license caps 通过
- [ ] rights ledger 覆盖 production、hosting、commercial、redistribution、training use
- [ ] public/private contamination、source lineage 与 external benchmark overlap 已审查
- [ ] exceptions 有 owner、理由、期限、substitute/retirement plan

### Release & maintenance

- [ ] manifest SHA 与所有 surface/version matrix 发布
- [ ] source cards、audit log、reproducibility bundle 与 limitation report 齐全
- [ ] maintainer、SLA、refresh trigger、grader-fix protocol、rollback/retirement plan 完整
- [ ] grader/evaluator 变化后的 re-run 与 leaderboard comparability policy 明确

## 假设判定

| Hypothesis | Verdict | 依据与剩余不确定性 |
|---|---|---|
| H1 taxonomy 是 coverage frame 而非 allocation rule | **Supported** | [E] O*NET/SOC 的目的和 ALE 的 taxonomy construction 不包含客户需求、经济价值、software/evaluator feasibility 或最优配额；[I] 因此不能从 55 leaves 推导平均或 ALE-proportional allocation。客户真实 demand 数据仍需 [A]。 |
| H2 Runnable/Legal/minimum Verifiable 是硬门槛 | **Supported** | [E] ALE 的 executable `main.py` contract、NIST legal-risk guidance、grader repair evidence 共同说明不可运行/不可用/不可判分会破坏测量与交付；没有公开证据显示高价值分能补偿这些失败。具体 thresholds 仍需 pilot [A]。 |
| H3 两种 1,000 scope 实质不同，ALE 比率不可作配额 | **Supported** | [E] v2 明确定义 workflow 与 instance，且举例一个 workflow 可共享 evaluator 产生多个 instances；[I] 两种 scope 的 identity/evaluator/成本面不同。公开资料没有证明 1,490/960 可迁移。 |
| H4 合法实例需要 marginal information，表面换值通常不提供 | **Supported, with empirical condition** | [E] 测试组装、benchmark selection 与 semantic dedup 文献支持信息/多样性而非样本数本身；[I] 但某个看似简单的 parameter change 可能跨越关键 decision boundary，故不能仅靠文本相似度判拒，必须用 graph+SME+response pilot。 |

## Sources 与可追溯性

每个来源的标题、作者/机构、URL、发布日期、访问日、版本/revision、直接相关原文证据、Credibility/Recency/Bias 评分及支持/反驳关系，分别保存在 [`sources/`](./sources/)；machine-readable deep-research 结果保存在 [`results/`](./results/)。来源总表见 [`sources.csv`](./sources.csv)。

Canonical source cards：

- [`01_arxiv_v2.md`](./sources/01_arxiv_v2.md)
- [`02_official_homepage_live.md`](./sources/02_official_homepage_live.md)
- [`03_official_submit_live.md`](./sources/03_official_submit_live.md)
- [`04_github_repo_pinned.md`](./sources/04_github_repo_pinned.md)
- [`05_huggingface_dataset_pinned.md`](./sources/05_huggingface_dataset_pinned.md)
- [`06_rdi_blog.md`](./sources/06_rdi_blog.md)

补充证据包括 O*NET/SOC、BLS/BEA、sampling/test blueprint/item information、diversity selection、agent-system/harness validity、randomness、LLM judging/injection、contamination/dedup、NIST AI RMF、SPDX/CC/GitHub rights guidance、datasheets/provenance、ALE grader repair、OSWorld release practice 与 parameterized private-seed benchmark 反例。所有跨项目数字仅用于说明方法风险，不作为 ALE 或本项目配额。

**最终假设结论：** H1 **supported**；H2 **supported**；H3 对“单位与产品不同、ALE 比率不可迁移”部分 **supported**，差异的成本/工期幅度 **underdetermined**；H4 作为 marginal-information selection principle **supported**，具体阈值与单个 variant 的身份仍需 pilot，故定量部分 **underdetermined**。

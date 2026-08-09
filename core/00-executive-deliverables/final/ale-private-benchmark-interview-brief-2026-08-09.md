# 客户私有 ALE-style Benchmark：交付建议书

## 960–1,000 个 workflows / 1,490+ 个 runnable instances

**版本：** Interview brief v1

**冻结日：** 2026-08-09

**研究基线：** ALE arXiv `2606.05405v2`；官方代码 `1e615e456de7cef57706680613cb80ee13c7fc76`；Hugging Face `a8c1fd174a1f6cfa76526572a2e3ebece1276be2`

**详细推导：** [完整技术报告](https://github.com/130U/agents-last-exam/blob/codex/ale-deliverable-draft-v1/core/00-executive-deliverables/drafts/ale-private-clone-960-workflows-1490-instances-delivery-report-draft-v3-2026-08-09.md)

### 阅读标签

- **事实：** 固定论文、代码或数据直接支持。
- **建议：** 本方案据此作出的产品和工程选择。
- **待冻结：** 需要客户合同或 pilot 数据确定的执行参数。

---

# 开场：从公开榜单失真，到客户为什么需要私有 benchmark

本方案从 **2026 年 8 月 2 日发布的[官方录像](https://www.youtube.com/watch?v=-npY6XjM8CQ)** 开始。录像记录了 Surge AI 的 Nick Heiner 在 2026 年 6 月 30 日 AI Engineer World’s Fair 上的演讲 *When Will The Benchmaxxing Plague End?*。它提出的核心问题不是“模型是否还能涨分”，而是：当公开题、脆弱 verifier 和排行榜激励共同成为优化目标时，分数可以继续上升，但人真正关心的工作价值未必同步上升。本文把演讲内容归纳为六个控制点：领域专家定义任务、真实工作输入、工具真实可用、题面与 verifier 双向覆盖、端到端 QC、私有 holdout 与主观任务的专业盲评。它们是问题框架，不是 ALE 有效性的独立证明。

**ALE 能够解决公开题长期暴露后，分数越来越难代表“未见任务能力”的问题。** 客户购买的不是另一份公开题库，而是一座只服务于自身决策的私有 benchmark warehouse：题面、输入、reference、evaluator 和正式运行记录均受控；development、validation、sealed final 与 rotation reserve 只是客户内部用途分区，外部公开比例为零。它不能证明绝对无污染，但能显著减少围绕固定公开题反复调参与查询的空间。

**ALE 能够解决 benchmark task 与真实专业工作脱节的问题。** 它把任务放回真实软件、输入、约束和交付物中：专家定义端到端 workflow 与成功标准，agent 在可复位环境内完成文件或系统状态，再由 task-specific evaluator 验证实际产物。测量对象因此是冻结配置下的完整 agent system，而不是脱离 harness、tools、environment、budget 和 retry policy 的裸模型。

因此，本项目不是复制 ALE 的公开题面，而是复刻它的测量架构，并把它建设成客户独占、可运行、可验证、可审计和可维护的私有产品。

---

# 1. 建议直接冻结的产品定义

> 为单一客户建设一套原创、封闭、可运行的 ALE-style 私有 benchmark 仓库。基础交付包括 **960 个通过最终验收的 distinct workflow packages**，以及 **1,490 个通过最终验收的 runnable instances**；不设置对外 public release。若客户特有的语言、地区、软件、监管或高风险场景存在明确缺口，可新增最多 40 个 customer-specific workflows。

基础计数为：

```text
W_base = 960 accepted distinct workflows
I_canonical = 960 accepted canonical instances
I_variant = 530 accepted additional instances
I_base = 1,490 final-QC accepted runnable instances
Public external release = 0
```

这是一项结构性复刻：复刻 taxonomy coverage、workflow→environment→reference→evaluator 的任务骨架、生产 QC 和私有治理；题面、输入、reference、grader 与环境资产必须原创或取得合法授权。ALE v2 的 1,490 条 inventory 包含 323 条 pending QC；本项目的 1,490 条必须全部 final-QC accepted，不能照抄其未完成状态。

每个 workflow 至少有一个 canonical instance；其余 530 个 instances 必须改变关键状态、信息可得性、约束、失败模式、reference 或决策边界。仅替换姓名、日期、seed 或表面数字的 pseudo-variant 不计数。完整计数与验收定义见[范围与产品定义](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/01-scope-and-product-definition/decision-report-2026-08-08.md)。

# 2. 覆盖蓝图：沿用 ALE v2，而不是重新“选一千题”

ALE v2 的正式口径是 **13 个 domains、55 个 subdomains、1,490 个 instances**。Figure 2 另外显示 `Other → Sports` 残余条带；它使 subdomain 总数达到 55，但论文没有把 `Other` 定义为第 14 个正式 domain。基础交付直接冻结 Figure 2 的 instance vector，不再凭空发明另一套行业配额。

| 顶层覆盖域 | v2 instances | 本项目重建 workflows |
|---|---:|---:|
| Engineering & Architecture | 368 | 238 |
| Computing & Mathematical Sciences | 237 | 153 |
| Visual & Media Arts | 226 | 147 |
| Business & Finance | 189 | 121 |
| Health & Medicine | 155 | 99 |
| Life Sciences | 111 | 70 |
| Physical Sciences | 46 | 30 |
| Transportation & Safety | 35 | 22 |
| Education & Information | 33 | 22 |
| Psychology & Neuroscience | 27 | 17 |
| Social Sciences | 26 | 17 |
| Agriculture & Environment | 19 | 12 |
| Legal | 15 | 10 |
| Other → Sports（残余条带） | 3 | 2 |
| **合计** | **1,490** | **960** |

ALE 没有公开 960 workflows 的逐 subdomain manifest。因此，表中的 workflow 数不是 ALE 官方原表，而是本项目按 `960 × subdomain instances / 1,490` 使用 Hamilton largest-remainder rule 透明重建的生产配额。55 个 subdomains、逐项 instance/workflow 数和专家 sourcing lanes 见[完整技术报告 §2.4、§4 与附录 E](https://github.com/130U/agents-last-exam/blob/codex/ale-deliverable-draft-v1/core/00-executive-deliverables/drafts/ale-private-clone-960-workflows-1490-instances-delivery-report-draft-v3-2026-08-09.md)。

# 3. 交付单位：不是 prompt，而是 runnable asset

一个计入付款与验收的 workflow package 至少包含：

1. `workflow_id`、专业目标、能力边界、输出和 evaluator contract；
2. participant-visible task spec 与经过授权的 input pack；
3. 可复位 environment、软件版本、license、credential 与 network policy；
4. hidden reference、合法等价解空间和 versioned evaluator；
5. evaluator unit tests、adversarial fixtures 与人工仲裁规则；
6. author demo、independent solve、domain review、rights/security clearance 与 final approval；
7. release manifest、运行证据、版本、incident、rotation 与 retirement 记录。

Idea、submission、spec-only task、pending-QC 条目、重复 workflow、cosmetic variant、retry、regrade 和缺陷修复都不增加正式计数。完整 schema 见[技术蓝图](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/02-ale-blueprint-and-version-audit/technical-blueprint-2026-08-08.md)。

# 4. 生产系统：Golden case → Batch zero → 分波次扩产

我会把过去项目中使用的 Golden case、guideline、batch zero 和 reviewer 晋升机制，升级为以下 stage-gated 生产线：

| Gate | 核心动作 | 放行证据 |
|---|---|---|
| G0 Scope | 冻结 intended use、claims、计数、权利和运行边界 | 批准的 SOW / manifest schema |
| G1 Golden case | Group Lead 跑通真实 workflow，形成 scenario matrix、rubric、checklist 与答疑 | executable evidence pack |
| G2 Batch zero | 少量最匹配专家独立生产与互审，隔离 guideline、expert、case、environment、evaluator 与 rights 根因 | 分歧与返工账本 |
| G3 Authoring | 按 subdomain、软件、法域和风险招募、校准、分批生产 | accepted spec/input/reference |
| G4 Engineering | 构建可复位环境和 versioned evaluator | clean-room dry-run 与 tests |
| G5 Independent validation | 未参与创作的 solver、domain reviewer 与 evaluator engineer 做盲测和 red team | gold/bad/alternate/near-miss fixtures |
| G6 Final acceptance | Rights/Security Owner 与 Final Approver 签字 | accepted workflow/instance manifest |
| G7 Release & operate | 分配客户私有用途池，冻结 run identity，持续 incident/rotation/retirement | signed release manifest |

RACI 的硬约束是职责分离：author、environment builder 或 evaluator engineer 不能单独批准自己构建的资产；reviewer 是 assurance authority，不是对优秀 author 的荣誉升级。完整 RACI 与专家治理见[专家生产治理](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/06-expert-production-governance/expert-production-governance-report-2026-08-09.md)。

# 5. 分数可信度：evaluator 与环境是产品核心

Evaluator 必须建立 `requirement → construct → reference → check → evidence → fixture` 的双向链。最低测试族包括 gold、known-bad、alternate-correct、near-miss、boundary、corrupt artifact、mutation、metamorphic、shortcut、tamper 与 environment-failure。主观或高风险维度才引入专业盲评；不能把 LLM judge 当成 validity 的替代品。详见[evaluator validity 与 integrity](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/07-evaluator-validity-and-integrity/evaluator-validity-and-scoring-integrity-report-2026-08-09.md)。

运行架构采用统一 control plane、多 substrate、独立 judge plane。一次结果的身份不是 image tag，而是 `release manifest + resolved launch attestation + task/harness/evaluator bundle`。Hidden reference 默认不进入 execution plane；credential、license、network、evidence 与 judge 分区。详见[环境与执行参考架构](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/08-environment-execution-reference-architecture/environment-execution-reference-architecture-report-2026-08-09.md)。

# 6. Pilot 的作用：测量扩产参数，不重开产品定义

Pilot 不再决定“做哪些 domain”或“要不要做 960/1,490”；这些已由 ALE-v2-matched base layer 冻结。它只回答能否以可接受的质量、成本和风险扩产，并实测以下参数：各角色 service hours 与 throughput、stage yields、返工、evaluator 误拒/误放、environment failure、trial variance、expert supply、license friction 与 reserve burn。

```text
N_ideas_required ≈ 960 / Π(stage acceptance yield)
Capacity_stage = available role hours / service hours per accepted unit
T_release = T_pilot + max(T_sourcing, T_evaluator, T_environment_and_legal)
            + T_integration_QA + T_rework + T_freeze
```

Advance、repair、rescope 与 stop gates 在 pilot 前预注册；具体人数、周期、预算和 SLA 在 pilot 后由实测参数进入合同。它们不是还缺一次 desk research，而是必须由客户约束和本项目数据决定。完整扩产公式见[完整技术报告 §10](https://github.com/130U/agents-last-exam/blob/codex/ale-deliverable-draft-v1/core/00-executive-deliverables/drafts/ale-private-clone-960-workflows-1490-instances-delivery-report-draft-v3-2026-08-09.md)。

# 7. 付款、验收与私有用途隔离

| Manifest | 验收对象 | 计费边界 |
|---|---|---|
| Base Workflow Acceptance | 960 个 distinct workflow packages | 通过全部 gates；含 canonical instance、环境、reference、evaluator、rights 与 final approval |
| Additional Instance Acceptance | 530 个有边际测量价值的 instances | 明确 parent workflow 与 variation dimension；cosmetic variant 不计 |
| Gap-fill | 0–40 个 customer-specific workflows | 仅在客户缺口有书面证据和 change approval 时启用 |
| Run & Service | QA、repeats、正式评测、托管、算力与 licensed software | 与 workflow/instance 数量分账 |
| Change / Repair | 版本升级、incident、regrade、replacement 与 retirement | 供应方缺陷修复不得伪装成新增资产 |

所有资产在商业访问意义上均为客户私有，但用途必须隔离：development/integration、restricted validation、sealed private final、private rotation reserve、retired audit archive；只有合同明确允许时才建立 training pool。任何进入训练或被反复调试的 concrete instance，永久失去 unseen-final 身份。

# 8. 原创 worked task：B2B SaaS 营销绩效与预算重分配

为展示方法如何落地，我会提供一个 Business & Finance workflow：agent 在 fresh Windows VM 中使用 spreadsheet 工具，核对广告平台、CRM、订阅/退款和财务确认收入，交付可审计 workbook 与一页决策 memo。Hidden reference 保存 canonical ledger、join relations、metric invariants、预算约束和多个合法解；evaluator 检查文件完整性、reconciliation、时区/币种/归因、指标 lineage、预算 feasibility 与 memo 数字一致性，并用重复 ID、缺失 UTM、refund lag、跨币种、外链注入和不可行预算等 red-team cases 验证 scorer。

这一题把 `workflow → inputs → environment → reference → evaluator → red team → QC → release` 全链闭合，同时允许多种满足约束的预算方案，不把“与标准答案不同”误判为错误。完整 task card 见[完整技术报告 §11](https://github.com/130U/agents-last-exam/blob/codex/ale-deliverable-draft-v1/core/00-executive-deliverables/drafts/ale-private-clone-960-workflows-1490-instances-delivery-report-draft-v3-2026-08-09.md)。

# 9. 能够声称什么，以及下一步

这套产品能够支持的结论是：在冻结的 ALE-v2-matched coverage、配置、affordance、预算和 evaluator revision 下，一个 agent system 对客户私有专业 workflows 的完成表现、失败结构、成本和稳定性。

它不能自动证明 human parity、岗位替代、总体经济影响、真实部署可靠性、整个职业市场代表性或绝对无污染。若客户需要 matched-human，主臂应为近期仍在实践、未参与出题、与目标 workflow 匹配的 experts，并匹配 instruction、software、internet、time、attempts 和 output contract；generalist、author 与 human+AI 必须分臂报告。统计与 human protocol 见[统计和 matched-human 方案](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/10-statistical-and-matched-human-protocol/statistical-and-matched-human-protocol-2026-08-09.md)。

**当前不需要再提出新的 deep-research 问题。** 11 个研究模块已经覆盖产品、taxonomy、production、RACI、evaluator、environment、statistics、human baseline、integrity、living governance、pilot 和 worked task。下一步是由客户在立项时冻结 intended use/claims、语言与地区、软件与 license、run budget、维护/incident SLA、Benchmark Owner、Rights/Security Owner、Final Approver，以及是否采购持续托管与运行服务。这些是合同决策，不是桌面研究缺口。

---

## 进一步阅读

- [完整技术报告：960 workflows / 1,490 instances](https://github.com/130U/agents-last-exam/blob/codex/ale-deliverable-draft-v1/core/00-executive-deliverables/drafts/ale-private-clone-960-workflows-1490-instances-delivery-report-draft-v3-2026-08-09.md)
- [ALE 技术蓝图与版本审计](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/02-ale-blueprint-and-version-audit/technical-blueprint-2026-08-08.md)
- [专家生产治理与完整 RACI](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/06-expert-production-governance/expert-production-governance-report-2026-08-09.md)
- [Evaluator validity 与评分完整性](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/07-evaluator-validity-and-integrity/evaluator-validity-and-scoring-integrity-report-2026-08-09.md)
- [Environment execution reference architecture](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/08-environment-execution-reference-architecture/environment-execution-reference-architecture-report-2026-08-09.md)
- [Living benchmark governance](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/09-living-benchmark-governance/living-benchmark-governance-report-2026-08-09.md)
- [Statistics 与 matched-human protocol](https://github.com/130U/agents-last-exam/blob/main/core/02-1000-task-delivery-design/10-statistical-and-matched-human-protocol/statistical-and-matched-human-protocol-2026-08-09.md)

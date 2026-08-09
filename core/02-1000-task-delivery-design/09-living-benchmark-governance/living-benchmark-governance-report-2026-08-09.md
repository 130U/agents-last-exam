# ALE-style living benchmark：Release Architecture、污染控制与生命周期治理

**用途：** UniPat 面试作业与 1,000-asset 生产方案  
**证据截止：** 2026-08-09  
**ALE 冻结基线：** `arXiv:2606.05405v2`；GitHub `1e615e456de7cef57706680613cb80ee13c7fc76`；Hugging Face `a8c1fd174a1f6cfa76526572a2e3ebece1276be2`  
**重要限制：** 本报告不从 ALE 或任何公开 benchmark 的 release counts 推导人员、工时、成本、周期、throughput、acceptance yield、通过率、阈值、领域配额或 public/private/rotation 比例。

## 0. 阅读规则与证据边界

全篇使用以下标签，避免把证据、主张和项目决策混在一起：

- **[E] 来源事实：** 来源直接支持且本研究可定位的事实。
- **[C] 来源主张：** 论文作者、机构或供应商的解释/宣称；不等同于本研究独立验证。
- **[I] 研究者推断：** 多源证据支持的项目语境推断，但不是来源原句或已验证的项目事实。
- **[P] 项目建议：** 可直接进入 ALE-style 1,000-asset 方案的治理规则。
- **[V] 客户/pilot 变量：** 必须由客户输入、合同、风险偏好或 pilot 测量确定。

“Asset”在本报告中默认指**已定义身份的 concrete runnable instance**。Workflow family、workflow、concrete instance、submission、release 和 run 是不同单位；只有客户另行定义，1,000-asset 目标才可包含其他单位。

## 1. 核心结论

1. **[P] 把治理对象拆成五个正交轴，再提供六个业务视图。** 原子记录分别是 asset lifecycle、pool purpose、access class、release membership、version/lineage；development/demo、restricted validation、private final、rotation reserve、training、retired archive 是业务用途/派生视图，不能塞进一个 `status` 字段。
2. **[P] 同一 workflow family 可以跨池，但必须重新实例化 attack surface。** 只允许共享稳定的能力构念/工作流契约；concrete inputs、reference、hidden tests/secret seeds、environment state、外部 IDs、ACL 和 canary/copy IDs 不得直接复用。
3. **[P] Public subset 的主功能必须先由 intended decision 冻结。** 若 adoption/integration 是主约束，它承担示例、开发、harness integration、复现；若监管/科学透明是主约束，它可主要承担公开审计或 representativeness check。无论哪种，representativeness 都必须验证，且 tuned public score 不是 unseen final evidence。
4. **[P] “保持 private”不是污染控制方案。** Pretraining exposure、post-training optimization、public solution、near-duplicate、search-time contamination、reference/evaluator leakage、internal leakage、repeated-query hill climbing 是八条不同路径；需要身份、访问、服务端执行、反馈信息预算、日志、传感器、审计与 incident response 的组合。
5. **[P] Gating 和 evaluation-as-a-service 缩小直接暴露面，却增加 operator trust、集中式服务、日志和内部权限的新攻击面。** Canary/watermark 只能作为检测/归因传感器；未触发不能证明没有污染。
6. **[P] 原子 lifecycle 只描述内容成熟度与资格。** `proposed → implemented → validated → accepted`；可信风险进入 `quarantined`；`repaired` 表示新 version 等待重新验证；不可修复进入 `retired`。`active-public`、`active-private`、`rotation` 和 `replaced` 是由多轴组合计算的派生视图，不是 lifecycle 原子状态。
7. **[P] Quarantine 是保全证据的暂停状态，不是有罪判定；repair 也不是直接复活。** 对旧 version、旧分数和旧访问状态采用 append-only 记录，严禁静默覆写。
8. **[P] Refresh 恢复 freshness，却不自动保留可比性。** 跨版本只允许三种结果：native release score、带假设和不确定性的 bridge-linked estimate、或 `not comparable`。
9. **[P] Leaderboard 分成 historical snapshot、current live、bridge analysis。** `submission_pause` 是事故动作，不再与 frozen snapshot 混名；历史 regrade 只增加 `corrected_score_view`，alternate metric 与 bridge estimate 另列；不覆盖 original。泄漏不能靠 regrade 恢复 unseen validity。
10. **[V] Public/private/rotation 的数量与比例没有公开的通用答案。** 需要由决策损失、覆盖要求、运行方差、反馈强度、暴露半衰期、资产生成能力、维护/替换负担、权利/安全约束和 reserve burn rate 的 pilot 值共同决定。

## 2. Claim-level 三类来源 ledger

**审计规则：** 同一 canonical project 的 paper/code/data 只算一个 source family；三个栏目分别支持 recommendation 的不同组成部分，不能说任一来源“证明了整个项目 policy”。Exact ontology/state 名称始终是 [P]，不是来源事实。完整摘要见 [claim ledger](working/claim_ledger.md)；可机械连接的权威表是 [claim-source join](claim_source_join.csv)，其每行含 `source_family_id` 外键、source category、institution family、evidence role、evidence card、locator type、exact locator、supported subclause 和 boundary。`validate_claim_join.py` 检查 orphan/mismatch、三类来源、机构独立性、来源类型与定位格式、反证与边界。

| Claim | Role | Benchmark / operational family | Government / standard family | Independent method / audit family | 结论强度与边界 |
|---|---|---|---|---|---|
| CL01 五轴 registry，derived active views | P | ALE official family 显示 paper/code/data/run 是不同对象 | NIST AI 800-2 精确版本/log；W3C PROV entity/derivation | UTBoost 显示 grader/version 变化改变 score/rank | 三类支持“必须分离和追溯”；五轴 enum 是本项目 ontology |
| CL02 Public 主功能需按 intended decision 冻结；tuned public 非 unseen | P | ALE/MMLU-CF/公开 benchmark 显示 public development 与 closed test 模式 | NIST TREC/pooling 研究支持 sampling/representativeness 需验证 | Reusable Holdout/Ladder 支持 adaptive feedback 风险 | 三类支持边界；哪个功能“第一”是 V，不是通用事实 |
| CL03 Family 可跨池，score-bearing concrete/secret surface 不复用 | P | ALE official family 支持 hidden reference 与 distinct instances | NIST 800-171/WIPO 支持 least privilege/need-to-know/copy tracking | Yang et al. 支持 paraphrase/translation 绕过去重 | 各源只支持 input/reference/access 子命题；跨模态 gate 需 pilot |
| CL04 Private/EaaS 必须叠加 feedback、logging、audit | P | Codabench/Kaggle 展示 gated/phased service practice | NIST 800-171 + W3C 支持权限、audit、provenance | Reusable Holdout + Shaky Ladder 支持 adaptive attack | 可支持 defense-in-depth；不提供 quota/delay |
| CL05 Marker/detector 只是 sensor，不是 clean certificate | P | BIG-bench official canary 是 exclusion-notice 实践 | WIPO 支持 copy tracking/attribution，不支持 clean claim | Watermark methods + Duan MIA failure evidence | 三类共同限定用途；具体 power/FPR/FNR 为 V |
| CL06 Quarantine 保全证据；repair 新版本再验证 | P | ALE/SWE benchmark repair/retirement 是 operational cases | NIST AI RMF/SP 800-61r3 支持 contain/recover/improve | W3C provenance + UTBoost grader audit | Incident流程可迁移；score treatment 为项目政策 |
| CL07 泄漏不能靠 regrade 恢复 unseen validity | P | ALE hidden-reference design/retirement cases表明 secrecy 是解释前提 | NIST incident guidance支持限定 scope/containment | Controlled contamination、near-duplicate 与 grader audits支持条件效应 | 这是三类证据的保守综合；受影响 lineage/window 要 incident-specific |
| CL08 Refresh 不自动保留跨版可比性 | P | Dynabench/LiveBench/SWE-rebench rolling practices；Dynabench提示不同比分 | NCES/Testing Standards/PISA 要求 linking/invariance/error | UTBoost 显示 regrade rank 变化；dynamic theory给出 stall反证 | 支持 conditional bridge；不能宣称严格 equating |
| CL09 Historical/current/bridge 三视图，original 不覆写 | P | SWE-bench-Live frozen/live 为 operational precedent | NIST AI 800-2 + W3C 支持版本、日志、派生 | NCES/testing + UTBoost 支持新 view/警告 | 视图命名与 priority 是 policy；coverage 不全不重排 |
| CL10 Pool allocation 由客户约束与 pilot measurement 决定 | P/V | ALE counts 是特定 snapshot/单位，不能当比例 | NIST AI 800-3 支持 sampling/randomness/uncertainty建模 | Adaptive evaluation与dynamic benchmark显示反馈/refresh trade-offs | 三类支持“不能直接外推”；具体变量/比例仍未知 |

主要证据卡见 [sources/](sources/)；canonical family 去重、外链、版本、mutable/refresh owner 见 [source manifest](source_manifest.csv)。

## 3. 多池 release architecture

### 3.0 五个原子轴与派生视图

**[P] Registry 不使用复合 `release_state`。** 至少拆成：

| Axis | 原子字段 | 说明 |
|---|---|---|
| Asset lifecycle | `proposed / implemented / validated / accepted / quarantined / repaired / retired` | 只描述内容成熟度、资格暂停和退役；不编码池或 release |
| Pool purpose | `development_demo / restricted_validation / private_final / rotation_reserve / training` | 描述允许用途；retired archive 由 lifecycle + archive disposition 表示 |
| Access class | `public / identity_gated / private_service / audit_only` | 与 pool 分离；同一 purpose 可因客户/权利使用不同 access class |
| Release membership | `(release_id, asset_version_id, role, effective_from, effective_to)` | 多对多、append-only；一个 version 可同时留在 R1 historical manifest 并作为 R2 anchor |
| Version / lineage | immutable `asset_version_id` + `repairs / supersedes / replaces / derived_from` edge | Edge 同时指向 asset 与 version；不把 `replaced` 存成可覆盖状态 |

另设 **actor/model-lineage-relative exposure relation**：`(asset_version_id, exposed_surface, actor_org, model_lineage, first_known_time, evidence_strength)`；以及独立的 `global_eligibility_decision`。因此一个 item 对 lineage A 可是 exposed、对 lineage B 仍可能未见；项目仍可基于传播/公平风险做 pool-global retirement，这属于 [P] policy decision，不是 exposure fact。

用户要求的四个名称按下式计算：

- `active-public := accepted + active release membership(public_dev) + development_demo purpose + public access`；
- `active-private := accepted + active release membership(native_unseen_core) + private_final purpose + private_service access + applicable lineage eligibility`；
- `rotation := accepted + rotation_reserve purpose + no score-bearing participant/provider exposure`；
- `replaced := retired old asset + accepted successor + replaces edge`。

这保证同一 `asset_version_id` 可以同时出现在 R1 historical snapshot 与 R2 bridge manifest，而不会覆盖 lifecycle、pool、access、exposure 或 lineage。

### 3.1 五个 active purpose + 一个 retired archive view

**标签说明：** 下表的 pool 划分、允许行为和解释边界均为 **[P] 项目建议**；它不是 ALE 作者规定，也不是公开 count 的推导。

| Pool / view | 主要功能 | 允许使用 | 禁止解释/行为 | 默认访问与反馈 | 退出条件 |
|---|---|---|---|---|---|
| **Development / demo** | 示例、authoring guidance、local debug、harness integration、schema/evaluator contract tests、复现与公开审计 | 公开练习、prompt/harness/tool 开发、教学 reference | 不得称为 unseen final；不得把 tuned public score 当最终泛化证据 | Public；详细 diagnostics；公开版本和已知问题 | 暴露不导致退出；过时/缺陷则 repair 或 retire |
| **Restricted validation** | pre-final eligibility、regression、system selection、受限客户 rehearsal | 限定次数/身份的自适应验证 | 不得当作未接触 final；不得无限次调试 | Identity-gated EaaS；聚合/粗粒度或延迟反馈；完整日志 | 反馈预算耗尽、污染、漂移或到期后 rotate/demote/retire |
| **Private final holdout** | 最终比较、客户验收、对未用于系统选择的 concrete instances 做泛化检验 | 预先冻结系统后的最终运行；受控 appeal | 不作为调试器；不返回可用于逐题爬坡的 oracle | 隔离 EaaS/可信节点；最小即时信息；窗口结束后聚合披露 | 曝光、重复反馈、缺陷、漂移、权利/安全事件或计划轮换 |
| **Rotation reserve** | 替代污染、过时、缺陷、许可失效、危险或失去辨别力的 active assets | Static QA、严格预注册的 sealed local QA、未来 promotion | 不做 participant/provider-visible routine scoring、training 或 validation；每次接触必须 disposition | 最严格 IAM/KMS；无参评者反馈；reserve-contact ledger | 仍 pristine 才可 promotion；外部接触则 burn/demote；或 quarantine/retire |
| **Training assets** | SFT/RL/agent policy、tool use、author training、evaluator/harness development、regression fixture | 可公开或按许可训练 | 对参与过优化的 actor/model lineage 永久不能恢复 unseen interpretation；是否全局退役另行决策 | 按训练/许可政策；关系型 exposure ledger | 继续 training/public；缺陷/权利事件可 retire |
| **Retired archive** | `retired` lifecycle + `archive_disposition` 派生视图；历史复现、审计、appeal、漂移、lineage | 冻结查看；按权利提供受控审计 | 不参与 current allocation denominator/scoring；不等于“可重新上线” | Public-retired 可公开；private-retired 可继续 sealed | 终态；有 accepted successor + replaces edge 时派生 `replaced` |

### 3.2 Public、restricted、private 的功能边界

- **[E]** ALE 冻结 paper/code surface 包含开放框架、公开任务与 agent 不可见 reference 的设计证据。**[C]** 作者提出 private/rotation 可降低暴露风险；该主张不证明任何比例对本项目合适，也不证明已执行 rotation。[R01](sources/R01_ale_arxiv_v2.md) [R02](sources/R02_ale_github_pinned.md)
- **[P]** Public 的主职责由 decision table 决定：adoption/integration 优先时用于构建、接入、复现；regulatory/scientific transparency 优先时用于公开审计/representativeness study。其 representativeness 仍必须用 blueprint sampling、缺失 strata、pooling-bias counter-audit、public/private directional check 与不确定性验证。[R25](sources/R25_nist_pooling_bias.md)
- **[P]** Restricted validation 承认自己是 adaptive surface；每次 query/反馈消耗 exposure budget。它不应伪装成 final。
- **[P]** Private final 回答“这个冻结系统在未用于其训练/选择/逐题反馈的 concrete instances 上表现如何”。对某个 actor/model-lineage 已产生实质自适应反馈后，原始结果仍保留，但 interpretation 必须变为 exposed/adaptive。
- **[P]** Private 不等于不可审计。应公开 construct、方法、版本、aggregate coverage、QA/uncertainty、已知限制，并让受控独立 auditor 查看 raw inputs/references/graders/logs。

### 3.3 Workflow family 是否可以跨池

**答案：可以，但只在 family/construct 层复用；不得直接复用 scored concrete surface。**

跨池 gate：

1. **[P]** Family 定义的是稳定能力/专业 workflow，不包含 family-wide invariant answer 或固定 grader shortcut。
2. **[P]** 新建 concrete inputs 与独立 reference outcome；跨公开/训练/隐藏池做 text、code/AST、file hash、formula/dependency graph、image/geometry、semantic 与 workflow/evaluator graph 的多层近重复检查。
3. **[P]** 可共享 evaluator interface；hidden tests、secret seeds、weights/tolerances、exploit fixtures、error behavior 必须独立实例化或严格 access-separated。
4. **[P]** 重建/重新播种 environment；移除 cache、history、temp files、credentials、future artifacts 和可搜索 sibling metadata。
5. **[P]** 外部 ID 使用不编码 pool、sequence、customer、source path 或 sibling count 的 scoped pseudonym；只有受限 registry 保留 family lineage。
6. **[P]** Training/dev 用户和管线不得通过共享 group、bucket、CI、dashboard、backup、support 或 observability 获得 private/reserve 访问。
7. **[P]** 用 common-agent pilot 证明新实例产生新的判别信息，而非 cosmetic variation 或答案迁移。

直接复用的风险：concrete input 允许答案/文件指纹迁移；reference 直接暴露目标状态；公开 grader/parser/error/weights 可形成 grader gaming；共享 ID 支持跨池 join、enumeration、cache/log lookup；共享 ACL 使“逻辑分池”变成标签而非隔离。

允许共享的边界进一步收紧为：**construct schema、non-secret evaluator engine/interface 和受限 internal family lineage 可以共享；score-bearing concrete input/reference、secret fixtures/config/weights/error oracle、external ID namespace 与 ACL 不共享。**

### 3.3.1 Linking anchor 与 reserve contact

**[P] `linking_anchor` 是独立 release role，不属于 private-final unseen numerator。** 每个 release 机械区分三张互斥计分面：

- `unseen_core_score`：只含对适用 actor/model lineage 未暴露的 private-final native items；
- `linking_diagnostics`：anchor/bridge paired runs，只支持跨版分析；
- `exposed_validation_or_public_score`：公开、training、restricted validation 或已反馈 items。

公开/重复使用的 anchor 不得混入 `unseen_core_score`。若业务需要 composite view，必须并列披露各面分数、权重和暴露状态，不能称“全体 unseen”。Common-agent bridge 默认使用预先指定的 bridge/anchor role，不从 emergency reserve 无痕抽样。

**[P] Reserve contact classes：**

| Class | 接触方式 | 默认 disposition |
|---|---|---|
| `RC0` | Static lint、schema、license、hash、reference-only QA；无 agent/model runtime | 不 burn；仍记录 operator/access event |
| `RC1` | Sealed local QA agent/reference run；无外部 provider、参评者、task-level feedback | 有限 exposure；只有预注册 cleanliness 条件满足才可继续 reserve |
| `RC2` | 外部 model/API/provider 可见 prompt/input，或非隔离 common-agent run | 默认 burn；移为 exposed-reserve/bridge candidate，不再 pristine |
| `RC3` | Participant/team 可见或获得 item/score/error feedback | Demote 到 restricted validation 或 public/exposed；不得 promotion 为 unseen core |

每次 reserve contact 必须记录 actor/model lineage、provider retention/training terms、task surface、feedback、日志位置和 `remain / burn / demote / quarantine` 决策。

### 3.4 建议的 release bundle

**[P] 每次 release 的 immutable manifest 至少包含：**

```yaml
suite_release_id: ...
evidence_cutoff: ...
pool_snapshot_id: ...
workflow_family_schema_version: ...
asset_versions: []
input_bundle_hashes: []
reference_bundle_version: ...
evaluator_bundle_version: ...
environment_bundle_version: ...
harness_protocol_version: ...
metric_definition_version: ...
access_feedback_policy_version: ...
leaderboard_policy_version: ...
license_rights_snapshot: ...
known_incidents_and_exclusions: []
signatures_attestations: []
```

## 4. Access matrix

`R`=read；`W`=write/change；`X`=单次 runtime ephemeral use；`A`=approve；`—`=无权限。此表是最小职责分离模板，不预设实际团队人数。

**标签说明：** 整张矩阵是 **[P] 项目建议**；NIST/WIPO/W3C/MLCommons 只支持最小权限、审计、provenance…12549 tokens truncated…P] 回应：** 采用 tiered transparency：公开 construct、taxonomy、method、aggregate stats、version history、synthetic/examples；受控 independent audit raw surface；提供不泄漏 oracle 的 appeal；退役后按风险延迟披露。

### 15.2 “Private/EaaS 已经解决污染”

**[E]** Reusable-holdout/Ladder 类方法在其假设下证明 repeated feedback 可产生 adaptive overfitting。**[I]** 因而 ALE-style private EaaS 不能仅凭“raw task 未公开”宣称免疫；服务还引入 admin、worker、error、artifact export 与 logs 风险。**[P] 回应：** 使用多维 feedback-risk ledger、身份/model-lineage linkage、delay/granularity、双 trust domains、fresh final 与 independent audit。

### 15.3 “Fresh/rotating 就是 contamination-free”

**[C]** 部分 benchmark creators 把 fresh/rolling collection 描述为降低 contamination 的方法。**[I]** 这不等于 clean：新任务仍可能 near-duplicate、公开可搜、内部泄漏、grader 弱或环境漂移；理论工作还显示 sequential dynamic benchmark 可能停滞或在 label noise 下损害 representativeness。[R24](sources/R24_dynamic_benchmark_theory_limits.md) **[P] 回应：** 每次 release 仍做 exposure、near-dup、distribution、grader/environment QA 与 limitations。

### 15.4 “Canary 未触发证明 clean”

**[I] 不成立。** Marker 可被删除、转写、翻译、稀释，或没有足够 statistical power；false negative 不代表无暴露。**[P] 回应：** Canary 只作为 pre-registered sensor，和 provenance、搜索、membership/behavioral evidence、clean rerun 组合。

### 15.5 “Refresh 后只需把新旧分数放一起”

**[E]** Dynabench 文档承认不同 release 分数可能不可比；测试标准要求实质变化时提供新 scale/警告；独立 regrade audits 观察到 rank 变化。**[I]** 因而 ALE-style native scores 在 content、environment、grader/metric 变化后不能默认共用标尺。**[P] 回应：** Historical native series + conditional bridge；没有 invariance/coverage/uncertainty 就 `not comparable`。

### 15.6 “用新 grader 覆写历史更干净”

**[E]** Independent audits 观察到新 parser/tests 可改变历史 score/rank。**[I]** Regrade 回答旧 artifact 在新 scorer 下的结果，不一定重建当时运行，更不能恢复泄漏后的 unseen status。**[P] 回应：** Append-only corrected/alternate view；不能 regrade 时 common-agent rerun；披露 coverage/missingness/rank delta。

### 15.7 “日志越多越安全”

**[E]** NIST 要求组织选择必要事件并保护 audit information。**[I]** Raw logs 可能包含 private prompt、reference、客户数据和可利用 error，因此“越多越安全”不能成立。**[P] 回应：** Data minimization、分层保留、受限索引、完整性保护、review owner 和 legal hold。

### 15.8 “Detector 没命中就没有训练污染”

**[E]** Duan et al. 在其多个 LLM/domain 设置中观察到多种 membership-inference attack 接近随机，并显示 distribution shift 可制造 apparent success。[R22](sources/R22_mia_failure_modes.md) **[I]** 因此 Min-K/MIA 命中或未命中都不能单独决定 contamination。**[P]** 预注册 access assumptions、calibration、FPR/FNR、not-assessable region，并与 corpus search、canary、behavior、clean rerun 组合。

### 15.9 “有动态采集或 judgment pool 就能保持代表性”

**[E]** Dynamic-benchmark theory 展示 sequential process 的 stall/noise failure；NIST/TREC 研究展示 pooling 在大集合中可出现系统性 bias。[R24](sources/R24_dynamic_benchmark_theory_limits.md) [R25](sources/R25_nist_pooling_bias.md) **[I]** 这些不是 ALE effect size，但足以反驳自动保证。**[P]** 代表性必须通过 sampling blueprint、missing strata、new-system counter-audit、measurement uncertainty 和 external review验证。

### 15.10 False flag / denial-of-evaluation

**[I] Threat hypothesis：** 竞争者或无关第三方可能公开 task、伪造 marker signal、构造 trap false positive，以迫使结果下架。**[P]** Signal 只触发 evidence-grade review 与最小 scope containment；必须保留 false-positive/no_change、independent appeal 和 notice lineage，不把 signal 当 guilt。

## 16. 适用边界

- **[I]** 大量 contamination 实验来自 text QA、translation、code benchmark；其效应大小不能直接量化迁移到 ALE-style GUI/CLI、长程、多文件、多模态 artifact workflows。
- **[I]** NIST/W3C/WIPO/供应链标准支持 confidentiality、accountability、provenance 与 incident handling，不自动证明 task representativeness、construct validity、grader correctness 或跨版本 equivalence。
- **[I]** Education psychometrics 的 anchor/linking 提供原则；agent tasks 异质、交互、部分计分、环境依赖且运行随机，因此默认只作 conditional bridge。
- **[I]** Gating、EaaS、delayed feedback、logging 和 watermark 都有 privacy、cost、participation、reproducibility 和 appeal trade-offs；不存在通用最优组合。
- **[I]** ALE 作者提出的 private/rotation 方向与冻结 code/data surface 是研究基线，不是本项目比例、零污染或生产 throughput 的证据。
- **[P]** 所有缺乏三类独立来源直接支持的 ALE-specific 发生率、效果、阈值、quota、yield、周期和比例，统一标 `evidence insufficient / pilot required`。

## 17. 来源表

**标签说明：** “来源与版本/类型”是 **[E] 本轮核验的来源元数据**；“本报告用途/主要边界”是 **[I] 研究者对证据适用范围的判断**。供应商/平台材料仅作为 operational practice clue。

| ID | 来源与版本 | 类型 | 本报告用途 | 主要边界 |
|---|---|---|---|---|
| R01 | [ALE arXiv v2](sources/R01_ale_arxiv_v2.md) | 冻结论文 | public/private、hidden reference、rotation 的作者设计 | 不是项目比例或实际治理成效证明 |
| R02 | [ALE GitHub pinned](sources/R02_ale_github_pinned.md) | 官方代码/commit | framework、run/evaluator surface、版本冻结 | 只代表该 commit |
| R03 | [ALE HF pinned](sources/R03_ale_hf_pinned.md) | 官方 dataset revision | 冻结公开数据面与字段 | 不代表完整私有 taxonomy/库存 |
| R04 | [ALE grader hardening PR](sources/R04_ale_grader_repair_pr64.md) | 官方 code change | evaluator defect/attack surface 的操作证据 | 不能外推 defect rate |
| R05 | [NIST AI RMF](sources/R05_nist_ai_rmf_core.md) | 政府框架 | monitor、change、incident、decommission | 非 benchmark-specific implementation |
| R06 | [NIST CAISI cheating](sources/R06_nist_caisi_evaluation_cheating.md) | 政府案例/方法 | search/grader/environment cheating 与 trace review | 案例不提供本项目发生率 |
| R07 | [NIST SP 800-61r3](sources/R07_nist_sp800_61r3.md) | 政府标准/指南 | incident prepare/respond/recover/improve | Score policy 为本项目扩展 |
| R08 | [W3C PROV-DM](sources/R08_w3c_prov_dm.md) | 标准 | entity/activity/agent、revision/replacement lineage | 不验证记录真实性 |
| R09 | [LiveBench v2](sources/R09_livebench_v2.md) | Peer-reviewed benchmark | recurring/public refresh 实例 | Creator evaluation；公开题会暴露 |
| R10 | [SWE-rebench](sources/R10_swe_rebench.md) | Peer-reviewed benchmark | fresh collection 与 train/eval 分层线索 | 自动化 QA 有 trade-off |
| R11 | [Dynabench](sources/R11_dynabench.md) | Peer-reviewed method | dynamic rounds、human/model loop | Release comparability 受限 |
| R12 | [The Ladder](sources/R12_ladder_leaderboard.md) | Peer-reviewed method | adaptive leaderboard/feedback risk | 具体参数不可直接迁移 |
| R13 | [MS MARCO leaks](sources/R13_ms_marco_leaderboard_leaks.md) | Independent empirical study | hidden test/repeated submission 泄漏与 overfit | 领域与 ALE 不同 |
| R14 | [MLCommons governed evaluation](sources/R14_mlcommons_governed_evaluation.md) | 官方 rules/practice | manifest、audit、benchmark detection restrictions | 行业实践，不独立证明 validity |
| R15 | [GAIA private answers](sources/R15_gaia_private_answer_pattern.md) | Benchmark practice | hidden-answer pattern 与局限 | 隐藏答案不是完整保密 |
| R16 | [HAL verified runs](sources/R16_hal_verified_runs.md) | Benchmark platform practice | run evidence/verified execution 线索 | 平台主张需独立 audit |
| R17 | [Reusable Holdout](sources/R17_reusable_holdout.md) | Peer-reviewed theory | adaptive reuse 风险与受控反馈 | 假设/机制不能直接给 quota |
| R18 | [NIST AI 800-2 draft](sources/R18_nist_ai_800_2_draft.md) | 政府 draft guidance | objective、protocol、log、QA、version、qualified claims | Initial public draft，需 refresh |
| R19 | [NIST AI 800-3](sources/R19_nist_ai_800_3_measurement.md) | 政府测量方法 | sampling/randomness/uncertainty 与 comparisons | 非 ALE-specific |
| R20 | [NIST AITE](sources/R20_nist_aite_sequestered.md) | 政府 operational program | Sequestered blind EaaS 实例 | Early phase，不是成熟效果证明 |
| R21 | [NIST TREC](sources/R21_nist_trec_governance.md) | 政府长期 benchmark | annual tracks、blind runs、archive、test-collection reuse | IR 任务与 agent workflow 不同 |
| R22 | [MIA failure modes](sources/R22_mia_failure_modes.md) | Independent empirical study | Detector near-random/distribution-shift 反证 | 不证明所有 detectors 失败 |
| R23 | [Shaky Ladder](sources/R23_shaky_ladder_attack.md) | Peer-reviewed method/counterexample | Adaptive leaderboard attack 与持续 red-team | 不提供项目 quota |
| R24 | [Dynamic benchmark theory](sources/R24_dynamic_benchmark_theory_limits.md) | Peer-reviewed theory | Stall/noise/representativeness 反证 | 形式模型，不是 ALE measurement |
| R25 | [NIST pooling bias](sources/R25_nist_pooling_bias.md) | Government-hosted empirical method | Judgment-pool representativeness 反证 | IR evidence，不能外推 effect size |
| C02 | [Rephrased samples](sources/C02_yang_rephrased_samples_near_duplicate.md) | Peer-reviewed/preprint empirical | paraphrase/translation near-duplicate 风险 | 文本为主 |
| C03 | [Search-time contamination](sources/C03_wang_search_time_contamination.md) | 2026 preprint | evaluation-time retrieval threat | 单篇新研究；ALE-specific evidence insufficient |
| C04 | [Min-K membership detection](sources/C04_shi_min_k_pretraining_detection.md) | Peer-reviewed/preprint method | black-box exposure signal | 概率 detector，不是 verdict |
| C05 | [Reusable holdout](sources/C05_dwork_reusable_holdout.md) | Peer-reviewed theory | private repeated-query 风险 | 无项目阈值 |
| C06 | [Ladder](sources/C06_blum_hardt_ladder_leaderboard.md) | Peer-reviewed theory | Feedback precision/adaptive leaderboard | 小样本与攻击存在反证 |
| C07 | [BIG-bench canary](sources/C07_bigbench_canary_official_code.md) | 官方 benchmark code | Canary exclusion/diagnostic practice | 可删除；非强制 crawler control |
| C08 | [Watermark contamination](sources/C08_sander_watermark_contamination.md) | Research method | Statistical exposure attribution | Power/utility/false signals 需 pilot |
| C09 | [Publish without answers](sources/C09_ishida_publish_without_answers.md) | Research/counterevidence | Private submissions 仍可 overfit | 任务类型不同 |
| C10 | [Codabench docs](sources/C10_codabench_official_participant_docs.md) | 官方平台文档 | Gating、phases、submission history | 技术能力不等于安全配置 |
| C11 | [Kaggle rules](sources/C11_kaggle_public_private_submission_rules.md) | 行业实践 | Public/private leaderboard、submission limits | 只能作为实践线索 |
| C12 | [NIST SP 800-171r3](sources/C12_nist_sp800_171r3_access_and_audit.md) | 政府标准 | Least privilege、protected audit | 不是 measurement-validity 标准 |
| C13 | [W3C PROV](sources/C13_w3c_prov_dm_audit_provenance.md) | 标准 | Provenance graph | 不提供 tamper resistance |
| C14 | [WIPO trade-secret guidance](sources/C14_wipo_trade_secret_need_to_know.md) | 政府间机构实践 | Need-to-know、copy tracking、access records | 法律适用需客户法务确认 |
| C15 | [MLCommons audit rules](sources/C15_mlcommons_inference_rules_audit.md) | 官方规则 | Independent audit、run restrictions | 不能单独证明 benchmark validity |
| C16 | [MMLU-CF](sources/C16_mmlu_cf_public_validation_private_test.md) | Research benchmark | Public validation + closed test 模式 | 与 ALE task form 不同 |
| C17 | [Open contamination report](sources/C17_li_open_contamination_report_counterevidence.md) | Independent study | 污染 effect 非统一的反证 | 不证明 ALE effect |
| C18 | [SWE-rebench fresh trade-off](sources/C18_swe_rebench_fresh_tasks_and_tradeoffs.md) | Peer-reviewed benchmark | Freshness 与自动 QA trade-off | Creator claims 需 audit |
| C19 | [Controlled contamination impact](sources/C19_icml_controlled_contamination_impact.md) | Peer-reviewed empirical | 暴露内容/阶段影响 effect | 非 agent artifact workflow |
| L04 | [Dynabench releases](sources/L04_dynabench_rounds_and_noncomparability.md) | Peer-reviewed method | Release-specific noncomparability | 不能给 bridge 参数 |
| L05 | [NIST AI 800-2 records](sources/L05_nist_ai_800_2_evaluation_records.md) | 政府 draft | Precise versions、logs、QA、bugs | Draft |
| L06 | [NCES linking standard](sources/L06_nces_linking_and_reporting_standard.md) | 政府统计标准 | Linking design、error、invariance | 教育测量迁移边界 |
| L07 | [Testing Standards](sources/L07_testing_standards_anchor_items.md) | 专业标准 | Anchor/common items、substantial change | 非 agent-specific |
| L08 | [PISA bridge design](sources/L08_oecd_pisa_bridge_design.md) | 政府间技术方法 | Cross-cycle/mode bridge | 不能直接 equate agent scores |
| L09 | [NIST AI RMF monitor](sources/L09_nist_ai_rmf_monitor_change_decommission.md) | 政府治理 | Monitor/change/decommission | Operationalization 为项目建议 |
| L10 | [W3C PROV-O](sources/L10_w3c_prov_lineage.md) | 标准 | Immutable version/derivation model | 不证明 content correctness |
| L11 | [NIST incident response](sources/L11_nist_sp800_61_incident_response.md) | 政府指南 | Incident process | Leaderboard policy 非原文 |
| L12 | [SWE-Bench+ audit](sources/L12_swe_bench_plus_independent_audit.md) | Independent audit | Solution/grader quality failure | 不外推全体缺陷率 |
| L13 | [UTBoost regrade](sources/L13_utboost_regrade_rank_changes.md) | Peer-reviewed audit | Regrade 改变 score/rank | 不能证明新 grader 是同一尺度 |
| L14 | [SWE-bench-Live](sources/L14_swe_bench_live_frozen_and_live_splits.md) | 官方 operational docs | Frozen/live split 实例 | 实践线索，不单独支撑政策 |
| L15 | [TRUCE](sources/L15_truce_private_benchmark_audit_tradeoff.md) | Private-eval research | Privacy/auditability trade-off | 仍需真实第三方 audit |
| L16 | [OpenAI retirement post](sources/L16_openai_swe_bench_retirement_disclosure.md) | Vendor/creator case | Retirement/disclosure 示例 | 供应商材料不能单独支撑通用结论 |

## 18. Refresh targets

| Target | 为什么 mutable | 何时触发 refresh | 核验动作 | Owner |
|---|---|---|---|---|
| ALE paper/code/HF frozen surfaces | 后续 commit、revision、task/grader/license/runtime 可变化 | 新 release、grader fix、task removal、rotation、leaderboard archive | 保留 frozen ledger；paper/code/HF 分别 diff，不回写旧事实 | Benchmark research owner |
| NIST AI 800-2 | Initial public draft | Final publication 或 major draft | 对 objective/log/version/cheating/reporting 逐节 diff | Standards owner |
| NIST AITE | Early/evolving program | Operational rules、audit、blind-data/execution changes | 更新 sequestered EaaS、evidence/appeal 边界 | Evaluation-ops owner |
| MLPerf Endpoints / inference rules | v0.x、rolling roadmap、GitHub rules mutable | Tag/release/rules/audit/change log | Pin tag/commit；更新 manifest、audit、continuous-review evidence | Benchmark research owner |
| Codabench / Kaggle practice | Latest docs 与 competition-specific rules | Platform/rule/API/feedback policy change | 保存 dated snapshot；不把平台能力当项目配置 | Evaluation-ops owner |
| HAL / live leaderboard surfaces | Dynamic content、verified-run criteria 可变 | Verification/schema/leaderboard change | 保存 manifest/screenshot/hash 与访问日 | Benchmark research owner |
| BIG-bench canary repo | Repository/root 引用可能变化 | Commit/tag/canary text change | Pin commit；只用于 exclusion-notice 证据 | Contamination-control owner |
| WIPO live guide / NIST live pages | Web content/法律实践更新 | Updated page、law/guidance revision | Archive page/hash；交 legal/security review | Legal/security owner |
| LiveBench / SWE-rebench / SWE-bench-Live | Cohort、split、scoring、frozen/live policy 可变 | 新 cohort/release/retirement/correction | 记录 release comparability、manifest 与 corrected views | Benchmark research owner |
| ALE independent audit | 当前缺乏多源 ALE-specific audits | 新 near-dup/provider/grader/environment/representativeness study | 验证 creator claims；不外推单一 audit | Independent-review owner |
| Contamination detectors | Methods/counterevidence 快速变化 | Detector validation/failure study | 记录 assumptions、calibration、FPR/FNR、validity region | Contamination-control owner |
| Search-time contamination | 新兴；ALE-specific 证据不足 | 多个独立研究、真实 traces、index changes | 更新 threat model；controlled-network pilot | Contamination-control owner |
| Marker families | Notice/forensic/watermark/trap 的绕过与合法性变化 | New modality/method、known bypass、law change | 分型测 power、survivability、false signal、key custody | Security + legal owner |
| Anchor/bridge for agents | 公开方法仍少；common agents 会消失/漂移 | Linking/rank-stability research 或 pilot | 验证 invariance、coverage、availability、uncertainty；允许 not comparable | Measurement owner |
| Environment/app/API/license | 外部依赖与权利持续漂移 | Health fail、vendor/API/license/contract notice | Freeze versions；reference/common-agent rerun；rights review | Environment + legal owner |
| Incident/repair precedents | 新 leak/regrade/retirement 影响 policy | Postmortem、appeal、raw-artifact regrade | 更新 score-treatment/disclosure/coverage/missingness | Governance owner |

## 19. 最终判断

**[P]** 对 UniPat/ALE-style 1,000-asset 生产，最稳健的起点不是先填 public/private 百分比，而是先冻结：决策与 unit、lifecycle/pool/access/release membership/version-lineage 五轴、family 跨池 gate、anchor/reserve contact、八类污染 registry、双 trust-domain EaaS、incident score-treatment matrix、三视图 leaderboard，以及 pilot 测量字段。随后再用真实 acceptance、run、grader、contamination、refresh、rights 和 access-operations 数据求可行 allocation。

**[P]** 不提供无条件默认 option。仅当客户已经确认 ecosystem adoption/open audit 是主约束、rights 允许公开、family-transfer risk 经 pilot 可接受时，才优先比较 Option A；当 final-integrity/operator-controlled execution 支配时比较 Option B；当客户隔离/regulated data 支配时比较 Option C。若这些约束未确认，三者并行做 feasible/Pareto analysis。

**[V]** 在 customer decision loss、asset unit、feedback needs、rights、安全与 pilot 数据未确认前，任何人员、工时、成本、周期、throughput、acceptance yield、通过率、阈值、领域配额和 pool 比例都应保持为空变量。

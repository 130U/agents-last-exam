# “1,000 道 ALE-style tasks”到底是什么产品？

## UC Berkeley RDI Agents' Last Exam 范围与产品定义决策报告

- 研究对象：UC Berkeley RDI **Agents' Last Exam (ALE)**；不含其他同名 ALE / ALE-Bench
- 研究日期与网页访问日：**2026-08-08**
- 论文基线：**arXiv:2606.05405v2，2026-06-11**
- GitHub 快照：`1e615e456de7cef57706680613cb80ee13c7fc76`（2026-08-05）
- Hugging Face 快照：`a8c1fd174a1f6cfa76526572a2e3ebece1276be2`（lastModified 2026-07-11）
- 逐源证据：[`sources/`](sources/)；索引：[`sources.csv`](sources.csv)；研究计划：[`plan.md`](plan.md)

### 证据标签

- **[事实]**：论文、代码、数据、标准在指定 revision 明确陈述或直接显示。
- **[作者/机构主张]**：ALE 作者/机构对真实性、客观性、意义或未来效果的解释，未在本研究独立复现。
- **[研究员推断]**：基于多个来源、但不是来源原话的综合判断。
- **[项目建议]**：拟写入本项目方案的选择，不冒充 ALE 自身做法。
- **[公开资料不足]**：不能据现有证据给出精确人员、比例、成本、周期、通过率或产能。

---

## Executive summary

**结论先行：不要把默认 scope 写成“生产 1,000 道题”，也不要默认成“1,000 个独立 workflow”。**

**[项目建议] 推荐默认采购对象是：1,000 个经 final-QC 接受的 runnable task instances，组成一个分层、可运行、可审计的 benchmark system。** 每个 instance 必须归属明确的 `workflow_id`；workflow 总数 `W`、每 workflow 的实例数 `n_w`、taxonomy 分配、环境/evaluator 复用上限和各访问池数量，不在缺乏 pilot 数据时预先编造，而由代表性 pilot 冻结。

默认产品同时包含四个相互隔离的用途层：

1. 可公开或受限的 **development/demo** 资产，用于调试、示范和外部审计；
2. 访问受限的 **validation** 资产，用于模型/agent system 选择，但承认反复使用会逐步过拟合；
3. 与训练/开发团队权限隔离的 **private final holdout**，用于最终验收；
4. 从未用于训练或调参的 **rotation reserve**，用于泄漏、老化或 evaluator 失效后的替换。

若另含 training/SFT/RL/agent-improvement 数据，它必须是单独的实例集合和访问策略；可以来自同一 workflow family，但不能与 private final 的具体 inputs、references、evaluator attack surface 和 instance IDs 重合。

**[事实] ALE v2 自己证明了“task”不是稳定单元：** Figure 5 的 1,490 是 task instances，其中 960 是 external submissions、530 是 commissioned tasks；同一 Figure 又按 release state 分成 150 public、1,017 private、323 pending QC。Appendix C.3.7 则另称 960 workflows / 1,490 instances，却没有证明两个“960”是同一集合。[S01](sources/01_arxiv_v2.md)

**[事实] 当前 surfaces 也不能合并：** 论文有 150/152 public 的内部快照差异；GitHub `full.txt@1e615e...` 有 152 unique curated workflow paths（默认 variant 0）；HF `a8c1fd...` 有 153 metadata rows；当前官网/博客说 1,500+ generic tasks、300+ experts，官网另有 5,000 target。[S01](sources/01_arxiv_v2.md) [S02](sources/02_official_home_2026-08-08.md) [S04](sources/04_github_repo_head.md) [S05](sources/05_huggingface_dataset_revision.md) [S06](sources/06_rdi_blog.md)

**[研究员推断] 1,000 workflows 与较少 workflows 衍生出的 1,000 instances 的差异主要来自固定工作与变量工作的组合：** 每个独立 workflow 都要重新完成专业真实性定义、spec、reference/evaluator contract、环境与软件决策、dry-run 和 workflow-level QC；额外 instance 可以复用部分 evaluator/environment，但仍需独立 inputs、references、rights、reset 和 instance QA。精确倍数无法从 ALE 公开资料得到。

**[事实 + 项目建议] 一个完整资产不是 prompt。** ALE 的论文/代码至少要求描述、inputs、software/environment、expected output、hidden reference、executable evaluator、deterministic start、runner contract 和 run artifacts；本项目还应补足 metadata、provenance/license、access classification、QA record、version/digest、known limitations 与 change history。[S01](sources/01_arxiv_v2.md) [S03](sources/03_submit_page_2026-08-08.md) [S04](sources/04_github_repo_head.md)

**[公开资料不足]** 现有证据不足以给出这个 1,000-instance 项目的精确专家数、workflow 数、workflow:instance 比、日生产率、预算、工期、通过率或配额。应通过 pilot 测量候选到 accepted 的 yield、专家/工程时长、evaluator 类型、环境失败、license clearance、QC 循环、flake/retry、run 成本和安全 instance expansion 的成功率。

---

## 1. 可证伪假设与预注册判据

| 假设 | 可证伪形式 | 最终判断 |
|---|---|---|
| **H1 Count-unit**：canonical ALE surfaces 的 workflow、submission、task/variant、instance、run 不是一对一 | 若论文、网站、代码和 HF 使用同一稳定单位且可一对一映射，则 refuted | **Supported** |
| **H2 Access-purpose incompatibility**：权限不变时，同一 instance 不能同时是 training data 与 hidden final eval | 若训练暴露后仍可无条件解释为 unseen hidden generalization，则 refuted | **Supported（有用途限定）** |
| **H3 Asset completeness**：ALE-style asset 是 runnable/versioned evaluation asset，不是 prompt-only record | 若官方实现接受 prompt-only 为 runnable task，则 refuted | **Supported** |
| **H4 Cost driver**：unique workflows/evaluators/environments 比 raw instance count 更强地驱动成本和周期 | 若公开数据或 pilot 显示成本几乎只随 instance 数变化，则 refuted | **Underdetermined；架构方向有支持，精确大小无公开数据** |

完整判定见报告结尾。

---

## 2. 关键定义：先固定单位，再谈 1,000

| 单位 | 本报告定义 | 不能与什么混淆 |
|---|---|---|
| **benchmark** | 资产池 + 运行协议 + 环境 + evaluator + harness interface + 版本/访问/聚合/报告/维护规则构成的评测系统 | 一个 dataset、一个 leaderboard 或一批 prompts |
| **domain / subdomain** | taxonomy 的覆盖/聚合单位；ALE v2 为 13 domains / 55 subdomains | workflow、software 或人员数 |
| **workflow** | 一个 end-to-end professional procedure；在 ALE v2 中通常由一个 `main.py`/共享 `evaluate()` 表达 | concrete case、expert submission |
| **runnable task instance** | workflow 的一个具体可运行 case：特定 input、reference/config、deterministic start 与可评分输出 | 一次 run、一个 prompt row |
| **expert submission** | 专家通过 portal 提交的候选规格/材料；可能被 revise/reject，尚非 accepted runnable asset | final-QC instance |
| **commissioned task** | Figure 5 的 provenance 类别，与 external submission 并列 | workflow 数、release state 或通过 QC 的保证 |
| **public/private/pending-QC instance** | 同一 inventory 上的 release/quality state | training/dev/validation/final 等用途标签 |
| **agent run** | 固定 agent system × environment × instance × budget/retry policy 的一次尝试 | 新 instance |
| **repeated trial** | 同一 instance 和配置的重复 run，用于估计 stochasticity | workflow/instance inventory 增长 |

**[事实]** ALE v2 明确定义 workflow 为 end-to-end procedure，instance 为共享 `evaluate()`、但 input/output data 不同的 concrete runnable case；单独的 “task” 通常指 instance。[S01](sources/01_arxiv_v2.md)

**[项目建议]** 在项目管理系统中禁止单独使用 `task_count`。至少并列记录：

`N_candidate_submissions, N_accepted_workflows, N_accepted_instances, N_public, N_private_final, N_pending_QC, N_runs, N_repeated_trials`。

---

## 3. 证据与版本矩阵：不同 surface 不做统一数字

| Surface | Frozen snapshot / revision | 原始单位与数字 | 可以安全使用的含义 | 禁止推导 |
|---|---|---|---|---|
| arXiv v2 Abstract/Intro | 2026-06-11 | 13 clusters；55 subfields；1K+ tasks；250+ experts | 论文 headline | 精确 staffing ledger |
| arXiv v2 Figure 5 | 2026-06-11 | **1,490 instances** = 960 external submissions + 530 commissioned；= 150 public + 1,017 private + 323 pending QC | 论文 inventory 的两种 partition | 960 submissions = 960 workflows；pending = private final |
| arXiv v2 Appendix C.3.7 / Conclusion | 2026-06-11 | **960 workflows / 1,490 instances** | 结构层计数 | 每 workflow 1.55 instances 的生产配额 |
| arXiv v2 §4 | 2026-06-11 | 152 public/evaluated tasks | 实验 snapshot | 覆盖 Figure 5 的 150 |
| Official homepage | live, accessed 2026-08-08 | 55 targeted sub-industries；1,500+ **tasks collected**；300+ experts；5,000 target | 当前 collection/marketing counter | runnable/final-QC/workflow 数 |
| `/submit` | live, accessed 2026-08-08 | no inventory；五字段与 CRV criteria | 当前 intake specification | acceptance rate、生产产能 |
| GitHub | head `1e615e...` | `full.txt` = **152 unique curated workflow paths**；tier memberships 67+55+38=160，因 8 个跨 tier 重复仍为 152 unique；默认 variant 0；165 code dirs 含 demo/non-curated | 当前 curated public execution manifest | 160/165 = public assets；full private inventory |
| Hugging Face | `a8c1fd...` | **153 metadata rows**；metadata-only；比 GitHub full 唯一多 bridge-model/null-split row | 固定 revision 的公开 cards | 153 = paper public count；完整 runnable packages |
| RDI blog | June 2026 page, accessed 2026-08-08 | 55 occupations/domains；1,500+ tasks；300+ experts | 官方 overview 的当前措辞 | 精确 taxonomy / manifest |
| Leaderboard | accessed 2026-08-08；Best-per-task Jul 4；runtime method Jul 10 | ALE-V1；Pass Rate / Score / harness / model / effort；Full vs Unlicensed | living result/config snapshot | paper v2 的同一实验；bare-model score |

### 版本矩阵的管理规则

1. **[项目建议]** 每次报告只引用一个 frozen manifest；live website 只能标访问日。
2. **[项目建议]** 所有结果绑定 `task_manifest_revision + instance_revision + environment_digest + evaluator_version + harness_commit + agent_config + budget/retry + run_id + timestamp`。
3. **[研究员推断]** 两个数字相等不代表集合相同；两个不同数字也不自动代表错误，可能是 inventory、experiment、metadata 或 living program 的不同快照。
4. **[事实]** 当前 GitHub head 正在修复 grader false-zero 和 visual evaluator 问题，说明 evaluator revision 本身会改变结果解释。[S08](sources/08_github_grader_fix_commit.md)
5. **[事实]** 当前 GitHub/HF card IDs 显示 14 个 `domain_id` 与 51 个 `subdomain_id`，但这是 code/data manifest 表面，不能覆盖或“修正”论文的 formal 13/55 taxonomy；3 个 curated cards 缺 card-level `evaluation` 字段但仍有 executable `evaluate()`，说明 metadata completeness 与 runtime readiness 也不是同一单位。[S04](sources/04_github_repo_head.md) [S05](sources/05_huggingface_dataset_revision.md)

---

## 4. “1,000 道题”可能对应的九种产品

| # | 产品解释 | 目标用户 / 决策 | 资产组成 | 成功标准 | 主要风险 |
|---:|---|---|---|---|---|
| 1 | **1,000 independent professional workflows** | benchmark owner、跨行业能力负责人；追求 breadth | 1,000 workflow specs；每个至少一个 instance；大量 evaluator/environment/reference contracts | 覆盖真实、互不重复的 end-to-end work；workflow-level validity | 极高固定工程/专家/rights 负担；“独立”定义容易虚化 |
| 2 | **较少 workflows → 1,000 runnable instances** | 需要 within-workflow robustness、case variation 的模型/客户 | `W<1000` workflows；`Σn_w=1000`；共享 evaluator family、不同 inputs/references | 变体保持同一 capability/complexity/grading contract；instance QA 稳定 | 表面参数替换、模板泄漏、难度漂移 |
| 3 | **training / SFT / RL / agent-improvement data** | 模型、policy、harness 团队 | 可见 prompt/input/reference/feedback/trajectory，可能含 grader signal | 在另一个未暴露 holdout 上改善；学习效率和安全性 | 污染 final eval；把 memorization 当 generalization |
| 4 | **development set** | agent 工程师、task/evaluator 开发者 | 公开/可见 references、可解释 evaluator、fast reset、debug traces | 快速复现、原因定位、回归稳定 | 反复优化，不能作为 final 估计 |
| 5 | **validation set** | 模型选择、ablation、配置调优 | 受限 set、固定 protocol、适量 feedback、重复运行 | 排名稳定、方差可控、选择决策有效 | 迭代使用后逐渐过拟合；访问日志不足 |
| 6 | **private final holdout benchmark** | 客户验收、独立评测、治理 | hidden prompts/inputs/references/evaluator details；sealed environment；submission API/audit | 隔离完整、可复位、可复核；估计目标 generalization | 隐私降低外部可审计性；仍可能 leakage |
| 7 | **public demo / public benchmark** | 市场、研究社区、供应商 onboarding | 易运行示例、公开 metadata、部分 evaluator/reference、traces | 透明、可复现、能展示产品边界 | 高污染；不能作为长期 hidden final |
| 8 | **internal capability map** | 产品、销售工程、客户诊断、roadmap | taxonomy coverage；workflow/instance scores；failure taxonomy；weighting | 能定位 capability gap 并映射 action/ownership | 权重主观；可能不是代表性 benchmark |
| 9 | **OTS 销售的数据/系统产品** | 多客户采购、渠道/销售、support | 可许可数据或可部署/托管系统；rights chain；docs；SLA；updates | 合法可分发、可安装/运行、稳定支持、版本兼容、客户复用 | 第三方权利、软件许可、secret/PII、维护与泄漏 |

**[研究员推断]** 这九类并非互斥，但必须通过 `purpose_primary`、`visibility`、`allowed_use` 和 `counting_status` 解耦。一个 public demo 可以是 dev pool 的一个 view，不应在总数中再次计为新 asset。

---

## 5. 主要发现

### 5.1 Training data 与 hidden evaluation 为什么不能在权限不变时由同一批 instance 同时承担

**[事实]** ALE v2 将 pre-training overlap 和 task-specific optimization 列为长期有效性威胁；独立研究也指出 train-test overlap 会改变结果解释，并要求披露。[S01](sources/01_arxiv_v2.md) [S09](sources/09_ai_agents_that_matter.md) [S11](sources/11_livebench_v2.md) [S12](sources/12_train_test_overlap.md)

**[研究员推断]** “training 可访问”与“hidden final”在同一 instance、同一权限状态下逻辑矛盾。暴露不只包括 prompt：inputs、reference、gold artifact、evaluator logic、detailed feedback、environment secret 和 task-specific harness rule 都可能形成优化通道。

暴露后的 instance 仍有价值，但成功标准必须改名：

- 可以测 **known-task mastery、regression、format compliance、memory/retrieval、debug stability**；
- 不能再无条件称为 **unseen-task generalization、private final acceptance 或 contamination-free score**。

**反例与边界：**

- 同一 **workflow family** 可以分别生成 train instances 与 final instances；前提是具体 inputs/references/secrets 分离，并用 pilot 检查 template leakage/evaluator shortcuts。仅换数字、文件名或表面措辞不够。
- 若主张跨 instance generalization，hold out instances；若主张跨 workflow，hold out workflows；若主张跨 domain，则需要更高层 holdout。
- Public benchmark 并非无用：它提高透明度、调试和外部审计；LiveBench 显示 rotation/freshness 是一种补偿机制，但只能称 contamination-limited。[S11](sources/11_livebench_v2.md)

### 5.2 1,000 workflows 与 1,000 instances 的数量级差异

设：

- `W` = accepted workflows；`I=Σn_w` = accepted runnable instances；
- `E` = evaluator families / workflow-specific evaluator contracts；
- `S` = distinct environment profiles / licensed software stacks；
- `R_i` = instance `i` 的 repeated trials × agent configurations。

| 工作包 | 更接近随什么扩展 | 1,000 independent workflows | `W<1000, I=1000` instances |
|---|---|---|---|
| 专业 workflow 发现、真实性与 spec | `W` 与 domain breadth | 接近 1,000 次独立定义/审查 | 可在 `W` 内复用专家语境，但仍需 variant review |
| evaluator 设计/实现/校准 | `E`，通常受 `W` 上界约束 | 最坏接近 1,000 个 evaluator contracts | 可复用到同 workflow 的 `n_w`，但需 instance fixtures/reference |
| 软件/环境集成 | `S`，由 software stack 决定 | 高异质性概率更高 | 若 workflow 共用 stack，可明显复用 |
| input/reference/rights | `I`，同时受 component diversity 影响 | 至少 1,000 套 | 仍为 1,000 套；不会因 evaluator 复用而消失 |
| instance QA/reset/smoke | `I` | 1,000 | 1,000 |
| workflow-level peer review | `W` | 1,000 | `W` |
| run compute/license/storage | `Σ_i R_i × resource_i` | 取决于每个实例 | 同样取决于每个实例，不由 W 单独决定 |

**[研究员推断]** 在 evaluator 固定工作近似相等、每 workflow 一个 evaluator contract 的简化情况下，workflow-heavy 与 instance-depth 的 evaluator 固定工作比约为 `1000/W`；这只是结构公式，不是公开观测倍数。真实值受 evaluator family 复用、software stack、rights、QA 返工与 complexity 影响。

**[公开资料不足]** ALE 没有发布生产 authoring hours、accepted yield、review cycles、environment failure、license cost 或 evaluator calibration effort，因此不能说“正好贵 X 倍/慢 X 倍”。论文的 `1,490/960≈1.55` 只是特定 inventory 平均，不是 quota。

### 5.3 一个完整 ALE-style asset 除 prompt 外必须交付什么

**[事实：canonical minimum]** ALE 的论文、submit page 和代码共同要求：task description、input、professional software/environment、expected output、reference/evaluation，以及 executable lifecycle/runner。[S01](sources/01_arxiv_v2.md) [S03](sources/03_submit_page_2026-08-08.md) [S04](sources/04_github_repo_head.md)

**[项目建议：contract minimum]** 每个 accepted instance 至少交付：

1. **Identity**：`asset_id, workflow_id, instance_id, revision, status`；
2. **Purpose/access**：training/dev/validation/final/rotation；public/restricted/private；allowed users/uses；
3. **Task contract**：prompt、professional goal、assumptions、constraints、required/forbidden actions、expected outputs；
4. **Input package**：files/data/context、checksums、schema、source/provenance、PII/secret classification；
5. **Software/environment**：OS/arch、VM/image digest、software/font/locale/timezone、dependencies/locks、network/API/license-server policy、credentials injection、resource limits；
6. **Start/reset**：deterministic initial state、fixture、health check、reset/cleanup/idempotency；
7. **Reference package**：gold/reference artifacts、tolerances、known alternatives、isolation/access rules；
8. **Evaluator**：versioned code、rubric/weights/gates、partial-credit logic、judge model/prompt if any、debug output policy、failure semantics；
9. **Runner/harness contract**：supported interface、input/output directories、budget/timeout、retry policy、telemetry/logging；
10. **Metadata**：domain/subdomain、workflow family、software、artifact/evaluat…4085 tokens truncated…uite、regrade pipeline；
8. trajectory/output/result store、failure taxonomy、cost/runtime telemetry；
9. QA/reviewer/adjudication workflow、defect/quarantine/rotation；
10. reporting/API/dashboard、version comparison、export policy；
11. backup/retention/deletion、security incident 与 leak response；
12. customer clean-room installer/UAT 或 managed-service boundary。

容器/VM 需要 pin digest，但 digest 不会冻结 external API、license server、hardware、time、network 或 secret；这些也要进 manifest 和 health checks。[S20](sources/20_docker_digest_pinning.md)

### 8.5 成本模型：只给公式，不编数字

令每个 workflow 的固定成本为 `F_w`，每个 instance 的边际成本为 `V_i`，平台/治理固定成本为 `P`，运行成本为 `Run_i`，维护/风险准备为 `M`：

```text
C_total = P
        + Σ_w F_w
        + Σ_i V_i
        + Σ_i (R_i × A_i × Run_i)
        + M

F_w = expert_discovery + workflow_spec + evaluator_design/build
    + environment_integration + workflow_peer_review

V_i = input/reference_creation + provenance/rights
    + instance_config/start_state + instance_QA/rework

Run_i = compute + software/license + API + storage/egress + judge + ops
```

其中 `R_i` 为 repetitions/retries policy，`A_i` 为 evaluated agent configurations。需另外跟踪：

```text
accepted_yield = N_final_QC_accepted / N_candidates
safe_variant_yield = N_valid_extra_instances / N_attempted_variants
evaluator_reuse = I / E
environment_reuse = I / S
rework_rate = N_returned_stages / N_assets_entering_stage
```

这些比单纯 `cost / 1,000` 更能解释 scope。

### 8.6 排期模型：关键路径，不是“人数 × 日产量”

```text
T_project = T_pilot
          + max(T_expert_sourcing_and_authoring,
                T_environment_and_evaluator_engineering,
                T_rights_clearance,
                T_QA_and_rework,
                T_infrastructure_hardening)
          + T_integration_baseline_UAT
```

**[项目建议]** Pilot 后用各 strata 的实际分布做 P50/P80 计划，并显式建模稀缺专家、commercial software entitlement、GPU/Windows capacity、rights/adjudication 与 final-QC reviewer 的并发上限。

### 8.7 交付/验收标准

一个 instance 只有在下列全为真时 accepted：

- schema 与 purpose/access/counting fields 完整；
- clean-room 环境可 build/restore，依赖与 digest 可核；
- input staged、reference 隔离、agent 无法通过 normal API 访问；
- gold/reference 能通过，negative 与 near-miss 按预期失败/得分；
- evaluator tests、judge config、partial-credit/gate 明确；
- supported runner 能在 timeout/budget 内结束并输出完整 logs/artifacts/result；
- reset/replay 不污染下一 run；pilot-defined flake gate 通过；
- component-level provenance/rights/privacy review 完成；
- independent domain/QA sign-off 与 known limitations 记录；
- manifest、environment、evaluator、task revisions 冻结；
- UAT 可在客户指定 boundary 重现；
- 未解决 defect 为零，或已明确 quarantine/waiver owner、expiry 与非计数状态。

---

## 9. 建议

### A. 推荐的默认 scope

**[项目建议] 默认选择 S6：1,000 accepted runnable instances 的 Hybrid Benchmark System，而不是 1,000 independent workflows。**

#### 计数与结构

- Contract unit：`I_accepted = 1,000 runnable instances`。
- 每个 instance 必须有 `workflow_id`；`I = Σ_w n_w`。
- `W` 不在签约前伪造；pilot 冻结 minimum breadth、maximum concentration、safe variant rules。
- `purpose_primary ∈ {training, development, validation, final, rotation}` 为互斥主用途；其合计为 1,000。若 training 另签独立数据包，则不占本 benchmark 的 1,000。
- `visibility ∈ {public, restricted, private}` 是独立 access 字段；public demo 可以是 development pool 的 view，不二次计数。

#### 默认功能层

1. **Development/demo slice**：visible evaluator/debug feedback、fast reset、公开/受限审计；
2. **Restricted validation pool**：反复使用受访问日志与查询预算控制；
3. **Private final holdout**：训练/开发团队无具体 asset access，结果最小披露；
4. **Rotation reserve**：未用于训练/调参，满足泄漏、老化、软件/evaluator 失效后的 replacement；
5. **Capability map**：不改变底层 asset count，提供 taxonomy、failure mode、confidence、cost/runtime 与客户 weighting；
6. **OTS readiness option**：只有通过 component-level rights、security、installer/support/SLA gates 的资产才能标 `ots_eligible=true`。

#### 为什么不是默认 1,000 workflows

- **[事实]** ALE 的 960 workflows 是特定 paper snapshot，不是质量标准或客户配额。[S01](sources/01_arxiv_v2.md)
- **[研究员推断]** 1,000 workflows 会最大化 evaluator/environment/expert fixed work，却可能只给每 workflow 一个 case，不能自动带来 robustness。
- **[公开资料不足]** 没有公开成本/yield 支持在 pilot 前承诺这一 breadth；如果客户坚持，应把 contract 明确改为 `1,000 distinct accepted workflows + ≥1,000 accepted instances` 并重算固定工作。

### B. 尚需向客户/面试官确认的问题（20 个）

1. “1,000”要计 **workflow、runnable instance、metadata row、expert submission 还是 accepted final-QC asset**？
2. 首要产品是什么：training data、dev set、validation、private final、public demo、capability map、OTS，还是组合？
3. 谁是直接用户，他们要据此做什么不可逆决策：训练、模型选择、客户验收、采购、销售还是研究发表？
4. 需要主张哪一层 generalization：新 input、new instance、new workflow、new subdomain 还是客户真实生产分布？
5. training/dev/validation/final/rotation 是否必须互斥？谁有权访问 prompts、inputs、references、grader feedback 与 evaluator code？
6. 是否允许同一 workflow family 同时生成 train 和 final instances？如何验证 template leakage 不使 final 失效？
7. 最低 workflow breadth、每 workflow 最大 instance concentration 和 domain/subdomain allocation 谁决定？
8. 哪些行业、地域、语言、software stacks 是 must-have，哪些明确 out-of-scope？
9. “Representative”是相对 ALE taxonomy、客户岗位/workflows、收入/风险权重，还是专家判断？
10. 每个 task 的专业真实性需要什么证据：已完成项目、工作样本、专家声明、客户流程文件，还是 human-time estimate？
11. Windows/GPU/commercial CAD/EDA/paid API/live web tasks 是否允许？软件/云/API/license entitlement 由谁采购和长期维护？
12. 客户是否要求 self-host、指定 cloud、air-gapped、managed service，或多 provider 可移植？
13. 哪些 inputs/references 可用于训练、内部评测、客户转移、公开发布和 OTS 商业转售？谁承担 legal/privacy review？
14. 是否允许 PII、confidential work files、proprietary standards、customer data 或 model-generated references？允许哪些脱敏/合成替代？
15. evaluator 可接受哪些模式：exact/numeric/geometric/behavioral/LLM judge/human review？谁定义 tolerance、partial credit 与 hard gates？
16. 支持哪些 agent/harness interfaces、GUI/CLI tools、network 权限、budget、timeout、retry、parallelism 与 model/provider？
17. 最终结果要报告 single-run、mean score、full pass、best-of-N 还是置信区间？重复 trial 数和缺失/超时规则如何定？
18. Acceptance 对 gold pass、negative/near-miss、flake、cross-machine、evaluator disagreement、rights 和 UAT 的阈值是什么？
19. Pilot 的 strata、预算/时间上限、go/no-go owner 与触发 rescope 的条件是什么？
20. 交付后谁负责 defect、regrade、software/API drift、leak response、rotation、deprecation、SLA 和 OTS 客户支持，持续多久？

### C. Proposal 可直接复用的“范围内 / 范围外”清单

#### 范围内（默认）

- 产品 charter、unit dictionary、success claim 与 frozen manifest；
- 客户 workflow/taxonomy mapping 与代表性 pilot；
- 专家 qualification、sourcing、intake、revision 与 peer review；
- accepted workflows 及合计 1,000 accepted runnable instances；
- task descriptions、input packages、expected outputs、references；
- 指定平台的 environment image/build/start/reset/health check；
- versioned evaluators、tests/fixtures、partial credit/gates、judge config；
- runner/harness adapters、budget/timeout/retry、logs/trajectory/result schema；
- development、validation、private final、rotation purpose/access partitions；
- component provenance/license/privacy/security review 与 manifest；
- engineer dry-run、independent QC、gold/negative/near-miss、flake/replay；
- baseline/reliability pilot、failure taxonomy、capability map；
- clean-room install/UAT、documentation、known limitations、change log；
- initial defect/adjudication/regrade/rotation procedure；
- OTS eligibility 字段与 rights gaps（仅评估；商业发布需单独授权）。

#### 范围外（除非变更单明确加入）

- 自动承诺 **1,000 个独立 workflows** 或复刻 ALE 的任何 snapshot allocation；
- 把 candidate submission、pending-QC、failed/quarantined asset、agent run 或 repeated trial 计入 1,000；
- 保证某模型/agent 达到指定 pass rate、排名、生产力或岗位替代率；
- 从 ALE score 推导 job automation、GDP impact、human parity 或客户 ROI；
- 模型预训练/SFT/RL、harness 产品开发或 agent 调优（可单独采购）；
- 无限 cloud/API/token、commercial software/license seat、GPU/Windows capacity；
- 未经 rights/privacy clearance 的 third-party/customer/proprietary assets；
- 支持所有 clouds、OS、harnesses、models、regions 或 air-gapped environments；
- 永久“contamination-free”、零泄漏、零 evaluator error 或零 flake 保证；
- 无期限维护、无限 rotation、所有上游 API/software 升级兼容；
- public release、benchmark branding、论文 authorship、leaderboard listing 或 OTS resale；
- 法律意见、license indemnity、隐私合规认证或安全认证；
- 客户 production deployment、business process redesign 或 human-in-the-loop operations。

### D. 对“1000 道题”的严谨重写

> **建议合同表述：** 本项目交付 **1,000 个经 final-QC 接受的 runnable task instances**。每个 instance 必须归属于唯一 `workflow_id`，可在指定、版本锁定的 environment image 中由 benchmark runner 独立 reset、执行，并由版本锁定的 evaluator 对输出评分；随附 task/input/reference、software/environment manifest、execution/reset scripts、metadata、component-level provenance/license、QA record、known limitations 及 immutable revision IDs。`workflow` 总数 `W`、各 `n_w`、taxonomy 分配、purpose/access pool、evaluator/environment 复用上限、trial policy 与 acceptance thresholds 由代表性 pilot 冻结。Training/development instances 与 private final/rotation instances 在具体 instance、inputs、references/evaluator secrets 和访问权限上隔离。Candidate submissions、commissioning records、pending-QC/quarantined assets、agent runs 和 repeated trials 均不计入 1,000。

若客户实际要 1,000 workflows，应改为：

> 交付 **1,000 个 distinct、经 final-QC 接受的 professional workflows**，每个 workflow 至少包含一个 accepted runnable instance；workflow 独立性、evaluator/environment 复用、instance 总数与 access partitions 另行定义和计价。

---

## 10. 可直接复用的表格、schema、checklist 或计算公式

### 10.1 Asset manifest schema（proposal 级）

```yaml
asset:
  benchmark_id: string
  workflow_id: string
  instance_id: string
  asset_revision: semver_or_digest
  counting_status: candidate|build|pending_qc|accepted|quarantined|retired

product_policy:
  purpose_primary: training|development|validation|final|rotation
  visibility: public|restricted|private
  allowed_uses: [train, tune, debug, evaluate, redistribute, commercialize]
  access_owner: string
  ots_eligible: true|false|undetermined

taxonomy_and_authenticity:
  domain: string
  subdomain: string
  workflow_family: string
  intended_population: string
  authenticity_evidence: [source_project, expert_attestation, workflow_document]

task_contract:
  prompt: file_or_text
  constraints: []
  required_actions: []
  forbidden_actions: []
  expected_outputs: []
  input_manifest: file

environment:
  os_arch: string
  image_digest: string
  software_bom: file
  dependency_lock: file
  locale_timezone: string
  network_policy: file
  license_entitlements: []
  resource_limits: {}
  start_script: file
  reset_script: file
  health_check: file
  known_nondeterminism: []

evaluation:
  reference_manifest: hidden_file
  evaluator_revision: commit_or_digest
  evaluator_mode: exact|structured|geometric|behavioral|llm_judge|hybrid
  hard_gates: []
  partial_credit: file
  tolerance_rationale: file
  judge_model_prompt_revision: null_or_string
  test_fixtures: [gold, negative, near_miss, adversarial]
  feedback_policy: none|aggregate|detailed

provenance_rights:
  component_manifest: file
  source_and_derivation: file
  licenses_and_evidence: file
  pii_secrets: none|present_and_controlled
  redistribution: allowed|restricted|prohibited|undetermined
  commercial_use: allowed|restricted|prohibited|undetermined
  reviewer_and_date: string

qa:
  expert_author_review: record
  engineer_dry_run: record
  independent_domain_review: record
  evaluator_regression: record
  reset_replay_flake: record
  rights_security_gate: record
  known_limitations: file
  final_signoff: record

run_contract:
  supported_harness_interface: string
  budget_timeout_retry: file
  result_schema: file
  required_logs_artifacts: []
```

W3C PROV、SPDX、Datasheets 与 licensing audit 支持将 provenance、build、train/test、rights 和 maintenance 拆成 component-level records，而不是一个 license 字段。[S15](sources/15_w3c_prov_dm.md) [S16](sources/16_spdx_3_0_1.md) [S17](sources/17_datasheets_for_datasets.md) [S18](sources/18_data_provenance_initiative.md) [S19](sources/19_cc_data_faq.md)

### 10.2 Task selection checklist

- [ ] 是 end-to-end deliverable，不是单一 UI action；
- [ ] 使用该行业真实 professional tool/stack；
- [ ] 目标用户/经济或专业价值明确；
- [ ] 输入、输出、约束、允许替代答案清楚；
- [ ] 有可隔离 reference 或可校准 rubric；
- [ ] evaluator 不奖励显然错误/空/placeholder/shortcut 输出；
- [ ] environment 能合法获得、初始化、reset 和健康检查；
- [ ] input/reference/software/component rights 可追溯；
- [ ] 与已有 workflow 的差异是能力差异，不是表面措辞；
- [ ] 若为新 instance，变体保持 workflow capability、complexity、environment 与 grading contract；
- [ ] access/purpose 与 contamination policy 已定；
- [ ] 失败、超时、缺失输出、partial credit、human escalation 已定义。

### 10.3 Evaluator QA checklist

- [ ] gold/reference 在 clean state 通过；
- [ ] empty/missing/malformed 输出有明确 semantics；
- [ ] known bad、near-miss、adversarial shortcut 按预期失败/得分；
- [ ] format check 与 substantive correctness 分离；
- [ ] 副作用、额外输出、state residue 被检查；
- [ ] evaluator/reference 对 agent 只读/不可见且 post-run staging；
- [ ] tolerance/weights/gates 有专业理由与边界样本；
- [ ] LLM judge 固定 model/prompt，做 order/swap/repeat calibration；
- [ ] evaluator update 有 regression tests、legacy regrade 与 change log；
- [ ] disagreement、appeal、quarantine 和 adjudication owner 明确。

### 10.4 无双重计数公式

```text
I_accepted = I_training + I_development + I_validation + I_final + I_rotation
            = 1,000

I_accepted = Σ_w n_w

N_runs = Σ_i (N_agent_configs_i × N_planned_trials_i + N_retry_attempts_i)

N_runs != I_accepted
N_submissions != W
N_pending_QC not included in I_accepted
```

`visibility` 是 overlay，不能再相加：例如 public demo 可以是 `purpose=development, visibility=public` 的同一 instance。

### 10.5 Pilot go/no-go scorecard

Pilot 不设未经证据的硬数值，但必须产生以下可估变量与分布：

| 维度 | 需测变量 | 决策用途 |
|---|---|---|
| Expert ops | sourcing time、spec/revision hours、availability、review disagreement | staffing/critical path |
| Production | candidate→accepted、stage returns、workflow fixed vs instance marginal hours | W/I scope 与预算 |
| Variant validity | attempted→safe instance yield、difficulty/capability drift、template leakage | concentration 与 n_w |
| Evaluator | mode mix、build/calibration hours、gold/negative/near-miss error、adjudication | evaluator capacity/QA |
| Environment | build/reset failure、software entitlement、cross-machine drift、external dependency | provider/support scope |
| Rights | clearance time、blocked/restricted components、OTS eligibility | public/OTS feasibility |
| Runs | runtime/cost distribution、timeout/flake/retry、trial variance | infra/trial policy |
| Customer value | ranking stability、failure actionability、decision usefulness | go/no-go/product layer |

---

## 11. 最终假设判定

### H1 — Supported

论文自己区分 workflow/instance，并在 Figure 5 与 Appendix C.3.7 使用两个不同含义的 960；代码、HF、网站又分别暴露 curated workflow paths、metadata rows 与 generic tasks。`1,000 tasks` 不足以定义 scope。

### H2 — Supported（有用途限定）

同一具体 instance 一旦对训练/调参团队暴露，就不能在权限不变时继续称 hidden final、也不能无披露地支撑 unseen generalization。它仍可用于 known-task mastery/regression。相同 workflow family 可以生成隔离的 train/final instances，但需 pilot 验证 template/evaluator leakage。

### H3 — Supported

ALE canonical paper/code 明确要求 executable lifecycle、environment、inputs、hidden references、evaluator 和 run artifacts；HF metadata-only surface反向说明 cards 不等于 runnable system。

### H4 — Underdetermined

架构清楚表明 workflow/evaluator/environment 有固定工作，instance 有边际 input/reference/QA/run 工作，因此两种 scope 必然不同；但 ALE 没有公开 production labor/cost/yield 数据，无法判定精确倍数或声称某一 driver 在所有 domain 都占主导。必须由 pilot 量化。

---

## 12. 证据三角与研究边界

本报告的核心跨项目结论使用了不同来源类型：

- **ALE primary**：paper v2、live site/submit、GitHub code、HF data、RDI blog、leaderboard；
- **Independent academic**：AI Agents That Matter、reproducible LM evaluation、LiveBench、train-test overlap、Datasheets、Data Provenance、LLM-judge study；
- **Independent standards/implementation**：NIST AI RMF、W3C PROV、SPDX、SWE-bench code、Docker docs、MLPerf。

ALE 的具体 count、task anatomy、release policy 和 implementation 只以 canonical primary surfaces 为准；独立来源用于验证一般方法论，不伪装成 ALE replication。

**最终边界：** 本研究可以确定应当采购/交付哪些层、如何计数、如何隔离、如何 QA 和 pilot 应测什么；不能从公开资料推导本项目的精确团队、分配、预算、周期、产能或商业价格。

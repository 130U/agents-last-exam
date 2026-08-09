# 1,000-task 项目：可直接复用的生产框架

## 1. 单位与计算公式

设 workflow 集合为 `W`，workflow `w` 的 runnable instances 数为 `V_w`，被测 configurations 集合为 `C`，配置 `c` 在 instance `i` 上的 repeated trials 为 `R_ci`：

```text
N_workflows = |W|
N_instances = Σ(w∈W) V_w
N_runs = Σ(c∈C) Σ(i∈Instances) R_ci
```

三者不可互换。`expert submissions`、`commissioned proposals`、`pending-QC instances` 另设独立漏斗变量：

```text
N_submitted → N_spec_accepted → N_implemented → N_dryrun_passed
            → N_final_QC_accepted → N_released(public/private)
```

生产工时与成本只使用变量模型：

```text
H_total = Σw(H_source + H_spec + H_reference + H_eval_design + H_env + H_workflow_QC)
        + Σi(H_variant + H_instance_dryrun + H_instance_QC)
        + H_platform + H_security + H_program_management + H_refresh

Cost_total = Σrole(H_role × Rate_role)
           + Cost_compute + Cost_storage + Cost_licenses + Cost_external_data
           + Cost_review/adjudication + Cost_refresh/retirement

Calendar_time ≠ H_total / headcount
```

排期还受专业专家、licensed environment、reference/evaluator 串行依赖与 rework loop 限制。所有 `H_*`、`Rate_*` 和一次通过率必须通过 pilot 估计。

## 2. Benchmark asset schema（YAML）

```yaml
asset_identity:
  benchmark_id: string
  workflow_id: string
  instance_id: string
  schema_version: semver
  asset_revision: immutable_hash
  release_state: dev|public|private|retired|pending_qc

construct:
  intended_capability: string
  intended_use: [development, regression, model_comparison, procurement, research]
  excluded_claims: [job_replacement, bare_model_ability, economy_wide_productivity]

taxonomy:
  domain: string
  subdomain: string
  workflow_family: string
  sampling_frame_source: string
  target_weight: null  # only if client population/decision defines it

provenance:
  sourcing_route: expert_submission|commissioned|licensed_source|public_source
  source_project_description: string
  source_dates: []
  contributor_roles: []
  rights_and_licenses: []
  pii_confidentiality_review: pass|fail|not_applicable

workflow:
  professional_goal: string
  coupled_stages: []
  cross_stage_dependencies: []
  recovery_requirements: []
  human_time_measurement:
    method: timed_attempt|expert_estimate|historical_record|unknown
    evidence_id: string|null
  nontrivial_parallelization_rationale: string

instance:
  task_description: string
  inputs: []
  expected_deliverables: []
  variant_parameters: {}
  solvability_evidence: []

environment:
  os_image_digest: string
  software_versions: []
  licenses: []
  compute_profile: string
  network_policy: offline|allowlist|open
  locale_timezone: string
  reset_procedure: string
  health_checks: []

evaluator:
  evaluator_revision: immutable_hash
  construct_to_metric_map: []
  hidden_references: []
  gates: []
  partial_credit_components: []
  tolerances_and_rationale: []
  judge_type: deterministic|llm|human|hybrid
  judge_model_prompt_revision: string|null
  false_positive_tests: []
  false_negative_tests: []
  adversarial_shortcut_tests: []

run_protocol:
  agent_manifest_required: true
  time_token_cost_limits: {}
  retry_policy: string
  repeated_trials: null  # set from pilot/uncertainty goal
  failure_codes: []
  artifacts_and_traces_retained: []

qa:
  expert_review: []
  engineer_dry_runs: []
  cross_reviewer_result: pass|fail
  evaluator_red_team: pass|fail
  leakage_scan: pass|fail
  reproducibility_runs: []
  known_limitations: []
```

## 3. Pilot 必测变量

| Variable | Why it cannot be invented | Pilot measurement |
|---|---|---|
| expert sourcing/spec hours by subdomain | professional scarcity and artifact complexity vary | time logs by workflow family; median + tail, not one global mean |
| evaluator engineering hours by mode | hash/table/geometry/LLM/hybrid differ materially | stratify by evaluator archetype |
| environment build/rebuild time | licenses, OS, packages and data vary | clean-room build and restore tests |
| submission→accept yield and rework loops | public ALE funnel is its snapshot, not client quota | pilot funnel at each gate with reason codes |
| workflow→instance multiplicity | must reflect legitimate variants, not quota inflation | variant-equivalence and difficulty stability audit |
| evaluator FP/FN rate | automatic does not mean valid | expert gold cases + adversarial near-miss cases |
| environment-caused failure rate | separates capability from broken task | human/oracle smoke run + health checks + reruns |
| run variance | stochastic agents and long trajectories vary | repeated trials on stratified subset |
| runtime/token/API/compute/license cost | depends on configuration and software | metered end-to-end runs, including setup/evaluation/sync |
| human baseline feasibility | comparable experts/affordances may be scarce | matched timed attempts on a designed subset |
| contamination exposure | public data, web, git history, package versions differ | threat model, network-policy test, trace audit |
| refresh/retirement burden | living software and tasks drift | scheduled replay after environment/data updates |

## 4. 十条应采用的做法

1. 先签署单位合同：workflow、instance、submission、commissioned item、release state、run、trial 分列计数。
2. 先写 construct/claim boundary，再选任务；同时写明 benchmark 不能证明的结论。
3. 从目标用户/职业 workflow landscape 取样，不从某个公开 benchmark 的当前分布复制生产配额。
4. workflow-first：先验证端到端依赖和专业真实性，再制作可控 instances；variant 必须有独立价值。
5. 采用 executable asset contract：spec、inputs、environment、reference、evaluator、logs、revision 缺一不可。
6. evaluator 采用 defense in depth：硬 gate、分项 credit、隐藏 reference、near-miss/shortcut red team、FP/FN audit。
7. dev/public/private 分离必须在 workflow family、source、reference 与 evaluator exposure 层考虑，而不只是随机切 instance。
8. 固定并公开 agent-system manifest：model、harness、tools、prompt、context、budget、retry、provider、environment、evaluator。
9. 用 repeated trials、failure codes、environment health checks、matched human subset 与 uncertainty 分析解释分数。
10. 建立 living governance：版本、rotation、incident adjudication、leak response、software refresh、task retirement 与 rights recheck。

## 5. 十个应避免的 design anti-patterns

1. **Prompt counting**：把自然语言 prompt 或 expert idea 当成 runnable task asset。
2. **Unit laundering**：把 workflow、instance、submission、run、trial 合并成“task 数”。
3. **Snapshot quota copying**：把论文/官网/HF/leaderboard 某个数字直接变成客户配额。
4. **Step-count horizon**：把很多独立 GUI clicks 串起来就称 long-horizon。
5. **Difficulty by breakage**：靠坏依赖、缺工具、低预算、极严 tolerance 让通过率变低。
6. **Evaluator = truth**：只因为 grader deterministic 就假定 construct valid、无 gaming、无 FP/FN。
7. **Public-set final exam**：同一公开静态集同时用于训练、prompt tuning、回归和最终能力宣称。
8. **Single-run leaderboard**：忽略 stochastic variance、retry policy、cost 与 best-of-N。
9. **Bare-model attribution**：跨不同 harness/tools/provider/environment 把分数差全部归给 foundation model。
10. **Automation erases humans**：宣称 fully automatic 因而不需要专家、QC、adjudication、licensing 和 maintenance。

## 6. Workflow 与 instance acceptance checklist

### Workflow gate

- [ ] 有目标使用者/职业背景与可审计 provenance。
- [ ] 是 coherent end-to-end deliverable；阶段存在真实依赖，不能平凡拆成独立题。
- [ ] 指定 professional software/affordances，且与真实实践一致。
- [ ] 有合法可交付 inputs、reference、software/license 路径。
- [ ] intended capability 与 evaluator signals 有显式映射。
- [ ] 有至少一种非整体“vibe”评分路径，或充分论证 narrow judge 必要性。
- [ ] 专家与工程 reviewer 均确认 solvable、context sufficient、bounds calibrated。

### Instance gate

- [ ] immutable instance ID/revision；输入与 reference 不串漏。
- [ ] fresh environment 可从零重建并通过 health check。
- [ ] oracle/human 能在给定 affordances 内成功；失败原因可分类。
- [ ] evaluator 对 full success、partial、near miss、empty/wrong-shape、shortcut cases 符合预期。
- [ ] agent 无法读取 evaluator、hidden reference、future repository/package state。
- [ ] dry-run artifacts、logs、metrics、cost、time 可复核。
- [ ] release state、rotation/retirement rule、known limitations 已记录。


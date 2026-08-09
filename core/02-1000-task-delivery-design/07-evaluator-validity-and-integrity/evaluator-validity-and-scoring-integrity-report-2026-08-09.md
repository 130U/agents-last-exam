# ALE-style Evaluator Validity and Scoring Integrity

## UniPat 面试作业与 1,000-asset 生产方案深度研究

**As-of：2026-08-09**  
**研究对象：** evaluator validity、score integrity、release governance、failure attribution 与 historical regrade  
**版本冻结：** arXiv:2606.05405v2；GitHub `1e615e456de7cef57706680613cb80ee13c7fc76`；Hugging Face `a8c1fd174a1f6cfa76526572a2e3ebece1276be2`

---

## 0. 怎样阅读本报告

每条结论使用以下标签，避免把来源、作者主张和本项目建议混为一谈：

- `[F]` 来源直接支持的事实；
- `[C]` 来源作者或机构的主张/实验结论；
- `[I]` 研究者推断；
- `[R]` 本项目建议；
- `[P]` 必须由客户输入或 pilot 确定。

`[I]` 与 `[R]` 都不会被表述成来源已经证明的事实。供应商/平台实践只作行业线索，不单独支撑重要结论。所有来源均有独立 source card；短引文保留在 `sources/` 中。

### Frozen ALE evidence ledger

- `[F]` ALE v2 将 artifact retrieval、hidden reference/rubric 和 `evaluate()` 评分置于 agent 结束后的 grading flow，并描述 exact/hash、numeric、geometric、visual、behavior、rubric 与 targeted judge 等模式。[S01]
- `[F]` 固定 Git commit 的 message 为 `fix(tasks): harden graders and sync visual-media evaluators`；patch 修复 false-zero、numeric boundary、recommendation semantic/negation、partial component 与 corrupt-artifact handling，并增加 regression tests。[S02]
- `[F]` 固定 public corpus audit 对 153 个 HF rows 的 executable scoring path adjudication 为 141 deterministic、7 hybrid、5 LLM-judge；这三个数是本报告的案例入口，不是 validity 结论，也不是未来生产配额。[S03]

---

## 1. 核心结论

### 1.1 Mode 不是 validity

`[I]` `deterministic / hybrid / LLM-judge` 只说明 scorer 怎样执行。Validity 要回答：这个版本化的 prompt/reference/evaluator/protocol 所产生的 score，是否支持计划中的能力解释和业务用途。

三角证据：ALE 固定代码仍需 grader repair `[F]`；NASA/NIST 要求 measurement target、implementation、reporting 与 requirements-to-tests traceability `[F/C]`；BetterBench 和 SWE/WebArena re-audits 说明 benchmark 的 metric、tests 与 maintenance 会持续产生 validity 缺口 `[C]`。[S02,S04–S06,S11–S13]

### 1.2 Coverage 必须双向且有区分力

`[R]` 对每个 atomic requirement 建 `prompt clause → construct → reference element → check → evidence → fixture` 映射。只有 check 同时接受 gold/alternate-correct，并拒绝 targeted known-bad/non-equivalent mutant，才计为有效 coverage；只有矩阵链接的是 `paper coverage`。

`[I]` 这一步把 NASA 双向 traceability、Terminal-Bench prompt/verifier alignment、JSON Schema 结构边界和 EvalPlus/mutation/property 方法合成 production rule。[S05,S14–S17,S24,S26]

### 1.3 Minimum test library 是 scorer 的 acceptance evidence

`[R]` 最低库必须包括：gold、known-bad、alternate-correct、near-miss、boundary、corrupt artifact、mutation、metamorphic、surface-compliant-but-wrong、shortcut、tampering 和 environment failure。另加 differential oracle、fuzz/parser bomb、round-trip/idempotence/permutation、cross-version replay 和 minimized counterexample。

`[I]` 这些类型不是要求固定数量，而是要求覆盖不同 failure mechanisms；每类数量、抽样、重复与目标值均属 `[P]`。

### 1.4 不把 reference likeness 当成任务完成

`[R]` exact/hash 只用于 identity 本身就是 requirement 的对象；schema/parser 证明结构真实性，不能替代语义；numeric tolerance 要有单位和专业依据；visual similarity 只证明某种感知邻近，不证明可编辑、功能、合规或业务效用；开放等价空间用 invariants、functional/property/metamorphic tests、multiple golds、expert rubric 与仲裁组合。

模式专属证据来自 JSON Schema、NumPy `allclose`、EvalPlus、QuickCheck、metamorphic/mutation testing 与 LPIPS。[S15–S17,S24–S27]

### 1.5 Integrity 是与 task score 分开的控制面

`[I]` 最可靠的证据链是 evaluator locking + agent/judge/audit trust zones + post-run hidden-material staging + content-addressed handoff + file/network/process access logging + patch lineage + full trajectory + independent recomputation。单一防线只封住单一通道。

RewardHackingAgents、NIST CAISI、RHB/STC 与 ALE 自身 run architecture 从研究、政府方法和官方实现三类来源支撑这一点。[S01–S02,S07–S10]

### 1.6 自动评分需要 blind arbitration 和可审计 regrade

`[R]` human arbitration 在 mode 冲突、alternate-correct rejection、judge instability/injection、environment ambiguity、near-boundary 高影响结果、integrity suspicion、reproducible appeal 或 scorer repair 时触发。两名独立 blind reviewers 分别判断 correctness、integrity、environment 和 root cause；分歧由 senior tie-breaker 处理；允许 `UNRESOLVED`。

`[I]` Cochrane duplicate review 提供独立裁决方法类比；SWE-bench/WebArena/ALE repair 和 MLCommons audit/change lineage 说明修复与历史影响必须纳入 benchmark 生命周期。[S02,S11–S13,S21–S22]

### 1.7 Scorer release 的默认建议是“分层”，不是固定比例

`[R]` 建议 public contract/wrapper/representative tests + hidden qualification/final tests + isolated judge + tiered feedback + delayed retired-set release。Private/EaaS 必须能 export/escrow code、container、version、logs、artifacts 和 results，才能支持 audit 与 historical regrade。

`[P]` public/hidden/private 的集合、query budget、feedback granularity、delay、retention 和 audit 深度由客户风险与 pilot 决定，绝不从 ALE 141/7/5、Kaggle 或其他公开 benchmark 比例外推。[S06,S09–S10,S21,S23,S30–S31]

### 1.8 Failure attribution 至少三分，根因最好八分

`[R]` 对外至少区分 `FAIL_AGENT`、`INVALID_EVALUATOR`、`INVALID_ENV`；内部另保留 task-spec、reference、harness、integrity 和 indeterminate。Evaluator/environment fault 不能静默记 agent 0。修复 scorer 后，以 executable affected-run selector 重评所有受影响 frozen artifacts，不只投诉者。

---

## 2. 研究方法与三角验证

### 2.1 Source hierarchy

1. ALE canonical paper、fixed official code/HF snapshot 和可复现 local audit；
2. NIST、NASA、MLCommons 等政府/标准/技术治理文件；
3. 同行评议或公开学术方法：benchmark QA、testing、visual metrics、LLM judge、adaptive feedback；
4. 官方 benchmark audit/release practice；
5. Kaggle 等 vendor practice 仅作线索。

### 2.2 Major-claim triangulation map

| Major claim | Academic/method | Official code/benchmark | Government/standard | Counterevidence |
|---|---|---|---|---|
| Mode ≠ validity | BetterBench, EvalPlus | ALE repair; SWE/WebArena re-audit | NIST 800-2; NASA traceability | exact/hash 在 identity construct 上可最佳 |
| Effective coverage | property/metamorphic/mutation | Terminal-Bench verifier rubric | NASA bidirectional traceability | properties/relations/mutants 可写错 |
| Layered integrity | RewardHackingAgents, RHB, STC | ALE post-run grading/trajectory | NIST CAISI/800-2 | logs/no-network 有成本和 false verdict |
| Judge needs assurance | G-Eval/MT-Bench positive + bias/injection studies | ALE targeted judge claim | NIST emerging judge practices | human review 也受扰动 |
| Arbitration/regrade | testing/audit methods | SWE/WebArena/ALE repairs | Cochrane method analogy; MLCommons governance | regrade 会造成 comparability/governance cost |
| Layered release | Ladder; EaaS | public/private benchmark practice | NIST reproducibility; MLCommons audit | public leaks; private hides defects |

### 2.3 Method boundary

`[I]` 三类独立来源支持的是控制方向，不产生 production 数字。公开论文/审计中的 attack rate、agreement、error prevalence、review count、private ratio、test multiplier 或 runtime 都不移植为 UniPat/ALE-style 参数。

---

## 3. A — Evaluator mode taxonomy and risk

完整可执行矩阵见 `deliverables/01_evaluator_mode_risk_matrix.md`。本节给出选择逻辑。

| Mode | Valid use | Typical failure | Required companion |
|---|---|---|---|
| exact/hash/set | 唯一 identity/canonical set 就是 requirement | alternate-correct false reject、leak-copy | canonicalization、reference isolation、mutants |
| schema/field | 结构、类型、required/shape | surface-compliant-but-wrong | semantic/cross-field/functional check |
| numeric tolerance | 有专业误差模型的数值 | arbitrary/near-zero/unit/NaN | boundary pairs、independent recomputation |
| artifact parser | 真文件、可打开/编辑、结构存在 | spoof、auto-repair、version drift、crash | multi-parser、corrupt/round-trip/security fixtures |
| functional/behavior | 代码、state、DB、simulation、interaction | visible-case hard-code、side effect、env drift | held-out replay、invariants、fresh state |
| invariant/property/metamorphic | 大空间或无完整 oracle | wrong/weak property、generator bias | relation basis、counterexamples、independent review |
| visual/geometric | 外观/空间确是 construct 一部分 | metric-good but unusable、renderer/camera overfit | structural/functional gates、multi-view、SME pilot |
| weighted rubric | 开放 deliverable 可分 observable criteria | fatal error 被补偿、double count、anchor drift | non-compensatory gates、anchors、calibration |
| LLM/VLM judge | 不能可靠形式化的 residual semantics | position/style/self bias、injection、drift | freeze/order swap/adversarial/human/abstain |
| hybrid | hard deterministic gates + residual soft quality | fallback/gate bypass、component double count | component ablation、version bundle、decomposed log |

### 3.1 ALE case interpretation

- `[F]` 141/7/5 是固定 public corpus 的 executable-path adjudication。[S03]
- `[I]` 它可以帮助选择 risk-based audit cases，例如从 exact/hash、numeric、parser、visual、hybrid、LLM judge 各取代表实例。
- `[R]` 它不能决定 1,000 assets 未来使用多少种 mode，也不能证明 141 个 deterministic scorers 有效。

### 3.2 Score composition

`[R]` 对每个 scorer 记录 scale、direction、gates、weights、missing/N/A、normalization、rounding、partial credit、aggregation 与 final decision rule。Item score、workflow score、benchmark aggregate 和业务 decision 不能混称。

---

## 4. B — Prompt/reference/evaluator bidirectional coverage

模板：`deliverables/02_requirement_to_evaluator_template.csv`；说明：`02_requirement_to_evaluator_guide.md`。

### 4.1 Required chain

```text
prompt clause
  → atomic requirement
    → construct / non-target construct / score use
      → observable evidence
        → reference element + allowed equivalence
          → check predicate/rubric + mode
            → positive and negative fixtures
              → component verdict + audit evidence
```

### 4.2 Bidirectional controls `[R]`

- Prompt requirement 无 check：undercoverage。
- Check 无 requirement：未经授权地测额外能力。
- Reference field 无 requirement/check：reference-lock risk。
- Check 无能让它失败的 fixture/mutant：paper coverage。
- Fixture 无 targeted requirement/check：不可解释测试。

### 4.3 Diagnostic formulas

`C_forward = covered requirements / applicable requirements`

`C_backward = authorized checks / all checks`

`effective(r,c) = accepted(correct or alternate-correct) AND rejected(targeted known-bad or non-equivalent mutant)`

`[P]` 这些是诊断量，不提供通用 numeric threshold；mandatory requirements、hard gates 与 acceptable residual risk 由客户定义。

---

## 5. C — Minimum evaluator test library

### 5.1 Required fixture families

| Family | What it proves | If it fails |
|---|---|---|
| gold | reference/known success 可达且 scoring path 完整 | reference/evaluator/environment defect |
| known-bad | targeted check 有拒绝能力 | false accept / paper coverage |
| alternate-correct | 不强迫 reference surface | false reject / reference lock |
| near-miss | acceptance boundary 与文字一致 | threshold/rounding/ordering defect |
| boundary | empty/zero/extreme/tie/locale/time/NaN/duplicate | brittle edge handling |
| corrupt artifact | scorer fail-closed 且不 crash | parser/integration defect |
| mutation | tests 能 kill 非等价 targeted defects | insufficient test sensitivity |
| metamorphic/property | 无完整 gold 时验证 relation/invariant | oracle gap 或 relation error |
| surface-compliant-wrong | schema/外观 proxy 不替代语义 | construct undercoverage |
| shortcut | grader 不奖励未声明 proxy/绕过 | grader gaming 或 prompt defect |
| tampering | trust boundaries、logging、locking 有效 | integrity breach/control gap |
| environment failure | platform fault 不计 agent 0 | attribution defect |

### 5.2 No universal test count

`[R]` Fixture 数量由 requirement criticality、input space、decision consequence、failure history 和 pilot detection curve 决定。使用 variables：

- `FAR_bad = accepted known-bad / executed known-bad`；
- `FRR_alt = rejected alternate-correct / executed alternate-correct`；
- `MS_survive = surviving non-equivalent mutants / executed non-equivalent mutants`；
- `ENV_invalid = invalid-environment runs / attempted runs`；
- `H_overturn = human-overturned / arbitrated cases`。

`[P]` 目标值、样本量与 stop rule 由客户风险决定；不从 EvalPlus、SWE-bench、ALE 或任何论文的数量复制。

---

## 6. D — Avoiding “only looks like the reference”

### 6.1 Decision rules `[R]`

- **Invariant**：多个合法输出共享必要性质，且可明示 preconditions；例如 totals balance、IDs unique、state constraints。
- **Functional test**：任务成功能由运行行为或 backend state 验证；优先于像素/文本近似。
- **Property-based test**：输入空间大且有可生成 property；保存 seed、generator 和 shrunk counterexample。
- **Metamorphic test**：没有完整 oracle，但输入变换后的输出关系已知；relation 要有领域依据与反例审查。
- **Multiple golds**：已知离散等价类有限；它是补充，不是开放空间完备性证明。
- **Expert rubric**：专业质量无法完全形式化；criteria 必须 observable、anchored，fatal items 不被权重补偿。
- **Human arbitration**：合法等价空间无法预枚举、mode 冲突、judge injection/instability、environment ambiguity 或高影响 edge case。

### 6.2 Visual outputs

`[C]` LPIPS 说明传统 PSNR/SSIM 对人类感知并不完备；learned metric 的正面证据也只针对 perceptual similarity。[S27]  
`[I]` 因此 visual scorer 应拆成：file/structure validity gate + semantic content + functional/editability + multi-view perceptual comparison + optional SME rubric。Visual similarity 不应单独代表“完成任务”。

### 6.3 Process shortcuts

`[R]` 只有 prompt/contract 明示过程约束时，process-policy scorer 才能惩罚跳步/工具访问。否则未预想方法可能是合法优化；若它在不具备目标能力时仍得高分，应修 construct claim、prompt 或 evaluator，而不是事后把 agent 定义为 cheating。[S14]

---

## 7. E — Adversarial validation and integrity labels

完整协议见 `deliverables/03_unit_and_adversarial_validation_protocol.md`；threat model 见 `06_integrity_threat_model.md`。

### 7.1 Validation sequence `[R]`

1. Freeze prompt/reference/evaluator/tests/environment and protocol manifest。
2. Static validity review：traceability、score semantics、reference provenance、parser/judge attack surface。
3. Unit regression：gold → known-bad → alternate-correct → near-miss → boundary → corrupt。
4. Artifact/evaluator mutation + property/metamorphic + differential oracle。
5. White-box red team：files、metadata、parser、judge、service、trajectory、feedback。
6. Black-box shadow agents + full trajectory inspection。
7. Patch–regress–held-out exploit–shadow regrade rehearsal。
8. Sign off only for stated use/version/protocol；支持 suspended 状态。

### 7.2 Locking and judge isolation

`[R]` Agent realm 可写工作区但只能使用声明工具；judge realm 在 agent 结束后启动，只读 artifact 并挂载 hidden tests/reference；audit realm 接收 hashes、access logs、patch lineage、trajectory、score 和 integrity label。Judge 不与 agent 共享 filesystem/process/network namespace。

### 7.3 Integrity labels

```yaml
task_outcome: {score: ..., status: PASS|PARTIAL|FAIL|UNRESOLVED}
run_integrity:
  status: VALID|SUSPECTED|VIOLATION|INVALID_ENV|INVALID_EVALUATOR|NOT_ASSESSABLE
  evidence_complete: true|false
  reason_codes: []
  arbitration_status: NOT_REQUIRED|PENDING|RESOLVED
  regrade_status: NOT_REQUIRED|REQUIRED|COMPLETED|SUPERSEDED
```

`[R]` 这套标签是项目建议，不是 NIST/ALE 标准。它保留“结果正确但越权”和“结果失败但运行完整”两种情况。

---

## 8. F — Human arbitration SOP

完整 SOP 见 `deliverables/04_human_arbitration_sop.md`。

### 8.1 Trigger summary

mode 冲突；alternate-correct rejection；judge disagreement/order instability/injection；parser/replay conflict；environment ambiguity；high-impact near-boundary；tampering/leakage suspicion；reproducible appeal；version repair 的历史影响。

### 8.2 Blind process `[R]`

1. 冻结 immutable evidence bundle；新增材料只作 amendment。
2. 去除 agent/provider/team、leaderboard、另一 reviewer verdict。
3. A/B 独立判断 correctness、integrity、environment 与 failure origin，并给 evidence-linked reason。
4. 不一致由 senior tie-breaker 先独立判断、后读理由。
5. COI/recusal/少数意见/申诉/precedent 全部记录。
6. 证据不足输出 `UNRESOLVED`，不强迫二元结论。

### 8.3 Human boundary

`[C]` Human 与 LLM judges 都会受扰动；人工不是无误 gold。[S29]  
`[R]` Human system 本身要用 calibration gold、duplicate blind review、drift/disagreement/overturn monitor。Reviewer 数、SLA、抽检与 trigger threshold 属 `[P]`。

---

## 9. G — Scorer release policy

完整比较见 `deliverables/05_scorer_release_policy.md`。

### 9.1 Trade-off table

| Mode | Main gain | Main cost | Recommended role |
|---|---|---|---|
| Fully public | audit/repro/debug | contamination/specialization | developer + retired set |
| Public wrapper + hidden tests | contract transparent, final evidence protected | parity/drift/appeal difficulty | default continuous benchmark layer |
| Delayed release | evaluation-period secrecy + later audit | delayed external scrutiny | rotating retired sets |
| Private scorer | strongest direct secrecy | black-box defects/vendor dependence | high-value final gate only |
| Tiered feedback | controls adaptive probing | weaker debug, design leakage | dev detailed; qualification coarse; final limited |
| EaaS | centralized private data/env + possible regrade | outage/lock-in/opacity | only with export/escrow/replay |

### 9.2 Recommended layer `[R]`

公开 contract、wrapper、error/status semantics、representative positives/negatives；隐藏易被特化的 qualification/final functional/metamorphic/mutation/anti-tampering tests；final isolated scoring；query accounting 与 tiered feedback；退役后 delayed audit release；private/EaaS 需 independent audit、commitment、escrow/export 与 regrade。

### 9.3 No ratio claim

`[P]` 哪些 assets/tests 属 public/hidden/private、延迟多久、允许多少 queries、返回多细 feedback，要由客户威胁模型、法律/隐私、价值与 pilot 决定。本研究不给任何比例或时长。

---

## 10. H — Integrity threat model

完整矩阵见 `deliverables/06_integrity_threat_model.md`。

| Threat | Key detector | Primary prevention | Corrective action |
|---|---|---|---|
| grader tampering | hash/write/process/file log/diff | separate read-only judge | quarantine; classify platform vs agent; regrade if needed |
| reference leakage | canary/file/network/search trajectory | remove from agent layer; post-run mount | rotate; invalidate platform-exposed runs |
| metadata shortcut | counterfactual metadata mutation | minimize/randomize non-semantic fields | semantic tests; scorer repair |
| artifact spoofing | magic/parser/backend replay | parse + semantic recomputation | quarantine parser revision; affected-set regrade |
| judge injection | canary/order swap/disagreement/rationale | structured minimal input + isolation + abstain | blind arbitration; prompt/parser patch |
| feedback leakage | query history/score delta/similarity | tiered/coarse feedback | restrict/rotate/review final probing |
| repeated-query hill climb | submission lineage and score sequence | accounting/final holdout | quarantine or final limited evaluation |
| search-time contamination | retrieved URL/content + use evidence | isolated/allowlisted snapshot + full logs | clean rerun if required; separate label |
| environment manipulation | pre/post state and cross-trial anomaly | fresh snapshot/isolation | integrity violation or invalid environment |
| patch/trajectory hiding | signed manifest/event-chain gaps | append-only lineage/harness capture | no formal score until evidence complete |

### 10.1 Threat-model boundary

`[C]` NIST CAISI 明确 transcript detection 仍有 false positives/negatives；单一 network rule 不适合所有任务。[S07]  
`[I]` 因此 threat controls 必须由 intended affordances 定义。合法 retrieval/tool use 与污染/越权的边界，必须在 prompt/protocol 先写清楚。

---

## 11. Evaluator defect, agent failure and environment failure

完整 policy 见 `deliverables/07_failure_and_regrade_policy.md`。

### 11.1 Minimum external classification

- `FAIL_AGENT`：环境健康，scorer 通过 calibration，artifact 不满足明确 requirement，无 integrity breach。
- `INVALID_EVALUATOR`：gold fail、known-bad pass、alternate-correct reject、shortcut accepted、wrong tolerance/weight/check 或 unexpected nondeterminism。
- `INVALID_ENV`：reset/hash、dependency、permission、network/service/resource/judge infrastructure 失败，使 agent 没有有效完成/评分机会。

### 11.2 Internal root causes

另保留 `INVALID_TASK_SPEC`、`INVALID_REFERENCE`、`INVALID_HARNESS`、`INTEGRITY_VIOLATION`、`INDETERMINATE`。Failure origin 与 observed symptom 分开，避免 parser crash 最终表现为“agent 0 分”。

### 11.3 Regrade policy `[R]`

1. 旧 revision 与 evidence freeze；
2. 最小 counterexample + root-cause class；
3. 新 revision，不 silent in-place patch；
4. 原反例、old gold/bad、alternate-correct/near-miss、held-out exploit 全部 regression；
5. executable `affected_run_selector` 找到所有历史 runs；
6. frozen artifacts 用 old/new shadow regrade；
7. independent approval、rollback、correction note；
8. 保存 original/superseded/new score、version、reason、date 和 comparability。

`[P]` 客户预先决定 artifact-only regrade 还是 full agent rerun；二者测量对象不同。无法重放时标 `NOT_REGRADABLE`，不得猜测。

---

## 12. 可直接采用的项目建议

### 12.1 Asset package contract `[R]`

每个 asset 包含：

- `task_spec`：atomic requirements、construct、score use、process/tool constraints；
- `reference_pack`：provenance、independent review、allowed equivalence、known limitations；
- `evaluator_pack`：mode components、score semantics、component evidence、version；
- `test_pack`：十二类最低 fixtures + targeted regression；
- `protocol_manifest`：model/harness/prompt/tools/budget/retry/environment/network；
- `integrity_pack`：trust zones、permissions、logging、patch/trajectory chain；
- `governance_pack`：owner/reviewer/approver、release layer、arbitration/regrade/refresh。

### 12.2 Production gates `[R]`

不以数量/比例表示，而以 evidence state 表示：

1. `SPEC_READY`：construct、requirements、score use 和 affordances 确定。
2. `TRACEABLE`：无未处置 orphan；每个 check 有 discrimination evidence。
3. `VALIDATED`：minimum fixture + adversarial protocol 完成。
4. `INTEGRITY_READY`：trust zones、logs、hashes、health 与 incident path 可用。
5. `GOVERNED`：release、arbitration、regrade、sunset 与 refresh owner 已批准。
6. `PRODUCTION_ELIGIBLE`：只对已记录版本/use；任一新 defect 可触发 `SUSPENDED`。

### 12.3 1,000-asset portfolio rule `[R]`

不要用 141/7/5 映射生产配额。先按 asset 的 construct、artifact type、decision consequence、equivalence openness、environment dependence 和 attack surface 选择 scorer composition；再用 pilot 的 FAR/FRR/mutation/judge/env/arbitration 数据决定控制深度。未来 portfolio 只汇总 versioned asset-level evidence，不把 workflow、instance、submission、run 与 release counts 混在一起。

---

## 13. 尚待确定的变量与 pilot measurement plan

### 13.1 Customer inputs `[P]`

- score 的实际用途：研究排名、诊断、采购、准入还是付费 acceptance；
- error consequences：false accept 与 false reject 分别造成什么损失；
- mandatory/hard-gate requirements 与可 partial-credit criteria；
- tool/network/filesystem/process affordances 与 prohibited actions；
- privacy/license/retention、review COI 与 third-party audit；
- public/hidden/private/delayed release 和 EaaS/escrow 要求；
- correction、appeal、regrade 与 benchmark retirement governance。

### 13.2 Pilot measures `[P]`

除本报告前述 FAR/FRR/mutation/env/human 指标外，pilot 记录：

- scorer repeatability 与 component variance；
- LLM/VLM judge order/repeat/human disagreement；
- task-spec/reference/evaluator/harness/environment/integrity defect incidence；
- alternate-correct discovery rate 与新 equivalence classes；
- parser/renderer/dependency cross-version divergence；
- integrity exploit fixtures 的 success/blocked/indeterminate；
- shadow regrade delta、status/rank/decision changes；
- evidence completeness、arbitration resolution 和 not-regradable cases。

### 13.3 Scenario analysis without fabricated numbers

- **Low openness / high identity**：更多 canonical/exact + strong isolation；主要 risk 是 leakage/format brittleness。
- **High openness / deterministic behavior**：functional/invariant/property/metamorphic + alternate-correct；主要 risk 是 under-testing。
- **High openness / subjective quality**：deterministic gates + rubric/LLM/expert residual layer；主要 risk 是 judge/reviewer drift。
- **High environment dependence**：health/replay/state/logging 与 invalid-run policy 优先；主要 risk 是归因错误。
- **High attack value**：hidden final tests、tiered feedback、patch/file logs、independent audit 和 delayed release 优先；代价是 reproducibility/appeal friction。

这些是条件路径，不是 asset allocations。

---

## 14. 反方证据

1. `[F/I]` exact/hash 在唯一 canonical identity 上可最有效；不能为复杂而复杂。
2. `[C/I]` MT-Bench/G-Eval 在特定开放偏好任务给 LLM judge 正面 evidence；不能一律禁止。[S18,S28]
3. `[C/I]` Human 与 LLM 都受扰动；“送人工”不是 validity guarantee。[S29]
4. `[F/I]` Fully public scorer 最大化复现、community audit 与 appeal；永久隐藏也会积累缺陷。[S06,S21]
5. `[C/I]` Property/metamorphic/mutation 可测试错误性质或 unrealistic mutant；不能把其分数当 validity threshold。[S15–S17]
6. `[C/I]` Visual perceptual metric 能比传统像素指标更接近某些人类判断；但它不代表功能/专业效用。[S27]
7. `[C/I]` Trajectory review 有 false positives/negatives、privacy 与成本；no-network 可能改变构念。[S07]
8. `[I]` 未明示的 shortcut 可能是合法创新；若只因“未预想”就处罚，problem/evaluator 本身失配。[S14]

反方审查完整卡：`findings/F6_adversarial_review.md`。

---

## 15. 适用边界

- 本研究设计 evaluator assurance 和 governance，不验证每个未来 1,000 assets 的内容正确性。
- ALE public corpus audit 不覆盖 private corpus，也不产生未来 mode distribution。
- NIST AI 800-2 是 Initial Public Draft，不是 final standard。
- RewardHackingAgents、RHB、STC、judge-injection 等多为预印本或特定任务实验；控制方向可借鉴，rate/overhead 不迁移。
- WebArena Verified 的早期 OpenReview submission 曾撤回；只将其作为具体 re-audit 方法线索，production 使用需 pin official repository commit。
- Kaggle 是 vendor practice，不能单独支持 release policy。
- NASA/Cochrane/MLCommons 分别来自高保证软件、系统综述和性能 benchmark；迁移是方法类比，不是法律/行业强制要求。
- 任何 score 只对固定 evaluated system/protocol/version 和 stated use 有效；跨 model/harness/tool/budget/environment 比较需另证 comparability。

---

## 16. Source table

| ID | Source | Type / pin | Used for | Important limit |
|---|---|---|---|---|
| S01 | [ALE paper](https://arxiv.org/abs/2606.05405v2) | canonical paper, v2 | architecture, mode claims | author claims; paper/code dates differ |
| S02 | [ALE fixed commit](https://github.com/rdi-berkeley/agents-last-exam/commit/1e615e456de7cef57706680613cb80ee13c7fc76) | official code, immutable | grader repair, regression, run flow | instances do not give corpus defect rate |
| S03 | Local fixed corpus audit | reproducible local audit, 2026-08-08 | 153; 141/7/5 | public only; mode ≠ validity |
| S04 | [BetterBench](https://papers.nips.cc/paper_files/paper/2024/hash/26889e8359e7ef8a7f5d77457364ca55-Abstract-Datasets_and_Benchmarks_Track.html) | NeurIPS 2024 | lifecycle QA, replication | general framework; PDF/HTML count wording refresh |
| S05 | [NASA bidirectional traceability](https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695427/SWE-052%2B-%2BBidirectional%2BTraceability) | government handbook | requirement ↔ test trace | high-assurance software analogy |
| S06 | [NIST AI 800-2 IPD](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.800-2.ipd.pdf) | government initial draft, Jan 2026 | measurement, logs, release | not final standard |
| S07 | [NIST CAISI cheating](https://www.nist.gov/caisi/cheating-ai-agent-evaluations) | government case study | transcript review, cheating taxonomy | detection has false results; no rate transfer |
| S08 | [RewardHackingAgents](https://arxiv.org/abs/2603.11337) | academic preprint | locking, file logs, patches, labels | small task/model scope |
| S09 | [Reward Hacking Benchmark](https://arxiv.org/abs/2605.02964) | preprint/ICML 2026 claim | shortcuts, metadata, tampering | no exploit-rate transfer |
| S10 | [Search-Time Contamination](https://arxiv.org/abs/2606.05241) | preprint | evaluation-time search leakage | mostly QA/research tasks |
| S11 | [WebArena Verified](https://openreview.net/forum?id=CSIo4D7xBG) | withdrawn submission / audit | parser/backend-state repair | withdrawn; pin official repo before use |
| S12 | [Introducing SWE-bench Verified](https://openai.com/index/introducing-swe-bench-verified/) | maintainer report | independent human screening | co-creator/vendor; review can still miss defects |
| S13 | [SWE-bench residual defects](https://openai.com/index/why-we-no-longer-evaluate-swe-bench-verified/) | maintainer audit, 2026 | narrow/wide tests, retirement | sampled failures; prevalence not portable |
| S14 | [Terminal-Bench Science rubric](https://github.com/harbor-framework/terminal-bench-science/blob/main/rubrics/task-implementation.toml) | official mutable code guidance | prompt-verifier alignment, method boundary | pin commit for production |
| S15 | [Metamorphic testing review](https://arxiv.org/abs/2002.12543) | academic review | oracle-free relations | relation quality/domain knowledge |
| S16 | [Mutation testing](https://arxiv.org/abs/2103.07189) | academic research | artificial defects/test gaps | equivalent mutants; limited real-quality proof |
| S17 | [QuickCheck](https://dl.acm.org/doi/10.1145/1988042.1988046) | foundational paper | property-based generation | only expressed property/generator distribution |
| S18 | [G-Eval](https://aclanthology.org/2023.emnlp-main.153.pdf) | EMNLP 2023 | judge positive/counter evidence | task/model-specific; preference risk |
| S19 | [LLM judge position bias](https://arxiv.org/abs/2406.07791) | academic study | order bias | no universal bias rate |
| S20 | [Judge prompt injection](https://arxiv.org/abs/2505.13348v1) | academic preprint | untrusted judge input | specific attacks/models |
| S21 | [MLCommons inference rules](https://github.com/mlcommons/inference_policies/blob/master/inference_rules.adoc) | standards-organization rules | replication/audit/remedy | performance benchmark context |
| S22 | [Cochrane duplicate review](https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current/chapter-07) | methodological handbook | blind independence/tie-break analogy | not benchmark standard |
| S23 | [Kaggle competition rules](https://www.kaggle.com/competitions/multi-task-optimization/rules) | vendor practice | public/private/tiered clue | cannot support policy alone |
| S24 | [JSON Schema validation](https://json-schema.org/draft/2020-12/json-schema-validation) | technical spec | schema semantic boundary | JSON only |
| S25 | [NumPy allclose](https://numpy.org/doc/stable/reference/generated/numpy.allclose.html) | official docs, accessed 2026-08-09 | tolerance direction/near-zero | no domain threshold |
| S26 | [EvalPlus](https://proceedings.neurips.cc/paper_files/paper/2023/hash/43e9d647ccd3e4b7b5baab53f0368686-Abstract.html) | NeurIPS 2023 | test augmentation/mutation | code-generation domain |
| S27 | [LPIPS](https://openaccess.thecvf.com/content_cvpr_2018/html/Zhang_The_Unreasonable_Effectiveness_CVPR_2018_paper.html) | CVPR 2018 | visual metric validity limits | perceptual patches ≠ business function |
| S28 | [MT-Bench LLM judge](https://papers.nips.cc/paper_files/paper/2023/hash/91f18a1287b398d378ef22505bf41832-Abstract-Datasets_and_Benchmarks.html) | NeurIPS 2023 | judge positive evidence + biases | dialogue preference only; no number transfer |
| S29 | [Humans or LLMs as judge](https://aclanthology.org/2024.emnlp-main.474/) | EMNLP 2024 | human and LLM perturbation | task/perturbation specific |
| S30 | [Evaluation-as-a-Service](https://arxiv.org/abs/1512.07454) | method proposal, 2015 | centralized historical re-eval | old/non-agent; requires platform durability |
| S31 | [The Ladder](https://proceedings.mlr.press/v37/blum15.html) | ICML 2015 | adaptive holdout feedback | prediction leaderboard, not full agent setting |

完整元数据、短引文、支持/限制与 credibility/recency/bias 见 `sources/01...31` 和 `sources.csv`。

---

## 17. Refresh targets

完整表见 `refresh_targets.md`。最重要的 refresh triggers：

- ALE paper v2 后续 revision；fixed Git/HF revision change；
- NIST AI 800-2 从 Initial Public Draft 更新为 final/next draft；
- ALE/Terminal-Bench/WebArena scorer/helpers/repository commit changes；
- judge model/prompt/API silent update、retirement 或不可重放；
- parser/renderer/schema/numeric dependency change；
- 新 exploit、independent replication、production incident；
- 客户 score use、risk、privacy/license 或 release/regrade policy change。

每次 refresh 必须更新 source-version-unit ledger、affected claims、regression fixtures 和 historical comparability；不得把新旧 revision 的 counts/ratios 混用。

---

## 18. Deliverables index

1. `deliverables/01_evaluator_mode_risk_matrix.md`
2. `deliverables/02_requirement_to_evaluator_template.csv`
3. `deliverables/02_requirement_to_evaluator_guide.md`
4. `deliverables/03_unit_and_adversarial_validation_protocol.md`
5. `deliverables/04_human_arbitration_sop.md`
6. `deliverables/05_scorer_release_policy.md`
7. `deliverables/06_integrity_threat_model.md`
8. `deliverables/07_failure_and_regrade_policy.md`
9. `deliverables/08_final_qc_evaluator_checklist.md`
10. `refresh_targets.md`
11. `sources.csv` + 31 source cards
12. `findings/F1...F6`

---

## Final recommendation

`[R]` 以“versioned validity argument + bidirectional effective coverage + minimum adversarial fixture library + isolated integrity control plane + blind arbitration + affected-set regrade + layered release”作为 1,000-asset evaluator production 的最低治理骨架。

`[P]` 每个 asset 的 mode composition、tolerances、weights、hard gates、test counts、query limits、feedback tiers、judge/human triggers、public/private boundary、retention、SLA 和 regrade materiality，必须由客户要求与 pilot evidence 决定；公开 benchmark 数量不提供这些参数。


# ALE-style professional benchmark：预注册式统计评估与 matched-human baseline 协议

**用途**：UniPat 面试作业；ALE-style 1,000-asset 生产与评估方案  
**协议状态**：可执行草案；所有标为「待客户/pilot」的量在获得输入前不得填入常数  
**冻结日**：2026-08-09  
**ALE 证据冻结**：arXiv `2606.05405v2`；GitHub `1e615e456de7cef57706680613cb80ee13c7fc76`；Hugging Face `a8c1fd174a1f6cfa76526572a2e3ebece1276be2`

## 阅读标签

- **[事实]**：来源直接支持的、限于该来源版本与研究设计的事实。
- **[机构/作者主张]**：来源作者或机构提出的解释、方法立场或外推。
- **[研究者推断]**：把多类证据映射到 ALE-style 项目的推论；不是来源原句。
- **[项目建议]**：本项目可直接执行的规范性选择。
- **[待客户/pilot]**：公开证据不能决定，必须由客户目标或 pilot 数据求解。
- **[反方证据]**：会削弱、限制或推翻简单结论的证据。

---

## 0. 核心结论

1. **[研究者推断；三类证据交叉]** 评估对象必须是完整的 `model × provider × harness × prompt/context × tools × environment × budget × retry policy × evaluator × snapshot` 系统，而不是抽象的“模型”。ALE 的冻结代码把 run 与任务环境、agent、grader 共同编排；可复现性研究和 harness 研究也表明实现表面会改变结果。[S02,S08,S62,S67]

2. **[项目建议；三类证据交叉]** 预注册先写 estimand，再写 estimator、缺失/失败处理与敏感性分析。`instance success probability`、固定 benchmark 的 FPR、目标总体的 domain aggregate、Mean Score 和 cost-constrained reliability 是不同问题，不得共享一个含混分母。[S20,S60,S01]

3. **[研究者推断；三类证据交叉]** 同一 instance 的 repeats 主要识别 trial stochasticity；增加独立 workflows/instances 主要识别 task heterogeneity。item bootstrap 不能补回没有 repeats 的 run-to-run uncertainty，增加 repeats 也不能修复任务框不代表目标总体。[S60,S23,S24,S32]

4. **[项目建议；三类证据交叉]** 主报告同时给出：绝对表现及区间、配对差异及 clustered interval、成本/时间分布、失败分解和排名不确定性。单一 leaderboard 次序、单一 Kendall/Spearman 或单次 aggregate 都不足以支持选型。[S29,S30,S35,S64]

5. **[项目建议；三类证据交叉]** `run` 只是编排容器；`trial` 才是 `(instance, frozen configuration)` 的随机重复单位。agent-visible retry 属于 trial 内 attempt 且消耗预算；只有可证实外因、无战略二次机会、状态与预算保真的 infrastructure continuation 才不新开 trial。[S02,S61,S62,S65]

6. **[项目建议；三类证据交叉]** agent timeout、agent/harness-attributable crash 和 missing required artifact 进入主分母并按 rubric 记零或部分分；独立且可验证的 infra-invalid execution 可一对一 replacement，但必须保留在运营可靠性与成本账本。evaluator rerun/regrade 不增加 agent trial。[S01,S60,S65,S66]

7. **[项目建议；三类证据交叉]** matched-human 主臂招募与目标工作相匹配、近期仍在实践且独立于任务创作的 practicing experts。generalist、task author 与 human+AI 是不同人群/配置，必须分臂报告；task author 更适合 rubric/scorer 诊断，不是默认 human upper bound。[S40,S44,S48,S49]

8. **[项目建议；三类证据交叉]** 人类与 agent 匹配的是可操作 affordances：instruction、input/state、software、internet/docs、time、attempts、hardware/resources、feedback 和 output contract；不能声称 token、认知过程或界面负担“完全相同”。[S40,S41,S44,S55]

9. **[反方证据]** 只分析成功人类的质量、时间或成本会产生选择偏差。主分析使用 all-assigned 成功率与 score-at-budget；未成功的 time-to-success 是右删失或竞争事件。successful-only 时间只能作为清楚标注的条件性描述。[S42,S43,S51]

10. **[适用边界]** 即使 matched-human 子集上 agent 与专家接近，也不能据此推出总体 human-level、岗位替代、就业影响或生产率。仍缺职业任务抽样框、部署权重、组织流程、质量风险、需求弹性与因果生产率证据。[S45,S50,S55,S64]

---

## 1. 冻结对象、决策与证据边界

### 1.1 评估决策

**[项目建议]** 在预注册首页逐项声明本次结果服务哪一种决策：

- 选择一个完整 agent configuration；
- 比较两个或多个配置在固定 manifest 上的差异；
- 估计某配置在目标 workflow/domain 总体中的表现；
- 估计给定成本与时限下的端到端可靠性；
- 与某个明确定义的人类人群和 affordance 条件进行比较。

未声明的决策不得在结果发布后追加为“研究目的”。

### 1.2 冻结清单

**[项目建议]** 每个 release 建立不可变 manifest，至少包含：

`benchmark_release_id`、task/workflow/instance IDs 与版本、目标权重、模型 checkpoint/alias、provider/region/API 与观测窗口、sampling 参数、seed 规则、harness commit、prompt/context hash、tool list/version、environment image、network policy、time/token/cost/tool-call budgets、attempt/retry/resume policy、evaluator/scorer/judge prompt/model/version、artifact contract、quarantine list、分析代码 commit、依赖锁文件、执行时间戳。

**[事实]** ALE 冻结 README 把一个 run 描述为 agent、environment 和 task 的组合，并经历 provision、input、agent run、hidden reference、grade、日志/轨迹/artifact 保存。[S02] 这支持“完整配置可审计”，但不决定本项目的统计分母。

### 1.3 有限 benchmark 与目标总体

**[研究者推断]** 若 1,000 个 accepted instances 构成被完整枚举的固定 release，则对这 1,000 个对象的描述性 aggregate 没有“任务抽样误差”，但仍有 trial、provider、environment 和 evaluator 不确定性。若要外推到未来同类工作，则 workflow/instance 是从目标总体产生的 cluster，必须有抽样框或可辩护权重并计入 between-task uncertainty。[S20,S60]

**[项目建议]** 结果表分两行：

- `finite-release descriptive`：只描述冻结 manifest；
- `target-population weighted`：仅在客户确认 target population、weights 和 coverage 后估计，否则写 `not estimable`。

**[待客户/pilot]** 目标 workflow/domain 总体、业务频率、经济/风险权重、equal-workflow 或 equal-instance 口径均不得由 ALE 公开数量代填。

---

## 2. Statistical analysis plan

### 2.1 单位与记号

- `c`：完整 configuration。
- `d`：domain；`w`：workflow；`i`：runnable instance。
- `r`：agent trial；`a`：trial 内 attempt；`q`：对同一 immutable artifact 的 evaluator rerun。
- `S_cdiwrq ∈ [0,1]`：partial score；`Y_cdiwrq = 1(S=1)`：full-credit indicator。
- `C`：按预注册成本边界累计的成本；`T_wall`、`T_active`：wall-clock 与 active time。
- `Ω_c`：该配置的 trial-generating distribution；必须说明 seed、provider/time/region 和其他 nondeterminism 是固定、block，还是按目标部署分布边际化。

### 2.2 A — estimands

| estimand | 预注册定义 | 主 estimator / interval | 禁止混用的结论 |
|---|---|---|---|
| Instance success probability | `p_ci = P_{ω~Ωc}(Y_cir=1)`；固定配置在 instance `i` 上一次全新 trial 完全通过的概率 | repeated Bernoulli 的 score/exact/registered Bayesian interval；或 hierarchical estimate | 其他 instances、best-of-R、任意 retry policy、未来 provider 状态 |
| Instance mean quality | `m_ci = E[S_cirq]`；若 judge stochasticity 单独建模，则另定义 latent-artifact quality | trial 均值；bounded/ordinal/hurdle mixed model；judge measurement model | full pass、业务 acceptance 或可靠性 |
| Workflow performance | `θ_cw^Y = Σ_i q_{i∣w}p_ci`；同时可定义 `θ_cw^S = Σ_i q_{i∣w}m_ci` | workflow 内预注册加权 + cluster-aware interval | “workflow 所有 instances 全成功”的 joint event；该量需另定义 |
| Domain aggregate | `Θ_cd^Y = Σ_w π_{w∣d}Σ_iq_{i∣w}p_ci`；Mean Score 同理 | 分层加权、post-stratification 或 mixed-model marginalization | 未给权重时的行业 prevalence、生产率或领域配额 |
| Full Pass Rate | 固定权重 `b_i` 和 single-trial policy 下 `FPR_c=Σ_i b_i p_ci`；观测实现为 `Σ_i b_iY_cir` | weighted estimate + paired workflow-clustered interval | `pass@R=1-(1-p)^R`；后者只在 iid 假设下成立且是另一 policy estimand |
| Mean Score | `MS_c=Σ_i b_im_ci` | weighted mean + workflow-clustered interval；验证 rubric scale comparability | full pass、现实交付接受率或 human quality |
| Cost-constrained reliability | 对完整 policy `π_c`：`R_c(B,H)=P(success before total cost B and wall time H ∣ π_c)` | 以整次 policy trial 为单位的 joint empirical/hierarchical model；报告成本分布和 Pareto frontier | success-only cost、免费 retries、不同预算的 accuracy 直接比较 |

**[事实]** ALE v2 将 FPR 定义为获得 full credit 的任务占比，将 Mean Score 定义为细粒度 task score 的均值。[S01]  
**[研究者推断]** 这两个 metric 是 task-level aggregate，不自动成为 production acceptance、任务时长或人类可替代性的测量。

### 2.3 C — 方差、漂移与测量噪声登记

| 来源 | 可观测设计/telemetry | 主要影响 | 主处理 |
|---|---|---|---|
| Model sampling | temperature/top-p、RNG/seed、trajectory | 同 instance 的 trial variance | 独立 planned trials；固定与变化 seed 分开报告 |
| Provider nondeterminism | model fingerprint/snapshot、region、API、timestamp、request IDs | seed 相同仍可变化；可能与时间共变 | provider×time block；canary；alias 与 snapshot 分开 |
| Harness | commit、dependencies、serialization、tool wrapper、timeouts | 可改变 agent 行为和排名 | configuration 的一部分；paired/crossed sensitivity |
| Environment | image/state、CPU/RAM/GPU、locale、clock、installed software | 影响可执行性、速度与 artifact | immutable image；preflight hash；state reset |
| Network/live services | allowlist、DNS/HTTP、external version、outage | operational failure 与非平稳性 | 记录 endpoint/time；按 estimand 决定计失败或 infra-invalid |
| Judge | judge model/prompt/order/seed、raw judgments | evaluator measurement noise/bias | blind panel、calibration set、rerun `q` 与 regrade，不增加 `r` |
| Task heterogeneity | domain/workflow/instance、difficulty/features | aggregate 与 rank 对 task mix 敏感 | 分层抽样、workflow clustering、random slopes/LOO sensitivity |
| Evaluator noise | parser tolerance、reference ambiguity、human reviewer | 分数重复性和版本漂移 | immutable artifacts；double-score subset/panel；versioned scorer |

**[反方证据]** 固定 seed 只控制已实现的某条 RNG 路径；PyTorch 和托管 provider 文档都不保证跨版本、平台或服务栈完全可复现。[S69,S70,S71] 因此 `seed` 是控制变量和审计字段，不是“确定性证明”。

### 2.4 D — 方法比较、假设与适用场景

| 方法 | 回答的问题 | 核心假设 | 失败条件/诊断 | 本项目位置 |
|---|---|---|---|---|
| Repeated Bernoulli | 单 instance 的 `p_ci` 或固定 task set 的 trial uncertainty | 同一 `Ω_c` 下 iid/stationary trials | provider drift、cache/warm start、resume、相关重试；0/R 或 R/R 时 Wald 退化 | instance reliability 主分析；不用 naive Wald [S21,S22] |
| Ordinary/item bootstrap | 从抽样 items 到 item population 的不确定性 | 被重采样单位与真实抽样过程一致且可交换 | 固定 census、workflow nesting、少 clusters、selection bias | 只有明确 item sampling frame 时使用；不替代 repeats [S23,S34,S60] |
| Workflow/multilevel bootstrap | workflow/domain aggregate、paired rank/score uncertainty | 顶层 workflows 近似独立；层内采样对应真实设计 | workflows 太少、size 极不平衡、逐 row 错误重采样 | paired configurations 同步重采样相同 workflow clusters |
| Mixed-effects | unbalanced nesting、config contrasts、variance decomposition | link/outcome family、random effects 与 conditional independence 合理 | separation、singular fit、few clusters、未建模 interactions/missingness | binary 用 logistic GLMM；partial 用 ordinal/beta/hurdle；报告诊断 [S25,S60] |
| IRT | item difficulty/discrimination、DIF、subset diagnostics | 单维/已注册多维、monotonicity、local independence、invariance、足够 systems×items | systems 少、能力分布多峰、workflow dependence、tool/harness DIF | secondary only；parameter-recovery 和 leave-config-out 后才可解释 [S26-S28] |
| Paired comparison | 同 tasks/blocks 上配置差异 | 完整配对、对称条件、pair/cluster 独立 | 非对称缺失、不同 subset、时间 confounding、discordant pairs 少 | binary：paired risk difference + McNemar；score：paired cluster bootstrap/permutation [S29,S30] |
| Clustered CI / CRVE/GEE | workflow 内任意相关下的 population-average contrast | workflows 独立且有效 cluster 数足够 | few clusters、high leverage、错误 clustering level | mixed model/bootstrap sensitivity；报告 cluster count/size/correction [S24] |
| Bayesian hierarchy | sparse `p_i`、partial pooling、posterior rank/top-k probability | likelihood、hierarchy、exchangeability 和 prior 合理 | prior dominance、misfit、divergence/nonidentifiability | 预注册 prior；prior/posterior predictive 与 alternative-prior sensitivity [S31] |

**[反方证据]** IRT 可提供难度/区分度，但近期针对 AI benchmark 的模拟研究显示，在 systems 少、能力分布偏斜或多峰时会扭曲 item 与 ranking inference。[S27,S28]  
**[反方证据]** NIST 明确警告 naive 的 item+trial 两层 bootstrap 可能高估 variation；正确方法取决于 estimand 和采样层级。[S60]  
**[适用边界]** clustered SE 或 rank stability 只能说明注册设计下的统计稳定性，不能修复 evaluator bias、task selection bias 或 construct invalidity。[S24,S35,S64]

### 2.5 主分析与 sensitivity hierarchy

**[项目建议]** 预注册如下优先级：

1. Primary：冻结 finite release、single-trial policy 的 FPR 与 Mean Score；workflow-clustered interval；all-planned-trial denominator。
2. Primary comparative：相同 tasks、provider/time blocks 上的 paired deltas；binary 报 risk difference，partial score 报 paired mean difference；同时报告区间。
3. Co-primary operational：cost-constrained reliability、wall time/cost 分布、agent/infra/evaluator failure ledger。
4. Secondary：domain/workflow estimates、human contrast、rank/top-k probability、conditional successful time。
5. Diagnostic：IRT、DIF、variance components、judge agreement、leave-domain/workflow-out、alternative priors/links。

多重比较 family、决策相关 pair、是否使用 family-wise error、FDR 或 posterior loss 必须在看结果前冻结。

---

## 3. B — run、trial、attempt、retry、resume、seed 与 evaluator rerun

| 名称 | 唯一 ID / 定义 | 是否增加 agent trial 分母 | 预算与状态规则 |
|---|---|---|---|
| Run | 一个编排/执行容器；可包含一项或批量 trial job | 否；不能仅以 process/job 数作为统计重复 | 保存 orchestration/run_id、host、timestamps、logs |
| Trial | `(instance_id, config_id, planned_trial_slot)` 的一次全新 stochastic realization | 是；主随机重复单位 | clean initial state；完整 budget；不得读取同槽位既往 outcome |
| Attempt | trial 内 agent 可见的一次行动链或策略性再尝试 | 否 | 累计消耗同一 trial 的 time/token/tool/cost budget |
| Agent retry | agent/harness policy 允许的恢复或重新执行步骤 | 否 | 属于 configuration/policy；不得获得免费预算或隐形 feedback |
| Infrastructure retry/continuation | 独立外因导致的 transport/host continuation；无战略二次机会 | 否，只有满足下列资格时 | 保留 `planned_trial_id`；state/remaining budget 等价；新 execution/run_id；全量记录 |
| Resume | 从 checkpoint 继续同一 trial | 否 | 必须保留 trial_id、累计预算、已见信息与 state provenance |
| Seed | RNG/control label；可固定、crossed 或从注册集合抽取 | 否 | 记录 requested/returned seed、provider fingerprint；不宣称绝对确定性 |
| Evaluator rerun | 对同一 immutable artifact/state 再评分 | 否 | 新 `evaluation_id/q`；保留全部 raw scores、judge config、聚合规则 |

### Infrastructure continuation 的必要条件

**[项目建议]** 必须同时满足：

1. 有独立 telemetry 证明原因发生在 agent 无法利用结果的外部基础设施层；
2. agent 未获得新 observation、error feedback 或战略性第二机会；
3. 已见上下文、filesystem/state、剩余 time/token/cost budgets 可验证地等价保留；
4. 触发和上限按结果无关的规则预注册；
5. 原 execution 永不删除，并进入 operational ledger。

任何条件不满足，就按 agent-visible retry（trial 内计预算）或新 planned trial 处理，不得事后挑选最有利标签。[S61,S62,S65]

---

## 4. E — repeats、CI、MDE 与 sample-size 计算流程

### 4.1 不可由公开 benchmark 决定的输入

**[待客户/pilot]** `h*`（可接受 CI half-width）、`δ*`（practically meaningful MDE）、置信/credible mass、`α`、power 或 posterior loss、decision-relevant pairs/top-k、family/multiplicity、最大错误选优概率、budget/cost perspective、目标权重、pilot variance/ICC、paired discordance、provider/evaluator variance、失败与缺失机制。

### 4.2 仅用于 design screening 的公式

1. **单 instance Bernoulli precision**：`SE(p̂) ≈ √[p(1-p)/R]`；候选 `R ≈ z²p(1-p)/h²`。`p` 未知时用 pilot uncertainty 与情景网格；最终 interval 不用极端计数会退化的 Wald。[S21,S22]
2. **固定 manifest 加权 FPR**：独立近似下 `Var(FPR̂) ≈ Σ_i b_i² p_i(1-p_i)/R_i`。若 trial/provider 相关，加入 block/random effect；若目标是 task superpopulation，另加 between-workflow/instance 项。
3. **paired binary MDE**：令 `D=Y_A-Y_B∈{-1,0,1}`，`Var(D)=p10+p01-(p10-p01)²`；粗筛 `N ≈ (z_{1-α/2}+z_{1-β})²Var(D)/δ*²`。`p10,p01` 来自 pilot；workflow clustering 后以 simulation 为准。[S30]
4. **cluster diagnostic**：等 cluster size 粗略 `DE≈1+(m-1)ρ`，`N_eff≈N/DE`；size 不等、三层 nesting、random slopes 与 missingness 使用完整仿真。[S33]
5. **variance budget intuition**：`Var(aggregate)≈σ_w²/W + σ_i²/(Wm) + σ_r²/(WmR)`。增加 repeats 只压低最后一项；不是未经 pilot 的 sample-size 答案。
6. **有限总体修正**：若从明确有限的 `N_target` 中不放回抽取 `n` 个单位，可按对应抽样设计考虑 `√[(N_target-n)/(N_target-1)]`；若 1,000 是生产目标而不是抽样总体，不得机械套用。
7. **成本约束下近似分配**：在独立固定-manifest 近似中，可用 `R_i ∝ b_i√[p_i(1-p_i)/cost_i]` 作为候选；必须加入每层覆盖、上限、provider blocks 和 pilot parameter uncertainty。

### 4.3 Pilot-calibrated sample-size algorithm

**[项目建议]**

1. 冻结每个 estimand 的 population、weights、effect sc…3694 tokens truncated…ngs、agreement statistic/CI、adjudication reason、old/new evaluator version。

机器可执行字段见 `schemas/human_baseline_attempt.schema.yaml`。

### 8.2 主分析

1. **All-assigned success**：所有随机/规则分配且开始资格流程后进入预注册人群的 participants/attempts 按分母规则分析；退出与失败不得从成功率中静默删除。
2. **Score-at-budget**：在统一 time/resource cap 时记录全体 partial score，包括失败的 rubric minimum/partial。
3. **Time-to-success**：成功为 event；到 cap 未成功为 right-censored；withdrawal、technical invalid、adjudication pending 作为预注册 competing events/strata。报告 survival curve、time-horizon-specific success 或 RMST contrast；具体 summary 由决策确定。[S51]
4. **Successful-only quality/time/cost**：只能作为 `conditional on observed success` 的 secondary result，并与 all-assigned 成功率、失败类型、删失数和 score-at-budget 同表。不得把它称为“典型人类时间/成本”。
5. **成本**：报告 all-assigned total/mean/distribution、incremental cost、cost per assigned success；`总成本/成功数` 不得用只成功者的劳动时间作分子。
6. **Confidence**：participant confidence 与 reviewer confidence 分开；校准用 success/score 对 confidence 的 reliability 分析，不能替代 objective score。
7. **Error taxonomy**：instruction misunderstanding、domain reasoning、software operation、search/documentation、planning、execution、verification、format/artifact、time management、infra/evaluator、other；允许多标签与 blinded adjudication。

### 8.3 Reviewer agreement

**[项目建议]** agreement 在 adjudication 前基于独立 raw ratings 计算；保存 initial 与 adjudicated scores。reviewers 尽可能对 human/agent 来源、configuration 和其他 reviewer score blind。

- full-pass/nominal：报告 raw agreement、confusion/prevalence、Krippendorff alpha 或适配的 chance-corrected statistic 及 interval；
- ordinal：使用与序数距离匹配的 alpha/weighted statistic，并报告逐级差异；
- continuous/partial：明确 absolute-agreement ICC 的 model、single/average-rating、CI；同时给 absolute difference、Bland–Altman/分布性诊断；
- agreement 不等于 validity；task author/adjudicator 的最终决定不能把 pre-adjudication disagreement 抹掉。[S46,S47,S52-S54]

**[待客户/pilot]** reviewer 数、double-score 比例、agreement 可接受区间、adjudication trigger 和 scorer calibration size 均由 risk、pilot disagreement 与预算决定，不设万能阈值。

---

## 9. 带 uncertainty 与完整配置的结果报告模板

### 9.1 Release header

```yaml
study_id: <id>
protocol_version: <semver + hash>
benchmark_release: <manifest hash>
ale_evidence_freeze:
  arxiv: 2606.05405v2
  github: 1e615e456de7cef57706680613cb80ee13c7fc76
  huggingface: a8c1fd174a1f6cfa76526572a2e3ebece1276be2
analysis_commit: <hash>
data_cutoff: <timestamp/timezone>
primary_estimands: [<ids>]
target_population_and_weights: <definition or not estimable>
amendments: <none or linked ledger>
```

### 9.2 Configuration table

| config_id | model/provider snapshot | harness/prompt/context | tools/environment/network | budgets | attempt/retry/resume | evaluator | execution window |
|---|---|---|---|---|---|---|---|
| `<id>` | `<exact ids>` | `<commit + hashes>` | `<versions + policy>` | `<time/token/tool/cost>` | `<policy version>` | `<scorer/judge version>` | `<region + timestamps>` |

### 9.3 Main result table

| estimand / population | config | estimate | interval + method | `N_plan/scored/infra_invalid/eval_pending/unresolved` | weights/clusters/repeats | time/cost | status |
|---|---|---:|---|---|---|---|---|
| FPR, finite release, single trial | A | `<value>` | `<level, method>` | `<counts>` | `<workflow/instance/R>` | `<ledger summary>` | final/provisional |
| Mean Score, same population | A | `<value>` | `<level, method>` | `<counts>` | `<same>` | `<same>` | `<status>` |
| `R(B,H)` | A | `<value>` | `<level, joint method>` | `<policy trials>` | `<policy>` | `<B,H,cost quantiles>` | `<status>` |
| paired FPR delta A−B | pair | `<value>` | `<workflow-clustered CI/posterior>` | `<complete/asymmetric pairs>` | `<blocks>` | `<incremental>` | `<status>` |
| matched-human contrast | A vs expert arm | `<value>` | `<paired/blocked model>` | `<agent + all-assigned human>` | `<task/person clusters>` | `<both ledgers>` | `<status>` |

### 9.4 Mandatory companion tables

- workflow/domain absolute results with weights and intervals；
- failure/exclusion/quarantine/replacement flow；
- score/cost/time distributions与 Pareto frontier；
- paired sensitivity matrix与 rank stability；
- old/new evaluator regrade confusion、delta与 rank shifts；
- human recruitment/attrition、expertise/familiarity/conflicts、all-assigned vs successful-only；
- reviewer raw agreement、CI、adjudication和 error taxonomy；
- assumptions/diagnostics：cluster counts/sizes、model convergence、separation、posterior predictive、missingness bounds；
- deviations/amendments、执行时间线和已知 incidents。

机器可执行模板见 `schemas/preregistration_template.yaml`、`schemas/run_trial_event.schema.yaml` 与 `schemas/result_reporting_table.md`。

### 9.5 解释句模板

**[项目建议]** 使用：

> “在冻结的 `<release>`、`<complete configuration>`、`<provider/time window>`、single-trial policy 与 `<weights>` 下，估计 `<estimand>` 为 `<estimate>`，不确定区间为 `<interval>`。该结论描述 `<finite set / target population>`；不外推到未测 workflow、其他 harness/provider、岗位替代或组织生产率。”

禁止只写“模型达到 X%”“超过人类”“可自动化 X% 工作”。

---

## 10. Benchmark 仍不能支持的结论

| 不支持的结论 | 为什么现有协议仍不足 | 需要的新增证据 |
|---|---|---|
| “human-level professional intelligence” | matched-human 只覆盖注册人群、任务和 affordances；construct/domain coverage 不等于一般能力 | 多职业抽样框、跨情境/时间外部验证、construct validity、独立复现 |
| “可替代某职业/岗位” | benchmark success 不含工作分解、责任、沟通、合规、需求与组织约束 | 职业任务频率/重要性、端到端部署、监督与风险、劳动经济研究 |
| “减少就业/工资” | capability score 不能识别劳动需求、替代/互补、价格和组织响应 | 因果 labor-market/firm evidence 与长期追踪 |
| “提高生产率 X%” | benchmark 时间/分数不是组织生产率；successful-only 时间有选择偏差 | randomized/credible quasi-experimental workplace study、质量调整 output、全成本 |
| “节省成本 X” | provider、人力、review、失败与整合成本随 deployment 变化 | 客户实际 ledger、规模情景、failure tail、维护/合规成本 |
| “模型本身更强” | 结果属于 model–harness–tool–provider–budget–evaluator 系统 | standardized harness 或对明确 config distribution 的 robustness 证据 |
| “生产可靠” | benchmark window 未覆盖 drift、outage、attack、长期 state 与 live dependencies | rolling shadow/pilot、SLO、incident/rollback、安全和长期监测 |

**[机构/作者主张]** benchmark 作者可能把饱和解释为工业能力或长任务自主性趋势。[S01,S42]  
**[研究者推断]** 这些是有价值的研究假设，不是由一次 release、排行榜或 matched-human 子集自动证明的结论。

---

## 11. 可直接采用的项目建议

1. 将本报告的 `schemas/preregistration_template.yaml` 作为每个 release 的 gate；主运行前锁定 `protocol_version` 与 manifest hash。
2. 把 1,000 assets 组织为 `domain → workflow → instance → trial → attempt/evaluation`，并让每个 ID/version 可追溯；不要把 production target 当 sample-size 常数。
3. 先做覆盖关键 strata 的 variance pilot，再以 simulation 选 repeats 与 task coverage；任何候选数字只作为 pilot scenario，不进入承诺。
4. 每个关键配置使用同 tasks、provider/time blocks 的 paired design；保留 common anchors 以检查 subset 与版本漂移。
5. 同时发布 single-trial FPR、Mean Score、cost-constrained reliability、failure ledger 和 paired uncertainty；best-of/retry policy 必须另命名。
6. Infrastructure continuation 使用五条件 gate；agent-visible retry 全部留在 trial 内并计预算。
7. Retain immutable artifacts、full logs、raw judge outputs、old/new evaluator scores；禁止 selective regrade。
8. primary human arm 采用 independent practicing experts；建立 expertise/familiarity/conflict ledger；task author 只做 diagnostic。
9. 人类主表用 all-assigned success、score-at-budget 与 censor-aware time-to-success；successful-only 仅 secondary。
10. 每个 release 执行 subset/seed/provider/harness/prompt/tools/budget/retry/evaluator sensitivity；任何 decision-relevant rank flip 必须进入 executive summary。
11. 把 human-level、就业和生产率结论列入 claim firewall；未经独立外部研究不得进入销售/新闻措辞。

---

## 12. 尚待确定的变量与 pilot measurement plan

| 类别 | 变量 | 决定者/测量方式 | 未确定时的状态 |
|---|---|---|---|
| 决策 | primary estimand、comparison family、loss/ranking criterion | 客户决策表 | 不启动 confirmatory run |
| 总体 | target workflows/domains、sampling frame、weights | 客户业务数据 + content audit | 只报告 finite release |
| 精度 | `h*`、`δ*`、interval level、power/posterior loss | 客户风险容忍度 | 输出 feasibility frontier |
| 方差 | workflow/instance/trial/judge variance、ICC、discordance、interactions | crossed pilot | scenario ranges，不给固定 repeats |
| 运营 | infra/network/evaluator failure、latency/cost tails | pilot telemetry | conditional 与 unconditional bounds |
| 人类 | target role、expertise/familiarity criteria、recruitment frame | 客户 job analysis + qualification pilot | human comparison not estimable |
| Affordance | software/internet/docs/time/attempts/hardware/output | matched-lab/deployment design | 不宣称 matched baseline |
| Reviewer | disagreement、calibration、adjudication load | double-score pilot | interval/bounds；不设万能阈值 |
| 生产 | throughput、acceptance yield、staffing、cycle time、unit cost | instrumented production pilot | 全部保留为变量/公式 |
| Release | quarantine authority、recovery window、retention、refresh cadence | governance owner | 结果 provisional |

**[项目建议] Pilot 输出**：每个 planned slot 记录 event schema；产生 variance-component posterior/CI、paired discordance、score/cost/time/failure joint distribution、human recruitment/attrition、reviewer disagreement、DGP scenarios；然后运行第 4 节 sample-size algorithm。pilot 不能用来宣称生产 throughput 或 acceptance yield，除非其抽样、培训、工具和 QA 流程与目标生产状态一致并报告不确定性。

---

## 13. 反方审查与适用边界

### 13.1 最强反方意见

- **[反方证据]** “基础设施失败也应计失败，因为用户确实经历它。”正确：这对应 unconditional deployed-system reliability。解决方案是并列报告 operational 与 conditional capability，不是抹去 infra incidents。[S60,S62]
- **[反方证据]** “retry 是好 agent 的能力。”正确：agent-visible recovery 应保留在 trial 内并计总预算；只有不可利用 outcome 的外部 continuation 才可能不新开 trial。[S61,S65]
- **[反方证据]** “固定 seed 比 noisy repeats 更公平。”它能改善配对和调试，但不能识别 provider/runtime nondeterminism；需同时做 changed/no-seed robustness。[S69-S71]
- **[反方证据]** “预算只够单次全跑。”那么结论是一次 descriptive realization；不得用 item bootstrap 冒充 instance reliability。[S60]
- **[反方证据]** “只重评失败样本更省钱。”它按 outcome 选择 measurement，可能偏置 score/rank；无法全量重评时只能 provisional/bounds 或新 release。[S65,S66]
- **[反方证据]** “task author 最懂任务，应是 human ceiling。”作者熟悉隐藏意图和 rubric，存在 construct-irrelevant advantage；作者更适合校验 scorer，独立专家才是主要外部比较。[S44,S55]
- **[反方证据]** “successful-only 时间最符合完成工作的速度。”它条件化于成功且会排除最慢/失败者；部署决策需要 all-assigned 成功率、删失分布和 score-at-budget。[S43,S51]

### 13.2 何种结果会推翻本协议的工作假设

- 若 pilot 显示 within-instance variance 在所有重要 strata 可忽略、provider/time blocks 无差异且 evaluator 完全重复，则可减少对应 repeats/reruns；必须用预注册 precision/rank-loss 标准判定，而非肉眼。
- 若 config×workflow/harness/provider interactions 在实用阈值内均接近零且区间足够窄，可把某些 sensitivity 轴降为监测项；不能永久删除 refresh。
- 若 human recruitment frame 明确面向 generalists 而非 experts，则主 human estimand 应预先改为 generalist；不能在结果后因哪组更有利而更换。
- 若 scorer repair 改变 construct/instruction/reference，则“全量 artifact regrade 可比”的假设被推翻，必须新 task version 和 agent rerun。

### 13.3 总体边界

本协议提高内部可解释性、重复性和决策透明度；不保证 task universe 代表现实、evaluator 测到正确 construct、公开任务无污染、provider 长期稳定或组织能将 capability 转化为生产结果。1,000-asset 规模本身不能消除这些边界。

---

## 14. 来源交叉验证表

| 关键结论 | 政府/标准 | 学术/公开方法 | 官方代码/技术文档 | 交叉验证状态 |
|---|---|---|---|---|
| 先定义 estimand、再定 estimator/失败规则 | ICH E9(R1) [S20]；NIST AI 800-3 [S60] | mixed/cluster 方法 [S23-S25] | ALE metric/code [S01,S09] | 已三类交叉；AI 映射为研究者推断 |
| trial variance 与 task heterogeneity 分离 | NIST AI 800-3 [S60] | bootstrap/cluster/power [S23,S24,S32] | Inspect logs/epochs [S65] | 已三类交叉；具体方差待 pilot |
| 完整 system configuration 是评估对象 | NIST repeatability terms [S69] | reproducibility/harness studies [S63,S67] | ALE frozen run surface [S02] | 已三类交叉；外推范围仍受 config grid 限制 |
| retry 改变 policy estimand 与成本 | NIST repeated-attempt study [S61] | AI Agents That Matter [S62] | Inspect retry/log provenance [S65] | 已三类交叉；无万能 retry 数 |
| evaluator failure 与 regrade 要版本化 | NIST judge/evaluation docs [S46,S60] | LLM-judge bias [S68] | ALE/Inspect scorer history [S09,S66] | 已三类交叉；exact judge calibration 待 pilot |
| paired/clustered comparison 优于无配对排名 | NIST McNemar [S30] | paired/cluster/rank methods [S23,S24,S29,S35] | frozen task/config manifest [S02] | 已交叉；small-cluster 仍可能失效 |
| human primary arm 应匹配独立实践专家 | OPM/O*NET/Testing Standards [S48,S49,S55] | RE-Bench/PaperBench [S40,S44] | protocol schemas/event logs | 标准+实证+实现；目标人群待客户 |
| all-assigned、censor-aware human analysis | NIST censoring [S51] | METR long-task methods [S42,S43] | human attempt schema | 已交叉；生存模型和时间点待决策 |
| agreement 在 adjudication 前计算并保留 raw ratings | NIST evaluation/adjudication [S46,S47] | alpha/ICC/GRRAS [S52-S54] | versioned score schema | 已交叉；无万能 agreement threshold |
| benchmark 不证明就业/生产率 | NIST risk/context framework [S45]；testing validity [S50,S55] | target/rank critique [S64] | ALE scope boundary [S01] | 已三类交叉；需要外部因果证据 |

**完整逐来源表**：`sources.csv` 共 53 条；每条含来源类型、URL、访问/冻结信息、credibility/recency/bias、evidence role、boundary 与对应 `sources/*.md` 来源卡。逐源卡保留短引，主报告不把供应商宣传作为独立结论证据。

### 来源编号范围

| 范围 | 主题 | 类型 |
|---|---|---|
| S01–S09 | ALE frozen paper/code/HF、NIST、METR、agent evaluation | 主要来源与官方实现 |
| S20–S35 | estimands、CI/power、cluster/mixed/IRT/paired/Bayesian/rank | 标准、政府统计与学术方法 |
| S40–S55 | human baseline、recruitment、affordance、censoring、agreement | benchmark 方法、政府/测试标准、测量方法 |
| S60–S71 | failure/retry/config sensitivity、reproducibility、judge/seed | 政府、学术研究与官方技术文档 |

---

## 15. Refresh targets

| target | 触发条件 | 必须重做的分析 |
|---|---|---|
| ALE paper/code/HF 任一 frozen revision 改变 | 新 paper version、commit、dataset revision 或 task/scorer repair | source/version/unit ledger；metric/evaluator diff；old/new artifact regrade 或新 trials |
| Provider model alias/snapshot/seed/fingerprint semantics | provider 文档、endpoint、region、model alias 变化 | provider/time sensitivity；config_id 升版；repeatability audit |
| Harness/environment/tool versions | commit/image/dependency/tool API 变化 | paired harness/config cells；failure与rank shift |
| Evaluator/judge model/prompt/parser | version、prompt、endpoint 退役或 calibration drift | 全量 retained artifacts regrade；old/new delta、confusion、rank bounds |
| Task release/quarantine/repair | instruction/reference/affordance/output contract 变化 | 判定 measurement-preserving vs changing；后者新 task version/new trials |
| Pilot variance/cost/failure | 新 stratum、明显 drift、区间不再满足目标 | 重新运行 sample-size simulation；不偷看后随意加样 |
| Human target population/affordances | 客户岗位、软件、internet、AI-use policy 变化 | 新 human estimand/arm；recruitment与matching 更新 |
| Agreement/censoring/missingness | disagreement或未决结果呈 configuration-dependent | reviewer panel、bounds、missingness sensitivity、结果 provisional |
| IRT/small-cluster/benchmark methods | 新 peer-reviewed方法或当前反证更新 | model fit/parameter recovery；alternative analysis sensitivity |
| 现实部署 | live service/task mix/security/organization 改变 | rolling evaluation、shadow pilot、SLO/incident/economic study；不与 frozen leaderboard 合并 |

---

## 16. 项目文件

- 预注册模板：`schemas/preregistration_template.yaml`
- run/trial event schema：`schemas/run_trial_event.schema.yaml`
- matched-human attempt schema：`schemas/human_baseline_attempt.schema.yaml`
- 结果表字段：`schemas/result_reporting_table.md`
- 完整来源索引：`sources.csv`
- 逐来源证据卡：`sources/`
- 原子 findings 与 adversarial notes：`findings/`、`subagent_notes/`

本报告是统计与测量协议，不是 staffing、成本、周期或 production yield 承诺。所有此类量须由 instrumented pilot 与客户约束求解。

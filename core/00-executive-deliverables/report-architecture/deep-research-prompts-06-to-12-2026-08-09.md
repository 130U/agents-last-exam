# ALE-style 1,000-asset 项目：Deep Research 问题 6—12

**用途：** 为 UniPat 面试作业的最终文字报告补齐问题 1—5 尚未覆盖的实施研究。  
**原则：** 每个问题应独立运行 Deep Research；优先使用论文、官方代码/文档、政府或标准机构、公开方法报告。重要结论至少由三类相互独立来源交叉支持。必须区分来源事实、作者主张、研究者推断、项目建议和待客户确认事项。缺乏证据的人员、成本、周期、产能、通过率、阈值和比例不得编造，应转化为 pilot 变量、公式或待决策项。

---

## 问题 6：如何建立专家生产、校准与治理体系？

### 我有什么样的问题？

对于一个需要生产 1,000 个 ALE-style runnable benchmark assets 的项目，应该如何定义专家画像、验证资格、组织招募和校准，并在 author、group lead、reviewer、task engineer、evaluator engineer、independent solver、domain reviewer 和 final approver 之间建立清楚的权责与升级机制？我在 Micro1 使用过的“Golden case → guideline/scenario matrix/rubric/checklist → 专家筛选 → batch zero → reviewer 晋升 → 日常问题分级与升级”流程，哪些部分可以迁移，哪些部分必须因 executable agent benchmark 的环境、reference 和 evaluator 要求而改造？

### Prompt

```text
请开展一项深度研究，目标是设计一套适用于“生产 1,000 个 ALE-style、通过 final QC 的 runnable task instances”的专家生产、校准与治理体系。研究不是泛泛讨论众包或数据标注，而是回答：怎样把真实专业 workflow 转化成可信、可执行、可审计的 benchmark asset。

请把下面这段 Micro1 项目经验作为“待验证的运营假设”，而不是外部事实或既定最佳实践：

1. 在正式招募大量专家前，由少量 group leads 阅读业务材料、公开研究和真实 raw data，先弄清任务要测什么能力、关键变量是什么、哪些场景最容易误判，并制作 Golden cases 或 demo。
2. 将 Golden case 的隐含判断规则拆成 scenario matrix、rubric、A/B ranking 或 preference rule、checklist、正反例和答疑材料，让 group lead 先走完整流程，暴露歧义和边界。
3. 标准与边界相对稳定后，再按照简历、平台 assessment、面试、客户要求、seniority 和 vertical experience 招募专家。
4. 用最匹配的一小批专家运行 batch zero；将分歧区分为 guideline defect、expert misunderstanding、case defect 或真实的合理多解。
5. 将表现稳定、解释能力强的专家晋升为 reviewer；日常运营按问题类型决定由 guideline 直接处理、peer review、domain lead adjudication 或项目负责人升级。

请研究并回答：

A. 对不同任务类型，怎样定义 domain expert、practitioner author、group lead、independent solver、domain reviewer 的画像？资格证书、职业年限、近期实践、作品样本、简历、结构化面试、blind work sample 和 Golden task 各自能证明什么，不能证明什么？怎样发现简历夸大、代做、过时经验或只会理论不会使用专业软件？

B. 专家来源可包括哪些渠道：现有专家池、行业协会、职业社区、大学/实验室、专业服务机构、供应商和定向猎寻？比较其覆盖、速度、稀缺专业触达、保密、利益冲突、质量可控性和可扩展性。不要凭公开资料估算具体招募速度或成本。

C. Golden case 和 guideline 应包含哪些组件，才能服务于 executable benchmark，而不仅是人工标签一致性？至少研究 task objective、scenario matrix、in-scope/out-of-scope、input assumptions、expected artifact、alternate-correct outputs、rubric/evaluator coverage、known-bad cases、edge cases、FAQ、escalation rules 和 change log。

D. Batch zero 应当测量什么：专家正确性、解释质量、分歧类型、guideline ambiguity、task feasibility、environment friction、reference correctness、evaluator disagreement、完成时间和返工原因？不要先给固定 batch size 或 agreement threshold；说明怎样通过 pilot 数据选择它们。

E. 什么情况下可以把优秀 author 晋升为 reviewer？如何避免“写题人兼最终裁判”、group lead 权力过大、熟悉 reference 导致泄漏、同一机构内部利益冲突，以及 reviewer 为提高 yield 而放宽标准？

F. 建立一份完整但不过度复杂的 RACI，覆盖：benchmark owner/research lead、group lead、practitioner author、task engineer、environment engineer、evaluator engineer、independent solver、domain reviewer、rights/privacy/security reviewer、operations/PM 和 final approver。明确谁可以提出、修改、复核、否决、仲裁和 final accept；哪些角色不能由同一人同时承担。

G. 研究 NDA、保密分级、客户数据/PII、知识产权、数据来源证明、专家雇主限制、利益冲突披露、reference custody、最小权限和离场撤权应如何进入专家运营流程。区分法律建议与项目流程建议，不要替代正式法律意见。

H. 分析 preference-data 项目中的 A/B ranking、reviewer calibration 和 QA 机制，哪些可以迁移到 benchmark production；哪些不能直接迁移，因为 ALE-style task 还需要 runnable environment、hidden reference、executable evaluator、reset 和 reproducibility。

来源要求：

- 必读 ALE arXiv:2606.05405v2 的 task construction pipeline 和 Appendix B.2，并检查固定 GitHub revision 1e615e456de7cef57706680613cb80ee13c7fc76；明确 ALE 公开资料披露了什么、没有披露什么。
- 寻找高质量 annotation/data-quality 方法研究，例如 NIST annotation guidelines、ACL/Computational Linguistics 关于 annotator management、guideline refinement、pilot、agreement、adjudication 和 validation 的研究。
- 寻找适用于测试/校准机构的正式质量体系作为类比，例如 ISO/IEC 17025、ISO 17034、ISO/IEC 17043 或 NIST Quality System；说明哪些原则可迁移，哪些只是类比。
- 重要主张至少使用三类独立来源交叉验证；供应商宣传只能作为行业做法线索，不能单独支撑结论。

最终输出：

1. 一套推荐的专家生产 operating model，从 group-lead discovery 到 final acceptance；
2. 专家角色与 qualification evidence matrix；
3. Golden case/guideline/batch-zero 的最小交付包；
4. 完整 RACI 与 segregation-of-duties 规则；
5. reviewer promotion、calibration、deboarding 和 escalation policy；
6. confidentiality、rights 和 conflict-of-interest control checklist；
7. 对 Micro1 方法的逐项判断：保留、修改、删除或新增，并解释原因；
8. 哪些阈值或人员配置必须通过 pilot 得出，不能由 desk research 决定；
9. 对最终 ALE 报告第“专家生产与组织治理”章节可直接采用的建议。
```

---

## 问题 7：如何用 pilot 建立真实的产能、返工与扩产模型？

### 我有什么样的问题？

从一个 workflow idea 到一个 final-QC accepted runnable instance，实际会经过多少道工序、发生哪些返工循环，真正的串行瓶颈在哪里？如何通过 batch zero 和分层 pilot 测出 throughput、acceptance yield、返工率、专家/工程工时、环境等待和 reviewer capacity，并由此决定是否以及如何扩展到 1,000 个 accepted instances？

### Prompt

```text
请开展一项关于 ALE-style benchmark production capacity 与 pilot scaling 的深度研究。目标不是给出一个看似精确的“多少人、多少周、多少钱”，而是建立一套可以用真实 pilot 数据填写的产能、返工、成本和扩产模型。

项目目标暂定为：交付 1,000 个通过 final QC 的 accepted runnable task instances，同时单独报告 distinct workflow 数量 W。请严格区分 workflow、submitted proposal、implemented candidate、runnable instance、accepted instance、quarantined/rejected asset、agent run 和 repeated trial。

请研究并回答：

A. 将端到端生产过程拆成可测量 stage gates，例如：capability/workflow discovery、Golden case、expert submission、first-pass review、rights review、task specification、input/reference preparation、environment implementation、evaluator implementation、engineering dry-run、independent solve、evaluator red team、domain peer review、final QC、UAT、release sealing。哪些步骤可以并行，哪些存在硬串行依赖？

B. 每个阶段应该记录哪些 operational variables：touch time、calendar wait time、queue time、一次通过率、revision count、返工原因、blocked days、稀缺专家等待、licensed software seat、environment build/cache、reviewer load、evaluator defect、infrastructure defect 和 final acceptance state？

C. 怎样定义并计算 funnel 与 yield，而不把 pending、rejected、duplicate、quarantined、failed run 或 retry 误算成 accepted asset？建立 submitted → reviewed → implementable → runnable → evaluator-valid → independently solved → final accepted 的状态转换模型。

D. 分析真正可能控制吞吐量的瓶颈：稀缺领域专家、group lead/guideline、environment image、licensed software、evaluator engineering、independent reviewer、rights clearance、客户 UAT、重复运行成本。说明为什么简单用总工时除以人数会产生错误排期。

E. 设计一个分层 pilot：应覆盖哪些 domain、OS/software、evaluator mode、workflow complexity、licensing risk 和 expected difficulty strata？Pilot 必须测得哪些参数，才能推断是否扩产；哪些参数只能在第二轮 pilot 或小规模 production 中估计？不要未经证据指定固定 pilot size。

F. 为 pilot 预先定义 advance、repair、rescope、pause 和 stop 五类决策。每类 gate 应观察哪些指标，例如 acceptance yield、critical defect rate、evaluator disagreement、environment failure、expert availability、repeat-run variance、rights blockage 和 refresh burden？不要发明通用阈值，而要给出设置阈值的方法、决策者和证据要求。

G. 建立成本和排期公式，至少区分 workflow fixed cost、instance marginal cost、environment/evaluator engineering、expert/reviewer/QC、licenses、infrastructure、agent runs、human baselines、adjudication、maintenance 和 rotation。说明平均数为何不足，哪些变量需要分布、区间或场景分析。

H. 研究从 batch zero 晋升 reviewer 是否可能缓解 reviewer bottleneck，以及它带来的独立性、reference exposure 和 quality drift 风险。将这一机制放入容量模型而非只当作人员政策。

来源要求：

- 以 ALE v2 的 construction pipeline、release states 和固定代码结构为主要案例，但不能用其公开任务数量反推生产 yield、工时或人员配置。
- 寻找 benchmark/data production、复杂软件 QA、专业数据标注、实验室/测试质量体系和 operations/queueing 方法中的可迁移证据。
- 对供应商公开的 throughput、成本或产能数字进行利益相关性审查；如果缺少可比口径，标记为不可用于本项目估算。
- 重要结论至少三类独立来源；明确事实、作者主张、研究推断和项目建议。

最终输出：

1. End-to-end production state machine 和 stage-gate 表；
2. 串行/并行依赖图与 bottleneck register；
3. Pilot measurement schema 和每项变量的定义、单位、采集责任人；
4. funnel/yield/rework/throughput/cost/schedule 的公式；
5. advance/repair/rescope/pause/stop decision matrix；
6. 三种情景模型：quality-first、balanced、accelerated；仅使用变量和条件，不编造数值；
7. 从 pilot 到 1,000 accepted instances 的扩产决策流程；
8. 公开证据无法回答、必须由 UniPat 或客户提供的参数清单。
```

---

## 问题 8：怎样构建安全、可复现、可维护的运行环境？

### 我有什么样的问题？

面对 Windows/Linux、GUI/CLI、GPU、专业软件和 licensed software 混合的 1,000 个实例，environment image、credential、network、secrets、输入/reference staging、reset、日志和清理应该如何设计，才能把 agent capability failure 与 environment/infrastructure failure 分开，并形成可验收的 reproducibility SLA？

### Prompt

```text
请开展一项深度技术研究，为 1,000 个 ALE-style runnable benchmark instances 设计环境与执行基础设施 reference architecture。研究重点是可复现性、隔离、安全、licensed software、credential 管理和 failure attribution，而不是只列云服务产品。

请研究并回答：

A. 一个完整 environment manifest 应记录什么：OS/image ID、软件与插件版本、license、driver/GPU、locale/timezone、screen resolution、filesystem state、installed fonts、network policy、credentials、compute/memory、input/reference hashes、task start/reset、agent/harness version、evaluator version 和 output retention？

B. 比较 full VM、container、nested virtualization、existing sandbox 和 remote desktop/GUI provider 在 Windows/Linux、GUI fidelity、GPU、licensed software、启动时间、隔离、可复现性和成本上的适用边界。不要假设所有任务都能容器化。

C. 环境镜像如何构建、签名、扫描、版本化和复现？研究 immutable image、infrastructure as code、SBOM/provenance、content hashes、golden image、cache、patch policy 和 emergency rollback。

D. Secrets 和 credentials 如何进入运行环境而不被 bake into image、泄漏给 agent、出现在 logs 或留在废弃 VM 中？区分 agent provider key、cloud credential、licensed-software credential、task-specific account 和 evaluator-only secret；提出最小权限、短期凭证、注入、撤销和审计机制。

E. Network policy 如何按任务设计：完全断网、allowlist、记录所有 egress、模拟服务或开放互联网？怎样避免 search-time contamination、恶意下载、数据外泄和非预期外部状态，同时不破坏任务真实性？

F. Hidden reference 与 evaluator 应何时、以何种隔离方式进入系统？比较 post-run staging、separate judge container/VM、read-only mount、host-side scoring 和 remote evaluation service，分析 reference leakage 与 grader tampering 风险。

G. 如何实现 deterministic start、reset、cleanup 和 retry？Retry 什么时候是 infrastructure recovery，什么时候会改变测量对象？怎样保留 failed run、timeout、crash 和 partial artifact，避免把基础设施故障记为 agent failure？

H. Reproducibility SLA 应包含哪些可测量维度：image resolvability、start-state checksum、software launch success、input integrity、evaluator repeatability、run artifact completeness、environment equivalence、cleanup success 和 incident recovery？不要发明统一 SLA 数字，说明 pilot 如何校准门槛。

I. 建立 build-versus-buy 和 provider abstraction 决策框架：哪些能力应由内部平台统一，哪些可以委托云/沙箱供应商，哪些必须由 task owner 维护？考虑 vendor lock-in、license terms、region、security、support 和 task migration。

来源要求：

- 必读 ALE 固定 GitHub revision 1e615e456de7cef57706680613cb80ee13c7fc76 的 README、quickstart、provider/image、task lifecycle、secret 和 logging 相关代码/文档；记录精确文件路径和 revision。
- 对比 OSWorld、SWE-bench、Terminal-Bench、Inspect、EdgeBench/SForge 或其他具有公开实现的 agent benchmark/eval harness；只采用可由代码或正式文档支持的机制。
- 参考可信的软件供应链、cloud security、SBOM、secrets 和 reproducibility 标准/官方文档。
- 所有架构建议必须区分“来源已实现”“研究者推断”“本项目推荐”。

最终输出：

1. Reference architecture 与 trust-boundary/data-flow diagram；
2. Environment manifest schema；
3. Image build/version/rollback policy；
4. Credential、secret 和 licensed-software control matrix；
5. Network policy profiles；
6. Hidden-reference/evaluator isolation options 与推荐；
7. Environment acceptance test、smoke test 和 reproducibility test suite；
8. infrastructure-vs-agent failure taxonomy 和 exclusion/adjudication rules；
9. 可由 pilot 校准的 SLA 指标，以及不能由公开资料设定的阈值。
```

---

## 问题 9：怎样验证 evaluator，并保护 scoring integrity？

### 我有什么样的问题？

如果模型会寻找最省力的得分路径，怎样确保 evaluator 真正覆盖 prompt 所要求的专业结果，而不是奖励 shortcut？怎样设计单元测试、adversarial validation、人工仲裁、grader isolation 和 scorer release policy，并对 evaluator tampering、reference leakage、surface compliance 和其他 reward hacking 风险进行治理？

### Prompt

```text
请开展一项关于 ALE-style benchmark evaluator validity 与 scoring integrity 的深度研究。核心决策是：在 1,000 个异构专业任务中，怎样证明每个 evaluator 衡量的是 intended professional outcome，而不是一个可被 agent 利用的狭窄代理指标。

请使用固定 ALE public corpus audit 的 153 个 task cards 和 executable scoring-path 分类（141 deterministic、7 hybrid、5 LLM-judge）作为案例入口，但不要把 deterministic 等同于有效，也不要把该比例当作未来 1,000 个实例的配额。

请研究并回答：

A. 建立 evaluator mode taxonomy：exact/hash、schema/field、numeric tolerance、artifact parser、geometric/visual similarity、behavior/state replay、gate-and-score、weighted rubric、LLM judge、human adjudication 和 hybrid。每类适合测什么，最典型的 false positive、false negative、brittleness 和 gaming route 是什么？

B. 怎样建立 prompt/reference/evaluator 的双向 coverage：prompt 中的每项要求必须被验证，evaluator 检查的每项内容也必须由 prompt 和可用输入支持。设计 requirement-to-check traceability matrix。

C. 每个 evaluator 的最低测试库应覆盖哪些类别：gold/reference、known-bad、alternate-correct、near-miss、boundary/tolerance、missing/corrupt artifact、mutation、metamorphic、shortcut、surface-compliant-but-wrong、evaluator tampering、reference probing 和 environment failure？

D. 怎样验证 alternate-correct outputs，避免只有“长得像 reference”才能得分？什么时候应使用 invariant、functional/behavioral test、property-based test、multiple golds、expert rubric 或 human arbitration？

E. 怎样设计 adversarial validation：由谁攻击、可以看到什么、如何记录 exploit、怎样区分 scorer defect 与 intended challenge？研究 evaluator locking、separate judge environment、file-access logging、patch tracking、trajectory inspection 和 integrity labels。

F. 什么情况触发人工仲裁：evaluator 与 expert disagreement、多个合理解、低 confidence judge、parser failure、environment defect、novel shortcut 或客户 dispute？定义仲裁材料、blind review、tie-break、版本修改、历史 score 处理和 reviewer conflict rules。

G. 设计 scorer release policy。比较 fully public scorer、public wrapper + hidden tests、delayed release、private scorer、tiered feedback 和 evaluation-as-a-service。分析透明度、可复现性、debuggability、contamination、gaming、客户可接受性和研究开放性的取舍。

H. 建立 evaluation-integrity threat model，至少覆盖：grader code tampering、reference leakage、test modification、prompt/evaluator mismatch、metadata shortcut、artifact spoofing、judge prompt injection、LLM-judge bias、environment escape、feedback-channel leakage 和 repeated-query hill climbing。

I. 研究 evaluator quality 应怎样持续监控：defect discovery rate、expert-evaluator disagreement、alternate-correct rejection、gaming success、test mutation survival、score changes after repair 和 regrade impact。不要先指定通用阈值。

来源要求：

- 以 ALE paper、固定 GitHub scorer implementation 和本地 153-task evaluator audit 为一手案例。
- 必查 RewardHackingAgents、Reward Hacking Benchmark、Search-Time Contamination、NIST/CAISI 关于 agent evaluation cheating 或 transcript analysis 的研究，以及 BetterBench 等 benchmark validity 方法。
- 对论文中的攻击成功率或开销数字保留其任务、模型、环境和版本，禁止直接迁移成 ALE 项目参数。
- 每个关键结论至少三类独立来源，并主动搜索“自动 evaluator 不应成为唯一裁判”“private scorer 损害可复现性”等反方论证。

最终输出：

1. Evaluator mode/risk/mitigation matrix；
2. requirement-to-evaluator traceability template；
3. evaluator unit/adversarial test protocol；
4. human arbitration SOP；
5. scorer release decision matrix 和推荐的分层政策；
6. integrity threat model 与 control mapping；
7. evaluator defect、agent failure、environment failure 的判定和 regrade policy；
8. final-QC evaluator acceptance checklist；
9. 仍需由 pilot 或客户风险偏好决定的阈值。
```

---

## 问题 10：怎样设计重复运行、统计推断和 matched human baseline？

### 我有什么样的问题？

Agent 的单次运行具有随机性，而且结果受 model、harness、预算、retry 和环境影响。应该运行多少次、怎样定义 seed/attempt/retry、怎样报告置信区间和排名稳定性？同时，如何让专业人类在尽可能匹配的 affordances 下完成同一任务，测得质量、时间、成本和 agreement，而不把不公平的人机比较写成“human-level”？

### Prompt

```text
请开展一项深度研究，为 ALE-style professional agent benchmark 制定预注册式 statistical evaluation protocol 和 matched human baseline protocol。目标不是寻找一个适用于所有任务的固定重复次数，而是明确 estimand、随机性来源、sample-size/power 决策和人机可比条件。

请研究并回答：

A. 明确不同层级的 estimand：单个 instance 的成功概率、workflow family 表现、domain 平均、全 benchmark aggregate、Full Pass Rate、Mean Score、成本约束下成功率和 reliability target。说明这些估计量分别能支持什么决策。

B. 区分 run、trial、attempt、retry、resume、seed 和 evaluator rerun。Infrastructure retry 不应自动被当作新的 agent trial；agent 自主重试可能是系统能力的一部分。提出清晰记录和计数规则。

C. 识别随机性和变异来源：model sampling、provider nondeterminism、harness scheduling、tool/environment state、network、judge model、task-instance heterogeneity、software race condition 和 evaluator noise。哪些可以固定，哪些必须纳入不确定性？

D. 比较适用的统计方法：per-item repeated Bernoulli trials、bootstrap、hierarchical/mixed-effects model、item-response model、paired comparison、clustered confidence interval 和 Bayesian interval。说明假设、适用场景和失败条件，而不是只推荐一种方法。

E. 怎样确定重复运行数和 sample size？从目标置信区间宽度、minimum detectable difference、ranking stability、任务成本、预期成功率和 domain clustering 反推。给出公式、模拟方案或计算流程，但不要在没有 pilot variance 的情况下给固定数字。

F. 怎样测试 ranking stability 和 configuration sensitivity：不同 task subset、seed、model provider、harness、prompt/context、tool权限、budget、retry policy 和 evaluator version 是否会改变排序？什么时候只能报告“在该配置下”的结果，不能推广到模型本身？

G. 怎样处理 timeout、crash、missing artifact、infrastructure failure、evaluator failure、quarantined task 和 post-hoc repaired scorer？定义 denominator、exclusion、sensitivity analysis 和 regrade policy。

H. Matched human baseline 应招募什么人：practicing expert、general skilled worker、task author、independent professional？怎样记录 expertise、software familiarity、training/familiarization 和 conflicts？

I. 人类与 agent 应匹配哪些 affordances：task instruction、input、software、hardware、internet、documentation、time limit、attempts、help/communication、prior context 和 output format？哪些差异不可避免，必须披露？

J. 人类 baseline 应记录质量、成功、partial score、completion time、active work time、monetary cost、confidence、error type 和 reviewer agreement。如何处理人类失败，只统计成功者会产生什么选择偏差？

K. 怎样建立 reference、human output 和 evaluator 之间的 agreement/adjudication：inter-rater reliability、expert-evaluator disagreement、multiple acceptable outputs 和 blind arbitration。不要把 agreement 指标机械当作 validity。

来源要求：

- 必读 NIST AI 800-3 或其官方说明、AI Agents That Matter、METR Time Horizons 的公开方法、NIST repeated-attempt agent evaluation，以及报告不确定性的 benchmark/eval 方法。
- 对 METR 等 human baseline 研究，明确其任务领域、专家来源、affordance 差异和已披露局限；不得直接推广到所有 ALE 专业领域。
- 将 ALE 的 Mean Score/Full Pass 和 configured system 边界纳入 protocol。
- 重要结论至少三类独立来源；保存方法假设、反例和适用边界。

最终输出：

1. Statistical analysis plan；
2. run/trial/retry/seed 的计数规则；
3. sample-size、repetition、CI 和 MDE 的公式或模拟流程；
4. ranking stability 与 configuration-sensitivity test plan；
5. missing/failure/exclusion/regrade policy；
6. matched human baseline recruitment 和 affordance protocol；
7. human quality/time/cost/agreement 的数据表结构；
8. 推荐的 leaderboard/reporting table，必须呈现 uncertainty 与配置；
9. 哪些结论仍不能被该 benchmark 支持，例如 job replacement、生产率或 human-level professional ability。
```

---

## 问题 11：怎样设计 public/private/rotation 与 living benchmark 生命周期？

### 我有什么样的问题？

一个面向模型厂商的 benchmark 如何同时支持开发、客户验证、private final evaluation 和持续更新，又不让同一实例成为训练、调参和最终考试的共同攻击面？如何检测污染和搜索时泄漏，怎样决定轮换、修复、退休和替换，并在 benchmark 版本变化后维持可解释的历史比较？

### Prompt

```text
请开展一项关于 ALE-style living benchmark release architecture、contamination control 和 lifecycle governance 的深度研究。目标是为 1,000 个 accepted runnable instances 设计可运营多年的发布、访问、轮换、修复和版本比较机制，而不是只做一次 public/private split。

请研究并回答：

A. 区分 development/demo、restricted validation、private final holdout、rotation reserve、training/SFT/RL assets 和 retired archive。说明同一 workflow family 是否可以跨池，但为什么 concrete inputs、reference、evaluator attack surface、IDs 和访问权限不能简单复用。

B. 建立 contamination taxonomy：pretraining exposure、post-training/test-specific optimization、public solution leakage、near-duplicate leakage、search-time contamination、reference/evaluator leakage、customer/internal operational leak 和 repeated-query hill climbing。每类怎样检测，什么证据只能说明风险而不能证明污染？

C. 研究访问控制：least privilege、gated access、evaluation-as-a-service、query limits、submission logging、reference custody、staff separation、canary/watermark、delayed feedback 和 audit trails。分析它们对客户可用性、debuggability 和研究开放性的影响。

D. Public subset 应承担什么功能：示例、开发、harness integration、方法透明度或代表性检查？Private final set 应承担什么功能？不要假设 public subset 必须按领域严格同比例抽样。

E. Public/private/rotation 比例应该由哪些变量决定：客户用途、威胁模型、workflow diversity、instance multiplicity、refresh capacity、benchmark half-life、成本、反馈需求和合规要求？不要从 ALE 当前 release counts 直接推导本项目比例。

F. 定义生命周期状态：proposed、authored、implemented、validated、accepted、active-public、active-private、rotation-reserve、quarantined、repaired、retired、replaced。列出进入/离开每一状态的 owner、证据和 change log。

G. 定义 refresh triggers：模型饱和、discrimination loss、污染证据、search exposure、environment/software drift、license/policy change、evaluator defect、task obsolescence、客户需求变化和 safety incident。区分 task repair、new instance、new workflow 和 full benchmark version。

H. 怎样处理 retirement 和 replacement：旧分数是否保留、是否回溯 regrade、何时冻结 leaderboard、如何披露 broken task、怎样避免静默改题？

I. 怎样维持跨版本可比性：anchor set、overlap/bridge runs、equating、版本化指标、common-agent reruns、frozen historical leaderboard、live leaderboard 和 uncertainty。说明 private holdout 与长期可比性之间的张力。

J. 制定 contamination 或 grader-leak incident response：发现、隔离、影响分析、客户通知、重跑、版本 bump、替换和 postmortem。明确哪些情况必须宣布 score invalid。

来源要求：

- 以 ALE v2 的 public/private/pending/rolling design 为主要案例，但严格保持各 count 的原始 unit 和 snapshot。
- 必查 Search-Time Contamination、公开 benchmark 饱和/plateau 研究、NIST/CAISI integrity 研究，以及具有 rolling/private/held-out 机制的官方 benchmark 文档。
- 主动搜索反方观点：private benchmark 损害透明度、固定 anchor 本身会污染、频繁轮换破坏可比性、evaluation-as-a-service 造成信任集中。
- 重要结论至少三类独立来源，所有比例和刷新周期若无证据必须保留为变量。

最终输出：

1. 多池 release architecture 和 access matrix；
2. contamination taxonomy、detection 与 mitigation mapping；
3. lifecycle state machine 和 ownership；
4. refresh/repair/quarantine/retirement decision tree；
5. versioning、leaderboard 和 cross-version comparability policy；
6. contamination/grader-leak incident response；
7. 三种 release-policy options 及其取舍，不预设比例；
8. 需要客户回答才能确定 public/private/rotation 配置的问题。
```

---

## 问题 12：哪一道原创 task 最适合证明这套方法？

### 我有什么样的问题？

为了同时回答面试官“请出一道 ALE-style 题”和“如何领导 1,000 道题的项目”，应该选择什么 domain 和 workflow，既能体现真实专业工作、长程执行、软件/文件操作和可验证交付，又能在面试作业范围内设计出可信的 input、environment、reference、evaluator 和 red-team cases？

### Prompt

```text
请开展一项“原创 ALE-style worked task 选择与完整设计”的深度研究。最终目标不是写一道知识问答或竞赛题，而是交付一个 implementation-ready 的专业 workflow benchmark asset blueprint，用来证明前述专家生产、环境、evaluator、统计和治理方法能够落到具体任务。

请首先生成并比较 4—6 个候选 workflow families，再选择一个最适合 UniPat 面试报告的方案。候选方向可以来自但不限于：

- 消费/marketing 或业务分析工作流，可借鉴我在 Micro1 中对业务材料、raw data、关键变量、误判场景和 Golden case 的真实理解，但不得使用或暴露前雇主/客户的机密数据与专有规则；
- 数学、物理或科学工作流，但必须产生真实专业 artifact 或软件状态，不能退化成单题推理问答；
- 文档、表格、可视化、研究或其他跨文件/跨工具 workflow；
- 问题 4 的 landscape 与问题 5 的 portfolio 研究发现尚未被现有 benchmark 充分覆盖的窄能力。

对候选任务进行严格筛选：

A. 是否来自真实、合理的专业工作，而不是为了难住模型而拼装的怪题？目标用户、职业角色和现实决策是什么？

B. 是否满足 Complex、Representative、Verifiable？“长程”是否来自跨阶段依赖、持久状态、错误恢复和最终 artifact，而不是简单增加点击、token 或软件数量？

C. 输入、软件和运行环境能否合法获得、稳定复现并在面试原型范围内解释清楚？优先 rights-clean 的公开、许可或重新构造数据；若使用 synthetic data，说明保持真实逻辑与避免明显 fake placeholders 的方法。

D. 成功是否可以通过 artifact/state 被观察？是否存在多个合理正确输出？怎样建立 hidden reference、invariants、rubric 或 functional tests，而不只做 exact matching 或视觉相似？

E. 任务是否对当前 agent system 有辨别力，但难度不是由坏环境、缺少信息、任意格式或 evaluator bug 人为制造？

F. 是否能展示至少一种重要的 evaluator 设计难点和 adversarial shortcut，同时可以通过合理控制缓解？

G. 是否与 ALE public tasks 和其他知名 benchmarks 高度重复？进行外部 overlap 检查，并解释创新点是新的 workflow、instance structure、evaluator mode 还是 capability combination。

H. 是否适合作为面试交付：非该领域面试官能理解业务价值，技术评审可以检查设计，且它能自然连接“如何扩展到 1,000 assets”的生产框架？

为最终选中的任务，完整设计：

1. task title、domain/subdomain、target practitioner 和 intended decision；
2. stable workflow_id 与一个具体 instance_id；
3. agent-facing task description，明确但不泄漏 scoring implementation；
4. input files、来源、license/provenance、敏感性与 hashes；
5. OS、软件、版本、资源、network、credentials、start/reset 和 environment manifest；
6. expected output artifact/state，以及 alternate-correct outputs；
7. hidden reference 的内容、custody 和 staging 时点；
8. evaluator 设计、分项 criteria、gates、tolerances、partial score 和 pseudocode；
9. requirement-to-evaluator coverage matrix；
10. gold、known-bad、near-miss、alternate-correct、mutation、shortcut、tampering 和 environment-failure test cases；
11. independent-solver 和 domain-review protocol；
12. failure taxonomy、human arbitration trigger 和 scorer release policy；
13. repeated-run 和 matched-human pilot 方案；
14. public/private/rotation 归属和未来 variant strategy；
15. 从本任务扩展成 workflow family 时，哪些变量构成合法 instance，哪些只是 pseudo-variant。

来源要求：

- 使用 ALE v2、固定 GitHub task protocol、固定 public corpus 和 evaluator audit 作为格式与风险参考，但任务必须原创，不复制其 prompt、input、reference 或 evaluator。
- 使用问题 4 的相邻 benchmark landscape 检查重合与创新点。
- 对 domain-specific 事实、标准、软件和数据使用一手/官方来源；重要设计结论至少三类独立来源。
- 清楚标注哪些内容是 source fact、benchmark precedent、research inference 和 proposed design。

最终输出：

1. 4—6 个候选 workflow 的比较矩阵；
2. 选择一个任务的决策与未选择其他候选的理由；
3. 完整 implementation-ready task asset blueprint；
4. evaluator pseudocode、coverage matrix 和 adversarial test suite；
5. 一份可以直接放进最终面试报告正文的 worked example；
6. 一份列明仍需真实 SME、工程实现或 pilot 验证的 open-items 清单。
```

---

## 推荐执行顺序

建议先运行问题 6、8、9、10 和 11；它们彼此相对独立。问题 7 应在问题 6、8、9 的初步结论出来后整合角色、环境和 evaluator 工序。问题 12 最后运行，并显式引用问题 6—11 的结论，把完整方法压缩到一个 worked example 中。

若时间只够运行四份研究，优先级为：

1. 问题 6：专家生产与治理；
2. 问题 9：evaluator validity 与 integrity；
3. 问题 7：pilot、产能与扩产；
4. 问题 12：原创 worked task。

问题 8、10、11 仍然重要，但可以先以较短的技术附录形式处理，再按时间加深。

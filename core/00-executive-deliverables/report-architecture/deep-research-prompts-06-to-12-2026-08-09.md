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

G. 设计 scorer release policy。比较 fully public scorer、public wrapper + hidden tests、delayed release、private scorer、tiered feedback 和 evaluation-as-a-service。分析透明度、可复现性、debuggability、contamination、gaming、客户可接受性和研究开放…20131 tokens truncated…，我越来越在意一个很具体的问题：一个模型怎么真正进入现实工作？任务谁来定义，什么算做对，专家的判断怎么留下来，做错以后又怎么改。
>
> 回国看机会以后，我接触到两个场景很不一样、但问的是同一件事的方向。通过 Manifold 的研究题，我看到世界模型和机器人怎样在物理环境里学习和行动；看 UniPat 的 ExpertEval 和 SaaS-Bench，我看到的是 Agent 怎样在专业任务和真实软件环境里工作。这让我更确定，我长期感兴趣的不是押某一个模型架构，而是参与 AI 从真实任务中学习、被检验、再继续改进的过程。
>
> 我接触到的这类国内早期团队，研究、数据、产品和实际需求离得比较近，这正是我现在想进入的工作方式。我希望加入核心团队，长期接住一块问题，而不是回国短期试一试。UniPat 是我觉得和已有经验有具体连接、也值得认真判断长期匹配度的机会。

如果需要更短：

> 我回国不是某一份 offer 推动的，而是过去两年慢慢确定的职业选择。我在美国做 LLM 评测和专家数据时，越来越感兴趣的是模型怎样进入真实专业任务：问题怎么定义、谁判断好坏、反馈怎样变成下一次改进。Manifold 让我从物理世界看到这个问题，UniPat 的 ExpertEval 和 SaaS-Bench 则让我从专业任务和软件环境看到同一个问题。我希望长期进入一个研究、数据和产品靠得很近的团队，把这件事做深，而不是回国短期试一试。

## “已经接受 Manifold offer，为什么还愿意聊 UniPat？”

> HR 应该跟您提过，我确实已经接受了 Manifold 的 offer。后来我专门去现场，和创始人及团队把日常工作和角色边界聊得更细，发现实际角色主要是 CEO Office 的战略支持和专项工作。我理解这类岗位的价值，长期也不排斥做战略；不过在现阶段，我更希望先扎进一条具体的产品或业务线，通过实际执行建立对产品、客户和市场的第一手认识，并且对一个明确结果负责。有了这些基础以后，我再参与更宽的战略判断会更扎实。因为这个职业顺序上的差异，我选择在正式开始前重新确认匹配度，也因此回来认真聊 UniPat。
>
> 我知道这也会让您关心我的承诺是否稳定。所以这一次我会把真实职责、双方预期和前几个月的结果先聊清楚，再做承诺；我认为这比信息不充分地入职、再很快发现不合适更负责。

不要说：

- “我一定要参与公司决策。”这会让人听成尚未创造结果便索取权力。
- “那边只是让我给 CEO 打杂。”这既贬低对方，也忽略 founder's-office 工作的合理价值。
- “我已经有独角兽 offer，所以你们要说服我。”这会损伤动机信号。

更成熟的表达是：

> 我不期待因为 title 获得决策权；我希望通过拥有一个 workstream、获得必要上下文并对结果负责，逐步赢得决策空间。

## “你想做什么岗位？”

> 我不急于先锁死 title，但现阶段的方向比较明确。结合我看到的岗位，产品经理和市场拓展都是我比较感兴趣的切入点：产品侧可以把 AI 数据策略、模型评测和 Agent 原型的经验带进产品定义与迭代；市场侧可以发挥研究与沟通能力，把技术能力转成客户能够理解和使用的场景。我也可以从 founder's office / special projects 切入，但希望项目最终落到一个具体产品、市场目标或业务结果上，并逐步由我完整负责。评测是我能够使用的方法，但不是我希望长期停留的工作终点。

### 可以主动提出的 90 天 charter 样例

1. **ExpertEval 金融域扩展**：完成子领域/专家供给地图、scenario taxonomy、rubric calibration SOP、critical-negative QA、专家一致性与吞吐指标，并跑通一轮 badcase → 数据修订 → 复评闭环。
2. **Echo 金融/决策产品验证**：访谈明确 ICP，定义一项可重复用例和验收指标，形成 pilot、反馈和包装方案。
3. **Professional Agent workflow**：为一个真实专业流程设计任务、checkpoint、基线和失败分析，并把结果连接到产品或训练团队。

这些是提案，不是你替公司决定优先级。先问对方目前最急的结果是什么。

## 面试里最值得问的 8 个问题

不需要全问。优先问前四个。

1. **“我的简历通过红杉学者渠道到您这里后，您最初看到哪一点，觉得值得先聊一次？”** 直接让对方暴露真实角色假设。
2. **“如果不先套岗位名称，公司现在最希望这个人解决的前三个问题是什么？哪一个最急？”**
3. **“Across ExpertEval、SaaS-Bench、UniScientist 和 UniMath，你们认为最可复用的核心资产是模型本身，还是任务、环境、rubric 和 feedback loop 的生产系统？”**
4. **“如果我加入，前 90 天我独立拥有的结果会是什么？哪些决定由我做，哪些是我为 CEO 准备？”**
5. **“你们未来 6–12 个月最优先的商业 wedge 是 Echo、评测、专家数据、RL 环境，还是定制合作？现在的经济买方是谁？”**
6. **“对一个通才型成员，六个月后理想状态是继续做 special projects，还是沉淀成某条产品/运营/评测线的 owner？”**
7. **“哪些工作目前由 CEO 反复亲自做？您希望我只是接走它，还是把它机制化以后拥有这条流程？”**
8. **“过去类似高潜 generalist 最容易成功和最容易失败的原因分别是什么？”**

不建议第一轮就审问融资金额、持股或 runway。若气氛合适，可用业务问题替代：

> “目前哪一类产品已经进入外部用户的重复使用，而不只是一次性研究或 pilot？”

## 你必须纠正的世界模型表述

你原来的讲法里有三处风险：

1. 公司叫 **Physical Intelligence**，不是 “Fiducial Intelligence”。模型家族写作 **π0、π0.7**。
2. VLA 与 WM/WAM 的根本区别不能简化成“文字作为媒介”对“视频/latent 作为媒介”。VLA 同样直接处理图像并可输出连续动作；关键差别更接近：VLA 学习从观测/指令到动作的策略，而 WM/WAM 显式预测动作条件下未来状态/观测，用于模拟、规划或训练。
3. π0.7 更稳妥的定位是 **world-model-assisted VLA**，不能把它说成已经完整实现双中心 causal WAM。其动作核心仍是连续 action chunk，而不是离散 action token。

如果被问，20 秒回答：

> 我最后形成的判断不是“VLA 用文字、WAM 用视频”，而是 VLA 更偏直接学习 observation-to-action policy，WM/WAM 则显式建模 action-conditioned future，用于预测、规划或训练。两者不是二选一，可以融合；π0.7 更稳妥地说是 world-model-assisted VLA。对我更重要的收获其实是如何把技术资格、产品可用性和商业采用证据分开验证。

### 更强的 fast-learner 故事

不要用“我一天读了很多篇论文”作为主体。用下面这条证据链：

> 我进入世界模型领域时没有现成框架，所以先把问题拆成公开锚点、候选发现和大厂替代三条互相制衡的研究线；再用资格门、来源卡、原子主张、反证查询和 red team 限制结论。最后公开仓库沉淀了 141 个来源、111 条原子主张和 58 次支持/反证查询，把候选从广泛线索收敛到可解释的重点对象。这个项目证明的不是我记住了多少模型名，而是我能在陌生领域迅速建立一套可复核的判断系统。

公开证据：[Manifold 海外世界模型竞争格局研究仓库](https://github.com/Madarame87/manifold-world-model-research)。

## 常见追问与短答

### 面试前必须统一的一处履历口径

Master Resume 把同一时期的部分 AI 工作写为 **Alignerr / Domain Expert / Present**，而提交版写为 **Micro1 / AI 模型评估与策略工程师 / 至 2026.06**。这很可能被追问。请在进面试前准备一句完全真实、可核实的说明：两者究竟是平台、项目、合同主体还是品牌之间的什么关系，以及为什么结束日期不同。不要临场猜，也不要为了让故事更顺而合并主体。

### “你的经历会不会太散？”

> 领域看起来分散，但我做的任务很稳定：把不完整数据、专家判断和复杂约束变成可重复的决策系统。金融、AI 评测和产品只是不同场景。我的复合背景只有在接口岗位上才有价值，所以我也不会把自己包装成任何方向都能做的万能通才。

### “你到底有多 technical？”

> 我能读技术材料、写 Python/SQL、搭 ETL、做原型和测试，也理解 Agent、RAG、tool use 和 evaluation workflow。但我不会把自己包装成基础模型研究员。我的比较优势是把模型能力、专家判断、数据质量、产品需求和商业约束连接成闭环，并能和研究及工程团队说同一种可执行语言。

### “AI-native 不就是会用工具吗？”

> 工具熟练度只是最低层。我更看重三件事：任务怎么拆给人与 Agent，证据和授权边界怎么固定，输出怎么通过测试、red team 和反馈继续迭代。Context Agent 的测试闭环和公开研究仓库都能证明这一点。

### “你为什么适合 Expert Community？”

> 我的强项不是传统猎头式专家资源，而是专家被找到之后，怎样把 tacit judgment 变成高质量 scenario、rubric、critical negative、preference signal 和可校准生产流程。我也会坦诚确认，你们现在更缺专家 sourcing、研究方法、数据 QA，还是产品 owner，因为这几种角色并不相同。

### “你能接受 dirty work 吗？”

> 能。我区分的是 high-leverage dirty work 和 non-compounding chores。前者虽然杂，但围绕一个重要结果，能逐渐被机制化并形成 ownership；后者长期是随机 one-off、缺少上下文也不对结果负责。我愿意从前者开始，而且我的习惯正是把重复脏活变成系统。

### “你如何证明 teamwork？”

不要说“我很好相处”。用 Micro1 的例子：

> 多位领域专家对模糊业务问题容易给出不同标准。我做的不是要求大家服从一个答案，而是把分歧拆成可观察变量、scenario variants、rubric 和 evidence re-check，再通过校准和 badcase 回溯让团队形成共同判断标准。我的团队价值通常是降低跨背景协作的翻译成本。

## 如何判断这个机会是否值得改变现有选择

### 绿灯

- 能明确说出 90 天结果、内部客户、指标和直接负责人；
- 任务虽然跨职能，但围绕一个连续 workstream；
- 你能获得完成结果所需的上下文和定期反馈；
- 六个月后职责会沉淀为某条产品/评测/专家系统的 ownership；
- 公司能讲清未来 6–12 个月的技术主线与商业优先级；
- 对方看中的是你已被证明的能力，而不是“聪明所以什么杂事都能接”。

### 红灯

- 成功仍只能定义为“CEO 随叫随到”或节约小时数，没有业务结果；
- 无法说清汇报线、预算/headcount、工作重心和反馈机制；
- “离 CEO 近”被当成主要成长机制，却没有上下文或授权；
- 任务是长期随机 one-off，没有可机制化和升级的路径；
- 研究发布很多，但无法说清哪一条是未来一年的核心业务；
- 要你放弃已接受的机会，却不愿形成书面 role charter。

### 最低决策门槛

不要因为一次聊得投机就推翻现有 offer。至少拿到下面五件事的明确答案：

1. 直接负责人和反馈频率；
2. 前 90 天具体 deliverable；
3. 决策权/建议权/执行权边界；
4. 六个月后的职责归宿；
5. 薪酬、期权、工作强度和加入时间。

## 对 UniPat 的事实边界

- **官方确认**：使命聚焦真实场景中的 AI 能力；官网公开一系列评测、Agent、模型与预测项目；招聘页列出 research、agent systems、infra、expert community、design、PR、legal、tax 等角色。[官网](https://www.unipat.ai/)；[招聘页](https://www.unipat.ai/joinus)。
- **公司自报**：LinkedIn 写 2025 年成立、11–50 人。这不是工商登记。[LinkedIn](https://www.linkedin.com/company/unipat)。
- **合理分析**：底层可能是 task/environment/rubric/data/post-training 的经验生产系统。
- **公开未知**：法定主体、融资轮次/金额/估值、付费客户、收入、定价、留存、runway 和哪项业务是近期主线。
- **红杉关系边界**：红杉官方页面能确认 xbench 与 UniPat 联合发布 BabyVision；招聘文案声称有顶级美元 VC 支持，但公开来源未给出投资方与轮次。你可以陈述自己通过红杉学者渠道被推荐，但不要因此推断“红杉已公开投资 UniPat”。
- **UniFuncs 页面边界**：用户提供的 `s.unifuncs.com` 链接是一份 2026-06-08 保存的 AI 搜索会话，不是 UniPat 官方页面；它对融资的表述前后矛盾，也遗漏七月项目，只能作为线索表。

## 面试前最后 45 分钟

1. 读三遍 90 秒介绍，删掉任何你说不顺的词；不要背得像演讲稿。
2. 各准备一个 60 秒 STAR：Micro1 专家校准、Jiritsu 18,000→800→30、世界模型研究治理。
3. 练两遍“为什么还聊 UniPat”和“想做什么角色”。
4. 只记四个公司关键词：`experience production loop / ExpertEval / Echo / role ownership`。
5. 从八个问题里圈出四个，优先问“为什么找我、90 天结果、核心资产、商业优先级”。
6. 最后十分钟停止补资料，检查设备、网络、纸笔和摄像头，降低语速。

## 结尾一句

> 我今天最希望确认的不是一个 title，而是有没有一块重要问题，既能用上我把专家判断和复杂信息系统化的能力，也能让我在明确反馈和责任边界下逐渐对结果负责。如果有，我愿意从最具体、最难、甚至最脏的一段开始。

# A. 16 个 benchmark 的 17 字段统一矩阵

研究截止：**2026-08-08**。`F` = **[事实]**；`C` = **[作者/机构主张]**；`I` = **[研究员推断]**；`U` = **公开资料不足**。**矩阵中无前缀的实现、数量、环境与实验描述默认均为 F；真实性、代表性、经济意义与外推如属作者解释则标 C，跨项目综合与建议标 I。** 版本/subset在同一 family row 内保留边界，不把快照相加。BrowserGym是harness，随WorkArena++记录，不单独计为第17个benchmark。

## A1. Construct、task unit、coverage、realism、workflow length、environment

| # | Benchmark | Evaluation construct | Task unit | Domain coverage | Real vs synthetic | Workflow length | Software / environment | Evidence |
|---:|---|---|---|---|---|---|---|---|
| 1 | **ALE** | F：固定harness+foundation model的generalist computer-use agent完成专业deliverable，由task evaluator界定成功 | F：workflow与runnable instance分层；v2为960 workflows/1,490 instances；submission/commission不是自动accepted asset | F：13 clusters/55 subdomains；SOC/O*NET启发但非劳动力加权 | C：作者称来自专家既往专业项目并具有真实/经济价值；I：full private pool provenance未独立审计 | F：准入标准要求来自需days/weeks的项目且是端到端耦合；U：全池matched active-time分布，因此准入标准不能当实测长度 | Windows/Linux VM、真实专业软件；GCP默认，repo另支持多provider/QEMU/Docker subset/static | 01–06,14 |
| 2 | **OSWorld / OSWorld2** | F：v1/Verified测desktop final functional state；v2测checkpointed end-to-end professional workflow | F：v1 paper 369 runnable instances；v2 release 108 workflow-instances；Verified/current另pin | v1 app/OS/multi-app；v2为7 professional domains/21 subcategories，分布非labor sample | 真实apps/services与artifacts；任务目标/初态主要人工构造/改写 | v1 launch cap 15 steps；v2 skilled-human active median约1.6h且69.6%>1h，均是作者snapshot | Ubuntu/Linux desktop、browser/cloud；v2 31 self-hosted services，release/image/assets联合pin | 20–24 |
| 3 | **WebArena** | F：self-hosted网站中的browser agent完成intent后的information/state correctness | F：241 intent templates→812 runnable instances；Verified Hard为258-instance公开subset | shopping/forum/GitLab/CMS + map/knowledge sites | 站点来自真实browser history并self-host复制；任务人工构造/参数化 | C：long-horizon；paper最多30 state transitions；U：职业active-time基线 | Docker/self-hosted replicas、Playwright/Chromium、账号/reset | 25–28 |
| 4 | **WorkArena++ / BrowserGym** | F：ServiceNow enterprise agent完成组合workflow；L2 explicit/L3 ticket presentation | F：341 workflows各有L2/L3，共682 **level-specific task presentations**；paper curriculum另采235/level=470 runnable evaluation instances；L1与BrowserGym另记 | 单一ServiceNow enterprise platform：KB/forms/catalog/lists/dashboards等 | fictitious data/brands +真实ServiceNow product；workflow程序化组合 | oracle action count/cap 50；I：依赖组合强于机械串联，但L2/L3共享底层workflow | remote ServiceNow PDI + BrowserGym/Playwright；browser/framework revision影响protocol | 29–31 |
| 5 | **GAIA** | F：tool-augmented assistant对multi-step open-world question给single closed-form answer | F：paper 466 questions；current HF >450描述；HAL分析面为165 validation task instances，每task再有agent trials | open-world reasoning/web/coding/multimodal，无职业配额 | human-authored真实web/docs/attachments；答案刻意单一 | L1/L2按约≤5/5–10 steps，L3更长；I：step heuristic不是职业workflow duration | 无统一环境；submitter自选search/browser/code/plugins，harness差异大 | 32–34 |
| 6 | **AssistantBench** | F：open-web assistant完成耗时information-seeking并输出结构化/closed-form answer | F：paper 214；current HF/HAL为33 validation subset | 15+ domains、525 pages、258 sites；需求驱动但非labor weighted | real human needs + live public web；筛选相对稳定答案 | 人类需数分钟browsing；U：跨阶段deliverable/state dependency证据 | live web；作者SPA、BrowserGym、HAL是不同harness surfaces | 35–39 |
| 7 | **SWE-bench family** | F：agent在固定repo base state根据真实issue产生patch，通过instance tests | F：Original 2,294；Lite 534；Verified 500；subset不求和 | 12 Python repositories | 真实GitHub issue/PR history；环境/test packaging为回放构造 | 单issue内导航/debug/edit/test；不覆盖完整需求—评审—部署lifecycle | repo-specific Docker image、base commit、test harness | 40–46 |
| 8 | **Terminal-Bench 2.0** | F：isolated terminal/container中完成instruction，grader读final state | F：instruction+Docker+tests+human oracle+limit；TB2 89；v1 Core-v0 80分开 | software engineering、sysadmin、security、data/scientific computing等 | 真实CLI/tool；contributor-authored challenges，不是自然工单抽样；C：“hard, realistic” | 多步terminal；多数attempt<20min，个别可到2h/极长tokens（作者run snapshot） | task-specific Docker/Harbor；CPU/memory/time/network并入protocol | 47–53 |
| 9 | **CRAB** | F：Android+Ubuntu单/跨环境agent；evaluator DAG计算goal/subgoal | F：v4 abstract/site 120，正文composition 100，未消解；当前精确inventory=U | Android phone+Ubuntu desktop；16/19 sub-task templates | 真实类型apps/OS，任务由templates组合/手工设计 | single/simple/challenging composition；DAG表达前置依赖；U：统一步数/时长/恢复分布 | Android emulator/device state + Ubuntu desktop；API或image/OCR evaluator | 54–56 |
| 10 | **Windows Agent Arena** | F：Windows 11 multimodal OS agent完成任务后由device/app state判分 | F：paper 154 runnable instances；“150+”近似；harder mode是post-paper protocol | Office、browsers、system、VS Code、VLC、utilities | 真Windows/apps；benchmark-authored，部分改编OSWorld | multi-step；human steps与perceived difficulty/success相关很弱，支持不以step count定horizon | Windows 11 VM in Docker、Flask bridge、UIA/SoM/screen parser | 57–59 |
| 11 | **Remote Labor Index** | F：操作定义以专业人工判断deliverable是否可被reasonable client接受；C：作者把该分数解释为remote-labor automation | F：240 project instances=10 public/230 private；brief+inputs+human deliverable | 23 Upwork categories，仅remote/self-contained/evaluable工作 | marketplace、commissioned、permitted online projects；仍经强筛选 | 历史人类time均值28.9h/中位11.5h；F：非统一benchmark计时；U：matched agent/human runtime | 不固定单一authoring app；integrated agents/CUA/OpenHands/CLI/pro media tools | 60–65 |
| 12 | **GDPval** | F：操作定义是professional deliverable相对职业专家的blind preference；C：作者把它联系到经济价值 | F：paper full 1,320；current HF public gold 220；prompt+files→deliverable | 9 sectors/44 occupations/30 tasks per occupation（paper） | 职业专家创建并清洗为self-contained task；非原始work log | gold creator时间均值约404min且有outlier；one-shot complete-context deliverable | 多种professional file formats；通常不依赖live proprietary system | 66–70 |
| 13 | **SpreadsheetBench 2** | F：agent在受控spreadsheet runtime完成end-to-end business workbook transformation | F：V2 321 instances；V1 912与后续400 subset不合并 | finance/business spreadsheet modeling/template/debug/visualization | 真实public finance files + expert-constructed removals/errors/specs | 最多50 turns；平均11.8 sheets/593.5 modified cells；I：不等于真实跨日/跨人workflow | Docker/Python 3.11、openpyxl/LibreOffice UNO、SWE-agent tools、no network | 71–74 |
| 14 | **OfficeBench** | F：language agent通过Python tool APIs完成单/多app office automation | F：300 synthetic runnable task instances；run另计 | 9 API applications、1–3 app composition；非职业taxonomy | 高度synthetic；ChatGPT/random generators创建tasks/data | 最多50 actions、1–3 apps；I：action-chain proxy，不证明long-horizon | Docker + Python APIs（System/Word/Excel/PDF/Calendar/Email/OCR/ChatGPT/Shell），非MS Office GUI | 76–77 |
| 15 | **Harness-Bench** | F：configuration-level model–harness diagnostics，不是bare-model ranking | F：106 sandboxed tasks；5,194 trajectories是runs | 8 categories：code/data/office/knowledge/vertical/SRE/long-running state等 | realism-oriented constructed from practical use patterns；非历史工作抽样 | 含long-running state adaptation，但统一human-time distribution=U | offline sandbox、固定fixtures/evaluator/budget/timeout、runtime hooks | 11 |
| 16 | **MBABench** | F：专业spreadsheet的accuracy、formula、format/readability/editability多维质量 | F：专业workbook task/instance；本证据包未取得可稳定复用的精确inventory | professional finance/MBA spreadsheets；与SpreadsheetBench均偏finance | C：real-world professional spreadsheets；有专业创建/验证 | U：统一matched workflow-time与跨阶段dependency分布 | proprietary GUI agents与API/tool agents均测；具体release environment manifest需刷新 | 75 |

## A2. Expert involvement、task sourcing、evaluator、human dependency

| # | Benchmark | Expert involvement | Task sourcing | Evaluator type | Human evaluation dependency | Evidence |
|---:|---|---|---|---|---|---|
| 1 | ALE | experts做source/proposal/reference/eval spec/revision；工程实现/dry-run；committee QC；paper 250+、live 300+分开 | external expert submission + commissioned build；Figure 5计instance，不与workflow count等同 | exact/hash、tabular、geometry、visual、behavioral、free text、executable；partial [0,1] | runtime以automatic为主；生产、校准、QC、incident仍高度人工 | 01–06 |
| 2 | OSWorld/2 | v1作者/CS annotators；Verified人工检查；v2 professional interviews+trained internal annotators，精确专家数U | v1探索apps人工构造；v2 interviews/docs/forums/工作经验，synthetic proposal仅ideation | task-specific final-state functions；v2平均27.25 checkpoints，functional优先、少量model-based | runtime自动；Verified、双人复跑、frontier/adversarial audit依赖人 | 20–24 |
| 3 | WebArena | authors/annotators制作，answers double-check+third adjudication；非职业专家sample | ~200 browsing-history segments选站，annotators写templates，LLM可启发 | exact/must-include/fuzzy + DB/API/JS state；Verified加type normalization/backend/network trace | runtime主要自动；制作、歧义和verified audit人工 | 25–28 |
| 4 | WorkArena++ | authors；human study 15人，其中11 ServiceNow employees；task-production专家工时U | 从33 atomic definitions按逻辑/brand/seed组合 | human-coded Playwright oracle + DB/page checks，binary | runtime自动；oracle实现、ServiceNow维护、baseline人工 | 29–31 |
| 5 | GAIA | creator+两位independent annotators；human validation约92% | 623 candidates人工设计，68%原样通过，其余修/删 | normalized exact/string/number/comma-list matcher | runtime自动；制作/歧义修订人工，不验trace/citation | 32–34 |
| 6 | AssistantBench | 53 contributors/35 experts；每题两位authors复核，非每题两专家 | 70 seeds/18 users→crowdworker扩展172 + 42 expert tasks | type-specific F1/precision/EM/partial numeric | runtime自动；答案构建/复核人工；不验evidence chain | 35–39 |
| 7 | SWE-bench | Verified由93 software-experienced annotators审1,699 samples筛500；Original production hours U | mined linked GitHub issues+merged PRs | executable regression/unit tests，FAIL_TO_PASS/PASS_TO_PASS等 | runtime自动；subset selection/test validity audit高度人工 | 40–46 |
| 8 | Terminal-Bench | 93 contributors提交229，3 reviewers选89；约3 reviewer-hours/final task，不是总工时 | open expert contribution/commission式submission | executable tests/grader读final container；trace integrity audit | runtime自动；authoring/oracle/review/cheating audit人工 | 47–53 |
| 9 | CRAB | 每sub-task template至少两位相关专家验证；精确总人数/工时U | 16+19 templates组合，部分人工设计 | Python boolean evaluator DAG；XML/state APIs/image/OCR | runtime以自动graph为主；template validation/human mode人工 | 54–56 |
| 10 | WAA | 有人类完成实验；task authoring/QC专家人数/工时U | OSWorld Windows-compatible改编 + WAA-specific authoring | application/device-state automatic evaluators | runtime自动；baseline/analysis人工 | 57–59 |
| 11 | RLI | F：freelancers/domain professionals贡献项目；人工evaluator与artifact review；精确参与者口径不得当staffing配额 | F：paper分别报告207 marketplace、7 commissioned、33 permitted online，并报告550初始→240最终；这三类是否互斥/对应最终保留层公开资料不足，**不得相加为247个final assets** | blinded human reasonable-client acceptance、majority automation rate、pairwise Elo | 核心score高度依赖人；每比较2–3 ratings/audit | 60–65 |
| 12 | GDPval | experts≥4年、均值14年；每occupation≥5；每task≥3 reviews、均值5 | occupation experts创建，经screening/training/review；每occupation 30 | occupation-expert blind pairwise preference；GPT-5-high judge为proxy | 高：gold标准是专家；auto judge有ungradable/偏差面 | 66–70 |
| 13 | SpreadsheetBench2 | >1,500 expert-hours不含QA；每task两名非creator experts独立solve/correct | public reports/filings，经专家构造transformation | exact/programmatic workbook comparison；visualization rubric+VLM | 生产/QA高；runtime多数程序化，visualization依赖VLM | 71–74 |
| 14 | OfficeBench | tasks/data主要生成；human baseline 2 CS grad students；职业expert production证据U | ChatGPT + random generators | per-task exact/fuzzy/execution-based checks | runtime低人工；未见持续职业adjudication | 76–77 |
| 15 | Harness-Bench | manual review realism/solvability/oracle/integrity；各vertical领域专家身份U | practical agent-use patterns/common requests，经构造审查 | deterministic validator where possible，rubric where necessary；security binary gates | runtime混合；rubric/process review有人依赖 | 11 |
| 16 | MBABench | 2 MBA + 3 finance professionals，700+ hours；408 expert annotations校验evaluator | 专业spreadsheet collection/construction；完整sampling frame U | 多维grader：accuracy/formula/format/editability；经expert annotations校验 | 生产/校验高度人工；正式runtime human-adjudication比例U | 75 |

## A3. Release、contamination、trials、human baseline、cost、validity、saturation

| # | Benchmark | Public / private split | Contamination policy | Repeated-run policy | Human baseline | Cost evidence | Known validity problems | Saturation / benchmark-specific optimization | Evidence |
|---:|---|---|---|---|---|---|---|---|---|
| 1 | ALE | paper 150 public/1,017 private/323 pending；HF153 rows另面 | small public、hidden refs/private pool、planned rotation；长期cadence/effect未独立证实 | 3 runs仅部分configs；无统一全量规则 | 无matched full-pool baseline | F：paper按configuration/tier报告total API cost；任何per-instance均值都需固定denominator重算；生产/维护全成本U | harness/env/budget/evaluator confounds；public representativeness只内部单config；license/drift | C：hardest tier unsaturated；I：private/rotation减缓但不消除优化 | 01–14 |
| 2 | OSWorld/2 | v1/Verified公开；v2 assets/task logic gated/release-versioned，不等于统计holdout | v1公开gold/evaluator曾有exploits；v2 gated logic、release pin；rotation U | v1/v2统一正式repetitions U；QA rollouts不是leaderboard policy | v1 paper 72.36%特定snapshot；v2完整matched success U | cloud/API/interviews/QA全成本U | service config/live web/FP-FN/agent-readable gold/shared state；v2仍有model judge与provider/image依赖 | v1静态高风险；v2 gating/release更强但108小集、长期证据U | 20–24 |
| 3 | WebArena | 812全公开；Hard 258公开subset | 无hidden split；公开reference/DOM/LLM judge exploits；Verified是修订不是holdout | 无统一；个别baseline retries不可推广 | 5 CS grads、170-template subset 78.24%，条件非完全匹配 | hosting/reset/API/annotation美元U | original FP/FN、ambiguity、substring、LLM judge、state/site drift；Verified paper withdrawn | 公开241 templates/812 instances易专项优化；per-template macro更合适 | 25–28 |
| 4 | WorkArena++ | generators/oracles公开；seeds 0–9 reserved但非hidden workflows | parameterization降逐instance记忆；33/341 families公开，无private workflow | 建议multiple seeds；需声明seed/trials | 15人98-task 93.9%；员工熟悉偏差且无同cap | ServiceNow/API/人工/维护U | single platform；composition realism未独立职业验证；oracle/config leakage/drift | 大量configs不等于新construct，易对atomic families训练 | 29–31 |
| 5 | GAIA | questions公开；paper称300 answers retained；HF validation answers public/test private | gating防bot；validation可lookup；normalizer/answer exploits；作者建议annual refresh | 部分API baseline 3 runs；非统一；HAL显示variance | annotator validation约92%，非matched agent environment | 约2 annotator-hours/question为旧snapshot；生产美元U | ambiguity、link/API failure、quota、normalizer FP/FN、answer lookup、plugin不可复现 | validation高暴露；private answers减缓但questions固定 | 32–34 |
| 6 | AssistantBench | HF validation33答案公开；held-out test evaluator较私有；paper overall214分开 | validation无抗lookup；无明确rolling rotation | original U；HAL当前entry单run，不能估variance | matched overall human success U | HAL 33-task API cost仅系统snapshot；production U | live URL/answer aging；closed-form漏过程/来源；repo/harness差异 | public33易优化；paper overall corpus固定，当前test精确数量须按split manifest读取，不能写成214 | 35–39 |
| 7 | SWE-bench | Original/Lite/Verified公开history/tasks/tests；Multimodal private另版本 | static history污染；SWE-rebench是相邻缓解，不是现有policy | 官方task definition无统一；64 runs是2026 audit sampling，不是policy | U；annotators/merged PR不是controlled baseline | full-suite model+compute/production U | selected138-case audit 59.4% material issue不可外推500；tests过/欠约束 | task-specific reproduction；2026 audit认为Verified不再适合frontier capability | 40–46 |
| 8 | Terminal-Bench | TB2 tasks/tests/oracles公开；长期hidden holdout U | integrity rules+ATIF trace audit；防grader读取/solution lookup，不防训练exposure | TB2每model-agent pair至少5 repetitions；32,155 trials | U；author estimates不是baseline | paper单full-run model cost约$1–100，machine/工程/审核不全 | reward hacking、answer/test leakage、pod/resource noise、verifier exploitation；各百分比保留样本边界 | C：约一年可能saturate并规划challenge sets | 47–53 |
| 9 | CRAB | hidden/private policy U，repo/site公开 | rotation/leak audit U | U | U；expert template validation不是baseline | U | 100/120内部冲突；API vs OCR误差；DAG可能漏等价路径；independent audit不足 | longitudinal evidence U；公开tasks/evals有理论风险 | 54–56 |
| 10 | WAA | current repo公开task/config/eval；hidden holdout U | formal rotatio…2058 tokens truncated…Echo × 风险工程/金融/决策系统

[Echo](https://www.unipat.ai/blog/Echo)是公开信息里最明确的商业产品入口。你有风险工程、金融研究、极端场景、证据校验和不确定性决策背景，可用于预测问题设计、金融垂类评测、客户用例和产品策略。不过当前公开资料没有证明定价、付费客户、留存或收入。

### 第三匹配：Agent workflow × Context Agent / 研究仓库

[SaaS-Bench](https://www.unipat.ai/blog/SaaS-Bench)和 Vibe-Coding Arena 关注长链任务、状态保持、人在回路和可验证交付。你的 Context Agent 端到端原型、39 pass / 0 fail 测试，以及公开研究仓库中的多 Agent、证据卡、red team 和机械 QA，是比“我会用 Codex/Claude”更强的 AI-native 证据。

## 自我介绍（推荐版：三个特点）

这版保留清楚的三点结构。每一点只讲一个证据，不按时间线复述简历，也不使用抽象的能力总结替代事实。

> 您好，我是欧阳乐陶。我的简历在邮件附件里，您可以随时参照，我就不再按时间线重复了。我想把这段时间用来介绍自己的三个特点：第一个是 fast learner，第二个是 AI native，第三个是复合背景。
>
> 先说 fast learner。我曾经被要求在很短的时间内，研究全球世界模型和具身智能的技术路线与竞争格局。坦白讲，这个领域我原来并不熟悉；经过一段高强度的学习，我完成了研究，之后又把它整理成了一个公开的 GitHub 项目。这份简历里没有项目链接，但我可以直接发给您。
>
> 这个任务来自 Manifold AI 的面试。他们后来给了我 offer，我也接受了；这个情况我之前已经告诉了贵司 HR。回国以后，我又去现场了解了团队和具体岗位，发现这个角色主要是 CEO 战略业务助理。我不排斥从支持工作开始，长期也不排斥做战略；只是对我现阶段而言，我更希望先扎进一条具体、能够落地的产品或业务线。通过实际执行，我可以建立对产品、客户和市场的第一手认识，也能够对一个明确结果负责。在这些基础上形成的战略判断，我认为会更加扎实。这也是为什么我还在继续寻找更适合当前发展阶段的机会。
>
> 第二个特点是 AI native。我会写代码，也会搭建 AI Agent workflow。我做过一个个人决策 Context Agent。除此之外，我经常在 Twitter 上收藏大量 AI 内容，但过去收藏以后往往没有时间阅读，其中不少还是很长的英文文章和学术材料。为了解决这个问题，我做了一个自动保存、定时翻译和提醒阅读的 workflow。这些项目在我的 GitHub 上都有体现。现在我每天都会通过这套流程获取 AI 信息、消化材料，也会用类似的方法验证自己的产品想法。
>
> 第三个特点是复合背景。我学的是数学和风险工程，后来做过 AI 数据策略、投资和市场研究，也通过了红杉学者的选拔。以我自己的面试体验，那套选拔会同时考察阅读能力、判断力、表达能力和经历的跨度。也是通过这个项目，我的简历被推荐到了您这里。
>
> 如果有机会加入 UniPat，我现阶段更希望从一条具体的产品或业务线切入。我也看了贵司 HR 在 BOSS 直聘上发布的岗位，其中产品经理和市场拓展是我比较感兴趣的两个方向。
>
> 在产品侧，我可以把过去做 AI 数据策略和 Agent 原型的经验带进产品定义与迭代；在市场侧，我可以发挥研究和沟通能力，理解客户真正需要什么，再把公司的技术能力转化成具体的应用场景。我希望先从一个产品模块、项目或者市场目标开始，逐渐做到能够完整负责并对结果承担责任。随着我对产品、客户和行业的理解不断加深，如果公司有需要，我也愿意承担更宽的跨部门和战略任务；我过去在咨询公司和投资部门的工作与实习经历，也能够为这部分提供支持。

控制原则：Manifold 段不能评价岗位含金量，只解释职业顺序不匹配——先做具体产品或业务，再扩展到战略。AI native 用个人决策原型和信息收集工具证明。红杉学者只作为复合背景的一句外部印证。对 UniPat 的兴趣落在产品、市场拓展、Agent workflow 和研究产品化；benchmark 经验统一上提为 AI 数据策略与评测能力。

## 30 秒版本

> 您好，我是欧阳乐陶。我想用三个特点介绍自己。第一，我是 fast learner：Manifold AI 曾让我在短时间内研究原本不熟悉的世界模型赛道，我后来把研究完整公开在 GitHub。第二，我是 AI native：我会写代码，也知道怎样让 AI 做检索和整理，同时把关键核验和最终判断留在自己手里。第三，我有数学、风险工程、AI 评测、数据和投资研究的复合背景，能够同时和技术、领域专家及业务团队工作。这三点也是我觉得自己和 UniPat 值得进一步聊的原因。

## “为什么寻求回国的机会？”（UniPat 定制版）

> 我这次回国不是因为某一个 offer 临时起意，而是过去两年慢慢想清楚的。在美国做金融数据、LLM 评测和专家数据时，我越来越在意一个很具体的问题：一个模型怎么真正进入现实工作？任务谁来定义，什么算做对，专家的判断怎么留下来，做错以后又怎么改。
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

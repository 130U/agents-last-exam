# Validation record

Date: 2026-08-09

## Deliverable truth

- Primary editable report: `artifacts/ALE_Environment_Execution_Reference_Architecture_2026-08-09.docx`
- Primary text record: `2026-08-09_ALE_environment_execution_reference_architecture.md`
- Executable manifest contract: `environment_manifest.schema.yaml`
- The PDFs and PNGs under `rendered/` are QA artifacts, not the normative report.

## Research-package checks

- 74 source cards and 74 `sources.csv` rows.
- 72 cited source IDs; no citation points to a missing source card.
- All required report sections present: core conclusions, counterevidence, boundaries, recommendations, pilot/client variables, source table and refresh targets.
- Ruby YAML parser successfully loaded the manifest schema with 20 top-level keys.

## DOCX checks

- Microsoft Word opened and repaginated the final DOCX successfully: 42 pages.
- All 15 DOCX XML parts parsed successfully.
- Numbering definitions precede numbering instances; all numbering references resolve.
- 21 tables, 192 rows; every row has `cantSplit`; 19 data tables repeat their header row.
- The table-header orphan and cross-document numbering defects found during visual QA were corrected and rechecked.

## Visual QA and render boundary

- All 42 pages were inspected for content, table continuation, numbering, bottom clipping and blank pages.
- Page 1 and pages 4–42 were exported from the final DOCX page by page. Pages 2–3 use the unchanged static TOC render from the prior whole-document Word export because Word's PDF filter stalls on those range exports.
- Word's `FromTo` PDF export can omit the running header/top ma…1405 tokens truncated…Echo × 风险工程/金融/决策系统

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

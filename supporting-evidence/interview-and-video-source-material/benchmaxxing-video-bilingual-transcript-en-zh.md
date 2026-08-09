# When Will The Benchmaxxing Plague End?

**Speaker:** Nick Heiner, Surge AI  
**Channel:** AI Engineer  
**Duration:** 17:24  
**Source:** https://www.youtube.com/watch?v=-npY6XjM8CQ

> Note: The video provides no human-authored subtitles. The English text below is YouTube's auto-generated English (Original) track; the Chinese is YouTube's aligned Simplified Chinese machine translation. Obvious caption line breaks and whitespace have been cleaned, but wording has not been silently rewritten.

## 00:00

**English:** Let's get started. When will the benchmaxing plague end? In the tech industry, we love a hype cycle. And in AI, we really love a hype cycle. And the way we do that is when a model comes out, there's a big announcement, there's a lot of benchmark

**Chinese:** 我们开始吧。卧推极限的风气何时才能结束？在科技行业，我们喜欢炒作周期。 在人工智能领域，我们非常喜欢炒作周期。 我们的做法是，当一个模型问世时，会发布一个大型公告，并引用很多基准数据

## 00:30

**English:** cited. Sometimes to keep things interesting, we do a little chart crime. And then people actually go and use it. And if the expectations aren't met by the reality, then we have allegations of benchmaxing. Benchmaxing, of course, being when labs are training too hard on benchmarks in a way that deviates from what people actually care about. So the existence of that term indicates that we have a sense that benchmarks don't always equal reality. And so in

**Chinese:** 。 为了增加趣味性，我们有时会做一些图表上的小改动。然后人们真的会去使用它。如果现实与预期不符，就会出现“卧推达到极限”的指控。 当然，所谓“基准测试过度”，指的是实验室过度依赖基准测试进行训练，而偏离了人们真正关心的内容。因此，该术语的存在表明我们意识到，基准并不总是等于现实。 所以，在

## 01:00

**English:** this talk we're going to figure out why does benchmaxing happen? Why are traditional benchmarks not always accurate reflections of real world value? Is this intrinsic to all benchmarks? And will we ever know which models are best? And the answers are incentives, poor methodologies, no and yes. All right, that was my talk. Thank you so much for coming. Um actually it looks like I have a few extra minutes so let's let's move on. I have a few extra slides we'll we'll go through.

**Chinese:** 这次谈话中，我们将弄清楚为什么会出现卧推极限现象？ 为什么传统基准并不总是能准确反映现实世界的价值？ 这是所有基准测试的固有特性吗？ 我们最终会知道哪些模型是最好的吗？答案是激励机制、方法论不足、否以及是。 好了，我的演讲就到这里。 非常感谢你们的到来。 嗯，其实我好像还有几分钟空闲时间，那我们继续吧。 我还有一些额外的幻灯片，我们过一遍。

## 02:30

**English:** So we have a sense that benchmarks don't equal reality but the industry is dominated by a lot of popular but very bad benchmarks. So there's millions of dollars on prediction markets being wagered on Elm Marina outcomes even as we have industry leaders openly bragging about gaming Elm Marina and you have thought leaders like Wor saying it can be easily gamed. It's past time for the Elm Marina people to sit down and think about whether they're doing more harm than good.

**Chinese:** 因此，我们感觉基准测试结果并不等同于现实，但该行业却被许多流行但非常糟糕的基准测试所主导。 因此，尽管行业领袖公开吹嘘操纵 Elm Marina 的结果，但预测市场上仍有数百万美元的资金押注 Elm Marina 的结果，而像 Wor 这样的思想领袖则表示它很容易被操纵。埃尔姆码头的人们早就应该坐下来好好想想，他们这样做究竟是弊大于利还是利大于弊。

## 02:00

**English:** Andre Karpathy had a similar observation when he noticed that the models that he thought were best were not lining up with what Elmarina was ranking. He said unfortunately the teams are not getting better models overall but better Elm Marina models whatever that is possibly something with a lot of nested list bullet points and emojis. So why does this happen that sort of industry insiders are telling us that this benchmark is not useful but it still gets a lot of play. The problem is

**Chinese:** 安德烈·卡帕西也有类似的观察，他注意到他认为最好的模型与埃尔马里纳的排名并不一致。 他说，遗憾的是，各团队并没有获得更好的整体模型，而是获得了更好的 ElmMarina 模型，不管那是什么，它可能包含很多嵌套列表项目符号和表情符号。那么，为什么会出现这种情况呢？业内人士告诉我们，这个基准指标没有用，但它仍然被广泛使用。 问题在于

## 02:30

**English:** that AI is aimed at everyone in the world is is something everyone in the world can use. And so everyone needs some tool to figure out which models are best. And benchmarks are what we have for that. But if you can't if you don't have the ability to assess if a benchmark is good, what you do have is the ability to assess what's popular. And this creates this avalanche, this feedback effect where the conversation is very much driven by incumbency and marketing and less by real world value. and even myself, right? Like unless I

**Chinese:** 人工智能面向全世界所有人，因为全世界所有人都可以使用它。 因此，每个人都需要一些工具来确定哪些模型是最好的。 而基准就是我们为此所做的。 但是，如果你没有能力评估一个基准是否好，那么你还有能力评估什么是流行的。这就造成了雪崩效应和反馈效应，导致对话很大程度上受现有企业和市场营销驱动，而较少受现实世界价值驱动。甚至包括我自己，对吧？ 除非我

## 03:00

**English:** actually look at a benchmark in a fair amount of detail, I don't have an opinion on it. So, it's a very challenging problem. So, what are the things that benchmarks do that lead to these problems? There are a handful of key antiatterns that we're going to go through. The first is price. Let's say you want to make an agentic coding benchmark, which these days is a very popular thing to want to do, and you want a thousand tasks in your benchmark. Each task takes 60 hours to make. Each software engineer

**Chinese:** 仔细研究过某个基准测试，否则我不会发表意见。 所以，这是一个非常棘手的问题。那么，基准测试究竟做了什么才会导致这些问题呢？我们将探讨一些关键的反模式。首先是价格。 假设你想做一个智能体编码基准测试（如今这非常流行），并且你想在基准测试中包含一千个任务。 每项任务需要60个小时才能完成。

## 04:30

**English:** in your workforce costs half a million a year. That's $15 million to make your benchmark. And if you think that over time about a third of those tasks are going to get washed away every year due to models getting better, that's $5 million to replace them. So that puts you out of budget for most projects. So then people turn to a variety of workarounds that have their own problems. One of which is trying to use a lot of AI assistance which ultimately

**Chinese:** 你公司每位软件工程师每年的成本是五十万美元。 要达到你的基准目标，需要1500万美元。 如果你认为随着时间的推移，由于模型不断改进，每年大约有三分之一的任务会被淘汰，那么替换这些任务就需要 500 万美元。 这样一来，大多数项目都会超出预算。 因此，人们转而寻求各种变通方法，但这些方法本身也存在问题。 其中之一是尝试大量使用人工智能辅助，但最终效果

## 04:00

**English:** does not really work. Like you can't push the frontier forward from within the frontier. You need to inject that external human expertise and it needs to be good expertise. If you try to use cheap labor, you're going to get what you pay for and the whole result is not going to be that useful. At Surge, one of our differentiators has long been that we are not trying to minimize cost. We are trying to maximize quality and part of that means paying a lot of money for good workers.

**Chinese:** 并不理想。 就像你不能从边疆内部推动边疆向前发展一样。 你需要引入外部的人类专业知识，而且必须是高水平的专业知识。 如果你试图使用廉价劳动力，你就会得到一分钱一分货的结果，最终的结果也不会有什么用处。 在 Surge，我们的一大优势在于我们并不试图将成本降到最低。我们力求最大限度地提高产品质量，而这其中一部分意味着要花很多钱聘请优秀的工人。

## 04:30

**English:** We've always believed that but especially in 2026 models are just beyond the point where you can make do with anything less than the best workers. Contamination is often thought of as when labs are explicitly training on the test set and that does happen sometimes but really contamination is the default outcome unless you are very very good. So labs put a lot of effort into holding back this flood of data that's going to contaminate their models.

**Chinese:** 我们一直都这么认为，但尤其是在 2026 年，车型已经发展到必须使用最优秀员工的地步了。 人们通常认为污染是指实验室专门针对测试集进行训练，这种情况确实有时会发生，但实际上，除非你非常非常优秀，否则污染是默认结果。因此，各实验室投入大量精力来阻止这股会污染其模型的海量数据。

## 05:00

**English:** But inevitably if you have public questions and answers on the internet that's going to get memorized to some extent. So SweetBench verified here's an example prompt. You can give opus the first part of the prompt and it will verbatim spit out the rest. It does that with the answers as well. And we actually did an investigation where we compared looking at the repos that Sweepbench verified was built out of. How much has Opus memorized the

**Chinese:** 但不可避免地，如果你在互联网上公开提问和回答，那么这些问题和回答在某种程度上会被记住。 所以SweetBench验证了以下示例提示。 你可以给 Opus 提示的第一部分，它会原封不动地输出其余部分。 答案也同样如此。我们实际上进行了一项调查，对比查看了Sweepbench 验证其构建所用的代码库。 Opus 对

## 06:30

**English:** Sweepbench verified contents versus the rest of the repo? And we found very clear evidence that Opus had memorized a lot of Sweetbench. In the most recent model card, Opus 4.8 talks about its SWE score. It does not disclose this contamination. We as an industry aren't really in the habit of doing those disclosures. And so what that means is that as benchmarking consumers, we're just missing that information. Reward hacking is also a big problem. Reward hacking is basically when a model finds a lazy and creative way to meet

**Chinese:** Sweepbench 验证过的内容记忆了多少，对代码库其他部分记忆了多少？ 我们发现了非常确凿的证据，证明奥普斯记住了很多《甜蜜长椅》的内容。 在最新的显卡型号中，Opus 4.8 谈到了它的 SWE分数。 它并未披露这一污染情况。我们这个行业其实并没有进行这类信息披露的习惯。 所以这意味着，作为基准消费者，我们恰恰缺少这方面的信息。奖励机制被滥用也是一个大问题。奖励作弊本质上是指模特找到一种偷懒且富有创意的方法来满足

## 06:00

**English:** the letter of the law, but not the spirit. You need to think about designing your rewards as a adversarial process against this maximally lazy agent. Gradient descent is basically like water flowing downhill looking for the path of least resistance. And so your verifiers need to be robust to that. Another key challenge is simply just not having the ambition to make a sophisticated enough benchmark. Automation bench tests that agents are

**Chinese:** 法律条文的要求，但违背法律精神。 你需要将奖励设计成一种对抗这种极度懒惰的智能体的过程。 梯度下降基本上就像水向下流动，寻找阻力最小的路径一样。因此，你的验证器需要能够应对这种情况。另一个关键挑战在于缺乏制定足够完善的基准的雄心。自动化基准测试，验证代理程序是否

## 06:30

**English:** able to make tool calls in an enterprise environment. The problem is that a lot of the verifiers are these hard-coded string matches. And so you'll see it for things like phone numbers where there are many different acceptable phone number formats. But this verifier just picks one and the prompt doesn't tell you which one it is. So the result of this is that Haiku and Fable both score 20% on this task. Haiku scores 20% because it makes a bunch of mistakes and Fable scores 20% because it gets it right 80%

**Chinese:** 能够在企业环境中调用工具。问题在于，很多验证器都是硬编码的字符串匹配。 所以你会看到，像电话号码这样的东西，有很多不同的可接受的电话号码格式。 但是这个验证器只会随机选择一个，而且提示信息不会告诉你选的是哪一个。 因此，结果是Haiku 和 Fable 在这项任务中都获得了 20% 的分数。 Haiku 得分 20%，因为它犯了很多错误；Fable得分 20%，因为它 80% 的

## 07:00

**English:** of the time but then just happens to pick different formats. So if the benchmark task is not differentiating between Haiku and Fable, it's not a useful task. And more broadly, in 2026, many of us in this room are looking towards AI that's about to remake entire industries. And benchmarks are ideally our lighthouse on the horizon to let us know when that's coming. And a simple hard-coded string match is just not going to do it to measure that sort of impact.

**Chinese:** 时间都做对了，但碰巧选择了不同的格式。 因此，如果基准测试任务不能区分俳句和寓言，那么它就不是一个有用的任务。更广泛地说，在座的许多人都在展望 2026 年，人工智能将重塑整个行业。 理想情况下，基准就像地平线上的灯塔，告诉我们目标何时到来。 仅仅依靠简单的硬编码字符串匹配是无法衡量这种影响的。

## 08:30

**English:** Another important aspect of a good benchmark is taste. Perhaps it used to be the case that benchmarks were these dry academic, you know, questions. and answer sets. But nowadays, a benchmark is an artifact expressing what it's an aspirational artifact. It's an expression of values of what you want your AI to do and how you want it to behave. And so you need to have some product sense in this process, some sort of a sense of what you want the AI to do. And that sense is unfortunately missing from ifal

**Chinese:** 衡量一个好的基准的另一个重要方面是品味。 或许过去衡量标准是一些枯燥乏味的学术性问题。 以及答案集。 但如今，基准是一种表达其理想状态的产物。 它表达了你希望人工智能做什么以及你希望它如何表现的价值观。 因此，在这个过程中，你需要具备一定的产品意识，对你想让 AI 做什么有一定的了解。 而这种感觉在 ifal if 中却很遗憾地缺失了，ifal

## 08:00

**English:** if has been cited on many model cards. And the way it was constructed was taking a bunch of arbitrary prompts that no user has ever asked in earnest and mashing them up with a bunch of other prompts to create a prompt set. The problem is that because no user actually has asked do not use any commas in your response or use the letter T at most once. You have to believe for this to be useful, you have to believe that there's a generalization from this to actual things that users are going to ask.

**Chinese:** 已被引用在许多模型卡片上。它的构造方式是将一堆任意的、没有任何用户认真问过的提示与一堆其他提示混合在一起，从而创建一个提示集。问题在于，由于没有用户实际提出要求，因此请不要在回复中使用逗号，或者最多只能使用一次字母 T。你必须相信这一点，才能使它有用；你必须相信这一点可以概括为用户实际会提出的问题。

## 08:30

**English:** If eval just happens also to have a bunch of prompts that are fully unsolvable due to having contradictory instructions. So this one starts by saying repeat this response verbatim and it ends by saying translate this into Hindi. Obviously you can't do both of those at once. Here's one that says write a riddle that includes exactly one bullet point. Make sure to include a few bullet points. Again this is just fully impossible. It uses a sentence splitter that does

**Chinese:** 如果 eval 恰好还有一堆由于指令相互矛盾而完全无法解决的提示。 所以，这个指令开头是要求你逐字重复这个回答，结尾是要求你把这个翻译成印地语。 显然，你不可能同时做到这两件事。这里有一个题目，要求你写一个谜语，谜语中只能包含一个要点。务必列出几个要点。这完全不可能。它使用的句子分割器

## 09:00

**English:** not align with how humans would actually split the sentences. And a lot of the prompts are not fully verified. So this one says write a story. There's nothing in the verifier that checks that a story was written. It just checks that the asky character I is not used more than once, which means that all of these responses get a full score, including response D. The way it gets a full score is by reward hacking and using the cerrillic eye character instead of the asy eye character. If is

**Chinese:** 与人类实际分割句子的方式并不一致。而且很多提示信息都没有经过完全核实。 所以这个题目要求写一个故事。 验证器中没有任何功能可以检查故事是否已撰写。 它只是检查“天空”字符 I 是否被使用超过一次，这意味着所有这些回答都会获得满分，包括回答 D。它获得满分的方法是利用奖励漏洞，用“塞里尔之眼”字符代替“天空之眼”字符。 如果

## 10:30

**English:** totally fine with that another challenge is operational ability. Making a big benchmark requires a lot of QC work and plenty of organizations just don't make that investment. Apex is a rag benchmark where the agent is given files and then asked questions about them. And in some instances, what's in the file and then what's expected in the rubric don't line up. So an agent that does the thing that it's

**Chinese:** 完全可以接受这一点，那么另一个挑战就是操作能力。 制定一项重要的基准需要大量的质量控制工…7396 tokens truncated…0

for name, size, color, before, after in (
    ("Heading 1", 16, BLUE, 16, 8),
    ("Heading 2", 13, BLUE, 12, 6),
    ("Heading 3", 12, DARK_BLUE, 8, 4),
):
    style = doc.styles[name]
    set_style_font(style, size=size, color=color, bold=True)
    style.paragraph_format.space_before = Pt(before)
    style.paragraph_format.space_after = Pt(after)
    style.paragraph_format.keep_with_next = True

for list_name in ("List Bullet", "List Bullet 2", "List Number"):
    st = doc.styles[list_name]
    set_style_font(st, size=11)
    st.paragraph_format.space_after = Pt(8)
    st.paragraph_format.line_spacing = 1.167
doc.styles["List Bullet"].paragraph_format.left_indent = Inches(0.5)
doc.styles["List Bullet"].paragraph_format.first_line_indent = Inches(-0.25)
doc.styles["List Bullet 2"].paragraph_format.left_indent = Inches(0.75)
doc.styles["List Bullet 2"].paragraph_format.first_line_indent = Inches(-0.25)
doc.styles["List Number"].paragraph_format.left_indent = Inches(0.5)
doc.styles["List Number"].paragraph_format.first_line_indent = Inches(-0.25)

# Running header/footer.
header = section.header
hp = header.paragraphs[0]
hp.alignment = WD_ALIGN_PARAGRAPH.LEFT
hr = hp.add_run("ALE-STYLE BENCHMARK DELIVERY PLAN  |  EDITABLE WORKING DRAFT")
set_run_font(hr, size=8.5, bold=True, color=MID_GRAY)

footer = section.footer
fp = footer.paragraphs[0]
fp.alignment = WD_ALIGN_PARAGRAPH.RIGHT
fr = fp.add_run("Page ")
set_run_font(fr, size=9, color=MID_GRAY)
add_field(fp, "PAGE", "1")
fr2 = fp.add_run(" of ")
set_run_font(fr2, size=9, color=MID_GRAY)
add_field(fp, "NUMPAGES", "1")

# Memo masthead.
p = doc.add_paragraph()
p.paragraph_format.space_before = Pt(10)
p.paragraph_format.space_after = Pt(4)
r = p.add_run("DELIVERY DESIGN MEMO")
set_run_font(r, size=23, bold=True, color=BLACK)

p = doc.add_paragraph()
p.paragraph_format.space_after = Pt(14)
r = p.add_run("1,000 ALE-style Tasks: Scope Definition and Executable Production Plan")
set_run_font(r, size=14, color="373737")

for label, value in (
    ("Purpose", "Interview take-home / client delivery design"),
    ("Version", "v0.2 - editable working draft"),
    ("Date", "2026-08-08"),
    ("Reference", "Agents' Last Exam, arXiv:2606.05405v2"),
):
    p = doc.add_paragraph()
    p.paragraph_format.space_after = Pt(2)
    r1 = p.add_run(f"{label}: ")
    set_run_font(r1, bold=True)
    r2 = p.add_run(value)
    set_run_font(r2)

rule = doc.add_paragraph()
rule.paragraph_format.space_before = Pt(8)
rule.paragraph_format.space_after = Pt(10)
set_paragraph_border_bottom(rule, color=BLUE, size=12, space=3)

add_callout(
    doc,
    "SCOPE LOCK / 可修改项 01",
    "本方案把客户的“1,000 条”定义为 1,000 个通过验收的可运行 instances。其内部结构固定为：960 个不同的专业 workflows 各产生 1 个主实例，另加 40 个关键流程的受控变体。该定义对齐 ALE v2 的 workflow 规模，但不声称复制 ALE 的 960 个原始 workflows。",
    fill=PALE_YELLOW,
    accent="7F6000",
)

add_heading(doc, "Executive decision", 1)
add_body(doc, "这不是一个“生产一千条题目”的标注项目，而是一项测量系统建设工程。最终验收对象是可从干净环境启动、由 Agent 独立完成、能产出明确 artifact，并可被校准评分器复验的任务实例。")
add_body(doc, "ALE v2 的统计口径是 960 个 workflows 与 1,490 个 instances，二者不可混用。由于 ALE 只公开约 150 个任务，客户项目无法也不应以“复刻 ALE 私有题库”为目标；可执行目标应是建立一套与 ALE 同量级的 960-workflow 自有覆盖图，并交付 1,000 个已验收实例。")

add_heading(doc, "1. Deliverable definition", 1)
add_table(
    doc,
    ["交付池", "数量", "计数单位", "用途与规则"],
    [
        ("开发与校准集", "100", "独立 workflows / instances", "供客户理解格式、联调 harness、校准评分器；不得用于最终排名。"),
        ("私有最终测试集", "760", "独立 workflows / instances", "冻结后仅由受控评测服务访问；作为正式比较与验收主集。"),
        ("滚动替换储备", "100", "独立 workflows / instances", "用于题目泄漏、软件升级或评分器失效后的版本替换。"),
        ("关键流程变体", "40", "instances", "从高价值、高风险流程中选 40 个，各增加 1 个输入或约束变体，用于鲁棒性检查。"),
        ("最终合计", "1,000", "accepted instances", "对应 960 个不同 workflows；全部通过质量门槛后方可计入。"),
        ("生产候选池", "1,250", "candidate instances", "按 80% 最终通过率设置 25% 生产缓冲；未通过项进入返工或淘汰，不混入交付数。"),
    ],
    [1900, 900, 1700, 4860],
    first_col_bold=True,
)

add_callout(
    doc,
    "RATIONALE",
    "“至少覆盖 960 workflows”在本方案中的含义是：建立 960 个彼此独立、具有不同工作目标或交付物的客户工作流，而不是给 960 个 ALE 私有题目换写 prompt。仅替换数字、公司名或输入文件，不产生新的 workflow，只能计为 instance variant。",
    fill=PALE_GREEN,
    accent="375623",
)

add_heading(doc, "2. Coverage allocation: 13 clusters / 55 subdomains", 1)
add_body(doc, "项目采用 ALE 的 13 个行业集群、55 个子领域作为一级覆盖框架，再由客户业务优先级进行二次加权。960 个 workflows 的分配在第 2 周冻结，方法如下：")
add_numbered(doc, "为每个子领域设置 10 个 workflow 的最低覆盖量，共 550 个，防止高流量领域挤压长尾能力。")
add_numbered(doc, "剩余 410 个 workflow 使用加权分配公式：客户重要性 40% + 经济价值 30% + 当前能力缺口 20% + 环境可实现性 10%。每项按 1-5 分评分。")
add_numbered(doc, "采用最大余数法把 410 个整数名额分配到 55 个子领域；任何单一子领域不得超过总量的 8%，除非客户书面批准。")
add_numbered(doc, "每个子领域至少包含 3 类任务：信息获取/分析、工具操作/产出、复核/决策；避免把覆盖等同于职业名称罗列。")

add_callout(
    doc,
    "可修改项 02 / CLIENT INPUT REQUIRED",
    "第 1 周客户需要提交业务优先级、禁用领域、软件许可边界和数据隐私等级。若客户未提供，项目仍按上述公式启动，但所有权重与分配结果会作为第一项正式签字件，而不是隐藏假设。",
    fill=PALE_YELLOW,
    accent="7F6000",
)

add_page_break(doc)

add_heading(doc, "3. Task contract: every instance is an executable package", 1)
add_body(doc, "每个实例必须包含下列 12 个版本化组件，缺一项即不得进入最终 QC：")
for item in (
    "workflow_id 与 instance_id：分别标识专业流程和可运行变体；",
    "domain / subdomain / role 标签及覆盖配额来源；",
    "专家署名记录、资历验证和冲突声明；",
    "面向 Agent 的任务说明、成功标准和禁止事项；",
    "输入文件包、数据来源、许可、隐私和脱敏记录；",
    "操作系统、软件版本、账号权限和工具 manifest；",
    "可复现的环境快照与启动/重置脚本；",
    "专家参考产物或可接受结果集合；",
    "evaluate() 评分器、rubric 与各项权重；",
    "正例、负例、边界例和 reward-hacking 测试；",
    "dry-run 轨迹、缺陷记录、修订历史和审批人；",
    "split 标签、版本号、访问权限、泄漏状态和退役规则。",
):
    add_bullet(doc, item)

add_heading(doc, "4. Seven quality gates", 1)
add_table(
    doc,
    ["Gate", "责任人", "强制产出", "通过标准"],
    [
        ("G0 需求与覆盖", "Program Lead + Domain Lead", "workflow brief、配额映射", "目标、交付物、用户价值和边界均明确；不与现有 workflow 重复。"),
        ("G1 专家与来源", "Domain Lead + Legal/Privacy", "专家记录、来源清单", "资历通过；数据授权、隐私和许可无阻断项。"),
        ("G2 任务工程", "Task Engineer", "环境、工具、输入、reference", "从干净快照连续 3 次可启动；工具可用率 100%。"),
        ("G3 Prompt-Verifier 对齐", "Evaluation Engineer", "覆盖矩阵、评分器、测试集", "每项要求均被评分；每项评分均有 prompt 或成功标准依据。"),
        ("G4 工程师 dry-run", "Independent QA", "完整轨迹、缺陷单", "非作者可独立完成；无缺失上下文、阻断工具或隐藏人工步骤。"),
        ("G5 对抗与校准", "Red-team QA + SME", "负例、边界例、作弊测试", "reference=1.0；空/损坏输出≤0.1；关键错误不能获得高分。"),
        ("G6 最终验收", "Acceptance Committee", "签字记录、split/version", "所有缺陷关闭；复跑通过；权限和私有集状态正确。"),
    ],
    [900, 1900, 2500, 4060],
    first_col_bold=True,
)

add_callout(
    doc,
    "COUNTING RULE",
    "只有通过 G6 的任务才计入 1,000 个 accepted instances。待 QC、返工中、环境不可复现或仅有 prompt 没有评分器的项目全部不计数。",
    fill=PALE_RED,
    accent="9C0006",
)

add_heading(doc, "5. Evaluation strategy by output type", 1)
add_table(
    doc,
    ["输出类型", "主评分机制", "人工介入", "验收要求"],
    [
        ("客观可验证", "确定性代码 / artifact checks", "专家定义规则；QA 抽样 10%", "同一输出重复评分一致；关键错误有明确扣分。"),
        ("多解但可 rubric 化", "结构化 rubric + 部分确定性检查", "2 名专家独立复核校准集；分歧时第 3 人裁决", "评分边界经至少 20 个样本校准；专家与自动评分趋势一致。"),
        ("高度主观", "专业人士盲法成对比较", "每个比较由 3 名合格评审；2/3 一致，否则裁决", "隐藏模型身份与生成顺序；报告胜率、置信区间及评审一致率。"),
        ("高风险专业判断", "自动检查 + 专家否决权", "领域专家审查全部关键失败", "严重安全、法律或事实错误触发 fail-closed，不被平均分掩盖。"),
    ],
    [1700, 2600, 2600, 2460],
    first_col_bold=True,
)

add_body(doc, "ALE 的专家主要参与上游任务定义、参考结果和 rubric QC，运行时以自动评分为主。因此，本方案不把专家盲评当成所有任务的第六个统一步骤；它只用于主观质量或高风险判断确实决定任务成功的类别。")

add_page_break(doc)

add_heading(doc, "6. 24-week production plan", 1)
add_table(
    doc,
    ["阶段", "时间", "累计验收", "关键动作与退出条件"],
    [
        ("Define", "W1-W2", "0", "冻结 13/55 覆盖图、960 workflow 配额、数据政策、任务 schema 与验收标准。"),
        ("Pilot", "W3-W4", "50", "每个行业集群至少 3 个试点；验证 Windows/Linux 环境、评分器与 QC 工时。"),
        ("Calibrate", "W5-W8", "200", "完成 150 个新增验收；基于缺陷数据调整模板、rubric 和专家培训。"),
        ("Scale I", "W9-W14", "530", "每周验收 55 个；覆盖所有 55 个子领域；开始冻结私有测试集。"),
        ("Scale II", "W15-W20", "860", "继续每周验收 55 个；补齐长尾配额，完成对抗测试和候选淘汰。"),
        ("Close", "W21-W22", "1,000", "完成最后 140 个验收；冻结 760 私有、100 储备、40 变体的版本与权限。"),
        ("Audit & Handoff", "W23-W24", "1,000", "独立抽样复跑、缺陷清零、文档/环境/评分器交接和客户验收。"),
    ],
    [1400, 1000, 1200, 5760],
    first_col_bold=True,
)

add_callout(
    doc,
    "可修改项 03 / SCHEDULE BASELINE",
    "24 周是本方案的承诺基线。若客户要求更短周期，必须增加并行专家与工程产能，或减少 960 个独立 workflows 的覆盖要求；不能通过压缩 G3-G6 的质量门槛换取进度。",
    fill=PALE_YELLOW,
    accent="7F6000",
)

add_heading(doc, "7. Team and throughput model", 1)
add_table(
    doc,
    ["角色", "基线配置", "职责 / 产能依据"],
    [
        ("Program & benchmark design", "1 Program Lead + 1 Benchmark Architect", "范围、覆盖、客户决策、版本和验收口径。"),
        ("Domain governance", "13 Domain Leads", "每个行业集群 1 名负责人；管理专家资历、工作流去重和专业质量。"),
        ("Expert authors", "42 名并行作者 + reserve pool", "稳定期每人每周提交约 1.5 个候选实例，支持约 62-65 个候选/周。"),
        ("Task engineering", "10 Task Engineers", "环境、软件、输入包、reference 与自动化启动。"),
        ("Evaluation engineering", "4 Evaluation Engineers", "evaluate()、rubric、测试集、评分器校准和 reward-hacking 检查。"),
        ("Independent QA", "6 QA Reviewers", "dry-run、对抗测试、缺陷分级、返工验收和批次抽样。"),
        ("Infrastructure", "3 Engineers", "Windows/Linux 镜像、运行编排、日志、权限、成本和可复现性。"),
        ("Legal / privacy / security", "2 shared reviewers", "数据许可、PII、客户政策、私有集访问与泄漏响应。"),
        ("Acceptance committee", "5 人跨职能委员会", "G6 最终签字；与任务作者分离。"),
    ],
    [2350, 2250, 4760],
    first_col_bold=True,
)

add_callout(
    doc,
    "可修改项 04 / STAFFING BASELINE",
    "人员配置由每周 62-65 个候选、约 80% 最终通过率和 50-55 个验收量反推。若专家提交率或一次通过率低于基线，先启用 reserve pool 和返工专班，再调整最终日期。",
    fill=PALE_YELLOW,
    accent="7F6000",
)

add_heading(doc, "8. Operating dashboard", 1)
add_table(
    doc,
    ["指标", "红线 / 目标", "管理动作"],
    [
        ("Accepted instances", "W4=50; W8=200; W14=530; W20=860; W22=1,000", "每周按 workflow 与 instance 双口径报数。"),
        ("Distinct workflow coverage", "≥960，且 55 个子领域均达最低配额", "重复或仅换输入的条目降级为 variant，不计新 workflow。"),
        ("最终通过率", "≥80%（1,250 candidates → 1,000 accepted）", "连续两周低于 75% 时暂停扩量，定位缺陷来源。"),
        ("干净环境启动成功率", "3/3 dry-runs；批量运行 ≥99%", "失败任务退出私有池并回到 G2。"),
        ("Prompt-verifier coverage", "100% 要求被覆盖；0 项无依据评分", "任何未覆盖项阻断 G3。"),
        ("严重 false accept", "0", "发现即冻结相关评分器与同模板任务，启动横向审计。"),
        ("私有集泄漏", "0", "撤下、换入 reserve、追踪访问日志并更新版本。"),
        ("主观评审一致率", "三人评审 2/3 一致率 ≥80%", "低于阈值时重写 rubric、复训评审并重新校准。"),
    ],
    [2600, 3300, 3460],
    first_col_bold=True,
)

add_page_break(doc)

add_heading(doc, "9. Governance and handoff", 1)
for item in (
    "公共/开发集、私有最终集、滚动储备和变体池分别存储，使用独立访问组；",
    "每次运行固定 agent harness、模型版本、系统提示、工具、环境、预算、重试策略和评分器版本；",
    "私有题目只通过评测服务下发，任务源码、隐藏 reference 与评分器不进入模型运行环境；",
    "所有任务和输入包使用内容哈希、版本标签与不可变发布清单；",
    "每月扫描泄漏线索、软件失效、许可变化和评分器异常；触发条件满足即从 reserve 替换；",
    "客户交接包含覆盖矩阵、任务包、环境镜像、评分器、QC 证据、访问清单、运行手册和变更日志。",
):
    add_bullet(doc, item)

add_heading(doc, "10. What the client receives", 1)
add_table(
    doc,
    ["交付物", "内容", "验收证据"],
    [
        ("1,000 accepted task packages", "960 个独立 workflows + 40 个变体", "G6 签字、版本清单、内容哈希。"),
        ("Coverage map", "13 clusters / 55 subdomains / 960 workflow quotas", "配额公式、客户权重、缺口与完成状态。"),
        ("Executable environments", "Windows/Linux 镜像、软件与权限 manifest", "3 次干净启动记录、批量运行成功率。"),
        ("Calibrated evaluators", "确定性评分器、rubric、盲评协议与测试集", "正/负/边界例、false-accept 审计。"),
        ("Audit trail", "来源、专家、dry-run、缺陷、返工与审批记录", "可追溯到 workflow_id / instance_id。"),
        ("Private-set governance", "访问、版本、泄漏、轮换与退役制度", "权限清单、轮换储备、响应演练。"),
    ],
    [2400, 3900, 3060],
    first_col_bold=True,
)

add_callout(
    doc,
    "FINAL POSITION",
    "客户购买的不是一千个 prompt，而是一个包含 1,000 个已验收实例、960 个专业工作流、可运行环境、校准评分器、质量证据和私有集治理的完整测量系统。",
    fill=LIGHT_BLUE,
    accent=DARK_BLUE,
)

add_heading(doc, "Review markers / 可直接提出修改的位置", 1)
add_table(
    doc,
    ["标记", "当前锁定值", "可修改内容"],
    [
        ("可修改项 01", "1,000 instances = 960 workflows + 40 variants", "工作流与变体的数量关系、最终计数单位。"),
        ("可修改项 02", "55 子领域最低 10 个 + 410 加权分配", "客户权重、禁用领域、软件与数据边界。"),
        ("可修改项 03", "24 周", "里程碑、并行批次和客户验收窗口。"),
        ("可修改项 04", "42 位活跃专家作者及配套工程/QA 团队", "人员规模、内外部比例与并行度。"),
        ("可修改项 05", "验收 KPI 与主观评审阈值", "通过率、抽样率、一致率与 fail-closed 条件。"),
    ],
    [1700, 3900, 3760],
    first_col_bold=True,
)

add_heading(doc, "Sources and evidence boundary", 1)
p = add_body(doc, "1. Agents' Last Exam, arXiv:2606.05405v2: ")
add_hyperlink(p, "Version-pinned paper", "https://arxiv.org/html/2606.05405v2")
p = add_body(doc, "2. Official ALE repository: ")
add_hyperlink(p, "Official GitHub implementation", "https://github.com/rdi-berkeley/agents-last-exam")
p = add_body(doc, "3. Nick Heiner, Surge AI, When Will The Benchmaxxing Plague End?: ")
add_hyperlink(p, "Conference talk video", "https://www.youtube.com/watch?v=-npY6XjM8CQ")
p = add_body(doc, "4. Surge AI, Hemingway-bench methodology: ")
add_hyperlink(p, "Writing benchmark methodology", "https://surgehq.ai/blog/hemingway-bench-ai-writing-leaderboard")

add_body(doc, "Evidence boundary: ALE v2 reports 960 workflows and 1,490 instances, including 150 public, 1,017 private and 323 pending QC. The 1,000-task delivery allocation, 24-week schedule, staffing plan, pool split and acceptance thresholds in this memo are proposed project decisions created for the client scenario; they are not claims made by the ALE authors.", italic=True)

doc.save(OUT)
print(OUT.name)

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

**Chinese:** 完全可以接受这一点，那么另一个挑战就是操作能力。 制定一项重要的基准需要大量的质量控制工作，而很多组织根本不会进行这方面的投资。Apex 是一个粗略的基准测试，测试人员会收到文件，然后被问及有关文件的问题。 在某些情况下，文件中的内容与评分标准中的要求并不一致。 因此，如果一个代理执行了它

## 10:00

**English:** seeing in the ground truth is going to get a negative score. And a lot of the data in Apex is seemingly synthetically generated because it's full of obvious placeholder values or dates or places that don't exist. And so as a result, the model is more likely to develop eval awareness where it realizes that it's being tested which undermines the entire exercise. It also just takes you out of distribution from actual real world data to something that

**Chinese:** 在真实情境中看到的行为，那么它将得到负分。Apex 中的很多数据似乎都是人工生成的，因为它充满了明显的占位符值、日期或地点，而这些值、日期或地点根本不存在。因此，该模型更有可能发展出评估意识，意识到自己正在接受测试，从而破坏整个测试过程。 这也会让你脱离真实世界数据的范畴，转而接触一些

## 10:30

**English:** is obviously fake. So that's an overview of some of the key antiatterns that happen during benchmark creation. But benchmaxing is a two-way process and there are all sorts of fun things that labs can do to benchmax and that's what we're going to talk about next. So the the core value that we're all trying to get towards as human eval right AI exists to serve humans and so just having humans look at the responses

**Chinese:** 明显是虚假的数据。以上概述了基准测试创建过程中出现的一些关键反模式。但基准测试是一个双向过程，实验室可以做各种各样有趣的事情来达到基准测试的目标，接下来我们就要讨论这一点。所以，我们作为人类评估者所追求的核心价值是，人工智能的存在是为了服务于人类，因此，

## 11:00

**English:** and make ratings like that's what we care about. The problem is that human eval is very expensive. And so a lot of what benchmarks are doing is trying to get around that and you are trying to distill human preference into something more scalable and you're hoping you do that distillation in a way that's still sufficiently faithful to what human eval wants. But what this means is that inevitably there is a point where you can keep hill climbing on a benchmark and the human eval stays flat. And you can actually take it even further if you want where you keep hill

**Chinese:** 我们真正关心的是让人类来查看反馈并进行评分。 问题在于人工评估成本非常高。 因此，很多基准测试都在试图解决这个问题，试图将人类的偏好提炼成更具可扩展性的东西，并且希望这种提炼能够足够忠实地反映人类的评估需求。 但这意味着，不可避免地，当你不断攀登某个基准点时，人类的评价就会停滞不前。如果你愿意，你甚至可以更进一步，

## 12:30

**English:** climbing on a benchmark even as the human eval goes down. But if for whatever reason you think this is necessary for marketing or we have sort of organizational politics or incentives that are demanding this that's how it can end up happening. In this instance the prompt is what time is it? And the response is absolutely deranged. No human eval is ever going to choose this but El Marina puts it at the top of the leaderboard. So again, you have this divergence and if you're trying to benchmax, you just cannot care about

**Chinese:** 即使人类的评价下降，你仍然可以在基准线上不断攀升。 但是，如果出于某种原因，你认为这对于市场营销是必要的，或者我们有某种组织政治或激励机制要求这样做，那么最终就会发生这种情况。 在这种情况下，提示是“现在几点？” 而这种反应简直是疯了。 任何人工评测都不会选择这个，但 El Marina 却把它排在了排行榜榜首。 所以，这里又出现了这种分歧，如果你想达到卧推极限，就不能在意这一点

## 12:00

**English:** that. Another thing you can do that I've heard stories of is you can actually hire a crowdsource army to vote for you in Elmarina since Elmarina basically does no filtering of their workforce. And you might say, well, we anonym, you know, Elmarina anonymizes. So how are they going to know who to vote for? That's actually quite simple. You have your model include a watermark that tells the crowd who to vote for. There's also all sorts of things you can do with running your evals in conditions that are like not fully representative

**Chinese:** 。我还听说过一种方法，那就是你可以雇佣一支众包大军在埃尔马里纳为你投票，因为埃尔马里纳基本上不对其员工进行任何筛选。 你可能会说，嗯，我们匿名，你知道，Elmarina 会匿名化。 那么他们怎么知道该投票给谁呢？其实很简单。 你的模型包含一个水印，告诉大家应该投票给谁。此外，你还可以通过在与

## 12:30

**English:** of the applesto apples comparison you're trying to make and then not always being super transparent about those conditions in such a way that undermines the validity that the community is trying to interpret because they don't have that contextualizing information. This was a paper um again about Elmarina and talking about how some of the dynamics of how it's run lead to models overfitting on Elmarina. Um in this instance, the specific chart we're seeing is that Meta tested 27 models

**Chinese:** 你想要进行的同类比较并不完全具有代表性的条件下运行评估来进行各种操作，并且不总是对这些条件保持高度透明，从而削弱社区试图解读的有效性，因为他们缺乏这些背景信息。这篇论文再次谈到了 Elmarina，讨论了它的一些运行动态如何导致模型在 Elmarina 上过度拟合。 嗯，就目前的情况来看，我们看到的具体图表显示，Meta 测试了 27 个模型，但

## 13:00

**English:** without disclosing that it was doing so. Um which you know distorts the results. So how are we going to end benchmaxing? We need to hold the benchmark industry and the labs to a higher standard. The first thing we need to do when making a good benchmark is start with great human experts. And those experts inform everything that is downstream from what types of tasks are we going to

**Chinese:** 并未公开此事。嗯，你知道这会扭曲结果。那么我们该如何终结卧推极限呢？我们需要对标杆行业和实验室提出更高的标准。制定一个好的基准，首先要做的就是找到优秀的人类专家。 这些专家为后续所有环节提供信息，包括我们将让代理执行哪些类型的任务

## 14:30

**English:** have the agent do? How is success measured? What are the input files that agents are given? What are the tools that they're given? But we also do need that product sense. So imagine you're making a medical benchmark. It's not enough to have doctors who can answer specific medical questions because if you're trying to test how ready are we for agents to be deployed into hospitals. You also need someone with the business sense to know what's the regulatory environment, what's the legal requirements because that is going to impact what types of tasks you're trying to have the AI solve.

**Chinese:** ？ 如何衡量成功？代理需要输入哪些文件？ 他们被赋予了哪些工具？ 但我们也确实需要这种产品意识。 想象一下，你正在制定一项医学基准。 仅仅拥有能够回答具体医疗问题的医生是不够的，因为如果你想测试我们是否做好了将特工部署到医院的准备。你还需要有商业头脑的人来了解监管环境和法律要求，因为这将影响你试图让人工智能解决哪些类型的任务。

## 14:00

**English:** You need high fidelity input data which is best done by going out and getting it from the real world, having actual people create this data. Synthetic approaches are possible, but it is very very hard to do it reliably. The tools need to actually work. A lot of benchmarks have tools that are buggy in various ways. And unless you're intentionally making a benchmark about buggy tools, this just introduces noise. You need verifiers that are fully aligned with the prompts. And this is a two-way alignment. So the verifiers need

**Chinese:** 你需要高保真度的输入数据，而最好的方法是走出去，从现实世界中获取数据，让真实的人来创建这些数据。 合成方法是可行的，但要可靠地做到这一点非常非常困难。这些工具必须真正有效。 许多基准测试工具都存在各种各样的缺陷。 除非你是有意对有缺陷的工具进行基准测试，否则这只会引入噪音。你需要与提示完全一致的验证人员。 这是双向对齐。 因此，验证人员

## 14:30

**English:** to be verifying everything the prompt asks for. And everything the prompt asks for needs to be covered by the verifiers. And if you get either side of those two misaligned, then it's going to be unfair to models and you're introducing random noise. You need to thoroughly QC everything and you need to have a private hold out set so you don't get contaminated. And if you do all this right, then you'll avoid what often happens with benchmarks, which is when labs get to

**Chinese:** 需要验证提示中要求的所有内容。 提示中要求的所有内容都需要由验证人员进行核实。 如果这两个变量中的任何一个出现偏差，那么对模型就是不公平的，而且会引入随机噪声。你需要对所有东西进行彻底的质量控制，并且需要一套私有的备用样品，以免受到污染。如果你把所有这些都做对了，那么你就能避免基准测试中经常发生的情况，即实验室达到

## 15:00

**English:** like 80% and say, "Okay, this is saturated." And I used to think that saturation was just them saying again we don't think training on this further is going to increase real world value. And it often does mean that but it can mean that because the lab is saying we realize 20% of these tasks are broken. But the problem is that as you're hill climbing you don't know what 20% are broken until you solve all the others. And so as a result you have a lot of noise. And if that 20% of broken tasks

**Chinese:** 80% 左右时会说：“好了，这已经饱和了。” 我以前认为，所谓的“饱和”只是他们再次表示，我们认为继续进行这方面的培训不会增加实际价值。这通常意味着这一点，但也可能意味着实验室说我们意识到这些任务中有 20% 是错误的。但问题是，在爬山的过程中，你只有在解决了所有其他问题之后，才知道哪 20% 的问题出在了其他问题上。因此，结果就是噪音很大。 如果这 20% 的失败任务

## 16:30

**English:** is randomly but in a biased way assigning the rewards, it's going to really distort the model relative ranking you're trying to get. So at Serge, we created a benchmark called Hemingway bench to measure writing. There have been a number of writing benchmarks that use various mechanical means to try to assess writing quality, but we believe that writing is just too rich and deep and nuanced and frankly human of an activity to measure with mechanical benchmarks

**Chinese:** 是随机但有偏见地分配奖励的，那么就会严重扭曲你想要获得的模型相对排名。因此，在 Serge，我们创建了一个名为“海明威基准”的基准来衡量写作水平。 已经有很多写作基准使用各种机械方法来尝试评估写作质量，但我们认为写作太过丰富、深刻、微妙，坦白说，它是一种人性化的活动，无法用机械的基准来衡量，

## 16:00

**English:** and LM as a judge doesn't really work either because LLMs don't have good taste in writing. Again, this is sort of the you can't expand the frontier from within the frontier situation. So what we've done is we've just created a workforce of thousands of professional writers in various domains, technical writers, poets, journalists, editors, and we just have them do blind model comparisons and then we create this leaderboard and it is quite expensive, right? Human eval is very expensive. Getting the time of these professionals

**Chinese:** 而且以文学硕士作为评判者也不太奏效，因为法学硕士对写作没有很好的品味。 这又回到了“你不能从边疆内部扩展边疆”的情况。所以我们所做的就是，我们创建了一个由数千名各个领域的专业作家组成的队伍，包括技术作家、诗人、记者、编辑，我们让他们进行盲测模型比较，然后我们创建了这个排行榜，这相当昂贵，对吧？ 人工评估成本非常高。聘请这些专业人士的费用

## 16:30

**English:** is quite expensive. But again, our goal is to maximize quality, not to minimize costs. So in conclusion, benchmaxing is the exploitation of benchmark misalignments between human preference, but we can do better and we can hold the industry to a higher standard. Both the people making the benchmarks like myself and the people who are reporting on the benchmarks. And if you'd like to be a part of that, of course, obligatory pitch at Serge, we're hiring for basically all aspects of that. Uh and if

**Chinese:** 相当昂贵。 但是，我们的目标是最大限度地提高质量，而不是最大限度地降低成本。总之，基准测试过度利用了人类偏好与基准测试之间的偏差，但我们可以做得更好，我们可以要求行业达到更高的标准。 既包括像我这样制定基准的人，也包括报告基准结果的人。 当然，如果您想参与其中，Serge 的招标环节是必不可少的，我们基本上在所有方面都在招聘。 呃，如果

## 17:00

**English:** you'd like more spicy takes from me, uh please follow my substack. Thank you very much.

**Chinese:** 你想看我更多犀利的观点，呃，请关注我的 Substack 账号。非常感谢。


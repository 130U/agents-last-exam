# “1,000 道”应该直接问，还是讨论两种情况？

## 最终建议

**问，但不要裸问；也不要等答案。**

向 GS 发送一条带默认方案的确认消息，同时继续写作业。正文采用一个主假设，另一种口径只做半页以内的敏感性说明，不写成两套平行方案。

## 为什么

ALE 论文已经说明，workflow 与 instance 不是必须二选一的两个项目方案：一个 `task workflow` 是端到端专业流程，一个 `task instance` 是该 workflow 下的一组具体、可运行、可评分的 input/output 案例。论文快照为 960 个 workflows、1,490 个 instances。

因此更专业的项目定义是：

> 1,000 道 = 1,000 个通过最终 QC、可以独立运行和评分的 task instances；这些 instances 分布在多个真实 workflows 下。允许受控 variants，但不能靠单一 workflow 机械换数据凑数。

具体 workflow/instance 比例应通过 pilot 校准，不能直接照搬 ALE 的历史比例。

## 推荐发给 GS 的版本

> GS 您好，我在拆 ALE 的千题方案时，注意到官方区分 task workflow 和 task instance：一个 workflow 可以对应多个共享 evaluator、但输入和 reference 不同的 runnable instances。为了统一交付口径，我准备先把“1,000 道”定义为 1,000 个可独立运行、独立评分、通过最终 QC 的 task instances，并通过 workflow 配额和重复上限保证多样性；不是要求 1,000 个完全不同 workflows，也不是简单换数据凑数。想确认一下，这个口径是否符合您的预期？我会先按此前提推进，并在方案中简要说明如果按 1,000 个 distinct workflows 计数，对专家配置、周期、成本和质检的影响。

关键是“我会先按此前提推进”：它把问题变成校准，而不是把判断交回对方。

## 如果不方便再联系 GS

在作业第一页直接写：

> **口径假设：**本方案中的 1,000 道，指 1,000 个通过最终 QC、可独立运行并产生独立评分的 task instances。它们隶属于多个 task workflows；同一 workflow 下的 instances 可以共享 evaluator，但必须具有实质不同的输入与 reference，不能只是措辞或数值替换。workflow/instance 比例将在 pilot 后依据覆盖度、成本与 grader 复用程度确定。

随后在正文或附录用一个小框说明：

- 如果客户要求 1,000 个 distinct workflows：专家创作、环境实现、grader 开发和 QC 成本都会显著提高，周期需要重估。
- 如果允许更多 instances 复用 workflow：工程效率更高，但必须用 workflow 覆盖率、重复上限与实质差异规则防止数据注水。

到此即可，不需要写两份完整项目计划。

## 什么时候一定要问清楚

- 本次面试作业：建议问一次，但不要因此停工。
- 真实项目报价、SOW、排期或验收前：必须书面确认。


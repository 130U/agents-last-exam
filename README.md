# Agents' Last Exam

面向客户私有 ALE-style benchmark 的完整研究与交付设计。研究对象不是裸模型，而是由模型、harness、prompt、工具、GUI/CLI、环境、预算策略、evaluator、hidden reference 与运行证据共同构成的 configured agent system。

## 交付入口

- [外部交付短报告（Markdown）](core/00-executive-deliverables/final/ale-private-benchmark-interview-brief-2026-08-09.md) — 面向快速阅读的核心结论与实施框架。
- [外部交付短报告（Word）](core/00-executive-deliverables/final/ale-private-benchmark-interview-brief-2026-08-09.docx) — 可下载、可编辑的正式交付版本。
- [完整技术报告](https://github.com/130U/agents-last-exam/blob/codex/ale-deliverable-draft-v1/core/00-executive-deliverables/drafts/ale-private-clone-960-workflows-1490-instances-delivery-report-draft-v3-2026-08-09.md) — 汇总版本口径、任务生产、评分、运行、统计与持续治理。

## 核心研究与交付设计

01–10 模块构成一条完整的 benchmark 生产路线：定义产品与测量对象，审计证据和任务组合，建立专家生产、评分与执行系统，最后进入统计验证和持续发布治理。

| 模块 | 展示内容 |
| --- | --- |
| [01 · 范围与产品定义](core/02-1000-task-delivery-design/01-scope-and-product-definition/) | 定义客户决策问题、交付单位、访问与权利边界、成本驱动因素，以及必须通过 pilot 校准的项目变量。 |
| [02 · ALE 蓝图与版本审计](core/02-1000-task-delivery-design/02-ale-blueprint-and-version-audit/) | 拆解 configured agent system，固定论文、代码与数据 revision，并给出最小任务 schema、运行链路和证明边界。 |
| [03 · 公共任务语料审计](core/02-1000-task-delivery-design/03-public-task-corpus-audit/) | 按 task、evaluator、revision 和计数单位审计公共语料，记录覆盖缺口、评分原型与典型失效模式。 |
| [04 · 相邻 Benchmark Landscape](core/02-1000-task-delivery-design/04-adjacent-benchmark-landscape/) | 对比 16 个相邻 benchmark 的真实性、覆盖、自动化与可扩展性，提炼可复用的生产设计。 |
| [05 · Portfolio 与抽样策略](core/02-1000-task-delivery-design/05-portfolio-and-sampling-strategy/) | 设计任务组合矩阵、分层抽样、holdout、覆盖约束和 allocation 变量，避免用公开均值替代客户 pilot。 |
| [06 · 专家生产治理](core/02-1000-task-delivery-design/06-expert-production-governance/) | 覆盖专家画像、RACI/COI、Golden Case、Batch Zero、QA gate、返工机制与不可变生产谱系。 |
| [07 · Evaluator 有效性与评分完整性](core/02-1000-task-delivery-design/07-evaluator-validity-and-integrity/) | 检查可执行 scoring path，并用 alternate-correct、known-bad、adversarial、replay 与 regression 测试评估误判和重评影响。 |
| [08 · 环境与执行参考架构](core/02-1000-task-delivery-design/08-environment-execution-reference-architecture/) | 设计 GUI/CLI、权限与凭据、环境 manifest、运行 artifact、可复现执行、恢复和审计链路。 |
| [09 · Living Benchmark 治理](core/02-1000-task-delivery-design/09-living-benchmark-governance/) | 定义版本化 release state、污染监测、轮换与退役、bridge evidence，以及跨版本可比性边界。 |
| [10 · 统计与 Matched-Human 协议](core/02-1000-task-delivery-design/10-statistical-and-matched-human-protocol/) | 明确 estimand、预注册分析、seed/trial/retry、匹配人类基线、置信区间、不确定性与敏感性分析。 |

## 基础与审计材料

- [项目背景与问题框架](core/00-project-context/) — 从公开榜单失真与 benchmaxxing 问题进入客户私有 benchmark 的测量需求。
- [ALE 基础研究](core/01-ale-foundations/) — 初学者解释、双语深读、版本差异以及 13 domains / 55 subdomains taxonomy。
- [全部核心材料](core/) — 最终交付、项目语境、ALE foundations 与 01–10 生产系统研究。
- [所有支持性材料](supporting-evidence/) — source archive、研究包、审计记录、构建脚本和可追溯证据。

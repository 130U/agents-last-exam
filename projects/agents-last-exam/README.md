# Agents' Last Exam (ALE)

本项目研究如何把 ALE 的公开 benchmark 设计转化为可审计的 agent evaluation 方法与客户私有 ALE-style benchmark 交付方案。测量对象不是裸模型，而是由模型、harness、prompt、工具、GUI/CLI、环境、预算策略、evaluator、hidden reference 与运行证据共同构成的 configured agent system。

本仓库不是 ALE 官方实现，也不表示已经生产完成 1,000 个 runnable instances。

## 交付入口

- [外部交付短报告（Markdown）](../../core/00-executive-deliverables/final/ale-private-benchmark-interview-brief-2026-08-09.md) — 面向快速阅读的核心结论与实施框架。
- [外部交付短报告（Word）](../../core/00-executive-deliverables/final/ale-private-benchmark-interview-brief-2026-08-09.docx) — 可下载、可编辑的正式交付版本。
- [ALE benchmark 短报告](../../core/00-executive-deliverables/ale-benchmark-short-report-2026-08-08.md) — 概括测评对象、能力边界、指标与版本口径。
- [1,000-task 可编辑交付计划（Word）](../../core/00-executive-deliverables/ale-1000-task-delivery-plan-editable.docx) — 面向项目规划与讨论的可编辑材料。

## 核心研究与交付设计

01–10 模块构成一条完整的 benchmark 生产路线：定义产品与测量对象，审计证据和任务组合，建立专家生产、评分与执行系统，最后进入统计验证和持续发布治理。

| 模块 | 展示内容 |
| --- | --- |
| [01 · 范围与产品定义](../../core/02-1000-task-delivery-design/01-scope-and-product-definition/decision-report-2026-08-08.md) | 定义客户决策问题、交付单位、访问与权利边界、成本驱动因素，以及必须通过 pilot 校准的项目变量。 |
| [02 · ALE 蓝图与版本审计](../../core/02-1000-task-delivery-design/02-ale-blueprint-and-version-audit/technical-blueprint-2026-08-08.md) | 拆解 configured agent system，固定论文、代码与数据 revision，并给出最小任务 schema、运行链路和证明边界。 |
| [03 · 公共任务语料审计](../../core/02-1000-task-delivery-design/03-public-task-corpus-audit/public-corpus-audit-report.md) | 按 task、evaluator、revision 和计数单位审计公共语料，记录覆盖缺口、评分原型与典型失效模式。 |
| [04 · 相邻 Benchmark Landscape](../../core/02-1000-task-delivery-design/04-adjacent-benchmark-landscape/landscape-report-2026-08-08.md) | 对比 16 个相邻 benchmark 的真实性、覆盖、自动化与可扩展性，提炼可复用的生产设计。 |
| [05 · Portfolio 与抽样策略](../../core/02-1000-task-delivery-design/05-portfolio-and-sampling-strategy/portfolio-and-sampling-strategy-report.md) | 设计任务组合矩阵、分层抽样、holdout、覆盖约束和 allocation 变量，避免用公开均值替代客户 pilot。 |
| [06 · 专家生产治理](../../core/02-1000-task-delivery-design/06-expert-production-governance/expert-production-governance-report-2026-08-09.md) | 覆盖专家画像、RACI/COI、Golden Case、Batch Zero、QA gate、返工机制与不可变生产谱系。 |
| [07 · Evaluator 有效性与评分完整性](../../core/02-1000-task-delivery-design/07-evaluator-validity-and-integrity/evaluator-validity-and-scoring-integrity-report-2026-08-09.md) | 用 alternate-correct、known-bad、adversarial、replay 与 regression 测试评估误判和重评影响。 |
| [08 · 环境与执行参考架构](../../core/02-1000-task-delivery-design/08-environment-execution-reference-architecture/environment-execution-reference-architecture-report-2026-08-09.md) | 设计 GUI/CLI、权限与凭据、环境 manifest、运行 artifact、可复现执行、恢复和审计链路。 |
| [09 · Living Benchmark 治理](../../core/02-1000-task-delivery-design/09-living-benchmark-governance/living-benchmark-governance-report-2026-08-09.md) | 定义版本化 release state、污染监测、轮换与退役、bridge evidence，以及跨版本可比性边界。 |
| [10 · 统计与 Matched-Human 协议](../../core/02-1000-task-delivery-design/10-statistical-and-matched-human-protocol/statistical-and-matched-human-protocol-2026-08-09.md) | 明确 estimand、预注册分析、seed/trial/retry、匹配人类基线、置信区间、不确定性与敏感性分析。 |

## 基础研究

- [项目背景与问题框架](../../core/00-project-context/benchmaxxing-interview-hook-brief-2026-08-08.md)
- [ALE 初学者解释](../../core/01-ale-foundations/ale-beginner-explainer-2026-08-05.md)
- [ALE 双语深读与六问分析](../../core/01-ale-foundations/ale-bilingual-deep-reading-and-six-question-analysis.md)
- [13 domains / 55 subdomains taxonomy](../../core/01-ale-foundations/ale-taxonomy-13-domains-55-subdomains-2026-08-06.md)

## 证据与治理

- [全部核心材料](../../core/)
- [支持性材料与研究归档](../../supporting-evidence/README.md)
- [上传状态与公开边界](../../supporting-evidence/UPLOAD_MANIFEST.md)
- [仓库架构](../../docs/REPOSITORY_ARCHITECTURE.md)
- [发布与隐私边界](../../docs/PUBLICATION_AND_PRIVACY_BOUNDARY.md)

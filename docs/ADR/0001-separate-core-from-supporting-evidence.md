# ADR 0001: Separate core deliverables from supporting evidence

- Status: Accepted
- Date: 2026-08-09

## Context

ALE 1,000-task 项目同时产生最终论证、生产设计、深度研究包、字幕、来源快照和辅助材料。若全部平铺，阅读者难以区分“已经采纳的结论”与“用于支持或挑战结论的证据”，也难以判断哪些文件应该进入面试交付。

## Decision

使用两个稳定内容区：

- `core/` 保存经过综合、可直接用于交付的材料；
- `supporting-evidence/` 保存来源、审计轨迹和辅助研究。

治理文件和自动化独立放在 `docs/`、`scripts/` 与 `.github/`。材料默认先进入 supporting evidence，通过 promotion gate 后再进入 core。两区通过相对链接关联，不复制同一内容。

## Consequences

正面影响：

- 主要阅读路径更短；
- 原始证据仍可追溯；
- review 可以针对“结论质量”与“证据完整性”分别进行；
- 后续替换来源或退役结论时影响面更清楚。

成本与约束：

- 维护者必须判断材料的状态；
- 提升或退役内容需要更新交叉链接；
- supporting evidence 不能成为无治理的文件堆积区；
- 公开证据区仍不适合保存私有 evaluator、hidden reference 或受限数据。

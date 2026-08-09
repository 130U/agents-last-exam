# Repository architecture

## Objective

把高密度最终结论与完整研究证据分开，同时让每个进入交付层的结论可以追溯、复核和更新。

```text
external sources
      │
      ▼
supporting-evidence/ ──► synthesis and review ──► core/
      │                                            │
      └──────── provenance and audit trail ────────┘
                         │
                         ▼
            final report / interview delivery
```

## Content zones

### `core/`

这是决策与交付层。文件应满足：

- 有明确使用场景；
- 关键事实固定 source version；
- 事实、推断、建议和假设可区分；
- 与其他核心文件没有未解释的口径冲突；
- 对 ALE-style runnable asset 的组成与计数单位表述一致。

当前子区：

- `00-executive-deliverables/`：短报告、最终架构、可编辑交付件；
- `00-project-context/`：面试意图、任务边界与 hook；
- `01-ale-foundations/`：ALE 基础解释、深读与 taxonomy；
- `02-1000-task-delivery-design/`：01–10 生产系统研究。

### `supporting-evidence/`

这是证据与复核层。可以保存完整研究包、来源快照、字幕、生成脚本和辅助研究。材料进入该区不代表其结论已经获得最终采纳。公开仓库中的任何证据仍必须满足权利、隐私与保密要求。

### `docs/`, `scripts/`, `.github/`

这是治理与自动化层：

- `docs/` 解释规则以及为何这样设计；
- `scripts/` 提供本地可重复检查；
- `.github/` 将相同规则嵌入协作流程。

## Source-of-truth rules

- 仓库级 source pins：`repository-manifest.json`。
- 本地来源到 GitHub 路径映射：`supporting-evidence/UPLOAD_MANIFEST.md`。
- 某个报告的具体证据：报告内引用、source index 或 claim-to-source map。
- 二进制可编辑交付件：对应 Markdown 内容或生成脚本优先作为审阅面。

当来源冲突时，不取平均值。建立 source/version/unit ledger，检查可执行 scoring path，并明确采用哪个版本及原因。

## What this repository is not

- 不是 ALE 官方实现或镜像；
- 不是已经生产完成的 1,000 个 runnable instances；
- 不是私有 evaluator、hidden reference 或 client data 的存储位置；
- 不是本地 Prework 目录的逐字节备份；
- 不是因公开可见而自动开源的内容库。

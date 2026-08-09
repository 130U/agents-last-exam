# Agents' Last Exam — 1,000-Task Delivery Research

[![Repository quality](https://github.com/130U/agents-last-exam/actions/workflows/repository-quality.yml/badge.svg)](https://github.com/130U/agents-last-exam/actions/workflows/repository-quality.yml)

本仓库沉淀 UniPat 面试任务中“如何领导生产 1,000 道 ALE 风格任务”的研究、生产治理与最终交付材料。它不是 ALE 官方仓库，也不是 1,000 个任务实例本身；当前交付重点是一套可执行的生产与治理方案。

## 从哪里开始

1. [ALE benchmark 短报告](core/00-executive-deliverables/ale-benchmark-short-report-2026-08-08.md)
2. [最终报告结构](core/00-executive-deliverables/report-architecture/synthesis-and-report-architecture-2026-08-09.md)
3. [1,000-task 可编辑交付计划](core/00-executive-deliverables/ale-1000-task-delivery-plan-editable.docx)
4. [01–10 生产系统研究](core/02-1000-task-delivery-design/)
5. [仓库架构与内容边界](docs/REPOSITORY_ARCHITECTURE.md)

## Repository map

| 路径 | 用途 | 准入标准 |
| --- | --- | --- |
| `core/` | 可直接进入最终报告、答辩或项目设计的核心材料 | 结论清楚、版本口径明确、关键主张可追溯 |
| `supporting-evidence/` | 研究包、字幕、来源材料、构建脚本与辅助研究 | 保留溯源价值，但不直接代表最终结论 |
| `docs/` | 仓库治理、内容生命周期、发布清单和架构决策 | 修改仓库规则时同步更新 |
| `scripts/` | 无第三方依赖的仓库质量检查 | 本地与 CI 使用同一入口 |
| `.github/` | CODEOWNERS、Issue/PR 模板和 Actions | 最小权限、可审计 |

完整的本地来源映射和暂未上传的大体积研究包见 [上传清单](supporting-evidence/UPLOAD_MANIFEST.md)。

## 固定研究口径

仓库级机器可读口径位于 [`repository-manifest.json`](repository-manifest.json)。当前 ALE 基线固定为：

- 论文：`arXiv:2606.05405v2`
- 官方代码：`rdi-berkeley/agents-last-exam@1e615e456de7cef57706680613cb80ee13c7fc76`
- Hugging Face 数据修订：`a8c1fd174a1f6cfa76526572a2e3ebece1276be2`

后续更新不得静默覆盖这些口径；应记录新旧版本、访问日期、计数单位和影响范围。

## 本地校验

仓库的质量检查仅依赖 Python 标准库：

```bash
python scripts/validate_repository.py
```

校验覆盖必要文件、顶层目录、清单结构、本地 Markdown 链接、零字节文件、文件大小和常见凭据模式。Pull Request 与目标分支推送会运行相同检查。

## 内容维护

- 新研究先进入 `supporting-evidence/`；只有形成可辩护结论后才提升到 `core/`。
- 文件名使用英文 kebab-case；有时间语义的报告使用 `YYYY-MM-DD`。
- workflow、runnable instance、submission、release 与 run 的计数必须分开。
- 二进制文档要同时保留可审阅的 Markdown 或生成脚本（如适用）。
- 变更流程见 [`CONTRIBUTING.md`](CONTRIBUTING.md)，发布前执行 [release checklist](docs/RELEASE_CHECKLIST.md)。

## 权利与安全边界

本仓库尚未选择统一开源许可证。公开可见不等于获得复用许可，详见 [`LICENSE_POLICY.md`](LICENSE_POLICY.md)。不要提交客户数据、个人信息、凭据、私有 evaluator、隐藏 reference 或未获授权的材料；安全问题按 [`SECURITY.md`](SECURITY.md) 处理。

## Source preservation

原始本地文件未被移动、重命名或改写。当前重命名、分区与压缩包仅发生在 GitHub 交付层。

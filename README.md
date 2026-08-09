# Agents' Last Exam — Private Benchmark Delivery Research

[![Repository quality](https://github.com/130U/agents-last-exam/actions/workflows/repository-quality.yml/badge.svg)](https://github.com/130U/agents-last-exam/actions/workflows/repository-quality.yml)

这是完整研究仓库：保存 ALE-style 私有 benchmark 的版本审计、产品定义、生产治理、evaluator、执行环境、统计、人类基线、living governance 与最终交付材料。它不是 ALE 官方仓库，也不包含真实的 960/1,490 个任务资产。

面向外部读者时，只应从 `core/00-executive-deliverables/final/` 进入；`supporting-evidence/` 是推导与审计层，不是默认展示层。

## 从哪里开始

1. [外部交付短报告（Markdown）](core/00-executive-deliverables/final/ale-private-benchmark-interview-brief-2026-08-09.md)
2. [外部交付短报告（Word）](core/00-executive-deliverables/final/ale-private-benchmark-interview-brief-2026-08-09.docx)
3. [完整技术报告（研究分支）](https://github.com/130U/agents-last-exam/blob/codex/ale-deliverable-draft-v1/core/00-executive-deliverables/drafts/ale-private-clone-960-workflows-1490-instances-delivery-report-draft-v3-2026-08-09.md)
4. [01–10 生产系统研究](core/02-1000-task-delivery-design/)
5. [仓库架构与内容边界](docs/REPOSITORY_ARCHITECTURE.md)

## Repository map

| 路径 | 用途 | 准入标准 |
| --- | --- | --- |
| `core/` | 可直接进入最终报告、答辩或项目设计的核心材料 | 结论清楚、版本口径明确、关键主张可追溯 |
| `supporting-evidence/` | 研究包、字幕、来源材料、构建脚本与辅助研究 | 保留溯源价值，但不直接代表最终结论 |
| `docs/` | 仓库治理、内容生命周期、发布/隐私边界和架构决策 | 修改仓库规则时同步更新 |
| `scripts/` | 无第三方依赖的仓库质量检查 | 本地与 CI 使用同一入口 |
| `.github/` | CODEOWNERS、Issue/PR 模板和 Actions | 最小权限、可审计 |

研究包边界和暂未上传的大体积归档见 [上传清单](supporting-evidence/UPLOAD_MANIFEST.md)。

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

校验覆盖必要文件、顶层目录、清单结构、治理文档的本地 Markdown 链接、零字节文件、文件大小和常见凭据模式。核心研究报告中指向未公开完整研究包的历史相对链接不作为 CI gate。Pull Request 与目标分支推送会运行相同检查。

## 内容维护

- 新研究先进入 `supporting-evidence/`；只有形成可辩护结论后才提升到 `core/`。
- 文件名使用英文 kebab-case；有时间语义的报告使用 `YYYY-MM-DD`。
- workflow、runnable instance、submission、release 与 run 的计数必须分开。
- 二进制文档要同时保留可审阅的 Markdown 或生成脚本（如适用）。
- 变更流程见 [`CONTRIBUTING.md`](CONTRIBUTING.md)，发布前执行 [release checklist](docs/RELEASE_CHECKLIST.md)。

## 权利与安全边界

本仓库尚未选择统一开源许可证。公开可见不等于获得复用许可，详见 [`LICENSE_POLICY.md`](LICENSE_POLICY.md)。不要提交客户数据、个人信息、凭据、私有 evaluator、隐藏 reference 或未获授权的材料；安全问题按 [`SECURITY.md`](SECURITY.md) 处理。

### 隐私红线

私人面试录音、逐字稿、个人简历与岗位决策材料不得进入本公开仓库，哪怕它们曾参与研究问题的形成。公开报告只能保留已经抽象化、可独立辩护的技术问题与结论。完整规则见 [publication and privacy boundary](docs/PUBLICATION_AND_PRIVACY_BOUNDARY.md)。

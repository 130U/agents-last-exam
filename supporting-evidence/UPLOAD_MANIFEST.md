# Upload manifest and public-repository boundary

更新日期：2026-08-09  
目标仓库：`130U/agents-last-exam`  
整理分支：`codex/organize-ale-project-files`

## 1. 已进入核心区

- 外部交付：结论层 Markdown、可编辑 Word 与完整技术报告。
- 项目背景：公开来源支持的 benchmaxxing hook、ALE 范围与产品定义；不保存私人面试逐字稿。
- ALE 基础：初学者解读、中英精读、13×55 taxonomy audit。
- 最终交付：短报告、最终报告架构、deep-research prompts、可编辑 DOCX 及生成脚本。
- 生产设计 01–10：scope、ALE blueprint、public corpus、adjacent benchmarks、portfolio、expert production、evaluator integrity、execution environment、living benchmark governance、statistics and matched-human protocol。
- 关键可复用附件：task minimum schema、environment manifest schema、validation、QA、source manifest 与 claim-source map。

## 2. 已进入支持区

完整 ZIP 研究包：

- `ale-benchmark-research-outline-and-results.zip`
- `agents-last-exam-paper-research.zip`
- `ale-beginner-deep-read.zip`
- `ale-bilingual-paper-reading-and-taxonomy-figure.zip`
- `ale-taxonomy-audit.zip`
- `interview-hook-research.zip`
- `final-report-architecture-and-deep-research-prompts.zip`
- `01-scope-and-product-definition-full-research-package.zip`
- `02-ale-blueprint-and-version-audit-full-research-package.zip`
- `04-adjacent-benchmark-landscape-full-research-package.zip`

逐文件材料：

- 英中双语视频稿、英文自动字幕、中文机器翻译字幕与生成脚本。
- 辅助界面研究；不作为 benchmark 结论或外部展示入口。
- 主要报告的 Markdown、DOCX、schema、QA 和 validation。

## 3. 大体积完整包：本次 PR 未附带

以下 ZIP 已在临时 staging 中完成，但 GitHub 插件的大文件传输通道未能接收；其主要结论和可编辑主文档已经逐文件进入 `core/`：

- `03-public-task-corpus-audit-full-research-package.zip` — 82,776,700 bytes
- `05-portfolio-and-sampling-strategy-full-research-package.zip` — 44,965,001 bytes
- `06-expert-production-governance-full-research-package.zip` — 13,802,931 bytes
- `07-evaluator-validity-and-integrity-full-research-package.zip` — 40,594,397 bytes
- `08-environment-execution-reference-architecture-full-research-package.zip` — 77,326,102 bytes
- `09-living-benchmark-governance-full-research-package.zip` — 48,918,024 bytes
- `10-statistical-and-matched-human-protocol-full-research-package.zip` — 84,778,925 bytes
- `delivery-plan-word-render-and-visual-qa.zip` — 2,647,650 bytes

这些包包含大量重复上游仓库快照、嵌套 `.git` objects、`node_modules`、逐页渲染图和 QA 中间产物。它们适合审计归档，不适合成为默认阅读入口。

## 4. 未公开项目

- 私人面试录音、逐字稿、作业原话、个人简历、岗位比较与由其直接生成的研究包：禁止进入公开 GitHub 仓库。
- `tmp/pdfs/resume_review/`：13 张个人简历审阅页面。目标仓库为公开仓库，因此未上传。
- 空目录：`docx_render_v1`、`docx_render_word_v2`、`docx_render_word_v3`、`.tmp_ale_deps`、`.tmp_yttools`。Git 不跟踪空目录。

## 5. 完整性说明

“核心结论和主要可编辑交付物”已经远程化；“所有原始复现包”尚未全部远程化。私人访谈和个人材料不是待上传项，后续也不得补传。

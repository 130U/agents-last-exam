# Contributing

本仓库是 ALE 1,000-task 交付研究的可审计工作区。贡献的首要目标不是增加文件数量，而是提高结论的可信度、可执行性和可追溯性。

## 1. 选择正确的内容区

- 新来源、原始笔记、完整研究包、转写与辅助材料先进入 `supporting-evidence/`。
- 只有形成明确结论、完成关键证据核验并能服务最终报告时，才进入 `core/`。
- 仓库规则、发布流程和架构决策进入 `docs/`。
- 自动化检查进入 `scripts/` 与 `.github/`。

不要把同一文件复制到两个区域；使用相对链接建立关系。

## 2. 研究证据规则

每次增加或改变关键结论时：

1. 优先使用论文、官方代码、数据集 revision 或官方方法文档。
2. 对可变来源固定版本、commit、revision 和访问日期。
3. 区分来源事实、作者主张、研究者推断与项目建议。
4. 明确计数单位，尤其不要混用 workflow、runnable instance、submission、release 和 run。
5. 缺失证据不能自动转化为人数、成本、周期、通过率或配额。
6. 涉及公开/私有数据、licensed software、credentials、hidden reference 或 evaluator 时，记录权利与泄漏边界。

若 canonical ALE source surface 变化，同时更新 `repository-manifest.json` 并在 `CHANGELOG.md` 记录影响。

## 3. 文件与版本规范

- 路径和文件名使用英文 kebab-case，不使用空格。
- 时间敏感报告使用 `YYYY-MM-DD`，不要使用 `final-v2-latest`。
- Markdown 为首选审阅格式；DOCX/PDF 等二进制交付物尽量附生成脚本或 Markdown companion。
- 单文件超过 10 MiB 时说明必要性；超过 50 MiB 不进入普通 Git 历史，应使用外部归档或经明确设计的 Git LFS。
- 不提交临时渲染、缓存、编辑器目录或本地环境。
- 不提交任何密钥、token、密码、个人信息、客户数据或未授权材料。

## 4. 分支与 Pull Request

1. 从最新目标分支创建 `codex/<scope>` 或其他清晰命名的功能分支。
2. 每个提交只表达一个可审阅意图。
3. 使用 Draft PR 暴露早期结构；准备好后再转为 Ready for review。
4. 填写 PR 模板中的证据、版本、权利和校验项目。
5. 涉及 `core/`、source pins、发布口径或治理规则的变更需要 CODEOWNER 审阅。

## 5. 本地验证

仅需 Python 标准库：

```bash
python -m py_compile scripts/validate_repository.py
python scripts/validate_repository.py
```

修复所有 error。warning 需要在 PR 中解释或消除。发布前再执行 [release checklist](docs/RELEASE_CHECKLIST.md)。

## 6. 权利声明

贡献材料并不会自动获得仓库级统一许可证。提交前确认你有权公开存储相关内容，并阅读 [`LICENSE_POLICY.md`](LICENSE_POLICY.md)。

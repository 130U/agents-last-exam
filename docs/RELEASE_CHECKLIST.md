# Release checklist

## Scope and identity

- [ ] 明确本次 release 是研究快照、面试交付，还是可执行 benchmark 版本。
- [ ] 记录 commit/tag、日期、负责人和包含的内容区。
- [ ] 不把方案文档描述为已经交付的 1,000 个 runnable instances。

## Evidence and versions

- [ ] `docs/repository/repository-manifest.json` 中的论文、代码与数据 revision 正确。
- [ ] 关键外部链接可访问，引用指向 canonical source。
- [ ] workflow、instance、submission、release 和 run 的单位未混用。
- [ ] 事实、作者主张、研究推断、假设和建议可以区分。
- [ ] 冲突数字有 source/version/unit 说明，而不是被平均处理。

## Content quality

- [ ] `core/` 中的结论与最新证据一致。
- [ ] 二进制交付件已打开检查，且有可审阅 companion 或生成路径。
- [ ] 目录、文件名、交叉链接和 README 入口正确。
- [ ] superseded 内容已标记并链接替代版本。
- [ ] `supporting-evidence/UPLOAD_MANIFEST.md` 与实际上传状态一致。

## Security, rights, and privacy

- [ ] 不含 credential、个人信息、客户数据或受限原始材料。
- [ ] private task、hidden reference、evaluator、seed 和 rotation policy 未被意外公开。
- [ ] 第三方 attribution 与 source-specific license notice 被保留。
- [ ] 没有宣称未经所有者选择的仓库级开源许可证。

## Reproducibility and automation

- [ ] `python -m py_compile scripts/validate_repository.py` 通过。
- [ ] `python scripts/validate_repository.py` 通过。
- [ ] GitHub Actions quality gate 通过。
- [ ] 生成脚本、环境依赖和不可复现部分均有说明。

## Handoff

- [ ] release notes 总结新增、变更、已知限制和未上传材料。
- [ ] 对下一位维护者说明 canonical entry points。
- [ ] 对需要后续决策的事项明确 owner 与触发条件。

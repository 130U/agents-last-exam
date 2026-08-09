# Security and confidential material

## Scope

本仓库同时涉及公开研究、私有评测治理和潜在执行环境设计。以下问题应按安全事件处理：

- API key、token、password、certificate 或其他 credential 泄漏；
- 客户数据、个人信息、专家身份或受限 licensed material 被公开；
- private task、hidden reference、evaluator 或 rotation schedule 泄漏；
- CI workflow 获得不必要写权限或执行不受信任内容；
- 可导致 grader tampering、reference leakage 或环境逃逸的实现缺陷。

## Reporting

不要在公开 Issue、PR、commit message 或附件中披露敏感细节。

优先通过仓库的 **Security** 页面提交 private vulnerability report。如果该入口未启用，请先通过 GitHub 联系仓库所有者，确认私密沟通渠道后再发送细节。报告可包含：

- 受影响路径或版本；
- 最小复现步骤；
- 可能暴露的数据或权限；
- 建议的临时缓解方案。

本仓库不承诺固定响应 SLA；维护者会根据影响范围确认处置方式。

## Immediate containment

如果凭据已经进入 Git 历史：

1. 立即在对应服务端撤销或轮换凭据；删除文件本身并不足够。
2. 暂停受影响的 workflow、environment 或 release。
3. 确认日志、artifact、fork 与缓存中的传播范围。
4. 在评估协作者影响后，再决定是否需要重写历史。
5. 记录不包含秘密值的事后说明和预防措施。

## Preventive controls

仓库 CI 会扫描若干常见凭据格式，但这不是完整的 secret-scanning 服务。贡献者仍须在提交前人工检查，并坚持最小权限、短期凭据、private evaluator 与 public artifact 分离。

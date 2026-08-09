# B. ALE glossary（单位优先，不把同名 task 合并）

> 固定对象：UC Berkeley RDI *Agents' Last Exam*；论文固定 `arXiv:2606.05405v2`，访问日 2026-08-08。`task` 单独出现时语义不稳定，正式 SOW/manifest 必须改写成下表中更精确的单位。

| Term | 本报告的工作定义 | 可计数边界 / 常见误读 |
|---|---|---|
| **benchmark** | 某一 revision 的 corpus + taxonomy + task/evaluator protocol + environment + reporting rules | 一个 benchmark 可有多个 snapshot/manifest/leaderboard surface；不是“一道题”。 |
| **domain** | taxonomy 的顶层行业/能力分组 | v2 标题口径为 13；Figure 2 另有显示容器 `Other→Sports`，不能无证据称第 14 个 formal domain。 |
| **subdomain** | domain 下的 workflow-level 专业子领域 | v2 为 55；HF 固定 revision 只观察到 51 个 structured mappings，不能用公开卡片补全/重写 v2 taxonomy。 |
| **workflow** | 一个端到端专业程序；live docs 对应一个 `main.py` 和一套通用 grading logic | 可声明多个 variants/instances；v2 Appendix C.3.7 报告 960 workflows。不是 submission 或 run。 |
| **variant** | 同一 workflow/共享 evaluator 下的一组 concrete input/reference/config | `load()` 每个 variant 返回一项。variant 是否等于一个可计数 runnable instance，取决于实现、数据和 QC 是否完整。 |
| **runnable task instance** | 一个 workflow 的一个可执行具体案例：固定 input/reference/variant config/environment/evaluator | v2 inventory 报 1,490 instances。必须能 start、run、evaluate；HF task card 或 prompt 本身不够。 |
| **task specification** | 把 description、inputs、软件/环境、expected output、hidden reference 与 evaluation contract 绑定的可执行规范 | live docs 的 package 至少为 `task_card.json + main.py`；自然语言五项 submission schema 是上游规格，不等同已实现 package。 |
| **expert submission** | 专家通过 portal 提交的工作流概念/既有项目/原始数据/评价知识 | Figure 5 的 `960 external submissions` 是 provenance/review-yield 标签；不能直接当作 960 workflows、experts 或 accepted instances。 |
| **commissioned task** | Figure 5 对 530 个 commissioned-build 来源项使用的标签 | 论文没有公开它与 workflow/instance 的逐行 crosswalk；保留原标签，不强行归一化。 |
| **public instance** | 某快照已公开的 runnable release item | v2 Figure 5 为 150；v2 experiment 又说 152 distinct tasks；HF 后续为 153 task-card rows。三个数分别报告。 |
| **private instance** | 未公开、保留用于评测/轮换的 instance | v2 Figure 5 为 1,017；private 降低定向优化风险，但不自动证明零污染。 |
| **pending-QC / unverified item** | 仍未完成验证/最终 QC 的来源或实例项 | v2 Figure 5 为 323；不能计入已验收产能或 final delivery。 |
| **input** | agent 运行前可见、被 staged 进 sandbox 的材料 | 需固定 bytes/hash、路径、权限和 provenance；HF descriptor 不是 input bytes。 |
| **output** | agent 留下、供 evaluator 读取的 deliverable：文件、app state 或 system state | 是 run 的结果，不是 reference；缺失输出按任务契约得 0，而不是丢弃样本。 |
| **reference** | evaluator-only 的 golden artifact/rubric/expected state | agent 运行时隐藏，结束后才 staging；泄漏会改变 construct。 |
| **`load()`** | 发现阶段的纯声明：返回每个 variant 的 prompt/metadata/OS-compute requirements | 不连接/修改远程 sandbox；返回项定义 run unit 候选。 |
| **`start(cfg, session)`** | 在 fresh sandbox 设置 input、目录、app 与确定性初始状态 | 属于环境准备，不是 agent reasoning；应 idempotent 并验证 reference 隐藏。 |
| **`evaluate(cfg, session)`** | agent 结束/timeout 后，读取 output 和 hidden reference，返回 `[0,1]` score list | shared evaluator 必须 version/hash；deterministic 只表示可重复，不保证构念正确。 |
| **environment** | provider-routed sandbox + OS/image/hardware/software/license/data/network/start state | 是评测条件。GCP/AWS/Aliyun/Docker/QEMU/static profiles 与 licensed/unlicensed manifests 不可混算。 |
| **harness** | 模型外的 agent 编排：system prompt、action loop、tools、GUI/CLI bridge、context policy、subagents、termination | 官方 leaderboard 将 harness 单列；同一 model 换 harness 可变分，因此不能只报 model name。 |
| **agent configuration** | `foundation model + harness` 及其 effort/prompt/tools/context/provider/executor settings | ALE 直接测量的系统对象；不是裸 foundation model。 |
| **agent run** | 某一 pinned agent configuration 在一个 instance、prepared start state、budget 下的一次执行和一次 evaluator result | 重试/重跑新增 run，不新增 task；失败重试与统计独立 repeated trial 也要分开。 |
| **repeated trial** | 同一 instance/configuration 的预先定义独立重跑，用于估计随机性/可靠性 | v2 只对部分配置给 3-run SD；live docs `max_attempts` 是失败恢复控制，不等同完整重复实验。 |
| **Mean Score** | task-specific evaluator 返回的 normalized partial credit 的平均（页面常乘 100） | 不等于“完成多少统一步骤”，也不是生产率或正确概率。 |
| **Full Pass Rate** | 得分恰为 `1.0` 的 evaluated units 比例 | 必须声明 unit、manifest、trial/best-of aggregation；不是岗位自动化率或 deployment reliability。 |
| **manifest** | 某 release/experiment 的精确 task/variant 列表及 split membership | `150/152/153`、`67/55/38`、`full.txt=152` 均依赖各自 manifest/surface。 |

## 两条必须写进合同的等式

```text
Asset counts:  S submissions → W accepted workflows → I accepted runnable instances
Run counts:    R = Σ(instance × agent_configuration × trial/retry policy)
```

`S ≠ W ≠ I ≠ R`。同一个数值（例如 `960`）若标签和集合不同，也不构成相等关系。

**Primary evidence:** [arXiv v2 audit](sources/01_arxiv_2606_05405v2.md), [HF revision audit](sources/05_huggingface_task_cards_a8c1fd1.md), [official task lifecycle](sources/37_official_task_lifecycle_docs.md), [official experiment configuration](sources/39_official_experiment_configuration.md), [official authoring contract](sources/41_official_add_task_docs.md).

# D. “ALE 可以证明什么 / 不能证明什么”边界表

> `[事实]` 指 pinned protocol/source 直接支持；`[作者主张]` 指 ALE 团队的解释；`[研究员推断]` 指跨来源归纳；`[项目建议]` 指本项目的 acceptance rule。

| 命题 | ALE 单独能否支持 | 最严谨表述 / 还缺什么 |
|---|---|---|
| 某 configured agent 完成某 pinned ALE manifest 的程度 | **能，有条件** | `[事实]` 在固定 model+harness、prompt/tools/context、environment、budget、retry/trial、evaluator 下报告 Mean Score、Full Pass Rate、cost/time 与不确定性。 |
| 某 run 是否满足该 evaluator 的全部条件 | **能** | `[事实]` score=`1.0` 即 Full Pass；只说明 evaluator-bounded acceptance。 |
| 某 run 部分满足 rubric/连续质量目标 | **能** | `[事实]` normalized partial score；不同 task 的 0.5 不一定有相同语义。 |
| 两个 agent systems 的相对表现 | **有限支持** | 需同 manifest/environment/budget/retry/evaluator；若不同 harness/model/effort 同时改变，只能比较完整 systems。 |
| foundation model 的独立能力 | **不能从开放 leaderboard 直接隔离** | 需要固定非模型组件，做 model×harness factorial/ablation 与 repeats；最多说“在指定 harness 下的 model effect”。 |
| harness 是否影响结果 | **能证明在被测范围内有影响** | 官方 fixed-model sweep 存在数个百分点 spread；同时 backbone spread 更大。不能推广为所有模型/任务的因果排序。 |
| 任务覆盖 13/55 taxonomy labels | **能描述特定 snapshot** | `[事实]` 是覆盖地图；不等于劳动市场、风险或 GDP 权重上的代表样本。 |
| public subset 代表整个 pool | **仅作者层面的有限证据** | v2 报 one-configuration、cluster-level `r=0.89`；不能证明严格分层比例、难度同分布、其他 agents 或未来版本同样成立。 |
| 高分代表 unseen-work generalization | **不能自动证明** | 需 private fresh workflows/instances、训练截止/exposure audit、near-duplicate scan、provider data-use evidence 与轮换政策。 |
| deterministic grader 正确 | **不能** | deterministic 只表示相同输入可复算；仍需 alternative-correct、known-bad、mutation/metamorphic、盲审 FPR/FNR 与 anti-gaming 测试。 |
| LLM/VLM judge 稳定、公平 | **不能自动证明** | 需固定 judge/prompt/renderer，做 order/swap/repeat tests、人类一致性与旧 artifact replay。 |
| human-level professional ability | **不能** | 缺同 brief/input/VM/tools/time/grader 的 matched-human runs；gold reference 不是 human baseline。 |
| 工作效率/生产率提升 | **不能** | 缺人机协作对照、质量校正后 time/cost、真实组织约束与因果部署实验。 |
| 岗位替代/自动化比例 | **不能** | 缺岗位 task frequency、非数字工作、采用成本、监督/责任、安全与劳动市场权重。 |
| GDP impact / ROI | **不能** | `economically valuable/GDP-relevant` 是 `[作者主张]` 的设计目标，不是 outcome variable。 |
| deployment reliability | **不能从单次 FPR 得出** | 需 repeated trials、`pass^k`、扰动/故障/模型漂移与安全副作用测试；best-of-k 回答的是另一问题。 |
| 所有专业能力/过程安全 | **不能** | outcome grader 只测编码条件；未编码的 provenance、maintainability、沟通、伦理/安全过程不在 construct 内。 |

## 最短可复用结论

> ALE 提供的是**配置、环境、manifest 与 evaluator 条件化的端到端数字交付证据**。它不是裸模型智力测验，也不是人类职业能力、岗位替代率、生产率、部署可靠性或 GDP 影响的直接测量。

**Evidence:** [paper/HF audit](findings/F1_paper_hf_version_audit.md), [adversarial construct-validity review](findings/F3_adversarial_construct_validity.md), [live leaderboard](sources/19_official_leaderboard.md), [official harness analysis](sources/40_official_harness_analysis.md).


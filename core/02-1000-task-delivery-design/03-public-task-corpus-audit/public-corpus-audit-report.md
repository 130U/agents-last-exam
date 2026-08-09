# ALE 公开 task corpus 结构化审计

**研究对象**：UC Berkeley RDI / RDI Foundation 的 Agents’ Last Exam（ALE）  
**研究日期 / 访问日期**：2026-08-08  
**决策用途**：规划约 1,000 个 ALE-style benchmark assets 的产品范围、task selection、专家组织、生产流程、evaluation、基础设施、QA、成本、排期与交付标准。  
**审计范围**：公开 task metadata、官方 task gallery、固定 Git commit、固定 Hugging Face dataset revision；不把公开资产外推成 private pool 的完整分布。

## Executive summary

1. **[事实] “当前公开 corpus”不是一个可互换的数字。** 固定 HF revision 有 153 行；固定 Git commit 的 `selected_full` 有 152 个唯一 task path；Git task tree 有 165 个带 `main.py` 的 task folders；官方 gallery 的 split API 有 152 项，而 featured API 有 32 项。它们是不同 surface、不同单位、不同快照，不能调和成一个统一的“约 150”。
2. **[事实] 本审计覆盖全部 153 个 HF metadata rows，并逐项与固定 Git task folder、`task_card.json`、`main.py` 和 gallery API 对齐。** 没有抽样替代全量 inventory。公开 repo 的 task-tree 差异、demo 与 gallery-only 资产另行记录。
3. **[推断] 公开 task 的实际形态是“专业输入 + 可执行环境 + 明确交付物 + 隐藏 reference/evaluator”，不是单轮问答。** 同一 workflow folder 可能加载多个 runnable instances；153 个 metadata rows 不等于 153 次可运行任务。
4. **[事实] 固定 HF/Git 对齐 corpus 的 evaluator 代码审计得到 141 deterministic、7 hybrid、5 LLM-judge。** 这是本 revision 下“最终计分角色”的研究员分类，不应与论文自己快照中的 93.2% code-based / 6.8% LLM-as-judge 直接合并。另有 Odoo 使用不进入最终 SQL 分数的辅助 LLM screenshot audit，说明“出现 LLM 调用”与“LLM 决定得分”必须分开。
5. **[事实] 公开 schema 缺口是结构性的。** 153/153 没有独立暴露 workflow ID；153/153 没有观测到的 action/tool-call 长度；153/153 不公开 expert labor、implementation labor、QA time、rework rate 或 per-task cost；hidden reference 内容也不公开。因此不能从 ALE 公开资料制造 1,000-task 的精确人力、成本、工期或配额。
6. **[建议] 把 1,000 “assets”先写成明确交付单位。** 合同需分别承诺 workflow 数、runnable task instance 数、public/private/pending-QC 数量、evaluator 与 repeated agent trial 数。没有这一步，预算和进度都不可审计。
7. **[建议] 先做分层 pilot，再锁生产配额。** Pilot 必须测量专家出题工时、实现工时、evaluator mutation failure、基础设施成功率、首次验收率、rework、license/VM 单次运行成本和多次 agent run 方差；公开 ALE 比例只能帮助设计 strata，不能作为生产配额。

## 研究假设与可证伪条件

| 假设 | 可证伪条件 | 结论 |
|---|---|---|
| H1：公开 corpus 在环境、软件、输入输出和 evaluator 上高度异质，且 schema 有显著缺口 | 若绝大多数任务共享单一环境/工件/evaluator 且关键字段完整，则反驳 | **Supported**：Windows/Linux、free/licensed/GPU、文档/数据库/CAD/媒体/仿真均存在；所有 153 行缺 action trace 与劳动力数据 |
| H2：多 instance workflow 确实存在，但 multiplicity 不均匀，公开均值不能成为生产 quota | 若所有 workflow 固定一实例，或 multiplicity 近似恒定，则反驳 | **Supported**：静态识别 14 个多实例候选，公开声明范围从 2 到 18；其余多为单实例推断 |
| H3：evaluator form 与可验证性有关：结构化 artifacts 偏 deterministic，语义/视觉残差更可能 narrow LLM/hybrid | 若结构化任务大量依赖开放式 judge，或语义任务普遍精确评分，则反驳 | **Supported，但有边界**：当前分类为 141/7/5；deterministic 仍可能 construct-invalid，LLM judge 也能被窄问题和 hard gates 约束 |
| H4：论文、live site、Git、HF、gallery 是不同时间快照，不能合并数字或 taxonomy | 若各 surface 的 IDs、counts、tier、taxonomy 完全一致且 revision 同步，则反驳 | **Supported**：153、152、165、32、152 并存；HF 比 split 多一个 bridge task；featured gallery 有 19 个不在 split/HF 的 IDs |

## 关键定义

| 单位 | 本报告定义 | 不能混同 |
|---|---|---|
| benchmark | 一套任务集合、环境、harness、评测与报告协议 | 不是单个 task |
| domain / subdomain | 分类标签；本审计保留每个 surface 的原始标签 | 不把 HF `category` 的 14 个 storage codes 当作唯一正式 taxonomy，也不外推 private pool |
| workflow | 可复用的端到端专业过程及共同 `evaluate()` 逻辑 | 不等于一次 runnable input-output case |
| runnable task instance | workflow 在一组具体输入、reference 和初始环境上的一次可运行配置 | 不等于 agent run；同一 instance 可重复运行 |
| expert submission | 外部专家提交的候选 task package | 不保证已通过 QC，也不等于 commissioned task |
| commissioned task | 由项目方定向委托生产的 task | 不应与 external submission 数字相加后改称 workflow，除非原文明确 |
| public / private / pending-QC instance | 发布状态；论文 v2 的 150 / 1,017 / 323 是论文快照下的 instance 数 | 不是 live Git/HF 行数 |
| agent run / repeated trial | 一个固定 agent system 在一个 runnable instance 上的一次执行 | repeated trials 不会产生新的 benchmark task |

## 方法与可复现性

### 审计母体与覆盖

- **主 inventory 母体**：HF revision `a8c1fd174a1f6cfa76526572a2e3ebece1276be2` 的 153 行 `task_cards.parquet`。
- **实现对齐**：Git commit `1e615e456de7cef57706680613cb80ee13c7fc76`。
- **gallery 对齐**：访问日 2026-08-08 保存的 `/api/demo/tasks` 与 `/api/demo/splits` 响应。
- **覆盖方法**：全量 153 行逐项 merge；不是分层抽样。对 evaluator form、reference、variants、OS/software、input/output 等字段做静态代码与 metadata 抽取。
- **长度估计**：`estimated_workflow_length` 仅用 prompt numbered/bulleted requirements 与 checklist 数形成高层 proxy；明确不是观测 action/tool-call 数、人工工时或 wall-clock。
- **分类方法**：task archetypes 与 evaluator archetypes 都允许多标签，是研究员归纳，不是 ALE 官方 taxonomy。

复现入口：

- `scripts/build_inventory.py`：重建全量 inventory 与 version diff。
- `scripts/export_source_records.py`：重建逐来源证据卡、evaluator library、mini cases。
- `data/task_inventory.jsonl` / `.csv`：machine-readable 153-row inventory。
- `data/inventory_summary.json`：汇总与缺口。
- `data/version_diff.json`：跨 surface ID-level 差异。

## 证据与版本矩阵

| Surface | 锁定版本 / 访问口径 | 该 surface 的单位与数字 | 审计含义 |
|---|---|---|---|
| arXiv paper | `2606.05405v2`，2026-06-11 | 960 workflows；1,490 instances = 150 public + 1,017 private + 323 pending QC | 论文快照；Figure 5 的 960 external submissions + 530 commissioned tasks 是生产来源计数，不能与 workflow 960 视为同一变量 |
| Official homepage | 2026-08-08 live snapshot | “1.5K+ tasks”“300+ experts”“55 subindustries”等机构陈述 | 作者/机构主张；无 immutable revision，不用于精确 reconciliation |
| Official submit | 2026-08-08 live snapshot | suitability decision tree 与 task package components | 生产规范证据，不提供历史通过率/工时/成本 |
| Official gallery | 2026-08-08；UI 标注 `ALE-V1, 2026/06` | featured API 32；split API 152 | curated gallery 与 split manifest 是两套集合 |
| GitHub | commit `1e615e456de7cef57706680613cb80ee13c7fc76` | selected full 152 unique paths；task tree 165 folders；tier files 67/55/38 条目但合计 160、仅 152 unique | 8 个 path 跨 tier；目录不等于 taxonomy 或唯一 release manifest |
| Hugging Face | revision `a8c1fd174a1f6cfa76526572a2e3ebece1276be2` | dataset v1.0；153 rows；14 observed category codes | 主 inventory 母体；输入 metadata 公开、reference contents gated |
| RDI launch blog | 2026-08-08 live snapshot | “fully reproducible / no human judges”等机构表述 | 宣传性主张；需与 paper 对 LLM-as-judge 与 repeated-trial 范围的细节一起解释 |

快照校验值：

- GitHub archive SHA256：`F83B64F90F10093F3A7E2C54F6D9DDF000C9B3966DD9CD38AF35B8C28B9EE39E`
- HF Parquet SHA256：`B6661183018F65F332260D1981F656102FEDCC17C8EE96C0DFE18A5AF9C184E8`

### 关键 ID 差异

- HF 153 与 split/Git selected 152 的唯一差：`engineering/2d_drawings_to_3d_bridge_model` 在 HF，不在这两个 152 集合。
- Git task tree 比 HF 多 12 个 folder：8 个 `demo/*`，以及 4 个 visual-media tasks。它们不能自动算进公开 benchmark split。
- Featured gallery 的 32 个案例中有 19 个 ID 不在 split API/HF。**[推断]** featured gallery 是 curated/legacy visual surface，不是 release manifest。
- Tier files 的 67 + 55 + 38 = 160 条目只对应 152 个唯一 path；8 个 path 跨 tier。不能把三份文件简单求和当公开 task 数。

## 主要发现

### 1. 实际 task package 长什么样

典型 package 不是只有 prompt，而是：

1. 专业任务说明、输入 assets 与环境初态；
2. 指定 OS / VM snapshot / software stack；
3. agent 在 browser、CLI、desktop app 或多 application 间执行；
4. 产出文件、数据库/application state、render、report、code 或 simulation results；
5. host 或 VM 侧 evaluator 读取隐藏 reference，先做 validity gates，再以 exact/tolerance/behavioral/geometric/semantic rules 计分。

**[事实]** 当前固定 153-row corpus：Linux 105、Windows 48；difficulty metadata 为 near-term 67、full-spectrum 47、last-exam 38、缺失 1。以上都是该 revision 的 metadata counts，不是 1,000-task 配额。

### 2. Task archetypes

识别到以下重叠 archetypes：document/spreadsheet transformation、CAD/3D、coding/CLI、browser/research、simulation、media production、professional report、structured database/query、scientific/data analysis、multi-application workflow。

**重要限制**：关键词和 software-based multi-label 会让广义 `coding/CLI` 或 `multi-application` 覆盖很高；这些 counts 适合检索与抽样，不适合宣称 ALE 的“真实分布”，更不能推断 private pool。

### 3. Workflow 与 multiple instances

静态代码识别 14 个 multiple-instance workflow candidates；例如 `engineering/gcode` 声明 18 variants、`engineering/mold-flow` 12、`visual_media/uv_reproduction` 10。将公开 variant 声明机械相加得到 222 个静态 runnable-instance declarations。

**边界**：222 是这个 Git commit 的静态代码审计结果，不是论文 public instance 数，也不证明这些 variants 都进入官方 split、能在同一日期成功 provision、或经过同等 QC。其余 110 个“单实例”状态只是没有解析到公开 variant declaration 的推断。

### 4. Evaluator architecture

本审计按“谁实质决定最终得分”分类：

- deterministic：141；
- hybrid：7；
- LLM-judge：5。

可复用 evaluator 模式包括：exact/hash/set equality、schema gate + tolerant fields、tiered partial credit、executable/replay、application-state/database query、geometry/render metrics、audio/music signal comparison、narrow LLM/VLM binary rubric、hybrid hard/soft gate-and-score。详见 `evaluator_archetype_library.md` 与 JSON 版。

有三个必须写进 evaluator spec 的边界：

1. 文件存在/可解析的 deterministic gate 不会把一个实质由 LLM 决定质量分的 evaluator 自动变成 hybrid；
2. 代码中出现 LLM 调用不代表 LLM 进入最终分数；Odoo 的 screenshot audit 是辅助信号，最终 SQL score 是 deterministic；
3. deterministic 不等于 construct-valid。过窄 schema、泄漏 expected values、只验单一 camera/view 或只验 surface compliance 都可能奖励 shortcut。

### 5. 26 个 mini cases 与四组五选

完整案例见 `mini_case_studies.md`。本报告的四组决策性选择如下，均为定性审计判断，不是有公开成本/风险数据支持的排名：

| 用途 | 5 个案例 |
|---|---|
| 最适合做项目样题 | `crop_rotation_d02`；`basel_operational_risk_bia_cn`；`k8s_migration_1`；`lenacapavir_sar_table2_extraction`；`abm_hangzhou_metro` |
| evaluator 设计最值得学习 | `crop_rotation_d02`；`homework_grading_numerical_pdes_instance_02`；`american_option_pricing_ls`；`openroad_sky130_ibex_pnr_signoff`；`skeletal_animation_reproduction` |
| 最易 shortcut / gaming | `pe_screening_memo_1`；`saas_onepager_brand_refresh_instance_1`；`go_game_reconstruction_1`；`chroma_key_from_reference`；`other/mota_exploration` |
| 基础设施/授权高负担候选 | `2d_drawings_to_3d_building_model`；`2d_drawings_to_3d_bridge_model`；`gcode`；`mold-flow`；`cailian_road_highway_alignment_2` |

选择逻辑：样题覆盖结构化 transformation、regulatory spreadsheet、executable infrastructure、专业科学 extraction 与 simulation；evaluator-learning 组覆盖 schema/tolerance、tiered credit、behavioral replay 与 hybrid visual；gaming 组集中 semantic/VLM、surface reconstruction 与狭窄 metric；高负担组有 Rhino、PowerMill、Moldex3D、Civil 3D 等授权/图形/VM 信号。**公开资料不足以给出精确 license price、每 task 运行成本或负担排序。**

## 反方证据与不确定性

### 当前结论何时会失效

- 若 ALE 后续 revision 改变 split、task cards、evaluator 或 taxonomy，本报告的 counts 与 ID diffs 立即成为历史快照，必须重跑脚本。
- 若运行时动态加载了静态审计看不到的 remote scorer/judge，deterministic/hybrid/LLM 分类会低估动态行为。
- 若公开 task card 与实际 provisioned VM、input bundle 或 hidden reference 不一致，metadata audit 不等于 end-to-end reproducibility audit。
- 若 1,000-task 项目的目标 domain、客户软件、security/network policy 与 ALE public corpus 不同，本报告的 archetypes 只能做设计灵感，不能做 allocation basis。

### 哪些数字不能作为生产配额

- 论文的 150/1,017/323 是发布状态快照；
- HF 153 是 metadata rows；
- Git selected 152 是 unique task paths；
- 67/55/38 是 tier-file entries，且存在跨 tier 重复；
- 222 是静态 variant declarations；
- paper 的 93.2%/6.8% 和 88.5%/11.5% 是论文自身 reference-tree snapshot；
- public/private cluster correlation 只对论文测试的一个 Claude Code + Opus 4.7 system 和 cluster-level pass rates 提供有限支持，而且 paper 同时指出 public set tier mix 更难。

### 成功可能来自 evaluator weakness、泄漏或 harness 差异

- **Evaluator weakness**：只检查字段、文件、截图、单视角或容易代理的 metric，未覆盖专业结果的完整语义；
- **Reference / solution contamination**：hidden reference、fixtures、expected values、gallery outputs 或 task-specific solution traces 泄漏后会塌缩难度；
- **Grader gaming**：agent 可针对 score surface，而不完成 intended workflow；NIST 的 agent-evaluation 材料明确记录 solution contamination 与 grader exploitation 风险；
- **Harness variance**：system prompt、tool schema、computer interface、browser state、network policy、timeout、token budget、retries、checkpointing 与 error recovery 都会改变结果；
- **Environment variance**：OS image、software version、license state、GPU driver、fonts/codecs、locale、database seed 与 external website drift 都会改变可运行性和得分；
- **LLM/VLM judge weakness**：位置偏差、视觉合理性偏差、prompt injection、模型 revision 或 fallback policy 可改变结果。

### 合理但无公开数据支持的建议

以下建议需要 pilot 验证，不能伪装成 ALE 证据：专家团队规模、每专家产能、每个 archetype 的配额、Windows/Linux 比例、licensed/free 比例、每 task 工时、一次验收率、rework 次数、reviewer-to-author ratio、重复 trials 数、总体月份和美元成本。

## 对 1,000-task 项目的具体决策影响

### Product scope

合同和内部 dashboard 至少分别记录：

- `workflow_target`
- `runnable_instance_target`
- `expert_submission_target`
- `commissioned_task_target`
- `public_instance_target`
- `private_instance_target`
- `pending_qc_target`
- `agent_runs_per_instance_by_release`

“1,000 tasks”只有在以上字段中指定一个主交付单位后才有可执行意义。

### Task selection

先用 domain × OS × software/infra × artifact type × evaluator archetype × difficulty × instance strategy 建候选 strata。Public corpus 的 counts 只能帮助发现 strata 和 failure modes；quota 应由客户 use cases、风险覆盖、基础设施可得性与 pilot yields 决定。

### 专家组织

将角色解耦为：domain author、task implementer、evaluator engineer、independent solver、adversarial QA、environment/infra owner、release curator。一个专家可以兼任，但每个 asset 的 author、reference/evaluator reviewer 与 final acceptance owner 必须可追踪；高风险任务至少需要独立复算/复现，而不是只审文案。

### 生产流程

建议 stage gates：brief → task-fit review → expert spec → clean reference → runnable environment → evaluator fixtures → independent solve → adversarial/mutation QA → repeated clean runs → release manifest/QC status。Pending-QC 不得计入 accepted delivery。

### Evaluation 与 QA

每个 evaluator 至少需要：

- positive fixture、near-miss、format-only pass、semantic failure、empty/corrupt、shortcut/adversarial artifacts；
- gate、partial score、full pass 的边界值测试；
- hidden reference isolation；
- mutation testing：删字段、换单位、改 ID、伪造截图、绕过 UI、复制 reference-like artifacts；
- frozen scorer code、dependencies、judge model/prompt、fallback、thresholds 与 aggregation；
- clean-room rerun 和 score reproducibility check。

### 基础设施

基础设施不是后台成本项，而是 measurement contract。Manifest 必须固定 OS/image digest、software/license、provider、GPU/CPU/RAM/disk、network allowlist、locale/fonts/codecs、preinstalled assets、snapshot reset、timeout/retry/checkpoint、artifact collection 与 evaluator side。高负担 strata 必须在立项前做 license 与并发容量验证。

### 成本、排期与交付标准

公开资料不足以生成精确预算或排期。使用 pilot 实测变量：

`C_total = C_shared_infra + C_program_management + Σ_i(C_domain_spec_i + C_implementation_i + C_evaluator_i + C_license_i + C_compute_i + C_QA_i + C_rework_i)`

`accepted_throughput = submitted_per_period × spec_pass_rate × implementation_pass_rate × independent_solve_pass_rate × final_QC_pass_rate`

`effective_runs = accepted_instances × systems_under_test × trials_per_system_instance`

`schedule = max(critical_path_workstreams) + release_hardening + contingency`，不能把所有人的人日简单除以团队人数。

上述每个变量都必须由分层 pilot 估计，并报告分布而非单一平均值；licensed desktop、web-dependent、large-artifact、simulation 与 simple structured transformation 应分别估算。

## 建议

1.…4568 tokens truncated…`
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; hard gate plus partial/continuous score
- 代表性：A PDF-to-chemical-table extraction task using structure-aware InChIKey comparison rather than string equality.
- 标签：sample_task_candidate
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/physical_sciences/lenacapavir_sar_table2_extraction.

## 15. `transport_safety/abm_hangzhou_metro` — Hangzhou Metro Passenger Simulation

- Domain / subdomain：engineering / Urban & Spatial Planning
- Tier / OS / snapshot：full-spectrum / Ubuntu Linux / cpu-free-ubuntu
- Software：Python; uv; geopandas; matplotlib; networkx; numpy; pandas
- Inputs → outputs：CSV; GeoJSON; JSON; uv Python environment manifest → CSV; text
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; executable / behavioral verifier
- 代表性：An agent-based simulation with multiple geospatial/table inputs and deterministic output checks.
- 标签：sample_task_candidate
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/transport_safety/abm_hangzhou_metro.

## 16. `visual_media/skeletal_animation_reproduction` — Skeletal Animation Reproduction

- Domain / subdomain：visual_media / 3D, Animation & Interactive Media
- Tier / OS / snapshot：last-exam / Windows / gpu-free
- Software：Blender
- Inputs → outputs：obj; mtl; mp4 → blend; mp4; task-prompt-section
- Evaluator：hybrid；structured artifact / exact-or-tolerant field checks; executable / behavioral verifier; render / geometry comparison; hybrid deterministic-plus-LLM/VLM
- 代表性：A hybrid evaluator combining rig/motion checks, replay similarity, skeleton coverage, and narrow VLM questions.
- 标签：evaluator_learning
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/visual_media/skeletal_animation_reproduction.

## 17. `visual_media/chroma_key_from_reference` — chroma_key_from_reference

- Domain / subdomain：visual_media / 3D, Animation & Interactive Media
- Tier / OS / snapshot：near-term / Windows / gpu-free
- Software：DaVinci Resolve
- Inputs → outputs：`.mp4`; `.png` → `.mp4`
- Evaluator：hybrid；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; render / geometry comparison; hybrid deterministic-plus-LLM/VLM; weighted or averaged multi-component rubric
- 代表性：A hard visual metric plus a VLM edit-authenticity gate; useful, but vulnerable to threshold-specific optimization.
- 标签：gaming_risk
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/visual_media/chroma_key_from_reference.

## 18. `other/mota_exploration` — Game Port Reference Capture: Magic Tower

- Domain / subdomain：visual_media / 3D, Animation & Interactive Media
- Tier / OS / snapshot：near-term / Windows / cpu-free
- Software：Ruffle (Flash emulator)
- Inputs → outputs：SWF → 
- Evaluator：LLM-judge；render / geometry comparison; narrow LLM/VLM rubric; hard gate plus partial/continuous score; weighted or averaged multi-component rubric
- 代表性：A screenshot-only LLM-vision comparison where semantic judge calibration and visual shortcut risk dominate.
- 标签：gaming_risk
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/other/mota_exploration.

## 19. `visual_media/music_transcription` — Music Transcription

- Domain / subdomain：visual_media / Audio, Music & Post-Production Media
- Tier / OS / snapshot：full-spectrum / Windows / cpu-license
- Software：Dorico 6
- Inputs → outputs：`.json`; `.mp3` → `.pdf`; `.mid`; `.png`
- Evaluator：hybrid；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; render / geometry comparison; audio / music signal comparison; hybrid deterministic-plus-LLM/VLM; hard gate plus partial/continuous score; weighted or averaged multi-component rubric
- 代表性：A licensed music-production workflow combining MIDI metrics, dynamic correlation, and a vision judge for score layout.
- 标签：无专项标签
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/visual_media/music_transcription.

## 20. `health_medicine/microdicom_nih_cxr_reader_adjudication` — MicroDicom NIH CXR Reader Adjudication

- Domain / subdomain：health_medicine / Clinical Diagnostics & Imaging
- Tier / OS / snapshot：near-term / Windows / cpu-free
- Software：MicroDicom DICOM Viewer
- Inputs → outputs：markdown; TSV; text directory; DICOM directory → TSV
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; hard gate plus partial/continuous score
- 代表性：A medical-imaging GUI workflow that turns visual review into a structured TSV deliverable.
- 标签：无专项标签
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/health_medicine/microdicom_nih_cxr_reader_adjudication.

## 21. `engineering/humanoid_wbc_policy_evaluation` — [uncertain] missing title in pinned HF row

- Domain / subdomain：engineering / Robotics & Autonomous Systems
- Tier / OS / snapshot：near-term / Ubuntu Linux / cpu-free-ubuntu
- Software：mjlab; MuJoCo; PyTorch; wandb
- Inputs → outputs： → json
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks
- 代表性：A robotics-policy evaluation task whose public metadata is unusually sparse, illustrating schema heterogeneity.
- 标签：无专项标签
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/engineering/humanoid_wbc_policy_evaluation.

## 22. `engineering/2d_drawings_to_3d_building_model` — Betonwerk Katzenberger 3D Model

- Domain / subdomain：engineering / Civil, Architectural & Geospatial Engineering
- Tier / OS / snapshot：last-exam / Windows / gpu-license
- Software：Rhino 8
- Inputs → outputs：Markdown; JSON; PNG; PDF; Wavefront OBJ; Rhino 3DM → JSON; PNG + JSON; OBJ + 3DM + DWG
- Evaluator：LLM-judge；structured artifact / exact-or-tolerant field checks; render / geometry comparison; narrow LLM/VLM rubric
- 代表性：A GPU-and-Rhino workflow scored by 14-view rendering and eight binary multimodal questions.
- 标签：infrastructure_high_cost
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/engineering/2d_drawings_to_3d_building_model.

## 23. `engineering/2d_drawings_to_3d_bridge_model` — Bridge The Gap — Bridge + Site 3D Model

- Domain / subdomain：engineering / Civil, Architectural & Geospatial Engineering
- Tier / OS / snapshot：[uncertain] missing task_split in pinned HF row / Windows / gpu-license
- Software：Rhino 8
- Inputs → outputs：Markdown; JSON; PNG; PDF; Wavefront OBJ; Rhino 3DM; DWG → JSON; PNG; OBJ + 3DM + DWG
- Evaluator：LLM-judge；structured artifact / exact-or-tolerant field checks; render / geometry comparison; narrow LLM/VLM rubric; hard gate plus partial/continuous score
- 代表性：A second Rhino GPU workflow with large geometry and multi-view judge payloads, exposing render and API cost.
- 标签：infrastructure_high_cost
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/engineering/2d_drawings_to_3d_bridge_model.

## 24. `engineering/gcode` — gcode

- Domain / subdomain：engineering / Manufacturing & Industrial Systems
- Tier / OS / snapshot：last-exam / Windows / gpu-license
- Software：Python
- Inputs → outputs：directory; `.prt`; `.jpg` → directory; `.stl`
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; executable / behavioral verifier; render / geometry comparison; hard gate plus partial/continuous score
- 代表性：A licensed GPU PowerMill workflow with collision gating and geometric/toolpath verification.
- 标签：infrastructure_high_cost
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/engineering/gcode.

## 25. `engineering/mold-flow` — mold-flow

- Domain / subdomain：engineering / Manufacturing & Industrial Systems
- Tier / OS / snapshot：last-exam / Windows / gpu-license
- Software：Python
- Inputs → outputs：directory; `.x_t`; `.json` → `.json`; directory
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; hard gate plus partial/continuous score
- 代表性：A licensed GPU Moldex3D simulation workflow with vendor-specific environment requirements.
- 标签：infrastructure_high_cost
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/engineering/mold-flow.

## 26. `engineering/cailian_road_highway_alignment_2` — Cailian Road Highway Alignment

- Domain / subdomain：engineering / Civil, Architectural & Geospatial Engineering
- Tier / OS / snapshot：full-spectrum / Windows / gpu-license
- Software：Autodesk Civil 3D 2024
- Inputs → outputs：Autodesk DWG; Windows batch script → Autodesk DWG; TSV
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; render / geometry comparison; hard gate plus partial/continuous score
- 代表性：A licensed GPU Civil 3D workflow with heavyweight CAD state and output verification.
- 标签：infrastructure_high_cost
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/engineering/cailian_road_highway_alignment_2.

## 四组五选

- 最适合作为项目样题：agriculture_env/crop_rotation_d02; business_finance/basel_operational_risk_bia_cn; computing_math/k8s_migration_1; physical_sciences/lenacapavir_sar_table2_extraction; transport_safety/abm_hangzhou_metro
- Evaluator 设计最值得学习：agriculture_env/crop_rotation_d02; education_info/homework_grading_numerical_pdes_instance_02; business_finance/american_option_pricing_ls; engineering/openroad_sky130_ibex_pnr_signoff; visual_media/skeletal_animation_reproduction
- 最易 shortcut / gaming：business_finance/pe_screening_memo_1; business_finance/saas_onepager_brand_refresh_instance_1; computing_math/go_game_reconstruction_1; visual_media/chroma_key_from_reference; other/mota_exploration
- 基础设施与授权负担最高候选：engineering/2d_drawings_to_3d_building_model; engineering/2d_drawings_to_3d_bridge_model; engineering/gcode; engineering/mold-flow; engineering/cailian_road_highway_alignment_2

Selections are qualitative audit judgments, not measured cost or risk rankings; no public dollar cost data supports precise ordering.
# 1,000 个 ALE-style Runnable Instances：专家生产、校准与治理体系

**用途：** UniPat 面试作业与后续 client-facing production design  
**研究快照：** 2026-08-09  
**目标单位：** 1,000 个通过最终 QC、可独立运行与评分的 runnable benchmark instances  
**ALE 冻结证据：** arXiv `2606.05405v2`；GitHub `1e615e456de7cef57706680613cb80ee13c7fc76`；Hugging Face `a8c1fd174a1f6cfa76526572a2e3ebece1276be2`

## 阅读约定

- **[F] 来源事实：** 论文、固定代码/数据、政府或标准机构文本、同行评议方法研究直接支持。
- **[C] 作者/机构主张：** 来源对自身方法或规范的解释；不自动视为独立验证。
- **[I] 研究者推断：** 多来源组合后对 ALE-style 生产的推断。
- **[R] 项目建议：** 本项目可直接采用的流程、控制与模板。
- **[P] 客户/Pilot 待定：** 必须由 intended use、客户事实、风险容忍度或 pilot 数据决定。

本报告不把公开 benchmark 的任务数、专家数、submission 数、run 数、缺陷审计样本或 release split 转化为人员、工时、成本、周期、throughput、acceptance yield、通过率、阈值、领域配额或 public/private 比例。

## 1. 核心结论

1. **专家体系必须按角色资格构建，而不是按“专家等级”构建。** [F] 人员选拔与 expert-elicitation 来源分别测量 domain knowledge、实际应用、访谈、工作样本、独立性与 facilitator 能力。[S10-S19, S1a] [I] 这些来源没有原生定义 ALE 角色；本项目把 domain expert、practitioner author、group lead、independent solver 与 domain reviewer 分别资格化。
2. **简历、学历、证书、作品和 references 主要是身份、scope 与历史 claim 证据；不能单独证明当前项目能力。** [F] 结构化面试与岗位相似 work sample 能更直接观察相关表现；元分析也提示经典效度估计可能偏高。[S10-S18] [I] 其增量价值与公平性须在本项目验证。[R] 采用“身份/claim 核验 + 结构化面试 + blind work sample + role-specific Golden task”的证据链，任何单项都不能单独录用或晋升。
3. **Golden case 必须是 executable evidence pack，不是唯一标准答案。** [F] ALE 固定论文/代码把 task 描述、inputs、software/environment、reference、evaluation 与 `load/start/evaluate` 生命周期连接起来；OSWorld/EvalPlus 的实验显示 alternate-correct 与测试覆盖不足风险。[S01-S03, S22-S23] [C] SWE-bench 维护者再审计报告了正确答案被拒、环境与污染问题。[S09/S24，同一底层来源] [I/R] 本项目因此把 Golden 定义为可反驳、可回归的 runnable contract。
4. **Batch zero 是故障隔离实验，不是小规模量产。** [R] 使用 blind solve、component swap、clean reset、保存 artifact/trace 与独立 adjudication，把问题标为 guideline、expert、case、environment、reference、evaluator；允许 primary cause + contributing causes。Agreement 只是一项症状指标，不是 root cause 或 validity。[S24, S28-S29]
5. **Reviewer 是 assurance authority，不是 author 的荣誉等级。** [F] NIST、NASA 与 UK AQuA Book 文本分别规定/建议 independent assessment、verification/validation 区分和 analyst/assurer 分离。[S25-S27] [I] 这些是规范与机制类比，并未证明本项目采用后必然提高质量。[R] 晋升必须在未见 cases 上证明 rubric 使用、合理多解判断、错误归因、理由质量、COI/保密与 escalation；不得最终裁决自己 authored/engineered 的 asset。
6. **职责分离必须落实到每个 instance/change/release，而不是只画组织图。** [F] NIST 与 GAO 文本包含 separation of duties、least privilege 和无法分离时的 alternative-control 要求/建议。[S30-S32] [I] 对 ALE-style 资产的风险降低效果尚需 pilot 测量。[R] 同一人不得闭环控制同一 asset 的 authoring、blind solve、sole review、reference/evaluator custody 与 final approval。
7. **NDA 不是安全、权利或 COI 的替代品。** [F] WIPO、GDPR、美国版权法、FTC、NIH 与 NIST 文本分别涉及 need-to-know、purpose limitation、data minimisation、chain of title、assignment-specific recusal、return/delete 与 deboarding。[S30-S39] [I/R] NDA 只覆盖其中部分风险；本项目把这些控制作为并列 gate。[P] 法域、worker status、合同和客户 data flow 决定具体义务。
8. **Micro1 五步法应“修改后全部保留”，并新增 owner mandate、盲化/权限分区、change control、持续抽审和 incident/retirement。** [I] 其顺序逻辑与公开证据相容；公开来源不验证其 staffing、产能、阈值或晋升标准。

### 1.1 三类来源交叉验证

[F] 证据卡按用途拆分，不等于独立来源：`S01/S20`、`S02/S21`、`S09/S24`、`S25/S31` 各自共享同一 canonical source cluster；ALE paper/code/HF 是同一项目的不同 evidence surfaces，不是三个独立机构。下表按 canonical cluster 去重，完整台账见 [`sources.csv`](sources.csv)。

| 重要结论 | 论文/代码或同行评议 | 政府/标准/方法 | 独立运营/再审计证据 | 状态与边界 |
|---|---|---|---|---|
| Golden 是 runnable contract | ALE frozen project surfaces [S01-S03/S20-S21，同项目]；OSWorld [S22] | NIST AI 800-2/RMF [S04, S25] | SWE-bench 再审计 [S09/S24，同源] | 强支持 runnable schema；字段深度由客户与 pilot 决定 |
| reference/evaluator 不是无误差真值 | EvalPlus [S23]；verifier hardening [S09b] | NIST cheating/TEVV [S05, S25] | SWE-bench [S09/S24，同源]；Terminal-Bench incident [S09a] | 强支持风险机制；不外推错误率 |
| 当前能力需角色相关直接证据 | work-sample/selection 元分析 [S12-S14, S1f-S1g] | OPM/EEOC/ISO [S10-S18] | EPA/NASEM panel 方法 [S19, S1a] | 支持；每个 gate 需 local validation |
| author 与 formal assurance 分离 | benchmark audit [S09/S24，同源]；academic verifier study [S09b] | NIST/NASA/AQuA/GAO [S25-S27, S30-S32] | ISO/NIH operating analogues [S33, S38] | 规范/机制与类比支持；本项目因果效果待 pilot |
| NDA 必须配合权限、权利与离场控制 | provenance/benchmark risk [S02-S05] | NIST/GAO/ISO [S30-S32, S38] | WIPO/GDPR/USCO/FTC/NIH [S33-S39] | 强支持；具体法律适用须 counsel/client facts |
| Batch zero 需要 controlled fault isolation | agreement 方法 [S28]；EvalPlus/OSWorld [S22-S23] | NIST measurement/TEVV、EPA calibration [S04-S06, S29] | ALE code 与 benchmark audit [S21, S09/S24] | 需要诊断有交叉支持；六类 taxonomy 是 [I/R] |
| Micro1 修改后保留 | ALE staged pipeline [S01-S03] | NIST/rights/governance controls [S04-S06, S30-S39] | academic/benchmark validity evidence [S07-S09b, S22-S24] | 仅与外部证据相容；Micro1 本身未被公开来源直接验证 |

## 2. 适用边界与决策原则

- [F] ALE v2 的公开流程包含 expert sourcing、first-pass review、engineering dry-run 和 expert final QC，但没有公开可迁移的专家资格权重、batch-zero size、agreement threshold、reviewer promotion rule 或 production staffing。[S01, S20]
- [I] 本报告设计的是高风险 benchmark production control system，不证明该组织必然具有更高 throughput、yield 或更低成本。
- [F] 人员选拔研究的研究对象是一般 job performance，并非 benchmark author/reviewer。[I] Laboratory、peer-review 与 NASA/FDA controls 仅作为可审查类比，不构成本项目法定认证或因果验证。
- [R] 法律与标准来源只转成流程 gate、记录要求和 counsel questions；不做跨法域法律结论，不声称 ISO/IEC 17025、NIST、NIH 或 FDA conformity。
- [R] “更多角色”不是目标。目标是让 authority、custody、execution、review 与 approval 可区分、可重建、可撤销；小团队可组合条件兼容的角色，但必须保留 hard incompatibilities 或书面 compensating controls。

## 3. 专家生产 Operating Model

[R] 下表是本项目 operating design；各 gate 的人员数、并行度、case/solver/repeat 构成、数值放行阈值与例外容忍度均为 [P]。

### 3.1 G0–G8 stage-gate families

| Gate | 主要工作 | 必交证据 | 放行条件 | Accountable |
|---|---|---|---|---|
| G0 Owner mandate | Intended use、construct、claim boundary、目标 workflow map、risk appetite | scope memo、unit ledger、client inputs、法律/安全问题清单 | 1,000 的单位、能/不能证明的 claim 与客户决策明确 | BO |
| G1 Rights/security envelope | 数据分级、权限、NDA/IP/PII/COI、reference custodian | data/rights map、access matrix、COI categories、incident route | raw data/客户材料可以合法且最小化分发 | RS |
| G2 Lead calibration | 已资格化 leads/engineers 建 scenario matrix 与 Golden package | guideline v0、Golden evidence pack、FAQ、known risks | clean demo evidence 与 blind-solve evidence 可执行；数量/构成为 [P] | GL |
| G3 Qualification & assignment | 多渠道 sourcing、身份/claim 验证、role-specific assessment | qualification packet、scope、COI/雇主限制、assignment | 候选人与 role/domain/software/risk 匹配 | GL |
| G4 Authoring & engineering | task spec、input、reference draft、environment、evaluator | versioned task/environment/reference/evaluator package | start/reset/health、rights 与 positive/negative controls 可运行 | TE（集成） |
| G5 Batch zero | Blinded crossed runs、独立 review、六类 root-cause | artifacts/traces、item×criterion decisions、incident log | 关键 defects 有归因、修复、回归或明确 underdetermined | GL |
| G6 Release assurance | Domain、technical、rights/security、reference custody 集成复核 | release memo、limitations、RACI/COI/access evidence | 无 unresolved mandatory blocker；FA 独立签字 | FA |
| G7 Controlled production | 版本化批次、风险抽审、quality/integrity monitoring | funnel、rework、root-cause、access/change logs | 只在 pilot-approved gates 内扩产；漂移可见 | BO |
| G8a Quality refresh/retire | Quarantine、repair、invalidate、rotate、retire | impact analysis、corrective evidence、new revision、closure | 受影响 lineage 已处理，quality 残余风险获批准 | BO |
| G8b Rights/security/deboard | Contain、revoke、rotate secret、return/delete、deboard | exposure/custody analysis、revocation/transfer evidence、closure | rights/security/access 决定单独关闭；release 仍由 FA 决定 | RS |

### 3.2 两条闭环

- **Asset loop [R]：** scenario → spec → environment/reference/evaluator → blind solve → domain/technical/security assurance → release。
- **Learning loop [R]：** disagreement/incident → 六类 root cause → versioned fix → regression → guideline/qualification update → re-baseline。

[R] 任何口头答疑、临时 tolerance、私下分享 reference 或 reviewer “凭经验放行”都会绕过闭环，必须转成有版本、有 owner、有影响面的变更单。

## 4. 专家画像与 Qualification Matrix

[F/C] 本节引用来源只支持各证据类型的 scope、局限与研究/机构主张。[I/R] 五类角色画像、red flags 与核验路由是本项目映射；任何录用、复测与晋升 cutoff 均为 [P]。

### 4.1 五类专家角色

| 角色 | 核心画像 | 最直接的资格证据 | 不能单独依赖 | 项目 gate |
|---|---|---|---|---|
| Domain expert | 概念/法规/变量/高风险场景与 credible alternatives 深度 | 近期实践、案例访谈、可验证专业判断/作品；必要执照 | 学位、论文数、seniority、协会会员 | unseen scenario 风险识别与反例分析 |
| Practitioner author | 当前能在目标软件中完成真实 workflow，并拆成可执行 spec/reference/evaluation | 等价环境 blind work sample、native artifact、trace、reverse walkthrough | 简历声称、静态作品、理论面试 | 先过 practitioner task，再过 authoring exercise |
| Group lead | 能做 capability map、guideline/Golden、校准、变更与升级；识别六类问题 | review/calibration sample、歧义诊断、版本变更记录 | 仅领域 seniority 或 people-manager title | 对含歧义/evaluator 缺陷样例分类、修订并说明证据 |
| Independent solver | 未见 reference/author rationale，仅凭 participant-visible packet 完成并记录阻塞 | 隔离、unseen、clean environment run + artifact/trace | author 自测、看过 Golden/reference 后求解 | prior-exposure/COI 声明；只见 R0 input |
| Domain reviewer | 判断领域正确性、alternate-correct、实质错误与边界，并写可审计理由 | blind review、counterexample generation、两阶段判断、shadow review | 高 author yield、与 lead 一致、解释流畅 | reviewer-specific Golden + shadow + 独立 promotion approval |

### 4.2 每种证据能证明什么

| 证据 | 能证明 | 不能证明 | 最小控制 |
|---|---|---|---|
| 简历/CV | 候选人声称的时间线、岗位、工具、项目 | 真实性、个人贡献、当前熟练度 | claim ledger；只核验岗位相关关键 claims；允许解释差异 [S15, S1e] |
| 学历/证书/执照 | issuer/scheme scope、考试或合法执业门槛、有效状态 | benchmark authoring、当前软件、完整实践质量 | issuer/registry、scope、status、recertification、discipline check [S18, S1b, S1g] |
| 近期实践 | 对目标 workflow/软件/约束的近期接触 | 每项能力都保持、独立完成、达到本项目标准 | 最后实操、版本、个人角色、可验证 outcome + blind sample [S14] |
| 作品/portfolio | 过去 artifact、复杂度、表达与决策上下文 | authorship、当前能力、展示权利、任务可比性 | contribution boundary、native source/versions、reverse walkthrough、rights [S15, S1e] |
| 结构化面试 | 可比的具体决策逻辑、失败复盘、边界、沟通 | 实际软件操作、artifact 质量、回答真实性 | 同题同序、预定义 probes、行为锚定评分、双人记录、pilot [S11-S12, S1f] |
| Blind work sample | 当前是否能在规定条件完成代表性工作 | 整个职业能力、长期协作、跨环境迁移、未来稳定 | unseen 变体、标准环境/合理便利、artifact+trace、identity binding [S10, S13, S16, S1c] |
| Role-specific Golden task | 对本项目 author/solver/reviewer 行为最接近的表现 | 泄漏后 general competence、其他软件/领域、永久稳定性 | 分角色、secure variant pool、exposure log、复测与 shadow audit [S10, S1c] |

### 4.3 反简历夸大、过时、代做、理论-only 与 COI

[I/R] 下列 red flags 只触发证据化核验，不自动拒绝；身份、监考或自动异常信号的 false-positive、合理便利与 appeal 结果必须在 pilot 评估。

| 风险 | Red flags（不是结论） | 决定性核验 | 不得采用的捷径 |
|---|---|---|---|
| 简历夸大 | 时间线/职责矛盾、一直用“we”、无法解释关键取舍 | structured claim/reference check；reverse walkthrough；blind sample 交叉验证 | 文风、口音、紧张或单一日期错误直接定罪 |
| 过时经验 | 只熟悉旧 UI/标准/格式，最近实践无法核验 | 当前或等价版本 blind sample；记录版本跨度与 relearning | 统一“超过 X 年失效”；按年龄/毕业年份筛除 |
| 代做/身份替换 | 阶段间身份/操作不一致、未授权协作者、trace 与现场动作冲突 | resolve/validate/verify；attended random variant；人工复核与 appeal | 单看证件、面部/键击/AI authorship score 自动封禁 |
| 理论-only | 能解释概念但无法创建/修改 native artifact，不能处理错误状态 | clean environment end-to-end software task；artifact/version/log/action/final state | 证书、论文、教程或口头 screen-share 当作完成证据 |
| 作品非本人主导 | 不能说明 personal action/decision，不能重现局部操作 | contribution boundary、原始 versions/commits（有权时）、mini-sample | 要求泄漏前雇主/客户机密；把团队协作本身视为负面 |
| COI/雇主限制 | 参与 reference、与客户/供应商/竞争方有利益、结果激励 | assignment-level disclosure、employer clearance、RS 决定 recusal/controls | 只在入池时问一次；让 conflicted reviewer 接触材料后再回避 |

[R] 自动异常信号只能触发人工核验，不得单独作不利决定；身份核验也不能证明专业能力。[S17, S1c]

## 5. Sourcing Channel 比较

[I/R] 以下是机制比较，不是行业事实、速度、成本或质量排名。本次检索没有找到六种渠道在 ALE-style 生产上的高质量 head-to-head 因果证据。[S19, S1a, S1d]

| 渠道 | 适用情况 | 稀缺触达/覆盖机制 | 质量与保密控制 | 可扩展性边界 |
|---|---|---|---|---|
| 已有专家池 | 重复/相邻 workflow，已有可审计历史 | Warm leads 与历史 calibration | 当前软件重资格；assignment COI；外部独立 solver/reviewer | 技能变旧、同质盲点、只覆盖曾招过领域 |
| 行业/职业协会 | 有执照/职业体系/标准、稀缺 sub-specialty | nominations、资格地图、多地区网络 | 协会只提名；会员不免测；披露 advocacy/sponsor | 单协会复制网络，非会员/边缘实践漏失 |
| 职业/开源社区 | 新工具、快速演化生态、公开 artifact 丰富 | alias/community contribution 发现 emergent practitioners | authorship/identity/license/employer check + blind sample | 热度/self-promotion/群体规范偏差；公开 profile ≠ 保密能力 |
| 大学实验室 | frontier science、罕见方法、文献/实验深度 | 论文/项目网络触达 niche expertise | grant/sponsor/IP/未发表数据 COI；若 author 仍过 practitioner task | 商业/监管 workflow 与专业软件熟练度未必覆盖 |
| 供应商/专业服务商 | vendor-specific 软件、格式、账号与支持 | 产品生态内稀缺 SME | marketing 不作证据；合同/license；涉及自家产品不得独立终审 | 单一实现偏见、直接商业利益、客户数据边界 |
| 定向猎寻 | capability map 明确缺口；需要行业×软件×法域交叉 | 可复现 search spec 与多 seed source | 保存 query/排除/转化；lead generation 与最终选择分离 | 依赖检索词/猎寻者判断，难形成可比全市场覆盖 |

[R] 所有渠道通过同一 role-specific gate；高风险/争议单元需要 source-diversity evidence。独立 lead source 的数量、构成与风险覆盖均为 [P]；单一 source cluster 须记录风险并增加独立 solve/review 证据。

## 6. Golden Case、Guideline 与 Batch-Zero 最小交付包

[R] 下表是 executable evidence-pack schema，而非来源原生标准；每类 control case、solver、reviewer、repeat 的数量与接受阈值均为 [P]。

| Package | 最小字段/文件 | 验收重点 |
|---|---|---|
| Construct & scenario | intended capability、excluded claims、scenario matrix、high-misclassification cases | 测量目标与客户 use case 对齐；不以难度/通过率替代 validity |
| Visible task contract | description、constraints、allowed resources、input/output paths、end condition | hidden evaluator 不强制题面不可合理推知的要求 |
| Input manifest | schema、format、hash、provenance、rights、visibility、异常约定 | 可重建、可授权、无 reference clue |
| Software/environment | OS/image/provider、software/plugins、license、locale/timezone、network、account、dependencies | clean build、health check、版本固定 |
| Start/reset…3246 tokens truncated…| C | C | I | C | C | C | I | C | C | I | A/R |
| Post-release monitor/invalidate/rotate/refresh | A | C | I | C | C | C | I | C | C | R | C |
| Quality-integrity incident/root-cause plan | A | R | I | R | R | R | C | R | C | R | C |
| Rights/PII/COI/reference-security incident | C | I | I | C | C | C | I | I | A | R | C |
| Transfer/deboarding/custody closure | I | C | I | C | C | C | I | I | A | R | I |

### 9.1 同一资产/变更/事件的硬不兼容角色

1. `AU ≠ IS`；作者/实质编辑者不是 blind solver。
2. `AU ≠ sole DR`；作者可答疑，不作唯一 domain disposition。
3. `AU/TE/EN/EE ≠ FA` 对自己的 artifact/change。
4. `IS ≠ DR` 对自己的 solver run。
5. Reference/evaluator custodian ≠ IS；有 sealed access 即不再 blind。
6. Access requester/privileged user ≠ RS access approver；OP 执行但不批准自己的 exception。
7. Production record creator/modifier ≠ 唯一能改写/关闭其 audit trail 的管理员。
8. Incident subject ≠ investigator/evidence custodian/closure approver。
9. `BO ≠ FA` 对 client-facing final/private holdout release；无法分离时需 independent countersignature。
10. Assignment-specific COI reviewer 不得接触受影响材料、讨论或决定。
11. Evaluator implementer 不得是其 coverage/control library 的唯一技术 accepter；environment builder 不得是其 clean-reset/rebuild evidence 的唯一 reproducer。独立 replay 的人员组合为 [P]。
12. 拥有同一资产 R2/R3 内容读取或导出权限的人，不得为该 blind run 提供 solver-facing provisioning/support 或操纵 evidence；必须跨侧时仅用 no-content service custody、独立审批与 protected logs。

[F] GAO 指出职责分离不能消除 override/collusion；无法严格分离时应设计 alternative controls。[S32] [R] 任何例外记录 scope、reason、duration、exposure、compensating control、approver 与 expiry；pilot 测其是否真实发现缺陷。

## 10. Confidentiality、Rights 与 COI Checklist

[R] `No/Unknown` 在 mandatory row 默认阻止生产 access 或 release，直到 RS/客户/法律顾问解决或记录被批准例外。[P] 法域、合同、worker status、data flow、retention 与例外容忍度由客户事实和 counsel 决定。

| Gate | 必须回答/保存的证据 | Owner | Unknown 时默认动作 |
|---|---|---|---|
| Customer authority | 哪个合同/指示允许接收、author、evaluate、retain 每个客户资产 | RS | Hold intake |
| Data inventory | 客户/专家数据、PII、confidential、credentials、traces 在哪里、由谁处理 | RS+OP | No production access |
| Purpose/minimisation | 每字段是否为明确目的所必需；能否 fictitious/redacted | RS+GL | Remove or justify |
| Retention/disposal | record class、owner、trigger、delete method、legal hold、evidence | RS+OP | 不编造期限；等 client-approved handling |
| Jurisdiction/transfer | parties、locations、cloud、onward transfer 与 counsel review | RS | 保持 approved boundary |
| NDA/access terms | protected info、purpose、use/disclosure、exceptions、incident、return/delete、survival | RS | No confidential access |
| Contributor IP | 谁创建 task/ref/rubric/evaluator；assignment/license/work-for-hire 是否成立 | RS | Hold release/reuse |
| Third-party rights | data/document/image/software/model/API/site/tool rights 是否兼容 sandbox/eval/release | RS+TE/EN | Replace/license/restrict |
| Employer restriction | outside work、confidentiality、client/export/professional duty、work product | RS+OP | 不分配受影响工作 |
| Inbound contamination | 明确不得带前雇主/客户 secrets/files/templates/credentials；记录 provenance | RS+GL | Quarantine，不传播 |
| Conflict of interest | 客户/source/vendor/competitor、prior task/ref、财务/个人关系与结果激励 | RS | Recuse or safeguards before access |
| Reference custody | author/ref/evaluator/solver access matrix、export/change logs | RS+OP | Draft 不进 production eval |
| Account security | unique identity、no shared password、task-scoped privilege、approved secret store | RS+OP | No access |
| Auditability | 能重建 create/change/view/export/seal/approve/release | OP+RS | Hold or approved compensating evidence |
| Supplier/subcontractor | security/IP/personnel change/onward subcontract/audit obligations 写入并验证 | RS+OP | No supplier access |
| Release clearance | 无 hidden refs、secrets、PII、comments/metadata、unlicensed material | RS+FA | Block release |
| Incident terms | report/preserve/contain/notify/customer contact/invalidation authority | RS+BO | Pause affected work |
| Deboarding | identity/asset inventory、revoke/transfer、return/delete、independent closure | RS+OP | Keep engagement open/escalate |

### 10.1 Reference custody states

- `R0 Public input`：solver 可见；保存 source、rights、hash/version。
- `R1 Working reference`：author/GL 可见的 candidate；完成 provenance、自检与分级。
- `R2 Sealed reference`：custody service 或 purpose-scoped DR/EE access；记录 seal/hash/version/access。
- `R3 Evaluator secret`：hidden tests/thresholds/credentials/judge prompt；service identity 优先。
- `R4 Release artifact`：经 rights/security、leak scan、release diff 与 FA 批准后才公开/交付。

## 11. 对 Micro1 方法的逐项裁决

[I/R] 本节只说明 Micro1 假设与外部证据相容并给出本项目修改；公开来源没有直接验证 Micro1 方法本身，所有人员构成、阈值与运营效果仍为 [P]。

| Micro1 假设 | 裁决 | 本项目修改 |
|---|---|---|
| 1. 少量 leads 先读材料/raw data、明确能力与风险、做 Golden/demo | **修改后保留** | 先加 G0 construct/claim boundary 与 G1 rights/security；纳入 task/environment/evaluator engineering 与 blind-solve evidence，具体人员/case/重复构成为 [P]。Golden 是待反驳控制包。 |
| 2. Golden 拆 scenario/rubric/A-B/checklist/正反例/FAQ，lead 走全流程 | **修改后保留** | 新增 input/software/expected artifact/alternate-correct/reference custody/evaluator controls/known-bad/start-reset/escalation/access/change log。A/B preference 仅在 construct 需要时。 |
| 3. 标准稳定后按简历/assessment/面试/seniority/vertical/client 招募 | **修改后保留** | Staged recruitment，不等永久稳定；资格按角色证据链，不以 seniority/credential 免测；客户要求转为 job-related、可审计 gate。 |
| 4. 最匹配专家跑 batch zero，区分 guideline/expert/case/合理多解 | **修改后保留** | 定义为 fault-isolation experiment；扩成 guideline/expert/case/environment/reference/evaluator 六类；盲化、component swap、trace、多标签归因。 |
| 5. 稳定、解释强的专家晋升 reviewer，建立升级 | **修改后保留** | 未见 cases、alternate-correct/known-bad/六类 fault、shadow review、COI/custody、独立批准、own-task recusal、drift/deboarding；不以 yield 为 KPI。 |

**删除的隐含假设 [R]：** 每个 case 都需要 A/B preference；高 agreement 即 guideline 正确；高 acceptance yield 即 reviewer 优秀；优秀 author 自动成为 reviewer。

**新增 [R]：** G0 owner/legal/security envelope；G3.5 身份/盲化/权限分区；每次变更 re-baseline；持续抽审；incident/rotation/retirement/deboarding。

## 12. 必须通过 Pilot 决定的人员与质量变量

### 12.1 人员与资格

- `Q_role,d`：domain 中满足 role-specific gate 的候选分布；按渠道记录，不当“市场供给率”。
- `A_role,d`：合格且在窗口内可用、通过 NDA/COI/雇主限制的 capacity。
- `H_role,stage,stratum`：各角色在各 gate、domain/software/evaluator/security stratum 的实测工时分布与尾部。
- `Span_GL`、`Span_DR`：lead/reviewer 可有效覆盖的 active work 与 escalation queue；由错漏和等待变化估计。
- Qualification signal predictiveness、sample reliability、sample-to-production transfer、retest delta、recency window、identity false positives/appeal outcomes。
- Channel coverage/duplication、qualified-and-cleared completion、COI/rights constraints；不预设渠道 yield、速度或成本。

### 12.2 生产与质量

```text
N_instances = Σ(workflow w) V_w
N_runs = Σ(configuration c, instance i) R_ci

N_idea -> N_spec_ready -> N_engineered -> N_oracle_pass
       -> N_independent_solve -> N_review_accept
       -> N_rights_security_clear -> N_release

H_total = Σ(role r, stage s, stratum k) H_r,s,k
Cost_total = Σr(H_r × Rate_r) + Compute + Storage + License + Security + Refresh
```

- `V_w` workflow→instance multiplicity、`R_ci` repeated runs、所有 `H_*`、`Rate_*` 与 funnel `p_*` 均为 [P]。
- [P] 若用 funnel 估算，`p_stage = N_stage / N_previous_stage` 是带分层与缺失说明的条件概率，不假设各 stage 独立；同时报告 numerator/denominator 与 uncertainty，点估计不直接成为 production commitment。
- Guideline question/ambiguity、case defects、rework loops 与 role handoff wait。
- Env clean-start/reset/rebuild/provider drift、license/permission incidents。
- Reference error、alternate-correct discovery、coverage gap、custody exposure。
- Evaluator false accept/reject、known-bad escape、legitimate regression、exploit/judge drift。
- Review disagreement/reversal/calibration drift/rationale、yield-pressure overrides。
- SoD exceptions/compensating-control detection、rights clearance exceptions、COI changes/recusal、access anomalies、revocation latency、incident containment。
- Pilot size、case/solver/reviewer/repeat composition、confidence/tolerance method、promotion/release threshold、audit/canary rate、advance/repair/rescope/stop gates 均 [P]。

Calendar time 还受稀缺 expertise、licensed environment、reference/evaluator 串行依赖与 rework queue 约束，不能用 `H_total/headcount` 简化。

## 13. 反方证据与残余风险

1. **Work sample 不是万能真值。** [F] 元分析提示经典效度叙事可能高估；技术/监控也可引入与目标能力无关的隐私、可及性与环境差异。[S12-S13, S1c] [R] 使用多证据链、合理便利、parallel forms 与 production shadow。
2. **证书有合法/专业价值，但 scope 有限。** [F] ISO 人员认证绑定 specific role/function 与 reassessment；执照考试研究不能支持广泛完整 practitioner competence 的因果主张。[S18, S1g]
3. **高 agreement 不等于 validity。** [F] Chance/base rate 可制造高 raw agreement；多数意见不决定 truth。[S28-S29] [R] 同看 confusion、理由、alternate-correct、adjudication 与 six-root-cause。
4. **独立 review 也有成本与盲点。** [F] AQuA/GAO 文本强调 proportionate assurance 和 alternative controls。[S27, S32] [I] 过度 compartmentalization 可能损失 tacit/domain context，须在 pilot 测 coordination cost 与漏检。[R] Author 可答疑/修订，但 formal acceptance 不回到 author。
5. **Deterministic evaluator 只能提高 repeatability，不自动保证 construct validity。** [F] Test insufficiency、narrow/wide tests、grader gaming 与 alternate-correct rejection 均有公开证据。[S05, S09, S09b, S22-S24]
6. **职责分离不能消除 collusion/override。** [F] GAO 明确承认残余风险。[S32] [R] 结合 protected logs、random rechecks、reason-coded appeals、independent closure 与 integrity culture。
7. **Audit logs 也是敏感数据。** [I] Logs 可能包含 PII、行为与 reference clues；同样需要 minimisation、access、retention 与 protected administration。
8. **法律适用 underdetermined。** [F] WIPO 指出国家法律不同；GDPR、美国版权、NIH/FDA/FTC 文本不能直接全球化。[S33-S39] [P] 客户、worker status、data flow、jurisdiction、contract 与 counsel 决定。

## 14. 可直接采用的项目建议

1. 在每个 instance ticket 加人名级 RACI、不兼容角色与 prior-exposure/COI check。
2. 用 `R0-R4` 分离 public input、working reference、sealed reference、evaluator secret、release artifact。
3. 把 Golden/guideline 从文档包升级为第 6 节的 executable evidence pack；所有口头标准进入 versioned FAQ/change log。
4. 把 batch zero 数据表设计成 item×criterion×expert×environment×reference×evaluator，可保存原始 judgment、reason、artifact、trace 与 adjudication。
5. Qualification 统一采用身份/claim → 结构化面试 → blind work sample → role-specific Golden；所有 sourcing channels 同 gate。
6. Reviewer 采用 blind qualification + two-stage reference reveal + shadow review + 独立 promotion；看 accepted 和 rejected cases。
7. Rights/security checklist 在 raw data 分发前执行；NDA、IP assignment/license、PII purpose、employer restriction、COI、custody 同时进 gate。
8. Rubric/evaluator 修改必须有 change request、impact analysis、positive/negative/alternate regression 与新 release decision。
9. Dashboard 不以 yield/throughput 代表质量；同时显示 false accept/reject、root causes、drift、overturn、COI/access/integrity incidents。
10. Deboarding 采用 event trigger、verified revocation、ownership transfer、return/delete、secret rotation（需要时）和独立 closure。

## 15. 假设检验结果

| 假设 | 结果 | 依据与失效条件 |
|---|---|---|
| H1 背景证据不等于当前表现，blind sample/Golden 更直接 | **支持但有限制** | OPM/EEOC/ISO + selection/work-sample 元分析；若 local pilot 显示直接样本无增量或引入不可接受 bias，则调整组合 [S10-S18] |
| H2 Raw agreement 不足以定位六类根因 | **强支持** | Agreement 方法、EPA、SWE-bench/OSWorld/EvalPlus 与 NIST environment/evaluator evidence [S04-S06, S22-S24, S28-S29] |
| H3 Asset-level separation/least privilege 可形成可审计风险控制 | **规范/机制与类比支持；因果效果待 pilot** | NIST/GAO/NASA/AQuA/NIH/WIPO；pilot 测 defect detection、leak/override exposure、SoD exception 与 coordination cost [S25-S27, S30-S34] |
| H4 Micro1 顺序可用但对 executable/governance 不完整 | **与外部证据相容；Micro1 本身未被直接验证** | ALE staged pipeline 与技术/治理证据支持修改方向，不证明 staffing、产能、阈值或效果 [S01-S09b, S20-S39] |

## 16. 来源表

完整逐源卡片位于 [`sources/`](sources/)，每张含元数据、短引文、支持/反驳、边界与评分；可筛选索引见 [`sources.csv`](sources.csv)。[F] `S01/S20`、`S02/S21`、`S09/S24`、`S25/S31` 是同一 canonical source 的不同用途摘录，只计一个独立来源；`sources.csv` 同时保留 institution/origin family，避免把同一项目不同 surface 当作独立验证者。

| ID | 来源 | 类型 | 本报告主要用途 |
|---|---|---|---|
| S01-S03 | [ALE paper](sources/01_ale_arxiv_v2.md)、[GitHub pinned](sources/02_ale_github_pinned.md)、[HF pinned](sources/03_ale_hf_pinned.md) | 论文/官方代码/数据 | 冻结术语、asset boundary、版本/unit |
| S04-S06 | [NIST AI 800-2](sources/04_nist_ai_800_2.md)、[agent cheating](sources/05_nist_agent_eval_cheating.md)、[AI 800-3](sources/06_nist_ai_800_3.md) | 政府方法 | TEVV、environment、contamination、measurement |
| S07-S09b | [Agents That Matter](sources/07_ai_agents_that_matter.md)、[SWE-bench method](sources/08_swebench_verified_method.md)、[reaudit](sources/09_swebench_verified_reaudit.md)、[Terminal-Bench](sources/09a_terminalbench_integrity.md)、[verifier hardening](sources/09b_verifier_hardening.md) | 学术/运营审计 | holdout、trace、test validity、gaming |
| S10-S11 | [OPM work samples](sources/10_opm_work_samples.md)、[structured interviews](sources/11_opm_structured_interviews.md) | 政府选拔方法 | current performance 与结构化面试 |
| S12-S14 | [Sackett 2022](sources/12_sackett_selection_validity_2022.md)、[Roth 2005](sources/13_roth_work_sample_meta_analysis_2005.md)、[skill decay](sources/14_arthur_skill_decay_meta_analysis_1998.md) | 同行评议元分析 | 反方效度与过时经验边界 |
| S15-S19 | [Reference checking](sources/15_opm_reference_checking.md)、[EEOC](sources/16_eeoc_uniform_guidelines_qanda.md)、[NIST identity](sources/17_nist_sp800_63a_identity_proofing.md)、[ISO 17024](sources/18_iso_iec_17024_2026.md)、[EPA experts](sources/19_epa_expert_elicitation_white_paper.md) | 政府/标准 | claim、identity、credential、expert selection |
| S1a-S1g | [NASEM](sources/1a_nasem_committee_balance_coi_2025.md)、[US Ed](sources/1b_us_ed_diploma_mills.md)、[ITC/ATP](sources/1c_itc_atp_technology_assessment_2025.md)、[Delphi review](sources/1d_schifano_delphi_scoping_review_2025.md)、[OPM accomplishments](sources/1e_opm_accomplishment_records.md)、[Interview meta-analysis](sources/1f_wingate_interview_meta_analysis_2025.md)、[licensing exam review](sources/1g_archer_licensing_exam_review_2016.md) | 政策/专业/学术 | panel balance、fraud、monitoring、渠道与限制 |
| S20-S24 | [ALE contract](sources/20_ale_arxiv_v2_batchzero.md)、[pinned code](sources/21_ale_github_pinned_task_contract.md)、[OSWorld](sources/22_osworld_alternate_correct_execution.md)、[EvalPlus](sources/23_evalplus_test_insufficiency.md)、[SWE-bench audit](sources/24_swebench_verified_reaudit.md) | 论文/代码/审计 | Golden、alternate-correct、test insufficiency |
| S25-S29 | [NIST RMF](sources/25_nist_ai_rmf_tevv_independence.md)、[NASA IV&V](sources/26_nasa_ivv_independence.md)、[AQuA](sources/27_uk_aqua_book_assurance.md)、[agreement method](sources/28_plos_raw_agreement_limit.md)、[EPA calibration](sources/29_epa_expert_calibration_boundary.md) | 政府/学术方法 | independence、assurance、agreement/calibration |
| S30-S34 | [NIST 800-53](sources/30_nist_sp800_53_roles_access_termination.md)、[AI RMF governance](sources/31_nist_ai_rmf_governance_roles_monitoring.md)、[GAO](sources/32_gao_green_book_segregation_alternative_controls.md)、[NIH](sources/33_nih_peer_review_confidentiality_coi_escalation.md)、[WIPO](sources/34_wipo_trade_secret_management_access_exit_contamination.md) | 控制/运营/IP | SoD、access、COI、custody、exit |
| S35-S39 | [GDPR](sources/35_eu_gdpr_minimization_security_records.md)、[US Copyright](sources/36_us_copyright_ownership_transfer_work_for_hire.md)、[FDA](sources/37_fda_audit_trail_attribution_access.md)、[ISO 17025 overview](sources/38_iso_iec_17025_competence_impartiality_consistency.md)、[FTC](sources/39_ftc_data_minimization_retention_vendor_oversight.md) | 法律/监管/标准 | PII、chain of title、audit trail、impartiality、vendor/data controls |

## 17. Refresh Targets

详细 delta-refresh 表见 [`refresh_targets.md`](refresh_targets.md)。优先监控：ALE 三个冻结表面的新 revision；NIST AI 800-2 final 与 AI RMF revision；ISO/IEC 17024/17025；目标法域数据/IP/劳动与 contractor rules；专业 license/certification registries；软件/license/ToS/VM image；reference/evaluator 泄漏或 exploit；qualification/Golden exposure；COI/雇主关系；pilot strata 的 drift。

每次 refresh 保存旧/新 revision、访问日、变更摘要、受影响 claim/instance、replay/regression、rights/COI/access decision 与 repair/invalidate/rotate/retire 结果。

---

**最终判断：** [R] 1,000 个 runnable instances 的核心组织问题不是“招多少专家”，而是把专业真实性、可执行性、reference/evaluator validity、独立判断、权利与 custody 组合成一条可审计的 release chain。只有 pilot 能把这条 chain 中的人员、阈值、吞吐、返工与成本变量冻结为项目承诺。

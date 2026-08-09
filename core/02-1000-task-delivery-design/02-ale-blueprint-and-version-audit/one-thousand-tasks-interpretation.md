# E. 面试作业中“一千道题”的最严谨解释

## 建议直接说

> 我不会把“一千道题”默认解释成一千个 prompt、workflow 或专家 submission。最可验收的默认口径是：**在一组经客户批准的 workflow portfolio 上，交付约 1,000 个完成实现与最终 QC 的 runnable task instances**。每个 accepted instance 必须包含 versioned task specification、visible inputs、可复现 start state、required software/environment、hidden reference、executable evaluator、专家与工程 QA 证据，以及 public/private/rotation 状态。workflow 数、submission 数、commissioned source projects、experts 和 validation runs 必须单列，由 pilot 估计，不从 ALE 的 960/1,490 历史快照倒推。

## 合同中的五个独立计数器

```text
S = expert submissions entering review
C = commissioned source projects/items
W = accepted workflow specifications / shared evaluator families
I = accepted runnable task instances
R = agent runs for dry-run, evaluator QA, calibration and final evaluation

I = Σ_w accepted_instances_per_workflow(w)
R = Σ(instance × agent_configuration × planned_trials) + infrastructure retries
```

`S/C/W/I/R` 不可互换。`I/W` 是项目完成后才可观察的 multiplicity distribution；ALE v2 的 `1,490/960≈1.55` 不是 quota，且两个 `960` 没有公开 crosswalk。

## Accepted instance 的 Definition of Done

- task ID、workflow ID、instance ID、taxonomy version 与 release status 已固定；
- input bytes/hash、provenance/use rights 与 hidden reference/hash 已登记；
- `task_card + load/start/evaluate` package 可在 clean environment 重建并 dry-run；
- start state 可复现、reference 对 agent 隔离、missing output 与 infra error 语义明确；
- evaluator 通过 gold/known-bad/alternative-correct、mutation/metamorphic 与 anti-gaming 测试；
- expert reference review、independent spec execution、engineering QA、final committee acceptance 有审计记录；
- environment image/software/license/network/budget 与 evaluator revision 可回放；
- public/private/rotation/retirement、access control 与 contamination/exposure ledger 已配置；
- 至少通过项目 pilot 定义的 reproducibility gate；重复次数和阈值不在没有数据时预设。

## 不计入最终 1,000 的对象

- 未实现的 task idea、prompt、HF metadata card 或 raw submission；
- pending-QC、blocked license/data、failed dry-run、evaluator 未校准或 reference 泄漏项；
- 同一 instance 的 retry、repeated trial、best-of-k run；
- 只更改文件名/随机种子而未证明同一 construct、复杂度和 evaluator validity 的伪 variant；
- 只在旧/污染 manifest 上通过、但无法在 fresh holdout 复现的结果。

## Pilot 必须估计，公开资料不足以预填的变量

```text
Submission yield       = accepted_workflows_from_submissions / S
Commission yield       = accepted_workflows_from_commissions / C
Instance multiplicity  = distribution(I_w | accepted workflow w)
Engineering load       = hours by environment family + evaluator family
QC rework              = rework cycles and defect escape by gate
Evaluator validity     = FPR, FNR, expert disagreement, judge drift
Reliability            = per-instance/run variance; pass@k and pass^k as required
Infrastructure cost    = Σ measured VM + license + API + storage + human adjudication
Calendar schedule      = critical path through expert, license, environment, evaluator, QC
```

不能从公开 ALE 数字直接给出 workflow/instance/domain/public-private 配额、专家人数、成本、工期、acceptance rate、FPR/FNR 阈值或重复次数。应写：**公开资料不足；先做 stratified pilot，再冻结 production plan 与 SOW。**

## 对产品范围的直接决策

1. **先选产品用途，再选 task。** training/dev、public demo、private final holdout、rotation pool 是互斥或受控用途；同一 exposed instance 不能同时声称是未见 final holdout。
2. **以 workflow/evaluator/environment family 规划产能。** raw instance 数不是主要复杂度代理；新专业软件、新 reference 形态和新 evaluator family 才可能打开新的工程关键路径。
3. **task selection 采用客户 sampling frame。** 可按业务价值、风险、使用频率、战略空缺或 balanced capability coverage；ALE 的 13/55 和当前 counts 只提供 taxonomy 参考，不提供客户配额。
4. **专家组织分层。** practitioner 负责专业真实性/reference；research lead 负责 construct/sampling；task engineer 负责 executable package；evaluator engineer 负责 grader；infra/license owner 负责 sandbox；independent QA/adjudicator 负责盲审；release owner 负责 manifest/权限/轮换。
5. **交付物是 measurement system。** 除 1,000 accepted instances 外还要交 taxonomy/coverage matrix、versioned manifest、images/software matrix、evaluators、QA/audit evidence、run/config cards、private-pool governance 与 refresh protocol。

**Primary evidence:** [arXiv v2/HF audit](findings/F1_paper_hf_version_audit.md), [task package docs](sources/41_official_add_task_docs.md), [adversarial QA review](findings/F3_adversarial_construct_validity.md).

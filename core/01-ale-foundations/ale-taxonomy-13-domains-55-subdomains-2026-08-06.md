# ALE taxonomy：13 个 domain 与 55 个 subdomain

## 结论先行

ALE 至少有三个不能混用的分类表面：

1. **arXiv v2 Figure 2（2026-06-11 的冻结快照）**：13 个具名 domain 下显示 54 个 subdomain，另有 `Other → Sports`，合计 55 个 subdomain、1,490 个 runnable task instances。
2. **当前官方 taxonomy 网页（检索于 2026-08-06）**：严格显示 13 个 domain、55 个 subdomain、100 个 benchmark leaves；没有 `Other` 或 `Sports`。
3. **当前 Hugging Face 公共 task-card 数据**：仍可看到 `14 / other → 14.1 / sports`，但 153 条公共记录只覆盖 51 个唯一 structured subdomain mappings，不能用来独立重建完整 55 项 taxonomy；顶层 `category` 是存储/路径标签，不是可靠的 taxonomy parent。

因此，若问题是“现在官网的 13×55 是什么”，使用下表；若问题是“论文 v2 Figure 2 的 55 项是什么”，使用后面的版本差异说明重建，且必须保留 `Other/Sports` 注释。

## 当前官网：13 domains × 55 subdomains

| # | Domain | Subdomains |
|---:|---|---|
| 1 | Engineering & Architecture (11) | Aerospace & Mechanical Engineering; Electronics Engineering; Civil, Architectural & Geospatial Engineering; Chemical & Process Engineering; Manufacturing & Industrial Systems; Energy, Power & Nuclear Engineering; Mining, Petroleum & Geological Engineering; Semiconductor & Microelectronics Design; Marine & Naval Engineering; Urban & Spatial Planning; Robotics & Autonomous Systems |
| 2 | Physical Sciences (4) | Physics; Chemistry & Materials Computation; Astronomy & Astrophysics; Earth & Atmospheric Sciences |
| 3 | Life Sciences (4) | Biomolecular Structure & Design; Genomics & Sequence Analysis; Cell & Imaging Biology; Systems & Microbial Biology |
| 4 | Health & Medicine (5) | Clinical Diagnostics & Imaging; Therapeutic & Oncology Services; Clinical Informatics & Care Operations; Public Health & Epidemiology; Clinical Research & Trial Operations |
| 5 | Psychology & Neuroscience (2) | Computational Neuroscience; Experimental Psychology & Neuroimaging |
| 6 | Business & Finance (7) | Accounting & Finance; Actuarial & Risk Modeling; Enterprise Analytics & Planning; Compliance & Regulatory; HR & Project Management; Sales & Marketing; Quantitative Finance & Trading |
| 7 | Legal (2) | Litigation Support & Discovery; Doctrinal Legal Research |
| 8 | Visual & Media Arts (4) | 3D, Animation & Interactive Media; Graphic, Visual & Product Design; Fashion & Apparel; Audio, Music & Post-Production Media |
| 9 | Computing, Data & Mathematical Sciences (7) | Software Engineering; Data & Analytics Engineering; AI Engineering, Safety & CS Research; Mathematical & Operations Research; Cybersecurity & Digital Forensics; Infrastructure Engineering & Cloud Operations; Quantum Computing |
| 10 | Transportation & Safety Operations (3) | Aviation & Airspace Operations; Maritime & Port Operations; Fire Science & Public Safety |
| 11 | Education & Information Services (3) | Educational Technology; Library & Information Science; Translation & Localization |
| 12 | Agriculture & Environment (2) | Environmental Modeling, Engineering & Water Resources; Precision Agriculture |
| 13 | Social Sciences (1) | Economics & Quantitative Social Research |

计数校验：`11 + 4 + 4 + 5 + 2 + 7 + 2 + 4 + 7 + 3 + 3 + 2 + 1 = 55`。

## arXiv v2 Figure 2：怎样从现行表还原论文快照

把缩写展开和措辞更新视为同一分类沿革后，与上面的现行官网 55 项相比，Figure 2 有四项**成员层级变化**：

- 删除 Engineering & Architecture 下的 `Marine & Naval Engineering`；
- 删除 Visual & Media Arts 下的 `Fashion & Apparel`；
- 在 Business & Finance 下加入 `Supply Chain & Logistics`；
- 在 13 个具名 domain 之外，以残余条带 `Other → Sports` 加入第 55 项。

所以 v2 Figure 2 的计数结构是：

- 13 个具名 domain：54 个 subdomains、1,487 个 task instances；
- `Other → Sports`：1 个 subdomain、3 个 task instances；
- 总计：55 个 subdomains、1,490 个 task instances。

论文没有说明 `Sports` 在 13 个正式 domain 中应归到哪一个，也没有把 `Other` 明确定义为第 14 个正式 domain。最保守的写法是：**`Other` 是 Figure 2 层面的额外 bucket；其中的 `Sports` 提供了使显示总数达到 55 的额外一项。**“残余容器”是审阅解释，不是论文原词。

除上述成员变化外，现行网页还展开或更新了若干标签措辞，例如 `Computing & Math Sci.` 变为 `Computing, Data & Mathematical Sciences`，`AI Engineering & CS Res.` 变为 `AI Engineering, Safety & CS Research`。因此，“四项差异”仅指标签归一化后的成员/层级变化，不是说精确字符串只有四处不同。

## 对面试作业的引用建议

若方案以论文 v2 的 1,490 instances 为生产基线，建议写：

> 本方案以 ALE arXiv v2（2026-06-11）Figure 2 的任务分布为冻结参照。该图显示 13 个普通 domain 条带、其下 54 个 subdomain，另有 `Other → Sports`，使显示总数达到论文报告的 55 个 subdomain；论文未解释 `Sports` 在正式 13-domain 层级中的归属。现行官网已更新为另一套严格的 13×55×100 层级，因此本文不混用两个版本的分类口径。

## 一手来源

- [ALE arXiv v2 HTML](https://arxiv.org/html/2606.05405v2)
- [ALE arXiv v2 abstract/version record](https://arxiv.org/abs/2606.05405v2)
- [ALE current Industry Taxonomy](https://agents-last-exam.org/taxonomy)
- [ALE Hugging Face public task-card dataset](https://huggingface.co/datasets/agents-last-exam/agents-last-exam)

## 审计底稿

- `sources/01_arxiv_v2_taxonomy.md`：Figure 2 全量标签、任务数与计数校验。
- `sources/02_official_live_taxonomy.md`：现行官网 13×55×100 层级及官网/仓库差异。
- `sources/03_huggingface_taxonomy.md`：153 条公共 task cards 的字段、51 个可观测 structured mappings、`category`/taxonomy 错位和 `Other/Sports` 记录。

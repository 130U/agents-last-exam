# ALE public task corpus audit

研究日期：2026-08-08。对象仅为 UC Berkeley RDI / RDI Foundation 的 Agents’ Last Exam（ALE）。

## 交付入口

- 主报告：[`REPORT.md`](REPORT.md)
- A — machine-readable task inventory：[`data/task_inventory.jsonl`](data/task_inventory.jsonl)、[`data/task_inventory.csv`](data/task_inventory.csv)
- B — evaluator archetype library：[`evaluator_archetype_library.md`](evaluator_archetype_library.md)、[`data/evaluator_archetype_library.json`](data/evaluator_archetype_library.json)
- C — corpus coverage/gap：[`data/inventory_summary.json`](data/inventory_summary.json)、[`data/version_diff.json`](data/version_diff.json)
- D — 10 条样题模式：主报告对应章节
- E — 无法公开回答的问题：主报告对应章节与每行 `public_information_gaps`
- 26 个 mini case studies：[`mini_case_studies.md`](mini_case_studies.md)
- 逐来源证据卡：[`sources/README.md`](sources/README.md)、[`sources/source_index.csv`](sources/source_index.csv)
- 机器校验：[`VALIDATION.json`](VALIDATION.json)

## 固定版本

- arXiv：`2606.05405v2`
- GitHub commit：`1e615e456de7cef57706680613cb80ee13c7fc76`
- Hugging Face revision：`a8c1fd174a1f6cfa76526572a2e3ebece1276be2`
- HF Parquet SHA256：`B6661183018F65F332260D1981F656102FEDCC17C8EE96C0DFE18A5AF9C184E8`

报告将论文、live site、Git、HF 与 gallery 保留为不同快照；153 个 metadata rows、152 个 split paths、165 个 Git task folders、workflow、runnable instance 与 agent run 不互换。

## 重建与验证

1. 运行 `scripts/build_inventory.py` 读取本地冻结 snapshots。
2. 运行 `scripts/reconcile_judge_classes.py` 应用三项人工 executable-code-path 仲裁。
3. 运行 `scripts/export_source_records.py` 重建 evidence cards、evaluator library 与 mini cases。
4. 运行 `scripts/validate_deliverables.py`；只有 `VALIDATION.json.status == PASS` 才视为交付完成。

`estimated_workflow_length` 是 prompt/checklist proxy，不是观测 action/tool-call 数、人工工时或 wall-clock。Task/evaluator archetypes 是研究员生成的重叠标签，不是 ALE 官方 taxonomy 或 private-pool 分布。

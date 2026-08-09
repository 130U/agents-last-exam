# Evaluator archetype library

固定版本：Git `1e615e456de7cef57706680613cb80ee13c7fc76`；访问日 2026-08-08。

这些是研究员从公开 evaluator 实现归纳出的重叠模式，不是 ALE 官方 taxonomy。

## Exact/hash/set equality

- 形式：Parse artifact, normalize stable fields, then compare bytes, hashes, IDs, or canonical sets.
- 最适用：Flags, manifests, exact row membership, fixed structured answers.
- 公开案例：computing_math/ghidra_malware_config_extraction_01; health_medicine/public_health_mask_mandate_ratio
- 主要失效模式：Brittle formatting dependence; Overly narrow answer keys; Reference leakage makes the task trivial
- 最低 QA：Canonicalization tests; Positive and realistic negative fixtures; Hidden-reference isolation test

## Schema gate plus tolerant field scoring

- 形式：Reject missing/unparseable outputs, then score numeric/text fields with exact, tolerance, or set-overlap rules.
- 最适用：CSV/JSON/workbook/GIS transformations and scientific results.
- 公开案例：agriculture_env/crop_rotation_d02; business_finance/basel_operational_risk_bia_cn
- 主要失效模式：Schema passes while semantics are wrong; Tolerance bands are too permissive or too narrow
- 最低 QA：Boundary-value tests; Column-order/ID coverage checks; Independent recomputation of derived fields

## Tiered partial-credit evaluator

- 形式：Mandatory base tier unlocks partial credit; harder tiers add score without rewarding fabricated claims.
- 最适用：Long numerical or algorithmic tasks with separable capability levels.
- 公开案例：business_finance/american_option_pricing_ls; computing_math/cfr_game_theory_equilibrium
- 主要失效模式：Agents optimize only the easiest tier; Tier weights distort the intended capability
- 最低 QA：Truthfulness checks; Cross-file consistency; Per-tier fixture calibration

## Executable/replay verifier

- 形式：Run, replay, compile, rebuild, or simulate the submitted artifact under fixed inputs.
- 最适用：Code, infrastructure, EDA, pipelines, and behavioral state.
- 公开案例：computing_math/k8s_migration_1; engineering/openroad_sky130_ibex_pnr_signoff
- 主要失效模式：Dependency drift; Nondeterministic runtime; Harness privileges or network access change results
- 最低 QA：Pinned runtime; Clean-room rerun; Timeout/resource ceilings; Mutation tests

## Application-state/database query

- 形式：Inspect the post-run database or application state for tagged business objects and exact balances/statuses.
- 最适用：ERP, BI, CRM, and other workflows where files are not the true outcome.
- 公开案例：business_finance/odoo; business_finance/metabase_bi_dashboard_01
- 主要失效模式：UI evidence diverges from database state; Agents write directly to storage while bypassing the intended workflow
- 最低 QA：Provenance/run tags; State-integrity constraints; Checks for unauthorized direct mutation

## Geometry/render/reference metric

- 形式：Render or sample geometry under canonical cameras and compare distance, silhouette, topology, or image metrics.
- 最适用：CAD, meshes, animation, medical imaging, and visual transformations.
- 公开案例：engineering/gcode; visual_media/chroma_key_from_reference
- 主要失效模式：Camera-specific overfitting; Metric-good but professionally poor artifacts; Renderer/version drift
- 最低 QA：Multiple held-out views; Geometry validity gates; Renderer and camera pinning

## Audio/music signal comparison

- 形式：Compare MIDI events, correlations, MFCC/timbral similarity, or track/stem completeness.
- 最适用：Transcription, project migration, and audio post-production.
- 公开案例：visual_media/music_transcription; visual_media/project_migration
- 主要失效模式：Perceptually poor outputs score well on narrow signal metrics; Alignment/matching errors
- 最低 QA：Perceptual counterexamples; Robust alignment; Silence/clipping gates

## Narrow LLM/VLM binary rubric

- 形式：Ask evidence-anchored yes/no questions over text or paired images and aggregate answers.
- 最适用：Residual semantic or visual qualities with no deterministic reduction.
- 公开案例：business_finance/pe_screening_memo_1; engineering/2d_drawings_to_3d_building_model
- 主要失效模式：Judge drift; Prompt injection in artifacts; Plausibility bias; API/model availability
- 最低 QA：Frozen judge model/prompt; Multiple adversarial fixtures; Judge-output logging; Human spot audit

## Hybrid hard/soft gate-and-score

- 形式：Deterministic validity and quality signals are combined with a narrow LLM/VLM residual judgment.
- 最适用：Editable visual/media artifacts that need both structural and semantic checks.
- 公开案例：visual_media/skeletal_animation_reproduction; business_finance/saas_onepager_brand_refresh_instance_1
- 主要失效模式：Fallback changes score semantics; Weighting hides a weak hard component; Card/code mismatch
- 最低 QA：Declare fallback behavior; Version the judge and weights; Cross-check metadata against executable code

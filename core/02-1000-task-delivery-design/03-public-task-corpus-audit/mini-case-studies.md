# 代表性 mini case studies

以下 26 个案例均来自固定 Git commit 与对齐的公开 metadata。选择标签是研究判断，不能解读为统计排名。

## 1. `agriculture_env/crop_rotation_d02` — Crop Rotation Audit for Stable Parcels

- Domain / subdomain：agriculture_env / Precision Agriculture
- Tier / OS / snapshot：near-term / Windows / cpu-free
- Software：Python; GeoPandas; pandas; pyogrio; shapely; pyproj; fiona
- Inputs → outputs：GeoPackage; Markdown; text → GeoPackage
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks
- 代表性：A clean geospatial transformation with exact CRS, schema, ID-set, and field-value checks.
- 标签：sample_task_candidate; evaluator_learning
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/agriculture_env/crop_rotation_d02.

## 2. `business_finance/ar_full_1500` — Annual Report Full Extraction (1500 files)

- Domain / subdomain：business_finance / Accounting & Finance
- Tier / OS / snapshot：last-exam / Windows / cpu-free
- Software：Microsoft Edge; Python
- Inputs → outputs：txt → xlsx; directory
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; executable / behavioral verifier
- 代表性：A browser-plus-Python bulk workflow whose workload scale is materially larger than a simple file transformation.
- 标签：无专项标签
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/business_finance/ar_full_1500.

## 3. `business_finance/basel_operational_risk_bia_cn` — Basel Operational Risk BIA Classification

- Domain / subdomain：business_finance / Actuarial & Risk Modeling
- Tier / OS / snapshot：full-spectrum / Ubuntu Linux / cpu-free-ubuntu
- Software：LibreOffice Calc; Python; openpyxl
- Inputs → outputs：md; xlsx; csv/json/txt → csv; json; txt
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds
- 代表性：A multilingual spreadsheet classification and regulatory calculation task with structured, auditable outputs.
- 标签：sample_task_candidate
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/business_finance/basel_operational_risk_bia_cn.

## 4. `business_finance/odoo` — Odoo Supply-Chain End-To-End Workflow

- Domain / subdomain：business_finance / Supply Chain & Logistics
- Tier / OS / snapshot：full-spectrum / Windows / cpu-free
- Software：Odoo 19; PostgreSQL 17
- Inputs → outputs：`.txt` → `.png`; `.txt`
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; render / geometry comparison; application-state / database query; hard gate plus partial/continuous score; weighted or averaged multi-component rubric
- 代表性：A genuine application-state workflow scored through PostgreSQL evidence rather than screenshots alone.
- 标签：无专项标签
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/business_finance/odoo.

## 5. `business_finance/pe_screening_memo_1` — PE Screening Memo 1

- Domain / subdomain：business_finance / Accounting & Finance
- Tier / OS / snapshot：near-term / Ubuntu Linux / cpu-free-ubuntu
- Software：Python
- Inputs → outputs：Markdown; JSON; PDF and plaintext extract → Markdown
- Evaluator：LLM-judge；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; narrow LLM/VLM rubric; hard gate plus partial/continuous score
- 代表性：A professional memo whose semantic coverage is judged with narrow LLM questions after deterministic gates.
- 标签：gaming_risk
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/business_finance/pe_screening_memo_1.

## 6. `business_finance/saas_onepager_brand_refresh_instance_1` — SaaS One-Pager Brand Refresh

- Domain / subdomain：visual_media / Graphic, Visual & Product Design
- Tier / OS / snapshot：near-term / Windows / cpu-free
- Software：Microsoft PowerPoint
- Inputs → outputs：PNG image; text; PDF; CSV; asset directory; Markdown; JSON → PowerPoint; PNG image
- Evaluator：hybrid；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds; render / geometry comparison; hybrid deterministic-plus-LLM/VLM; hard gate plus partial/continuous score; weighted or averaged multi-component rubric
- 代表性：An editable PowerPoint plus raster export with anti-copy heuristics and an optional VLM layer.
- 标签：gaming_risk
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/business_finance/saas_onepager_brand_refresh_instance_1.

## 7. `computing_math/ghidra_malware_config_extraction_01` — Ghidra Malware Config Extraction

- Domain / subdomain：computing_math / Cybersecurity & Digital Forensics
- Tier / OS / snapshot：near-term / Windows / cpu-free
- Software：Ghidra 11.3; JDK 21
- Inputs → outputs：Windows PE; JSON; BAT → JSON
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; hard gate plus partial/continuous score
- 代表性：A Windows reverse-engineering task with a structured JSON answer and deterministic grading.
- 标签：无专项标签
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/computing_math/ghidra_malware_config_extraction_01.

## 8. `computing_math/k8s_migration_1` — Docker Compose To Kubernetes Migration

- Domain / subdomain：computing_math / Infrastructure Engineering & Cloud Operations
- Tier / OS / snapshot：near-term / Ubuntu Linux / cpu-free-ubuntu
- Software：Docker; Minikube; kubectl; Helm; Terraform; Trivy; Python
- Inputs → outputs：markdown; yaml; directory; sql; text → directory; yaml
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; executable / behavioral verifier; render / geometry comparison; hard gate plus partial/continuous score
- 代表性：A multi-file infrastructure migration whose artifacts can be linted, deployed, and behaviorally tested.
- 标签：sample_task_candidate
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/computing_math/k8s_migration_1.

## 9. `computing_math/paper_reproduction_instance_1` — LCA-on-the-Line Table 2 Reproduction

- Domain / subdomain：computing_math / AI Engineering, Safety & CS Research
- Tier / OS / snapshot：near-term / Ubuntu Linux / cpu-free-ubuntu
- Software：Python; PyTorch; NumPy; pandas; SciPy; scikit-learn; statsmodels
- Inputs → outputs：pdf; zip; md → json
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; render / geometry comparison; hard gate plus partial/continuous score; weighted or averaged multi-component rubric
- 代表性：A research-reproduction task combining a paper, codebase, fixed environment, and quantitative result contract.
- 标签：无专项标签
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/computing_math/paper_reproduction_instance_1.

## 10. `computing_math/go_game_reconstruction_1` — Go Game Reconstruction 1

- Domain / subdomain：other / Sports
- Tier / OS / snapshot：full-spectrum / Ubuntu Linux / cpu-free-ubuntu
- Software：Sabaki v0.52.2; Python; sgfmill
- Inputs → outputs：PNG image; Linux AppImage → SGF
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; executable / behavioral verifier; render / geometry comparison; hard gate plus partial/continuous score
- 代表性：A deterministic SGF replay evaluator with an explicit unresolved identifiability reservation.
- 标签：gaming_risk
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/computing_math/go_game_reconstruction_1.

## 11. `education_info/homework_grading_numerical_pdes_instance_02` — Homework Grading Numerical PDEs 02

- Domain / subdomain：education_info / Educational Technology
- Tier / OS / snapshot：near-term / Ubuntu Linux / cpu-free-ubuntu
- Software：Python
- Inputs → outputs：Markdown, PDF, JSON; Python + JSON → CSV, JSON, Markdown
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; hard gate plus partial/continuous score; weighted or averaged multi-component rubric
- 代表性：A five-artifact grading bundle scored by exact scores, set overlap, phrase coverage, and manifest checks.
- 标签：evaluator_learning
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/education_info/homework_grading_numerical_pdes_instance_02.

## 12. `business_finance/american_option_pricing_ls` — American Option Pricing via Longstaff-Schwartz

- Domain / subdomain：business_finance / Quantitative Finance & Trading
- Tier / OS / snapshot：full-spectrum / Ubuntu Linux / cpu-free-ubuntu
- Software：Python; NumPy; SciPy; uv
- Inputs → outputs：Markdown; TOML; Lockfile; Shell script → JSON; NumPy array
- Evaluator：deterministic；structured artifact / exact-or-tolerant field checks; continuous metric with thresholds
- 代表性：A transparent three-tier scorer that preserves useful partial credit while blocking fabricated scalar-only results.
- 标签：evaluator_learning
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/business_finance/american_option_pricing_ls.

## 13. `engineering/openroad_sky130_ibex_pnr_signoff` — OpenROAD SKY130 Ibex PnR Signoff

- Domain / subdomain：engineering / Semiconductor & Microelectronics Design
- Tier / OS / snapshot：last-exam / Ubuntu Linux / cpu-free-ubuntu
- Software：OpenROAD-flow-scripts; Docker; Python
- Inputs → outputs：Markdown; directory; shell script → Makefile fragment; Markdown; log artifact; stamp file
- Evaluator：deterministic；executable / behavioral verifier; hard gate plus partial/continuous score; weighted or averaged multi-component rubric
- 代表性：An evaluator that rebuilds the submitted configuration in a pristine flow and uses hard quality gates plus partial credit.
- 标签：evaluator_learning
- 证据定位：Pinned GitHub task_card.json/main.py and aligned HF row at tasks/engineering/openroad_sky130_ibex_pnr_signoff.

## 14. `physical_sciences/lenacapavir_sar_table2_extraction` — Lenacapavir SAR Table2 Extraction

- Domain / subdomain：life_sciences / Biomolecular Structure & Design
- Tier / OS / snapshot：near-term / Windows / cpu-free
- Software：Microsoft Edge; Visual Studio Code; Python
- Inputs → outputs：`.pdf` → `.csv`
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
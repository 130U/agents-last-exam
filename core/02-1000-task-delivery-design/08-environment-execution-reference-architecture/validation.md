# Validation record

Date: 2026-08-09

## Deliverable truth

- Primary editable report: `artifacts/ALE_Environment_Execution_Reference_Architecture_2026-08-09.docx`
- Primary text record: `2026-08-09_ALE_environment_execution_reference_architecture.md`
- Executable manifest contract: `environment_manifest.schema.yaml`
- The PDFs and PNGs under `rendered/` are QA artifacts, not the normative report.

## Research-package checks

- 74 source cards and 74 `sources.csv` rows.
- 72 cited source IDs; no citation points to a missing source card.
- All required report sections present: core conclusions, counterevidence, boundaries, recommendations, pilot/client variables, source table and refresh targets.
- Ruby YAML parser successfully loaded the manifest schema with 20 top-level keys.

## DOCX checks

- Microsoft Word opened and repaginated the final DOCX successfully: 42 pages.
- All 15 DOCX XML parts parsed successfully.
- Numbering definitions precede numbering instances; all numbering references resolve.
- 21 tables, 192 rows; every row has `cantSplit`; 19 data tables repeat their header row.
- The table-header orphan and cross-document numbering defects found during visual QA were corrected and rechecked.

## Visual QA and render boundary

- All 42 pages were inspected for content, table continuation, numbering, bottom clipping and blank pages.
- Page 1 and pages 4–42 were exported from the final DOCX page by page. Pages 2–3 use the unchanged static TOC render from the prior whole-document Word export because Word's PDF filter stalls on those range exports.
- Word's `FromTo` PDF export can omit the running header/top margin on individual pages even though the DOCX paginates correctly; therefore the merged `rendered/v3` PDF is retained only as a content-QA artifact.
- Automated raster checks: 42 PDF pages, 42 PNG pages, all nonblank, all 1360 × 1760 pixels.

## SHA-256

| File | SHA-256 |
|---|---|
| `2026-08-09_ALE_environment_execution_reference_architecture.md` | `20BECBD48F8D627EF8EDA9956C1C302C3FF679D45BF85CAF93BDE74D46D52EBB` |
| `environment_manifest.schema.yaml` | `A24256C6E845EAB35BF222AF690137FE490CDF706FB5C59DA3D262DFCE02F25D` |
| `sources.csv` | `868C6213EC4E580DF4D5EABE3F7947627151A885B0446A686D24419DA7AE0198` |
| `artifacts/ALE_Environment_Execution_Reference_Architecture_2026-08-09.docx` | `53CDCFB6032A2D8CDF3B5D2DE5D116AB97331BED50841DE3890DFEFF45B1B9B3` |
| `artifacts/trust_boundary_architecture.png` | `F0FED1C0EF67246AB441B742FECBC2E23C440D097C3F372D2DC49F4BF46193C4` |

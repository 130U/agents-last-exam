# Draft v3 QA record

Date: 2026-08-09

## Content checks

- Repository validator: pass after removing task-local render directories.
- Git whitespace check: pass for all Draft v3 text and script files.
- Official instance allocation: 55 subdomains, 1,490 instances.
- Reconstructed workflow allocation: 55 subdomains, 960 workflows.
- Domain summary: 1,490 instances, 960 workflows, 530 additional instance slots.
- Product boundary: one client, zero external public release, 960 base workflows, 1,490 base instances, 0–40 gap-fill workflows.

## DOCX checks

- Builder completed successfully.
- Microsoft Word opened the DOCX read-only and completed pagination.
- Word statistics: 35 pages, 36 tables, 1,238 paragraphs.
- Page-level text profile contained no empty pages; page 35 contains the final allocation rows rather than a blank page.
- Final cover text verified: “客户私有 ALE-style Benchmark / 960–1,000 Workflows / 1,490+ Instances / Draft v3.”

## Render limitation

The required `render_docx.py` was attempted first and failed because the environment has no LibreOffice executable. Microsoft Word could open and paginate both Draft v3 and the previously accepted Draft v2, but PDF export hung for both files in this session. The v2 control failure indicates an Office PDF-export environment issue rather than a v3-only document defect. No PDF is included or claimed as visually verified. The DOCX itself passed Word open, pagination, page-profile and structural checks.

# Draft v1 validation report

**Validated:** 2026-08-09  
**Scope:** additive Draft v1 deliverables and evidence refresh; no existing repository file is part of the proposed commit.

## Content and repository checks

- Repository validator: **passed**, 112 files in the temporary validation index, 0 warnings.
- Relative Markdown links in the main report: **21 checked, 0 broken**.
- DOCX package integrity: **passed** (`ZipFile.testzip() = None`).
- DOCX parse: **469 paragraphs, 27 tables**.
- Required-content probes: count contract, G0–G8 gates, original B2B SaaS worked task, and no-fabricated-constants warning were all present.
- Render: Microsoft Word export to PDF, **25 pages**.
- Visual QA: every rendered page was inspected; blockquote width, numbering restart, footer consistency, and stranded table-header issues were corrected before this report.

## Artifact checksums

| Artifact | Bytes | SHA-256 |
|---|---:|---|
| `ale-1000-runnable-assets-delivery-report-draft-v1-2026-08-09.md` | 50,388 | `76D42681943FA2B7A1675117AD51F46C8BE464DFACBAD586F55009E698BE3FE3` |
| `ale-1000-runnable-assets-delivery-report-draft-v1-2026-08-09.docx` | 73,216 | `0A4B0F83F7AC1A4349F3EB2167AF772A8166781BCAD731B7A3509EB237351A6D` |

## Evidence boundary

Passing these checks establishes repository conformance, package integrity, layout quality, and internal-content presence. It does not validate the proposed worked task as an executable released asset, nor does it supply project-specific throughput, cost, schedule, yield, evaluator-error, repeat-count, pool-ratio, or human-baseline estimates. Those remain gated by implementation, independent runs, and the stratified pilot.

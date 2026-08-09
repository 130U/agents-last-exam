# Delivery QA — ALE-style Expert Production Governance

**Finalized:** 2026-08-09  
**Scope:** Markdown research report, DOCX, rendered PDF, source cards, source ledger, findings, refresh targets, and validation scripts.

## Release checks

| Check | Result |
|---|---|
| ALE evidence freeze | PASS — arXiv `2606.05405v2`; GitHub `1e615e456de7cef57706680613cb80ee13c7fc76`; HF `a8c1fd174a1f6cfa76526572a2e3ebece1276be2` |
| Epistemic labels | PASS — `[F] [C] [I] [R] [P]` all defined and used |
| Required deliverables | PASS — operating model, qualification matrix, executable minimum pack, RACI, reviewer policy, rights/security checklist, Micro1 verdict, and pilot variables |
| Counterevidence/boundaries | PASS — dedicated section plus local caveats at affected claims |
| Source cards | PASS — 48 per-source cards |
| Canonical-source independence | PASS — 48 cards resolve to 44 canonical sources; duplicate cards are not double-counted |
| Source ledger | PASS — 48 rows with source type, origin/institution cluster, canonical cluster, revision/date, access/snapshot and independence note |
| Local links | PASS — 171 local Markdown targets resolve |
| RACI | PASS — 21 lifecycle activities; every row has exactly one accountable role |
| Anti-fabrication boundary | PASS — no fixed staffing, sample size, cycle time, cost, throughput, yield, acceptance, agreement or release threshold is inferred from public benchmark counts |
| DOCX render | PASS — Microsoft Word export to 25-page PDF; all pages rasterized and visually inspected |
| Layout | PASS — portrait/landscape section transitions, repeated table headers, list numbering, table fit, clipping, overflow and final-page closure inspected |
| Background lock | PASS — Word automation process closed; no temporary DOCX lock remains |

## Canonical duplicate clusters

- `S01/S20` — ALE arXiv v2.
- `S02/S21` — frozen ALE GitHub commit.
- `S09/S24` — OpenAI SWE-bench Verified re-audit.
- `S25/S31` — NIST AI RMF 1.0 Core.

These pairs may provide different claim cards or operational readings, but they count as one canonical source within an independence test.

## Adversarial-review disposition

The independent review's blocking findings were resolved before release:

1. Added canonical-source clustering and `sources.csv`; removed same-source double counting from triangulation logic.
2. Split source facts, institutional claims, project inference, recommendations and pilot/client decisions.
3. Reconciled reviewer authority with the RACI; separated reference correctness/provenance escalation from custody/leak/access escalation.
4. Made evaluator and environment acceptance independent of their implementers on the same asset.
5. Replaced unsupported fixed counts and selection quantities with required evidence types plus pilot variables.

## Visual QA record

- Rendered output: 25 pages.
- Review method: two-page contact sheets for the full document, followed by full-resolution checks of list continuations, reviewer policy, incompatibility rules, the landscape RACI, pilot-variable formulas and the final source/refresh page.
- Final targeted recheck after the last typography edit: pages 16, 21 and 25.
- No clipping, overflow, broken table, orphaned header or pagination defect remains.

## Artifact hashes

| Artifact | SHA-256 |
|---|---|
| DOCX | `4C7645CAC0C41ABF97018518CCF40282643B18C06DB508A236D217A858419D42` |
| PDF | `328420308F2C4A7F2B02127E851C171675BC79E588F0EDFDFE0FF816C991D7AC` |
| Markdown report | `A0FC08DB496B1831EF927875F15B797C71557FC52A1514632D2114B8AA601CC3` |

## Residual boundaries

- Legal, employment, licensing and data-protection applicability remains jurisdiction-, contract- and worker-status-specific; customer/legal input is required.
- Causal effects of the proposed operating controls remain pilot questions even when the mechanisms are supported by standards or adjacent empirical studies.
- Before any report claim becomes a contractual acceptance criterion, its source locator should be hardened to the most precise available section, page, control, table or code path and rechecked against the then-current revision.

Validation is reproducible with `scripts/validate_delivery.py` using the bundled workspace Python runtime.

# Delivery QA — 2026-08-08

## Automated / structural checks

- Source cards: **74** Markdown files.
- `sources.csv`: 74 rows; 0 missing title, authors/institution, URL, publication/update date, access date, version/revision, Credibility, Recency or Bias.
- Every source card contains at least one marked original-language short quote; root, desktop/web and coding/terminal cards were checked against the ≤25 English quoted-word/source limit; labor/professional-file cards were separately machine-checked at 1–16 quoted words/source.
- Unified matrix: 16 benchmark rows × 3 field groups = 48 data rows; all 17 requested comparison fields present.
- Required report sections present: Executive summary、definitions、evidence/version matrix、findings、counterevidence/uncertainty、1,000-task decisions、recommendations、questions、reusable artifacts、H1–H4 verdict。
- Stale-pattern scan passed: no `TODO/TBD/PLACEHOLDER` and no removed unit errors (`GAIA 165 trials`, `AssistantBench test=214`, `WorkArena++ 682 instances`) or unsupported ALE/RLI point-cost phrases.

## Independent adversarial review corrections

1. GAIA HAL `165` corrected to validation task instances; agent trials remain a separate unit.
2. AssistantBench `214` kept as paper overall tasks; current 33 validation and held-out test surfaces are separate.
3. WorkArena++ `341 workflows × L2/L3` recorded as 682 level-specific task presentations; paper curriculum’s 235/level = 470 runnable evaluation instances is separate.
4. ALE “system-level novelty” changed from fact to cross-benchmark researcher inference; component existence remains fact.
5. Unsupported derived ALE per-instance cost range and unlocated RLI staffing/cost point estimates removed from final matrix/report.
6. RLI source-route counts 207/7/33 are not summed into final 240; mutual exclusivity/retention alignment is marked unresolved.
7. Matrix label contract made explicit: unprefixed implementation/count/environment/experiment cells default to fact; construct-validity claims, inference and recommendations require C/I labels.

## Tool/provenance note

- Versioned arXiv, GitHub, Hugging Face and official pages were retrieved through semantic web/API/CLI routes and saved as source cards.
- The in-app browser was invoked for visible-page verification, but its dynamic DOM runtime failed on part of the session. That runtime failure was not used as evidence and did not replace version pinning.
- Mutable web/leaderboard facts are frozen only to 2026-08-08 and listed in `refresh_targets.md`.

## Remaining evidence limits

- Public materials do not support exact project staffing, schedule, production cost, gate yield, evaluator FP/FN threshold, repeat count, public/private ratio or rotation cadence for the proposed 1,000-asset program.
- WebArena-Verified is a withdrawn paper; its audit is used with reduced credibility and not as a stable canonical release claim.
- CRAB v4’s 100/120 count conflict remains unresolved pending a release-tagged manifest.
- H4’s exposure/optimization mechanism is supported; the cross-benchmark rate of validity decay remains underdetermined.

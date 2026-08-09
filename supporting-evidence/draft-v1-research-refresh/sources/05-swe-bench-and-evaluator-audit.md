# Source 05 — SWE-bench design and later evaluator audit

- **Paper:** https://arxiv.org/abs/2310.06770v3
- **Harness:** https://github.com/SWE-bench/SWE-bench
- **Audit:** https://openai.com/index/separating-signal-from-noise-coding-evaluations/
- **Role:** benchmark design plus independent evaluator-audit evidence
- **Accessed:** 2026-08-09

> “2,294 software engineering problems drawn from real GitHub issues and corresponding pull requests”

> “estimate that ~30% of SWE-bench Pro tasks are broken”

## Supports

Real-world provenance, containers, and hidden tests do not guarantee valid measurement. Evaluator QA must probe underspecification, strict or low-coverage tests, alternate-valid solutions, near misses, shortcuts, hard-coding, and regressions; disagreement requires independent review and arbitration.

## Limits

The estimated defect rate applies only to the audited SWE-bench Pro surface and must not be used as ALE's expected defect rate. The audit is vendor research rather than peer-reviewed evidence.

## Source assessment

High credibility for SWE-bench design; medium-high for the bounded audit result.


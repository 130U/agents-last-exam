# Cross-source findings used in Draft v1

## F1 — The contract unit must be explicit

**Conclusion:** specify `1,000 accepted runnable instances + distinct workflow count W`, not 1,000 prompts.

- ALE v2 distinguishes workflow and instance while also reporting external submissions.
- The frozen code shows that runnability depends on lifecycle code, staged inputs and references, and evaluator behavior.
- The HF release is metadata-only, proving that a task-card row cannot be treated as a complete asset.

**Boundary:** this is a project recommendation, not a confirmed client contract. If the client requires 1,000 distinct workflows, scope and economics must be re-baselined.

## F2 — Deterministic scoring is not validity

**Conclusion:** evaluator acceptance requires construct traceability, positive and negative fixtures, adversarial validation, failure attribution, and controlled scorer releases.

- ALE's frozen code snapshot includes grader hardening.
- SWE-bench's later audit illustrates that real provenance, containers, and tests can coexist with broken measurement.
- NIST CAISI documents solution contamination and grader gaming, and recommends transcript-level controls.

**Boundary:** no adjacent-benchmark defect rate is used as an ALE or project prior.

## F3 — The measured object is a configured system

**Conclusion:** reports and procurement manifests must freeze model/provider, harness, prompts and tools, environment, network, budget and retry, evaluator, and snapshot.

- ALE is explicitly an agent–environment–task system.
- OSWorld requires initial-state setup and execution-based evaluation.
- *AI Agents That Matter* identifies configuration, cost, and reproducibility as central to decision usefulness.

**Boundary:** model-only claims are excluded unless every other configuration component is held constant and the estimand says so.

## F4 — Pilot data, not public prose, determines scale parameters

**Conclusion:** staffing, throughput, yield, rework, cost, schedule, thresholds, pool ratios, repeats, and human-baseline sample sizes remain variables until an instrumented stratified pilot.

- ALE public materials do not disclose the required production economics.
- BetterBench and NIST AI 800-2 frame quality as a lifecycle and reporting problem.
- NIST AI 800-3 shows that uncertainty depends on the estimand and variance structure.
- METR shows that human baselines depend on the sampled people, task context, affordances, success definition, and analysis population.

**Boundary:** Draft v1 provides formulas and decision gates, not fabricated constants.

## F5 — ALE mitigates selected benchmaxxing mechanisms; it does not prove real-world value

**Conclusion:** use the talk as a short hook, then move immediately to measurable controls and claim boundaries.

- The talk frames divergence between benchmark reward and human value.
- ALE's professional workflows, executable environments, hidden references, QC, and private pool address several proximate failure modes.
- NIST and adjacent benchmark evidence show that leakage, evaluator gaps, environment drift, and sampling bias can remain.

**Boundary:** an ALE score does not automatically establish human parity, job replacement, economic impact, or deployment reliability.


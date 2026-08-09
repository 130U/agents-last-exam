# Adversarial review of the deliverable draft

**Review lenses:** project lead, technical evaluator, procurement reviewer.  
**Disposition:** deliverable as a decision draft if every blocker below is answered or explicitly labeled as an owner/pilot dependency.

## Blockers and the draft's response

| Reviewer challenge | Required response | Draft location |
|---|---|---|
| What exactly are we buying—prompts, workflows, instances, or runs? | Count contract, manifest, exclusions, and `W` disclosure | §§1, 3 |
| Can an asset be launched and scored by an independent party? | Asset contract, DoD, environment manifest, run evidence | §§3, 7 |
| Who may approve an asset and where is self-review prohibited? | Asset-level RACI and hard incompatibilities | §5.5 |
| What stops an invalid evaluator from creating a high score? | Bidirectional validity chain, fixture families, FAR/FRR, adversarial tests | §6 |
| How are task failure and infrastructure failure separated? | Failure taxonomy, retry rule, arbitration and regrade policy | §§6.4, 7.5 |
| Can hidden references or graders be reached or changed? | Plane separation, credential custody, write protection, network policy | §§7.1–7.4 |
| What uncertainty does a reported ranking contain? | Pre-specified estimand, paired clustered intervals, sensitivity and stability | §8 |
| Does the human baseline match the target work? | Independent practicing-expert main arm, affordance matrix, all-assigned analysis | §8.5 |
| How does the benchmark survive leakage and repair without rewriting history? | Four evaluation pools, event ledger, quarantine, new versions and bridge view | §9 |
| Why should procurement accept the scale, schedule, or price? | Instrumented funnel, service-hour/cost/capacity formulas, explicit decision gates | §10 |

## Non-negotiable drafting rules

1. Do not infer a production number from ALE's public counts or an adjacent benchmark's defect rate.
2. Do not describe 1,490 ALE instances as all final-QC accepted.
3. Do not equate the two reported 960 counts.
4. Do not equate deterministic evaluation with valid evaluation.
5. Do not call a private pool uncontaminated without evidence.
6. Do not convert repeat runs into coverage of task heterogeneity.
7. Do not use author estimates as the main human baseline.
8. Do not present the worked example as a released or validated asset; it is a complete design evidence pack awaiting implementation and pilot.

## Remaining red flags after Draft v1

- Client owner decisions and budget/risk appetite are still absent.
- No project-specific batch-zero or pilot observations exist.
- No expert roster, contract, credential, license-seat, or environment-provider evidence exists.
- The original worked task still needs executable implementation, blind solve, evaluator red team, and final approval.
- Final schedule, staffing, cost, pool ratio, repeat count, and statistical thresholds must stay blank until calibration.


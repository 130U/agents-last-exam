# Draft v2 count, taxonomy and hook research plan

## Decision to support

Decide how the report should interpret “build 1,000 ALE-style tasks,” explain why a private benchmark has customer value, and present ALE's taxonomy without merging incompatible versions or units.

## Falsifiable hypotheses

1. The interview wording is better served by 1,000 accepted workflow packages than by 1,000 accepted instances.
2. ALE formally reports 13 domains and 55 subdomains; the apparent 14th domain is a figure/metadata artifact, not a stable official top-level domain.
3. The arXiv v2 public share is below 20% under every defensible same-unit denominator.
4. ALE mitigates public-benchmark leakage and gaming but does not prove zero contamination or eliminate evaluator/harness risk.

## Source strategy

- Freeze arXiv v2 for paper counts, units and Figure 2 taxonomy.
- Use the official live taxonomy only as a dated living surface.
- Use the fixed GitHub/HF revisions to audit implementation and metadata surfaces.
- Use the timestamped talk transcript only for the rhetorical hook.
- Reuse the prior NIST and adjacent-benchmark source notes for independent threat-model support.

## Opposition queries

- Could “1,000 tasks” mean instances rather than workflows?
- Does Figure 2 actually authorize calling Other a 14th domain?
- Can private data be treated as uncontaminated by definition?
- Does one canonical instance per workflow establish benchmark readiness?
- Does the 1,490/960 ratio justify a variant target?

## Risk register

- Interviewer did not formally define the unit.
- The paper uses 960 in two different ledgers.
- Paper, live taxonomy and HF metadata do not expose the same taxonomy surface.
- 1,490 includes pending-QC inventory.
- The commercial-client rationale is an inference, not an ALE author claim.

## Stop criteria

Stop when the fixed paper, official living page, fixed code/HF metadata, transcript and adversarial review agree on the safe wording, and every numeric statement identifies surface, date, unit and denominator.

## Execution note

No task-specific `outline.yaml` existed in the repository, so `GENERAL-research-deep` batching was not applicable. The investigation instead followed the parallel-source and adversarial-review workflow from `GENERAL-deep-research`.

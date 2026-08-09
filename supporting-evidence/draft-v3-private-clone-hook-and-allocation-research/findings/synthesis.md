# Synthesis

## Hook decision

Write the timing precisely: the talk occurred on 2026-06-30; the official recording was published on 2026-08-02; the report incorporated it by 2026-08-09. Highlight two ALE-relevant responses in the opening:

1. fresh private tasks, hidden references/evaluators and rotation reduce the value of memorizing or tuning to a public set;
2. expert workflows, real software, concrete artifacts and task-specific evaluators reduce the gap between isolated questions and professional work.

Place the six-point talk-to-ALE mapping later in the report.

## Product decision

Freeze a single-client, no-public-release product:

```text
W_base = 960 accepted distinct workflows
I_canonical = 960
I_additional = 530
I_base_total = 1,490 final-QC accepted instances
0 <= G <= 40 customer-specific gap-fill workflows
W_total = 960 + G
I_total >= 1,490 + G
```

Reproduce Figure 2's 55-subdomain instance vector exactly. Reconstruct the workflow vector transparently with Hamilton largest-remainder allocation:

```text
q_s = 960 * I_s / 1,490
W_s = Hamilton_largest_remainder(q_s)
```

The resulting 960-workflow allocation is a project design, not an ALE fact.

## Private-pool decision

All assets are commercially private to the client. Internally separate client-private development/integration, restricted validation, sealed private final, private rotation reserve, client-private training if contracted, and retired audit archive. Exposure purpose and commercial confidentiality are different axes.

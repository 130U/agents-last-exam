# Refresh targets before a final SOW or public release

Refresh these items when any trigger fires. Do not silently overwrite historical values.

| Target | Trigger | Required action |
|---|---|---|
| ALE paper inventory | new arXiv version | add a new source note and unit ledger row |
| ALE framework/evaluator | release or grader change | freeze commit, rerun evaluator fixtures, record score-semantic impact |
| HF metadata | revision changes | record row count and schema at the new revision; do not equate with runnable count |
| Original worked task | implementation milestone | add environment hash, reference pack, evaluator tests, blind-solve and red-team evidence |
| Production parameters | batch zero/pilot wave closes | replace variables only with observed distributions and confidence bounds |
| Licensed software | vendor terms/image change | re-verify automation, redistribution, seat, credential, and rebuild rights |
| Human baseline | task/affordance/sample changes | update eligibility, analysis population, attrition, agreement, cost and uncertainty |
| Pool governance | leakage/incident/rotation | quarantine affected versions, create event ledger entry, preserve historical views |
| Claim boundary | intended use or audience changes | rerun validity and decision-risk review before broadening claims |

## Finalization gate

Draft v1 may become a final implementation plan only after the owner signs the unit contract and intended use, a stratified pilot supplies operating parameters, and the worked task passes independent run, evaluator validation, rights/security review, and final approval.

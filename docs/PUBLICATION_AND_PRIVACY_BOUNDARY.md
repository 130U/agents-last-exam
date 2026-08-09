Exit code: 0
Wall time: 1.1 seconds
Output:
# Publication and privacy boundary

## Two-repository model

- **Full research repository (`130U/agents-last-exam`)**: version-pinned reports, technical derivations, QA, schemas, source manifests and reproducible builders.
- **Showcase repository**: external-facing README, concise Markdown, downloadable Word report and links into the full research repository. It must not mirror raw evidence packages.

The showcase repository is the default link sent to an interviewer. The full repository is an optional evidence layer for readers who want to inspect a claim or implementation decision.

## Red-line exclusions

The following material must never appear in either public repository:

- private interview audio or video;
- speaker-attributed interview transcript or verbatim assignment conversation;
- personal resume, career-decision or offer-comparison material;
- research packages that embed any of the above;
- private customer data, expert identities, credentials, hidden references or evaluators.

Public reporting may retain an independently supportable technical question or conclusion that was prompted by an interview, but it must not reproduce the private conversation or attribute an unstated intention to the interviewer.

## External-delivery rule

The external Word report contains decisions and conclusions only. Detailed reasoning is linked to stable Markdown in the full research repository. Video transcripts, raw captions, source snapshots and QA artifacts remain in the supporting layer and are not copied into the showcase repository.

## Git-history warning

Deleting a path from the latest branch tip does not erase old Git objects, pull-request refs, forks or caches. If sensitive material has already been published, active branches should be sanitized immediately; complete purge requires a coordinated history rewrite and, where needed, GitHub Support cache and pull-request-ref cleanup.


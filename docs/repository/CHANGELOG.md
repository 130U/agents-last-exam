# Changelog

All notable repository-level changes are documented here. Research claim revisions should also be explained in the affected report.

## Unreleased

### Added

- External-facing concise Markdown and editable Word brief, with the 2026-08-02 official video release stated in the opening.
- Machine-readable repository manifest with pinned ALE source surfaces.
- Repository architecture, content lifecycle, release checklist, and initial architecture decision record.
- Standard-library repository validator and GitHub Actions quality gate.

### Changed

- The root README is now a link-only entry point for deliverables and supporting material.
- Repository metadata and reference-only root configuration are grouped under `docs/repository/`.
- Validation and governance references now use the grouped repository metadata paths.
- The repository is maintained as a single-owner research store rather than a contributor-facing project.

### Removed

- Root-level contribution, license-policy, and security-policy documents.
- Private interview/assignment context files and packages from active public branches.

## 2026-08-09

### Added

- Initial GitHub organization into `core/` and `supporting-evidence/`.
- Source mapping and large-package status in `supporting-evidence/UPLOAD_MANIFEST.md`.

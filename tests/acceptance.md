# POC acceptance matrix

Status must be PASS / FAIL / BLOCKED **only after observation**. Initial state: NOT RUN.

| ID | Scenario | Status | Evidence / notes |
|---|---|---|---|
| POC-01 | Plugin installs and activates | NOT RUN | |
| POC-02 | Client example renders on published page | NOT RUN | Compare exact and clean URL |
| POC-03 | Album navigation works | NOT RUN | Video or screenshots; test img_index |
| POC-04 | Only manually selected posts shown | NOT RUN | Editor + frontend |
| POC-05 | Manual ordering preserved | NOT RUN | Before/after screenshots |
| POC-06 | Responsive layout | NOT RUN | 375, 430, 768, 1024, 1440, 1920 px |
| POC-07 | Multiple embeds acceptable performance | NOT RUN | Baseline vs 1/3/6, repeated runs |
| POC-08 | Invalid/private post graceful handling | NOT RUN | Invalid and known private separately |
| POC-09 | No API credentials | NOT RUN | Installation + working frontend |
| POC-10 | No premium plugin licensing | NOT RUN | Installed plugin list/license |

## Evidence protocol

Record browser + OS, WordPress/PHP/DB/plugin/theme versions, exact URL, editor screenshot, published page screenshot, console errors, failed Network requests, navigation recording, and timings. Save screenshots/video in an external evidence store or locally under `docs/evidence/` (gitignored). Do not imply that WP-CLI checks alone establish frontend acceptance.

## Gates

- **A:** Native Meta Embeds fully satisfies curation, carousel, and performance.
- **B:** Embeds pass but editorial management needs a small provider-independent curator.
- **C:** Critical embed, layout, or performance failure; report blocker and compare alternatives.

Local PASS is provisional until real Hotel Indigo staging reproduction.

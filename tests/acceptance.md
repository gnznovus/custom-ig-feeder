# POC acceptance matrix — local results (2026-10-29)

Scope: local Docker WordPress lab. **Local PASS does not equal production approval.** Full staging reproduction is outstanding. Status values are PASS, FAIL, or BLOCKED; partial outcomes are explained in evidence notes.

| ID | Scenario | Local status | Evidence / outstanding work |
|---|---|---|---|
| POC-01 | Plugin installs and activates | PASS | WP-CLI shows WordPress 6.9.4 installed, Meta Embeds 1.2.2 active; MariaDB healthy |
| POC-02 | Client example on published page | PASS | User-supplied screenshot of rendered client album at exact URL |
| POC-03 | Album navigation | PASS | User confirmed both exact and clean URLs navigate; last-slide Next opens Instagram. Initial `img_index=2` selection not definitively established |
| POC-04 | Manual selection | PASS | Distinct sample post renders; user confirmed removal makes deleted post disappear |
| POC-05 | Manual ordering | PASS | User-supplied screenshot after reorder and confirmed published order |
| POC-06 | Responsive layout | BLOCKED | Local 360 × 800 screenshot shows functional responsive embed and minor theme spacing; remaining breakpoints and Hotel Indigo theme not tested |
| POC-07 | Multiple embeds performance | BLOCKED | Deferred to real Hotel Indigo test site; no LCP/CLS/request measurements yet |
| POC-08 | Invalid/private post handling | BLOCKED | Invalid URL visibly degrades to plain clickable link without broken page; private/deleted cases and console/network errors not yet tested |
| POC-09 | No API credentials | PASS | Public embeds render with no Meta developer credentials configured |
| POC-10 | Free plugin licensing | PASS | Meta Embeds 1.2.2 installed without paid license; this does not include labor/hosting cost |

**Local summary:** 7 PASS, 3 BLOCKED (POC-06, 07, 08). POC-06 has provisional responsive evidence; POC-08 has successful invalid-link fallback evidence. No staging acceptance is claimed.

## Evidence protocol

Screenshots and behavior confirmations were supplied in the project conversation on 2026-10-29. Evidence files/recording have **not** been committed to the repository. Attach/export them before presenting a formal audit packet. Capture editor and published views, tested URLs, browser/OS, widths, console/network observations, and performance numbers on staging. Do not infer outcomes from HTTP 200 or editor previews alone.

## Observed limitations

- **UX-01:** Native album carousel does not wrap; advancing past the last item takes visitors to Instagram. Non-blocking unless client requires looping.
- **UX-02:** Invalid post URL falls back to a visible link, not a branded error placeholder.
- **UX-03:** Initial-slide behavior of `?img_index=2` is unconfirmed.
- **PERF-01:** Real-site performance unmeasured.

## Gates

- **A (provisionally favored):** Continue with native Meta Embeds if staging confirms functional, editorial, responsive and performance requirements.
- **B:** Add provider-independent lightweight curator only if real editorial workflow is insufficient.
- **C:** Stop/re-evaluate if critical rendering/performance requirements fail.

**Next:** Reproduce on Hotel Indigo test site. No custom curator or premium plugin is currently justified by local evidence.

# Meta Embeds POC — local test report

**Date:** 2026-10-29  
**Project:** Hotel Indigo Bangkok Thonglor — Custom IG Feeder  
**State:** Local functional verification completed; staging acceptance pending  
**Decision:** Gate A (Meta Embeds alone) is provisionally favored, **not final**.

## Executive findings

The client's key requirements — manual selection of Instagram posts and native album/carousel presentation — worked in a free local WordPress setup. The operator successfully added, rearranged and removed embed blocks using Gutenberg. This supports a native-first solution without developing a custom curator for now.

Seven of ten local acceptance checks are recorded PASS; POC-06, POC-07 and POC-08 remain BLOCKED for complete acceptance. See [acceptance matrix](../tests/acceptance.md). **No production or Hotel Indigo staging tests have yet been performed.**

## Verified environment

- Docker Compose on Windows with WSL 2 integration; local WordPress served at `http://localhost:8086`
- WordPress **6.9.4** (WP-CLI output)
- PHP **8.3.31** (Apache container log)
- MariaDB **11.4.13** (healthy container log)
- Meta Embeds **1.2.2**, active (WP-CLI output)
- Test fixtures: `/poc-client-exact/`, `/poc-client-clean/`, `/poc-multiple/`, `/poc-invalid/`
- Active theme version and full verification output not captured

## Native feature observations

1. **Exact client URL:** `https://www.instagram.com/p/DeMM_u5n_ct/?img_index=2` rendered as a native Instagram album in the published WordPress frontend (user screenshot).
2. **Clean permalink:** `https://www.instagram.com/p/DeMM_u5n_ct/` also worked; user confirmed navigation on both variants. Whether `img_index=2` controls the first visible slide remains unresolved.
3. **Second distinct post:** `https://www.instagram.com/p/fA9uwTtkSN/` from Meta documentation rendered in WordPress (user screenshot). This supports independent manual URL selection; no Instagram login was required for frontend embedding.
4. **Manual curation:** Operator moved a selected embed above another, saved and saw the published reordered layout (screenshot). Operator then deleted a block and confirmed it disappeared. No curator plugin was needed.
5. **Carousel boundary:** Next on the final item takes the visitor to Instagram rather than cycling back to the first slide (**UX-01**, non-blocking potential UX concern).
6. **Responsive:** User provided a **360 × 800** mobile screenshot with functional embed sizing and minor theme margin/padding issues. Other planned viewports and the Hotel Indigo theme remain untested (**POC-06 blocked for complete acceptance**).
7. **Invalid URL:** A malformed/unavailable-looking URL on `/poc-invalid/` appeared as a plain clickable link, while the page remained intact (**UX-02**). A known private/deleted post and console/network behavior are still untested (**POC-08 blocked for complete acceptance**).
8. **Credentials/license:** Plugin worked with no configured Meta API key/developer account and was installed without a premium license. Internal implementation and maintenance still have costs.

## Evidence inventory

- **Available in conversation, not repository:** screenshots of rendered client album, separately selected second post, published reordered result, mobile responsive result and invalid-link fallback; explicit operator confirmations of navigation/removal.
- **Not yet available:** archived screenshot files in repo, full editor screenshot set, carousel screen recording, browser console/network trace, detailed timing and accessibility evidence.
- **Caution:** do not describe this evidence as a complete formal staging test.

## Performance — deferred

**POC-07 BLOCKED** until real Hotel Indigo test site testing. Measure comparable empty page vs 1/3/6 embeds, cold and warm runs, LCP, CLS, transferred bytes, third-party requests, errors and visible render time. Local tests cannot substitute for the actual theme, hosting, caching and plugin stack.

## Staging reproduction checklist

- Confirm versions, content/theme/CSP and all required URLs.
- Recheck carousel navigation and final-slide outbound behavior.
- Confirm editor can add, remove and reorder posts.
- Check mobile/desktop theme spacing and interaction/keyboard access.
- Inspect failed/unavailable embeds, console/network errors and privacy implications.
- Record performance and obtain client acceptance of native Instagram styling and link-out behavior.

## Recommendation

**Use the official free Meta Embeds plugin for staging reproduction.** Build no custom curator unless the client requires a more convenient editorial experience, and make no custom carousel hack before verifying a genuine requirement. Preserve the option to separate selected URL storage from the provider only if Gate B becomes necessary.

**Final Gate: UNDECIDED** until staging performance and layout acceptance.

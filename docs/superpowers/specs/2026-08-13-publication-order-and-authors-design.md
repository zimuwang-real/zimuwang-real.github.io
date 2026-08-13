# Publication Order and Author Presentation Design

## Goal

Refine the existing personal-website content update so that RSIHub links directly to its GitHub repository and EffiSkill leads the Publications page with a conventional academic author line.

## Scope

- Replace the homepage RSIHub URL with `https://github.com/simple-agent-lab/RSIHub`.
- Keep EffiSkill first on the Publications page using explicit display metadata rather than changing publication dates.
- Add the full EffiSkill author list directly beneath its title.
- Underline `Zimu Wang` in that author list to identify the website owner.
- Leave the long-horizon survey without an author line for now.
- Preserve the existing typography, spacing, theme, and publication descriptions.

## Content

The EffiSkill author line will be:

`<u>Zimu Wang</u>, Yuling Shi, Mengfan Li, Zijun Liu, Jie M. Zhang, Chengcheng Wan, Xiaodong Gu`

Its venue and year remain beneath the author line as `Under review at EACL 2027, 2026`.

## Implementation Design

Each publication receives a numeric `display_order` front-matter field. The Publications page sorts the collection by that field in ascending order, placing EffiSkill before the survey without altering either date.

EffiSkill receives an `authors` front-matter field containing the approved author line. The shared publication archive template renders this field in a paragraph only when it exists. Consequently, the survey entry retains its current appearance.

No CSS changes are required. The author line uses the site's existing paragraph styling and the standard HTML underline element.

## Verification

- Assert that the homepage RSIHub link targets the GitHub repository and no longer targets the Simple Agent Lab RSIHub page.
- Assert that generated Publications HTML places EffiSkill before the survey.
- Assert that the complete EffiSkill author line is rendered and `Zimu Wang` is underlined.
- Assert that the survey renders no author line.
- Parse changed front matter, run `git diff --check`, and complete a Jekyll build.
- Inspect the Publications page at desktop and mobile widths to confirm that the author line wraps cleanly without horizontal overflow.

# Publication and Web CV Refresh Design

Date: 2026-07-30

## Goal

Refine the website's content hierarchy so the homepage emphasizes work led by
Zimu Wang, publication links lead directly to the relevant external preprints,
and the web CV reflects the current ByteDance role. The downloadable PDF resume
will remain unchanged.

## Homepage

Keep the existing page structure, but reduce **Featured Work** to:

1. **Simple Evolve Agent** — keep first because it is the user's most important
   current ByteDance project.
2. **EffiSkill** — add as first-author research and identify it as under review
   at EACL 2027.

Remove Simple Agent Lab and Building Reliable Long-Horizon Agents: A Survey
from Featured Work. They remain available in the sections that best represent
the user's contribution:

- Simple Agent Lab remains on Projects.
- The survey remains on Publications.

The Experience section remains separate from Featured Work.

## Publications

Keep two publication entries:

1. **EffiSkill** — venue text: "Under review at EACL 2027." Its title links
   directly to <https://arxiv.org/abs/2603.27850>.
2. **Building Reliable Long-Horizon Agents: A Survey** — venue text remains
   "Preprint." Its title links directly to
   <https://building-reliable-long-horizon-agent.github.io/>.

Remove the "Download Paper" action from publication listings. Entries marked
as external-only will not display the secondary internal-permalink icon. This
makes the title itself the single clear action.

The existing EffiSkill collection source remains available for publication and
CV rendering, but visitors will no longer be directed to its standalone detail
page from the site interface. This avoids a larger data-model migration while
solving the unwanted click behavior.

## Projects

Keep both existing project entries and their current order:

1. Simple Evolve Agent
2. Simple Agent Lab

Both private GitHub links and "Coming soon" labels remain unchanged.

## Web CV

Update only `/cv/`; do not modify the downloadable PDF.

Add a **Professional Experience** section before Research Experience:

- **Large Language Model Engineering Intern, Douyin AI, ByteDance — May
  2026–Present**
- Summarize the role using the three current work areas:
  - Simple Evolve Agent, emphasized as the primary project
  - Simple Agent Lab
  - reliable long-horizon-agent research and evaluation

Keep the existing historical research, teaching, education, and skills
sections. Update EffiSkill wherever it appears to say it is under review at
EACL 2027.

The Selected Publications list will use the same external-first behavior as the
main Publications page: publication titles link to arXiv or the preprint page,
with no separate download action.

## Scope and constraints

- Do not modify the downloadable resume PDF.
- Do not remove Simple Agent Lab from the Projects page.
- Do not remove the long-horizon-agent survey from Publications.
- Do not expose private repository contents.
- Preserve the site's current theme and navigation.
- Do not modify or commit the unrelated `.DS_Store` working-tree change.

## Validation

- Homepage Featured Work contains only Simple Evolve Agent and EffiSkill, in
  that order.
- EffiSkill is labeled "Under review at EACL 2027."
- Publications contains EffiSkill and the survey.
- Their titles lead directly to the approved external URLs.
- No publication listing shows "Download Paper" or an internal permalink icon
  for these external-only entries.
- Projects still contains Simple Evolve Agent and Simple Agent Lab.
- The web CV includes the ByteDance role beginning May 2026 and reflects the
  updated EffiSkill status.
- The downloadable PDF is byte-for-byte untouched.
- `.DS_Store` remains unstaged and uncommitted.

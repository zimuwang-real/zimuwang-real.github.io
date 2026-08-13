# Personal Website Content Polish Design

Date: 2026-08-13

## Goal

Update Zimu Wang's personal website to reflect the now-public Simple Agent Lab
ecosystem and his current experience, while preserving the site's existing
academic design. The revised content should serve AI engineering recruiters
first and research collaborators or graduate admissions readers second.

The website should present contribution levels precisely. RSIHub is Zimu's
flagship 0-to-1 engineering project. EffiSkill is his flagship first-author
research work. Other collaborations should remain discoverable on their
appropriate supporting pages without receiving equal prominence on the
homepage.

## Design Principles

- Preserve the current Jekyll theme, sidebar, navigation, typography, dark
  mode, and page structure.
- Make content-level changes only. Do not introduce a visual redesign, new
  components, or interactive features.
- Keep the homepage concise and evidence-led.
- Describe personal contributions explicitly without implying ownership of
  unrelated Simple Agent Lab work.
- Link readers to the public code, documentation, project pages, and papers.

## Information Architecture

### Homepage

Keep the current section-based academic layout:

1. Introduction and profile links
2. Research Interests
3. Selected Work
4. Experience

Selected Work contains only the two strongest personal signals:

1. RSIHub
2. EffiSkill

Do not add a catch-all sentence about the survey or Simple Long Horizon Agent
to the homepage. Those works remain available on the Publications and Projects
pages.

### Projects

Use this order:

1. RSIHub
2. Simple Long Horizon Agent

Add a brief introduction linking these projects to Simple Agent Lab, described
as an open-source research collective. The collective is context, not a project
that Zimu personally claims to have built.

Do not list AutoTrainess because Zimu did not contribute to it.

### Publications

Keep EffiSkill as the first-author flagship and retain Building Reliable
Long-Horizon Agents: A Survey as a normal co-authored publication. Preserve any
other existing valid publications.

## Homepage Content

### Introduction

Replace the current present-tense ByteDance description with language based on:

> I am a computer science undergraduate at **UC Berkeley**. I recently
> completed a **Large Language Model Engineering Internship at Douyin AI,
> ByteDance**, where I worked on agent self-evolution, practical agent systems,
> and evaluation for long-horizon and code-oriented tasks. My research focuses
> on self-improving agents, code intelligence, and reliable AI systems.

Keep the existing Resume PDF, Google Scholar, and GitHub links.

### Research Interests

Retain the current Research Interests section and its existing concise list.
Minor wording adjustments are allowed only when needed for consistency with
the approved introduction and project terminology.

### Selected Work

Rename Featured Work to Selected Work.

The RSIHub entry should communicate:

- Zimu is the project's primary developer.
- He led its 0-to-1 implementation.
- It is an open-source framework for reproducible agent self-improvement.
- It uses frozen evaluators, declared mutation boundaries, and auditable
  experiment lineage.

Use wording based on:

> **RSIHub** — Primary developer, leading its 0-to-1 implementation. An
> open-source framework for reproducible agent self-improvement under frozen
> evaluators and declared mutation boundaries, with auditable experiment
> lineage.

The EffiSkill entry should retain its first-author emphasis and concise
description of reusable agent skills for automated code-efficiency
optimization.

Remove every homepage reference to Simple Evolve Agent and all "Coming soon"
language.

### Experience

Update ByteDance to:

> **Large Language Model Engineering Intern, Douyin AI, ByteDance —
> May–August 2026.** Worked on agent self-evolution, practical agent systems,
> and evaluation for long-horizon and code-oriented tasks.

Merge the two Shanghai Jiao Tong University entries because they were with the
same group and mentor. Use wording based on:

> **Researcher, Shanghai Jiao Tong University — Summer 2025 and Spring 2026.**
> Developed SFT and GRPO training pipelines for code models, then built
> EffiSkill and its scalable inference and evaluation workflows for
> code-efficiency optimization.

Keep the UC Berkeley research-assistant and teaching-assistant entries
unchanged.

## Project Entries

### RSIHub

Replace the obsolete Simple Evolve Agent project entry with RSIHub. The project
page and listing excerpt should identify Zimu as the primary developer and
describe the 0-to-1 implementation. The longer description may name these
contribution areas:

- experiment lifecycle and framework architecture
- evaluator isolation and mutation boundaries
- candidate lineage and evidence retention
- recipe and operator system
- runtime and Harbor integration
- benchmark and experiment infrastructure
- testing and documentation

Keep the wording compact and readable rather than turning the entry into a
commit-by-commit inventory.

Provide links to:

- RSIHub overview: <https://simpleagentlab.com/rsihub/>
- GitHub repository: <https://github.com/simple-agent-lab/RSIHub>
- Documentation: <https://simpleagentlab.com/RSIHub/>

### Simple Long Horizon Agent

Replace the generic Simple Agent Lab project entry with a short Simple Long
Horizon Agent entry. Use explicitly scoped contributor language based on:

> Contributor to agent skills, composable agent interfaces, tools, memory, and
> evaluation infrastructure. Also conducted experiments on PostTrainBench.

Do not describe Zimu as the creator, lead developer, or primary contributor of
this project.

Link to:

- <https://github.com/simple-agent-lab/simple-long-horizon-agent>

### Projects Page Introduction

Add one brief sentence linking to <https://simpleagentlab.com/> and identifying
Simple Agent Lab as the open-source research collective associated with the
listed projects. Do not list the collective as a third project card.

## Publications

Ensure the public survey entry remains available and links to:

- Project page: <https://building-reliable-long-horizon-agent.github.io/>
- Public repository:
  <https://github.com/Building-Reliable-Long-Horizon-Agent/Building-Reliable-Long-Horizon-Agent.github.io>

Preserve EffiSkill and its first-author status. Remove no valid publication as
part of this update.

## Out of Scope

- Any CSS, Sass, JavaScript, layout, theme, sidebar, navigation, or dark-mode
  redesign
- The website CV page
- `Zimu_Resume.pdf`
- `files/Zimu_Wang_Resume.pdf`
- AutoTrainess
- Changes to the Simple Agent Lab website or its repositories
- Changes to the RSIHub or Simple Long Horizon Agent repositories
- Unrelated working-tree files, including `.DS_Store`

## Validation

Before completion:

1. Build the Jekyll site successfully using the repository's supported build
   workflow.
2. Inspect the rendered homepage, Projects page, and Publications page at
   desktop and narrow viewport widths.
3. Confirm the existing theme, sidebar, navigation, and dark-mode control still
   render as before.
4. Confirm the homepage says May–August 2026 for ByteDance and uses past-tense
   internship language.
5. Confirm the two SJTU periods appear as one homepage entry.
6. Confirm RSIHub precedes EffiSkill in Selected Work and is presented as the
   primary developer's 0-to-1 implementation.
7. Confirm the Projects page orders RSIHub before Simple Long Horizon Agent and
   scopes the latter as contributor work.
8. Confirm AutoTrainess is absent from personal-work listings.
9. Search rendered and source content for stale user-facing references to
   "Simple Evolve Agent" and "Coming soon."
10. Verify the RSIHub overview, RSIHub documentation, both GitHub repositories,
    Simple Agent Lab, EffiSkill, and survey links.
11. Confirm the CV page and both resume PDFs are unchanged.

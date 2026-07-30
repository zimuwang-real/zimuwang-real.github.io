# Website Content Refresh Design

Date: 2026-07-30

## Goal

Refresh Zimu Wang's personal website to reflect his current ByteDance role and
three related works, while separating featured work from employment history.
Remove CodeEffiJudge until it is public.

## Content hierarchy

The homepage will use this order:

1. Introduction
2. Research Interests
3. Featured Work
4. Experience

Featured Work and Experience must remain distinct sections. Project and
publication detail pages will provide the longer descriptions.

## Homepage

### Introduction

Replace the current SJTU-focused paragraph with:

> I am a computer science undergraduate at **UC Berkeley** and a **Large
> Language Model Engineering Intern at Douyin AI, ByteDance**. My work focuses
> on agent self-evolution, code intelligence, AI-agent evaluation, and reliable
> long-horizon systems.

Keep the existing Resume PDF, Google Scholar, and GitHub links.

### Research Interests

Use these interests:

- Agent self-evolution and automated improvement
- Code intelligence and software-engineering agents
- AI-agent evaluation
- Reinforcement learning and post-training
- Reliable long-horizon agents

Reliable long-horizon agents appears last because the user is not a main
contributor to the survey.

### Featured Work

Show the three works in contribution-priority order:

1. **[Simple Evolve Agent](https://github.com/simple-agent-lab/simple-evolve-agent)**
   — **Coming soon.** Infrastructure for reproducible agent self-evolution
   research, supporting iterative improvement with sandboxed evaluation,
   provenance tracking, and reliability guardrails.
2. **[Simple Agent Lab](https://github.com/simple-agent-lab/simple-agent-lab)**
   — **Coming soon.** A compact and practical agent framework for
   understandable, verifiable long-horizon work and reproducible evaluation.
3. **[Building Reliable Long-Horizon Agents: A Survey](https://building-reliable-long-horizon-agent.github.io/)**
   — A survey of the definitions, metrics, benchmarks, and system-design
   principles needed to build agents that remain reliable over extended tasks.

The two private GitHub links remain clickable. The "Coming soon" labels explain
their current private/404 state and should remain after the repositories become
public so no website update is required at release time.

### Experience

Rename "Experience Snapshot" to "Experience" and use this order:

1. **Large Language Model Engineering Intern, Douyin AI, ByteDance — May
   2026–Present.** Working on agent self-evolution, practical agent systems,
   and evaluation for long-horizon and code-oriented tasks.
2. Keep **Researcher, Shanghai Jiao Tong University — Spring 2026** with its
   existing EffiSkill and code-efficiency description.
3. Keep **Research Assistant, UC Berkeley — Fall 2025** unchanged.
4. Keep **Researcher, Shanghai Jiao Tong University — Summer 2025** unchanged.
5. Keep **Teaching Assistant, UC Berkeley — Fall 2024** unchanged.

Historical SJTU roles remain. Only the current-role language changes.

## Projects page

Create two project entries in this order:

1. Simple Evolve Agent
2. Simple Agent Lab

Each entry links to its GitHub repository and displays "Coming soon." Simple
Evolve Agent receives the longer description and greater prominence.

## Publications page

Add **Building Reliable Long-Horizon Agents: A Survey** as a 2026 preprint.
Link its title to the public project page:

<https://building-reliable-long-horizon-agent.github.io/>

Remove CodeEffiJudge from:

- the homepage
- the publications collection
- its standalone `/publication/codeeffijudge/` route

Keep EffiSkill and every other existing publication unchanged.

## Scope and constraints

- Do not alter the CV page.
- Do not alter historical SJTU, UC Berkeley, or teaching experience content
  except for section placement and the approved heading change.
- Do not expose private repository contents beyond the approved summaries.
- Do not modify or commit the unrelated `.DS_Store` working-tree change.
- Preserve the existing visual theme and navigation structure.

## Validation

After implementation and deployment:

- The homepage shows the new introduction, research interests, Featured Work,
  and Experience sections in the approved order.
- Simple Evolve Agent appears before Simple Agent Lab, and the survey appears
  last.
- Both private project links are present and labeled "Coming soon."
- The Projects page contains both project entries.
- The survey appears on Publications and its project-page link works.
- No rendered page or source content references CodeEffiJudge.
- `/publication/codeeffijudge/` returns 404 after deployment.
- The CV page, EffiSkill publication, and historical experience remain
  available.

# Personal Website Content Polish Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update the personal website's homepage, project portfolio, and survey links so they accurately present Zimu Wang's current experience and open-source contributions without changing the existing visual design.

**Architecture:** Preserve the current Academic Pages/Jekyll structure and update only Markdown documents in the homepage, `portfolio`, and `publications` collections. Use source-level assertions for each content unit, then run a complete Jekyll build and inspect the rendered pages at desktop and mobile widths.

**Tech Stack:** Jekyll, Academic Pages, Markdown, YAML front matter, Liquid collection templates, Ruby source assertions, Bundler

## Global Constraints

- Preserve the current Jekyll theme, sidebar, navigation, typography, dark mode, and page structure.
- Make content-level changes only; do not modify CSS, Sass, JavaScript, layouts, includes, or theme configuration.
- Serve AI engineering recruiters first and research collaborators or graduate admissions readers second.
- Present RSIHub as Zimu's flagship project and describe him as its primary developer who built it from 0 to 1.
- Present EffiSkill as Zimu's flagship first-author research work.
- Scope Simple Long Horizon Agent as contributor work; do not call Zimu its creator, lead developer, or primary contributor.
- Do not list AutoTrainess as Zimu's work.
- Do not add the survey or Simple Long Horizon Agent to the homepage Selected Work section.
- Update ByteDance to May–August 2026 on the homepage only.
- Merge the two SJTU periods on the homepage only.
- Do not modify `_pages/cv.md`, `_data/cv.json`, `Zimu_Resume.pdf`, or `files/Zimu_Wang_Resume.pdf`.
- Do not stage, modify further, or commit the unrelated `.DS_Store` working-tree change or `.superpowers/` brainstorming artifacts.

## File Structure

- `_pages/about.md`: root homepage copy, research interests, Selected Work, and homepage-only Experience summary.
- `_pages/portfolio.html`: Projects page introduction and priority-sorted portfolio collection rendering.
- `_portfolio/01-rsihub.md`: RSIHub listing metadata and contribution-focused detail content.
- `_portfolio/02-simple-long-horizon-agent.md`: scoped Simple Long Horizon Agent listing and detail content.
- `_publications/2026-07-01-long-horizon-agents-survey.md`: existing survey publication metadata, project link, and public-repository link.

---

### Task 1: Refresh the Homepage Content

**Files:**
- Modify: `_pages/about.md`

**Interfaces:**
- Consumes: Existing homepage front matter, profile links, Research Interests list, and Academic Pages Markdown rendering.
- Produces: Updated content for the root `/` route with Introduction, Research Interests, Selected Work, and Experience in that order.

- [ ] **Step 1: Run the approved-homepage assertion and verify the current source fails it**

Run:

```bash
ruby -e '
text = File.read("_pages/about.md")
required = [
  "I recently completed a **Large Language Model Engineering Internship at Douyin AI, ByteDance**",
  "Selected Work",
  "[RSIHub](https://simpleagentlab.com/rsihub/)",
  "Primary developer; built the project from 0→1",
  "May–August 2026",
  "Researcher, Shanghai Jiao Tong University — Summer 2025 and Spring 2026"
]
forbidden = ["Featured Work", "Simple Evolve Agent", "Coming soon", "May 2026–Present"]
missing = required.reject { |value| text.include?(value) }
present = forbidden.select { |value| text.include?(value) }
abort("missing: #{missing.join(" | ")}; forbidden: #{present.join(" | ")}") unless missing.empty? && present.empty?
'
```

Expected: FAIL and report the missing approved wording plus the current stale wording.

- [ ] **Step 2: Replace the homepage body with the approved copy**

Keep the existing YAML front matter and replace the Markdown body with:

```markdown
I am a computer science undergraduate at **UC Berkeley**. I recently completed a **Large Language Model Engineering Internship at Douyin AI, ByteDance**, where I worked on agent self-evolution, practical agent systems, and evaluation for long-horizon and code-oriented tasks. My research focuses on self-improving agents, code intelligence, and reliable AI systems.

<p><a href="/files/Zimu_Wang_Resume.pdf">Resume PDF</a> | <a href="https://scholar.google.com/citations?user=jAEC_qEAAAAJ&hl=en&oi=sra">Google Scholar</a> | <a href="https://github.com/zimuwang-real">GitHub</a></p>

Research Interests
======

* Agent self-evolution and automated improvement
* Code intelligence and software-engineering agents
* AI-agent evaluation
* Reinforcement learning and post-training
* Reliable long-horizon agents

Selected Work
======

* **[RSIHub](https://simpleagentlab.com/rsihub/)** — **Primary developer; built the project from 0→1.** An open-source framework for reproducible agent self-improvement under frozen evaluators and declared mutation boundaries, with auditable experiment lineage.
* **[EffiSkill: Agent Skill Based Automated Code Efficiency Optimization](https://arxiv.org/abs/2603.27850)** — **Under review at EACL 2027.** First-author work on automated code-efficiency optimization using reusable agent skills mined from slow and optimized program pairs.

Experience
======

* **Large Language Model Engineering Intern, Douyin AI, ByteDance — May–August 2026:** worked on agent self-evolution, practical agent systems, and evaluation for long-horizon and code-oriented tasks.
* **Researcher, Shanghai Jiao Tong University — Summer 2025 and Spring 2026:** developed SFT and GRPO training pipelines for code models, then built EffiSkill and its scalable inference and evaluation workflows for code-efficiency optimization.
* **Research Assistant, UC Berkeley (Fall 2025):** developed data-cleaning and analysis pipelines on a 1.2M-row gig-economy dataset and supported collaborator-facing empirical analysis.
* **Teaching Assistant, UC Berkeley (Fall 2024):** mentored students on Data 8 for data science and Python programming.
```

- [ ] **Step 3: Re-run the approved-homepage assertion**

Run the Ruby command from Step 1.

Expected: PASS with exit code 0.

- [ ] **Step 4: Verify preserved homepage content and protected-file scope**

Run:

```bash
rg -n 'Resume PDF|Google Scholar|github.com/zimuwang-real|Research Assistant, UC Berkeley|Teaching Assistant, UC Berkeley' _pages/about.md
git diff --check -- _pages/about.md
git diff --exit-code 21d16cd -- _pages/cv.md _data/cv.json Zimu_Resume.pdf files/Zimu_Wang_Resume.pdf
```

Expected: The preserved items are printed; both Git commands exit 0 without output.

- [ ] **Step 5: Commit the homepage refresh**

Run:

```bash
git add -- _pages/about.md
git diff --cached --check
git commit -m "Update homepage work and experience"
```

Expected: One commit containing only `_pages/about.md`; `.DS_Store` and `.superpowers/` remain unstaged.

---

### Task 2: Replace the Obsolete Project Entries

**Files:**
- Modify: `_pages/portfolio.html`
- Create: `_portfolio/01-rsihub.md`
- Create: `_portfolio/02-simple-long-horizon-agent.md`
- Delete: `_portfolio/01-simple-evolve-agent.md`
- Delete: `_portfolio/02-simple-agent-lab.md`

**Interfaces:**
- Consumes: Jekyll's `portfolio` collection, numeric `priority` front matter, and `_includes/archive-single.html` rendering.
- Produces: `/projects/`, `/project/rsihub/`, and `/project/simple-long-horizon-agent/` content with correct contribution scope and external links.

- [ ] **Step 1: Run the project-content assertion and verify the current source fails it**

Run:

```bash
ruby -e '
required_files = ["_portfolio/01-rsihub.md", "_portfolio/02-simple-long-horizon-agent.md"]
forbidden_files = ["_portfolio/01-simple-evolve-agent.md", "_portfolio/02-simple-agent-lab.md"]
missing = required_files.reject { |path| File.file?(path) }
present = forbidden_files.select { |path| File.exist?(path) }
portfolio = File.read("_pages/portfolio.html")
abort("missing files: #{missing.join(", ")}; obsolete files: #{present.join(", ")}") unless missing.empty? && present.empty?
abort("missing Simple Agent Lab introduction") unless portfolio.include?("open-source research collective") && portfolio.include?("https://simpleagentlab.com/")
'
```

Expected: FAIL because the approved project files are absent and the obsolete entries remain.

- [ ] **Step 2: Replace the RSIHub portfolio document**

Delete `_portfolio/01-simple-evolve-agent.md` and create `_portfolio/01-rsihub.md` with:

```markdown
---
title: "RSIHub"
collection: portfolio
permalink: /project/rsihub/
link: https://simpleagentlab.com/rsihub/
priority: 1
excerpt: "**Primary developer; built the project from 0→1.** An open-source framework for reproducible agent self-improvement under frozen evaluators and declared mutation boundaries, with auditable experiment lineage."
---

I am the primary developer of RSIHub and led its 0→1 implementation. My work spans the experiment lifecycle and framework architecture, evaluator isolation and mutation boundaries, candidate lineage and evidence retention, the recipe and operator system, runtime and Harbor integration, benchmark infrastructure, testing, and documentation.

RSIHub enables controlled agent self-improvement while keeping the evaluation mechanism outside the candidate's mutable surface and preserving reproducible evidence for each generation.

[Project overview](https://simpleagentlab.com/rsihub/) · [GitHub](https://github.com/simple-agent-lab/RSIHub) · [Documentation](https://simpleagentlab.com/RSIHub/)
```

- [ ] **Step 3: Replace the Simple Long Horizon Agent portfolio document**

Delete `_portfolio/02-simple-agent-lab.md` and create `_portfolio/02-simple-long-horizon-agent.md` with:

```markdown
---
title: "Simple Long Horizon Agent"
collection: portfolio
permalink: /project/simple-long-horizon-agent/
link: https://github.com/simple-agent-lab/simple-long-horizon-agent
priority: 2
excerpt: "Contributor to agent skills, composable agent interfaces, tools, memory, and evaluation infrastructure. Also conducted experiments on PostTrainBench."
---

I contributed to agent skills, composable agent interfaces, tools, memory, and evaluation infrastructure in Simple Long Horizon Agent. I also conducted experiments on PostTrainBench.

This is a collaborative project; I am not its primary contributor.

[View the repository](https://github.com/simple-agent-lab/simple-long-horizon-agent).
```

- [ ] **Step 4: Add the Simple Agent Lab context to the Projects page**

In `_pages/portfolio.html`, keep the existing front matter, `{% include base_path %}`, priority sort, and loop. Insert this paragraph between the include and the `{% assign projects ... %}` line:

```html
<p>These projects are part of <a href="https://simpleagentlab.com/">Simple Agent Lab</a>, an open-source research collective exploring simple yet effective methods for AI4AI and self-improving systems.</p>
```

- [ ] **Step 5: Re-run and extend the project-content assertion**

Run the Ruby command from Step 1, then run:

```bash
rg -n 'Primary developer; built the project from 0→1|github.com/simple-agent-lab/RSIHub|simpleagentlab.com/RSIHub/' _portfolio/01-rsihub.md
rg -n 'Contributor to agent skills|PostTrainBench|not its primary contributor' _portfolio/02-simple-long-horizon-agent.md
! rg -n 'creator|lead developer|primary developer' _portfolio/02-simple-long-horizon-agent.md
! rg -n 'AutoTrainess|Coming soon|Simple Evolve Agent' _pages/portfolio.html _portfolio
git diff --check -- _pages/portfolio.html _portfolio
```

Expected: Required contribution and link lines are printed; all negative searches and `git diff --check` exit 0 without output.

- [ ] **Step 6: Commit the project refresh**

Run:

```bash
git add -- _pages/portfolio.html _portfolio/01-rsihub.md _portfolio/02-simple-long-horizon-agent.md _portfolio/01-simple-evolve-agent.md _portfolio/02-simple-agent-lab.md
git diff --cached --check
git commit -m "Update open-source project portfolio"
```

Expected: One commit containing only the Projects page and portfolio document replacement; `.DS_Store` and `.superpowers/` remain unstaged.

---

### Task 3: Expose the Survey's Public Repository

**Files:**
- Modify: `_publications/2026-07-01-long-horizon-agents-survey.md`

**Interfaces:**
- Consumes: Jekyll's `publications` collection and Markdown rendering of the `excerpt` field in `_includes/archive-single.html`.
- Produces: A Publications listing whose title links to the survey project page and whose excerpt exposes the public GitHub repository.

- [ ] **Step 1: Run the survey-link assertion and verify the current source fails it**

Run:

```bash
ruby -e '
text = File.read("_publications/2026-07-01-long-horizon-agents-survey.md")
required = [
  "link: \"https://building-reliable-long-horizon-agent.github.io/\"",
  "https://github.com/Building-Reliable-Long-Horizon-Agent/Building-Reliable-Long-Horizon-Agent.github.io",
  "Open-source materials: [GitHub]"
]
missing = required.reject { |value| text.include?(value) }
abort("missing: #{missing.join(" | ")}") unless missing.empty?
'
```

Expected: FAIL because the current publication document does not expose the public repository.

- [ ] **Step 2: Add the repository link without changing publication status**

In `_publications/2026-07-01-long-horizon-agents-survey.md`, replace the `excerpt` value with:

```yaml
excerpt: "A survey of the definitions, metrics, benchmarks, and system-design principles needed to build agents that remain reliable over extended tasks. Open-source materials: [GitHub](https://github.com/Building-Reliable-Long-Horizon-Agent/Building-Reliable-Long-Horizon-Agent.github.io)."
```

Replace the final body link with:

```markdown
[Visit the project page](https://building-reliable-long-horizon-agent.github.io/) · [View the public repository](https://github.com/Building-Reliable-Long-Horizon-Agent/Building-Reliable-Long-Horizon-Agent.github.io)
```

Keep `venue: "Preprint"`, `external_only: true`, the title, date, permalink, and project-page `link` unchanged.

- [ ] **Step 3: Re-run the survey-link assertion and verify publication preservation**

Run the Ruby command from Step 1, then run:

```bash
rg -n '^title: "Building Reliable Long-Horizon Agents: A Survey"$|^venue: "Preprint"$|^external_only: true$|^date: 2026-07-01$' _publications/2026-07-01-long-horizon-agents-survey.md
rg -n '^title: "EffiSkill:|^venue: "Under review at EACL 2027"$' _publications/2026-03-29-effiskill.md
git diff --check -- _publications/2026-07-01-long-horizon-agents-survey.md
```

Expected: The preserved publication metadata is printed and `git diff --check` exits 0.

- [ ] **Step 4: Commit the survey-link update**

Run:

```bash
git add -- _publications/2026-07-01-long-horizon-agents-survey.md
git diff --cached --check
git commit -m "Link survey open-source materials"
```

Expected: One commit containing only the survey publication document; `.DS_Store` and `.superpowers/` remain unstaged.

---

### Task 4: Build and Verify the Complete Site

**Files:**
- Verify: `_pages/about.md`
- Verify: `_pages/portfolio.html`
- Verify: `_portfolio/01-rsihub.md`
- Verify: `_portfolio/02-simple-long-horizon-agent.md`
- Verify: `_publications/2026-03-29-effiskill.md`
- Verify: `_publications/2026-07-01-long-horizon-agents-survey.md`
- Verify unchanged: `_pages/cv.md`
- Verify unchanged: `_data/cv.json`
- Verify unchanged: `Zimu_Resume.pdf`
- Verify unchanged: `files/Zimu_Wang_Resume.pdf`

**Interfaces:**
- Consumes: All content produced by Tasks 1–3 and the repository's Jekyll build configuration.
- Produces: A successful static-site build and evidence that the approved pages render correctly without protected-file changes.

- [ ] **Step 1: Run source-wide stale-content and scope assertions**

Run:

```bash
! rg -n 'Coming soon|Simple Evolve Agent|May 2026–Present' _pages _portfolio _publications
! rg -n 'AutoTrainess' _pages/about.md _pages/portfolio.html _portfolio
rg -n 'RSIHub|EffiSkill|May–August 2026|Summer 2025 and Spring 2026' _pages/about.md
rg -n 'Simple Agent Lab|RSIHub|Simple Long Horizon Agent' _pages/portfolio.html _portfolio
git diff --exit-code 21d16cd -- _pages/cv.md _data/cv.json Zimu_Resume.pdf files/Zimu_Wang_Resume.pdf
git diff --check
```

Expected: Negative searches and Git checks exit 0; approved content searches print matches.

- [ ] **Step 2: Build the Jekyll site**

Run:

```bash
bundle exec jekyll build --trace
```

Expected: Exit code 0 and generated output in `_site/` with no Liquid, YAML, or Markdown errors.

- [ ] **Step 3: Verify generated routes and rendered copy**

Run:

```bash
test -f _site/index.html
test -f _site/projects/index.html
test -f _site/publications/index.html
test -f _site/project/rsihub/index.html
test -f _site/project/simple-long-horizon-agent/index.html
rg -n 'Primary developer; built the project from 0→1|May–August 2026' _site/index.html
rg -n 'open-source research collective|Simple Long Horizon Agent|PostTrainBench' _site/projects/index.html _site/project/simple-long-horizon-agent/index.html
rg -n 'Building Reliable Long-Horizon Agents|Building-Reliable-Long-Horizon-Agent.github.io' _site/publications/index.html
! rg -n 'Coming soon|Simple Evolve Agent|May 2026–Present|AutoTrainess' _site/index.html _site/projects/index.html _site/publications/index.html _site/project
```

Expected: Every route exists; approved rendered text is found; no stale or unrelated project language is found.

- [ ] **Step 4: Inspect desktop and mobile rendering**

Run:

```bash
bundle exec jekyll serve --host 127.0.0.1 --port 4000
```

Keep that terminal session running during browser inspection, then stop it with
Ctrl-C after all three routes have been checked at both viewport sizes.

Open these routes in the browser at 1440×900 and 390×844:

- <http://127.0.0.1:4000/>
- <http://127.0.0.1:4000/projects/>
- <http://127.0.0.1:4000/publications/>

Expected at both widths:

- The existing header, sidebar, navigation, typography, and dark-mode control retain their current appearance.
- Homepage sections appear in the approved order and do not overflow.
- Project and publication links are readable and do not collide with titles or excerpts.
- RSIHub precedes Simple Long Horizon Agent on Projects.
- RSIHub precedes EffiSkill in homepage Selected Work.

- [ ] **Step 5: Verify all approved external links**

Check these URLs with a GET request that follows redirects and discards the
response body:

```bash
for url in \
  https://simpleagentlab.com/ \
  https://simpleagentlab.com/rsihub/ \
  https://simpleagentlab.com/RSIHub/ \
  https://github.com/simple-agent-lab/RSIHub \
  https://github.com/simple-agent-lab/simple-long-horizon-agent \
  https://arxiv.org/abs/2603.27850 \
  https://building-reliable-long-horizon-agent.github.io/ \
  https://github.com/Building-Reliable-Long-Horizon-Agent/Building-Reliable-Long-Horizon-Agent.github.io
do
  curl -L --fail --silent --show-error --output /dev/null "$url"
done
```

Expected: Exit code 0 after every URL returns a successful response.

- [ ] **Step 6: Confirm final repository scope**

Run:

```bash
git status --short
git log -4 --oneline --decorate
```

Expected: The three content commits and plan commit are visible. Only the pre-existing `.DS_Store` change and untracked `.superpowers/` artifacts remain outside committed work; no website implementation changes are unstaged.

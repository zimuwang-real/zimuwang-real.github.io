# Website Content Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update the personal website with the approved ByteDance role, two Simple Agent Lab projects, and the long-horizon agents survey while removing all public CodeEffiJudge content.

**Architecture:** Keep the existing Jekyll collections and visual theme. Update the homepage copy directly in `_pages/about.md`, represent the two repositories as ordered `portfolio` collection entries, and replace the CodeEffiJudge publication document with a survey publication document. Validate source ordering and absence checks before publishing, then use the deployed GitHub Pages output as the end-to-end build verification.

**Tech Stack:** Jekyll, Markdown with YAML front matter, Liquid collection templates, Bash/Ruby source assertions, GitHub Pages

## Global Constraints

- Preserve the existing visual theme and navigation structure.
- Keep the CV page unchanged.
- Keep EffiSkill and all historical SJTU, UC Berkeley, and teaching experience content.
- Show Simple Evolve Agent before Simple Agent Lab, and show the survey last.
- Keep both private GitHub links clickable and label both projects "Coming soon."
- Remove every CodeEffiJudge source and rendered reference, including `/publication/codeeffijudge/`.
- Do not stage, modify further, or commit the unrelated `.DS_Store` working-tree change.
- Use only the approved project summaries; do not expose additional private-repository content.

---

### Task 1: Refresh the homepage

**Files:**
- Modify: `_pages/about.md`

**Interfaces:**
- Consumes: Existing homepage front matter and external profile links.
- Produces: Approved Introduction, Research Interests, Featured Work, and Experience sections used by the root `/` route.

- [ ] **Step 1: Run the homepage assertion before editing**

Run:

```bash
ruby -e '
text = File.read("_pages/about.md")
required = [
  "Large Language Model Engineering Intern at Douyin AI, ByteDance",
  "Featured Work",
  "Simple Evolve Agent",
  "Simple Agent Lab",
  "Building Reliable Long-Horizon Agents: A Survey",
  "Large Language Model Engineering Intern, Douyin AI, ByteDance — May 2026–Present"
]
missing = required.reject { |value| text.include?(value) }
abort("missing: #{missing.join(", ")}") unless missing.empty?
abort("CodeEffiJudge still present") if text.include?("CodeEffiJudge")
evolve = text.index("Simple Evolve Agent")
lab = text.index("Simple Agent Lab")
survey = text.index("Building Reliable Long-Horizon Agents: A Survey")
abort("wrong Featured Work order") unless evolve < lab && lab < survey
'
```

Expected: FAIL with a list of missing approved content and/or `CodeEffiJudge still present`.

- [ ] **Step 2: Replace the homepage body with the approved content**

Keep the existing front matter and replace the Markdown body with:

```markdown
I am a computer science undergraduate at **UC Berkeley** and a **Large Language Model Engineering Intern at Douyin AI, ByteDance**. My work focuses on agent self-evolution, code intelligence, AI-agent evaluation, and reliable long-horizon systems.

<p><a href="/files/Zimu_Wang_Resume.pdf">Resume PDF</a> | <a href="https://scholar.google.com/citations?user=jAEC_qEAAAAJ&hl=en&oi=sra">Google Scholar</a> | <a href="https://github.com/zimuwang-real">GitHub</a></p>

Research Interests
======

* Agent self-evolution and automated improvement
* Code intelligence and software-engineering agents
* AI-agent evaluation
* Reinforcement learning and post-training
* Reliable long-horizon agents

Featured Work
======

* **[Simple Evolve Agent](https://github.com/simple-agent-lab/simple-evolve-agent)** — **Coming soon.** Infrastructure for reproducible agent self-evolution research, supporting iterative improvement with sandboxed evaluation, provenance tracking, and reliability guardrails.
* **[Simple Agent Lab](https://github.com/simple-agent-lab/simple-agent-lab)** — **Coming soon.** A compact and practical agent framework for understandable, verifiable long-horizon work and reproducible evaluation.
* **[Building Reliable Long-Horizon Agents: A Survey](https://building-reliable-long-horizon-agent.github.io/)** — A survey of the definitions, metrics, benchmarks, and system-design principles needed to build agents that remain reliable over extended tasks.

Experience
======

* **Large Language Model Engineering Intern, Douyin AI, ByteDance — May 2026–Present:** working on agent self-evolution, practical agent systems, and evaluation for long-horizon and code-oriented tasks.
* **Researcher, Shanghai Jiao Tong University (Spring 2026):** built EffiSkill, scalable inference pipelines, and offline evaluation workflows on EffiBench-X for code-efficiency optimization.
* **Research Assistant, UC Berkeley (Fall 2025):** developed data-cleaning and analysis pipelines on a 1.2M-row gig-economy dataset and supported collaborator-facing empirical analysis.
* **Researcher, Shanghai Jiao Tong University (Summer 2025):** implemented SFT + GRPO training pipelines for code LLMs and ran large-scale ablations on 8 x A100 GPUs.
* **Teaching Assistant, UC Berkeley (Fall 2024):** mentored students on Data 8 for data science and Python programming.
```

- [ ] **Step 3: Re-run the homepage assertion**

Run the Ruby command from Step 1.

Expected: PASS with exit code 0.

- [ ] **Step 4: Verify preserved profile and historical content**

Run:

```bash
rg -n 'Resume PDF|Google Scholar|github.com/zimuwang-real|Shanghai Jiao Tong University|Research Assistant, UC Berkeley|Teaching Assistant, UC Berkeley' _pages/about.md
! rg -n 'Currently, I am working on research with.*Shanghai Jiao Tong University|CodeEffiJudge' _pages/about.md
git diff --check -- _pages/about.md
```

Expected: All preserved items are printed; the negative search prints nothing; `git diff --check` exits 0.

- [ ] **Step 5: Commit the homepage refresh**

```bash
git add -- _pages/about.md
git diff --cached --check
git commit -m "Refresh homepage work and experience"
```

Expected: One commit containing only `_pages/about.md`; `.DS_Store` remains unstaged.

---

### Task 2: Add ordered Simple Agent Lab project entries

**Files:**
- Create: `_portfolio/01-simple-evolve-agent.md`
- Create: `_portfolio/02-simple-agent-lab.md`
- Modify: `_pages/portfolio.html`

**Interfaces:**
- Consumes: Jekyll's `portfolio` collection and `_includes/archive-single.html`, which uses a document's `link`, `title`, `url`, and `excerpt`.
- Produces: Two externally linked project entries sorted by numeric `priority`.

- [ ] **Step 1: Run the project-entry assertion before creating files**

Run:

```bash
test -f _portfolio/01-simple-evolve-agent.md
test -f _portfolio/02-simple-agent-lab.md
rg -q 'sort: "priority"' _pages/portfolio.html
rg -q 'Coming soon' _portfolio/01-simple-evolve-agent.md
rg -q 'Coming soon' _portfolio/02-simple-agent-lab.md
```

Expected: FAIL because the two project documents do not exist.

- [ ] **Step 2: Create the Simple Evolve Agent entry**

Create `_portfolio/01-simple-evolve-agent.md`:

```markdown
---
title: "Simple Evolve Agent"
collection: portfolio
permalink: /project/simple-evolve-agent/
link: https://github.com/simple-agent-lab/simple-evolve-agent
priority: 1
excerpt: "**Coming soon.** Infrastructure for reproducible agent self-evolution research, supporting iterative improvement with sandboxed evaluation, provenance tracking, and reliability guardrails."
---

**Coming soon.**

Simple Evolve Agent provides infrastructure for reproducible agent self-evolution research. It supports iterative agent improvement with sandboxed evaluation, provenance tracking, and reliability guardrails.

[View the repository](https://github.com/simple-agent-lab/simple-evolve-agent).
```

- [ ] **Step 3: Create the Simple Agent Lab entry**

Create `_portfolio/02-simple-agent-lab.md`:

```markdown
---
title: "Simple Agent Lab"
collection: portfolio
permalink: /project/simple-agent-lab/
link: https://github.com/simple-agent-lab/simple-agent-lab
priority: 2
excerpt: "**Coming soon.** A compact and practical agent framework for understandable, verifiable long-horizon work and reproducible evaluation."
---

**Coming soon.**

Simple Agent Lab is a compact and practical agent framework for learning, experimentation, and real work that requires sustained progress across many model turns. It emphasizes understandable behavior, verification, and reproducible evaluation.

[View the repository](https://github.com/simple-agent-lab/simple-agent-lab).
```

- [ ] **Step 4: Sort the Projects page by priority**

In `_pages/portfolio.html`, replace:

```liquid
{% for post in site.portfolio %}
  {% include archive-single.html %}
{% endfor %}
```

with:

```liquid
{% assign projects = site.portfolio | sort: "priority" %}
{% for post in projects %}
  {% include archive-single.html %}
{% endfor %}
```

- [ ] **Step 5: Re-run and extend the project assertion**

Run:

```bash
set -eu
test -f _portfolio/01-simple-evolve-agent.md
test -f _portfolio/02-simple-agent-lab.md
rg -q 'sort: "priority"' _pages/portfolio.html
rg -q '^priority: 1$' _portfolio/01-simple-evolve-agent.md
rg -q '^priority: 2$' _portfolio/02-simple-agent-lab.md
rg -q 'https://github.com/simple-agent-lab/simple-evolve-agent' _portfolio/01-simple-evolve-agent.md
rg -q 'https://github.com/simple-agent-lab/simple-agent-lab' _portfolio/02-simple-agent-lab.md
rg -q 'Coming soon' _portfolio/01-simple-evolve-agent.md
rg -q 'Coming soon' _portfolio/02-simple-agent-lab.md
git diff --check -- _portfolio/01-simple-evolve-agent.md _portfolio/02-simple-agent-lab.md _pages/portfolio.html
```

Expected: PASS with exit code 0.

- [ ] **Step 6: Commit the project entries**

```bash
git add -- _portfolio/01-simple-evolve-agent.md _portfolio/02-simple-agent-lab.md _pages/portfolio.html
git diff --cached --check
git commit -m "Add Simple Agent Lab projects"
```

Expected: One commit containing only the two project documents and Projects page ordering; `.DS_Store` remains unstaged.

---

### Task 3: Replace CodeEffiJudge with the survey publication

**Files:**
- Delete: `_publications/2026-01-01-codeeffijudge.md`
- Create: `_publications/2026-07-01-long-horizon-agents-survey.md`

**Interfaces:**
- Consumes: Jekyll's `publications` collection and `_includes/archive-single.html`.
- Produces: A 2026 preprint entry whose title links to the public survey page and whose local permalink provides a stable detail page.

- [ ] **Step 1: Run the publication assertion before editing**

Run:

```bash
test ! -e _publications/2026-01-01-codeeffijudge.md
test -f _publications/2026-07-01-long-horizon-agents-survey.md
! rg -n -i 'CodeEffiJudge|codeeffijudge' _pages _publications _portfolio
```

Expected: FAIL because CodeEffiJudge still exists and the survey document does not.

- [ ] **Step 2: Delete the unpublished CodeEffiJudge document**

Delete `_publications/2026-01-01-codeeffijudge.md`.

- [ ] **Step 3: Create the survey publication document**

Create `_publications/2026-07-01-long-horizon-agents-survey.md`:

```markdown
---
title: "Building Reliable Long-Horizon Agents: A Survey"
collection: publications
category: conferences
permalink: /publication/building-reliable-long-horizon-agents/
link: https://building-reliable-long-horizon-agent.github.io/
excerpt: "A survey of the definitions, metrics, benchmarks, and system-design principles needed to build agents that remain reliable over extended tasks."
date: 2026-07-01
venue: "Preprint"
---

Building Reliable Long-Horizon Agents surveys how long-horizon capability should be defined, measured, evaluated, and engineered across the full agent system. It covers model design, harness design, environments, benchmarks, reliability, recovery, and evaluation protocols.

[Visit the project page](https://building-reliable-long-horizon-agent.github.io/).
```

- [ ] **Step 4: Re-run and extend the publication assertion**

Run:

```bash
set -eu
test ! -e _publications/2026-01-01-codeeffijudge.md
test -f _publications/2026-07-01-long-horizon-agents-survey.md
! rg -n -i 'CodeEffiJudge|codeeffijudge' _pages _publications _portfolio
rg -q '^title: "Building Reliable Long-Horizon Agents: A Survey"$' _publications/2026-07-01-long-horizon-agents-survey.md
rg -q '^link: https://building-reliable-long-horizon-agent.github.io/$' _publications/2026-07-01-long-horizon-agents-survey.md
rg -q '^venue: "Preprint"$' _publications/2026-07-01-long-horizon-agents-survey.md
test -f _publications/2026-03-29-effiskill.md
git diff --check -- _publications
```

Expected: PASS with exit code 0.

- [ ] **Step 5: Commit the publication replacement**

```bash
git add -- _publications/2026-01-01-codeeffijudge.md _publications/2026-07-01-long-horizon-agents-survey.md
git diff --cached --check
git commit -m "Publish long-horizon agents survey"
```

Expected: One commit deleting CodeEffiJudge and adding the survey; `.DS_Store` remains unstaged.

---

### Task 4: Validate, publish, and verify the live site

**Files:**
- Verify only: `_pages/about.md`
- Verify only: `_pages/portfolio.html`
- Verify only: `_portfolio/01-simple-evolve-agent.md`
- Verify only: `_portfolio/02-simple-agent-lab.md`
- Verify only: `_publications/2026-07-01-long-horizon-agents-survey.md`
- Preserve unstaged: `.DS_Store`

**Interfaces:**
- Consumes: All content produced by Tasks 1–3 and the GitHub Pages deployment from `main`.
- Produces: A live homepage, Projects page, Publications page, and expected 404 for the removed CodeEffiJudge route.

- [ ] **Step 1: Run complete source verification**

Run:

```bash
set -eu
git diff --check
test ! -e _publications/2026-01-01-codeeffijudge.md
test -f _publications/2026-03-29-effiskill.md
test -f _publications/2026-07-01-long-horizon-agents-survey.md
test -f _portfolio/01-simple-evolve-agent.md
test -f _portfolio/02-simple-agent-lab.md
test -f _pages/cv.md
! rg -n -i 'CodeEffiJudge|codeeffijudge' _pages _publications _portfolio
ruby -e '
text = File.read("_pages/about.md")
evolve = text.index("Simple Evolve Agent")
lab = text.index("Simple Agent Lab")
survey = text.index("Building Reliable Long-Horizon Agents: A Survey")
abort("missing Featured Work item") unless evolve && lab && survey
abort("wrong Featured Work order") unless evolve < lab && lab < survey
'
npm run build:js
node --check assets/js/main.min.js
test "$(git status --porcelain .DS_Store)" = " M .DS_Store"
test -z "$(git status --porcelain | awk '$2 != ".DS_Store" { print }')"
```

Expected: PASS; JavaScript rebuild succeeds; `.DS_Store` is the only working-tree change.

- [ ] **Step 2: Verify the commit sequence**

Run:

```bash
git log -4 --oneline
git status --short --branch
```

Expected: The design, homepage, projects, and publication commits are present; `main` is ahead of `origin/main`; only `.DS_Store` is modified.

- [ ] **Step 3: Push `main`**

Run:

```bash
git push origin main
```

Expected: The local `main` commits are pushed to `https://github.com/zimuwang-real/zimuwang-real.github.io`.

- [ ] **Step 4: Wait for the GitHub Pages deployment**

Run:

```bash
for attempt in 1 2 3 4 5 6 7 8 9 10 11 12; do
  home=$(curl -sS -L "https://zimuwang-real.github.io/?content-refresh=${attempt}")
  projects=$(curl -sS -L "https://zimuwang-real.github.io/projects/?content-refresh=${attempt}")
  publications=$(curl -sS -L "https://zimuwang-real.github.io/publications/?content-refresh=${attempt}")
  codeeffi_status=$(curl -sS -L -o /dev/null -w '%{http_code}' "https://zimuwang-real.github.io/publication/codeeffijudge/?content-refresh=${attempt}")

  if printf '%s' "$home" | rg -q 'Simple Evolve Agent' &&
     printf '%s' "$home" | rg -q 'Large Language Model Engineering Intern' &&
     printf '%s' "$projects" | rg -q 'Simple Evolve Agent' &&
     printf '%s' "$projects" | rg -q 'Simple Agent Lab' &&
     printf '%s' "$publications" | rg -q 'Building Reliable Long-Horizon Agents' &&
     ! printf '%s%s%s' "$home" "$projects" "$publications" | rg -qi 'CodeEffiJudge|codeeffijudge' &&
     test "$codeeffi_status" = 404; then
    printf 'Deployment verified on attempt %s\n' "$attempt"
    exit 0
  fi

  printf 'Attempt %s: previous deployment still served\n' "$attempt"
  sleep 5
done
exit 1
```

Expected: PASS within 12 attempts after GitHub Pages updates.

- [ ] **Step 5: Run final live and repository verification**

Run:

```bash
set -eu
local_head=$(git rev-parse HEAD)
remote_head=$(git ls-remote https://github.com/zimuwang-real/zimuwang-real.github.io refs/heads/main | awk '{print $1}')
test "$local_head" = "$remote_head"
test "$(curl -sS -L -o /dev/null -w '%{http_code}' https://zimuwang-real.github.io/)" = 200
test "$(curl -sS -L -o /dev/null -w '%{http_code}' https://zimuwang-real.github.io/projects/)" = 200
test "$(curl -sS -L -o /dev/null -w '%{http_code}' https://zimuwang-real.github.io/publications/)" = 200
test "$(curl -sS -L -o /dev/null -w '%{http_code}' https://zimuwang-real.github.io/cv/)" = 200
test "$(curl -sS -L -o /dev/null -w '%{http_code}' https://zimuwang-real.github.io/publication/effiskill/)" = 200
test "$(curl -sS -L -o /dev/null -w '%{http_code}' https://zimuwang-real.github.io/publication/codeeffijudge/)" = 404
test "$(git status --porcelain .DS_Store)" = " M .DS_Store"
test -z "$(git status --porcelain | awk '$2 != ".DS_Store" { print }')"
printf 'HEAD=%s\nRemote=%s\nLive content refresh verified; .DS_Store remains unstaged.\n' "$local_head" "$remote_head"
```

Expected: All retained routes return 200, CodeEffiJudge returns 404, local and remote commits match, and `.DS_Store` remains the only unstaged change.

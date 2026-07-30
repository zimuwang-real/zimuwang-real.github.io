# Publication and Web CV Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reorganize featured work, make publication titles external-first, update EffiSkill's review status, and add the current ByteDance role to the web CV.

**Architecture:** Continue using Jekyll collection documents as the single publication data source for both the Publications and CV pages. Add an `external_only` front-matter flag that suppresses internal permalink icons while preserving collection rendering, then update the homepage and hand-authored web CV content directly.

**Tech Stack:** Jekyll, Liquid templates, Markdown, YAML front matter, Bundler

## Global Constraints

- Do not modify the downloadable resume PDF.
- Do not remove Simple Agent Lab from the Projects page.
- Do not remove the long-horizon-agent survey from Publications.
- Do not expose private repository contents.
- Preserve the site's current theme and navigation.
- Do not modify or commit the unrelated `.DS_Store` working-tree change.
- Keep Simple Evolve Agent before EffiSkill on the homepage.
- Use "Under review at EACL 2027" for EffiSkill.

---

### Task 1: External-first publication rendering and homepage hierarchy

**Files:**
- Modify: `_pages/about.md:23-28`
- Modify: `_publications/2026-03-29-effiskill.md:1-14`
- Modify: `_publications/2026-07-01-long-horizon-agents-survey.md:1-14`
- Modify: `_includes/archive-single.html:29-34`
- Modify: `_includes/archive-single-cv.html:26-31`

**Interfaces:**
- Consumes: Jekyll publication documents with optional `link` and `external_only` front matter.
- Produces: `external_only: true` publication entries whose titles open `post.link` without rendering an internal permalink icon.

- [ ] **Step 1: Record content assertions that currently fail**

Run:

```bash
test "$(rg -c '^\\* \\*\\*\\[' _pages/about.md)" -eq 2
rg -q 'EffiSkill.*EACL 2027' _pages/about.md
rg -q '^link: "https://arxiv.org/abs/2603.27850"$' _publications/2026-03-29-effiskill.md
rg -q '^external_only: true$' _publications/2026-03-29-effiskill.md
rg -q '^external_only: true$' _publications/2026-07-01-long-horizon-agents-survey.md
```

Expected: one or more commands fail because the homepage still has three
featured items and EffiSkill lacks the external-first metadata.

- [ ] **Step 2: Update publication metadata**

In `_publications/2026-03-29-effiskill.md`, replace:

```yaml
venue: "arXiv / under review at ASE 2026"
paperurl: "https://arxiv.org/abs/2603.27850"
```

with:

```yaml
venue: "Under review at EACL 2027"
link: "https://arxiv.org/abs/2603.27850"
external_only: true
```

In `_publications/2026-07-01-long-horizon-agents-survey.md`, quote the existing
`link` value and add:

```yaml
external_only: true
```

- [ ] **Step 3: Suppress internal permalinks for external-only entries**

In `_includes/archive-single.html`, render the existing permalink icon only
when `post.external_only` is not true:

```liquid
{% if post.link %}
  <a href="{{ post.link }}">{{ title }}</a>{% unless post.external_only %} <a href="{{ base_path }}{{ post.url }}" rel="permalink"><i class="fa fa-link" aria-hidden="true" title="permalink"></i><span class="sr-only">Permalink</span></a>{% endunless %}
{% else %}
  <a href="{{ base_path }}{{ post.url }}" rel="permalink">{{ title }}</a>
{% endif %}
```

Apply the identical conditional behavior to `_includes/archive-single-cv.html`.

- [ ] **Step 4: Replace homepage Featured Work**

Use exactly these two list items in `_pages/about.md`:

```markdown
* **[Simple Evolve Agent](https://github.com/simple-agent-lab/simple-evolve-agent)** — **Coming soon.** Infrastructure for reproducible agent self-evolution research, supporting iterative improvement with sandboxed evaluation, provenance tracking, and reliability guardrails.
* **[EffiSkill: Agent Skill Based Automated Code Efficiency Optimization](https://arxiv.org/abs/2603.27850)** — **Under review at EACL 2027.** First-author work on automated code-efficiency optimization using reusable agent skills mined from slow and optimized program pairs.
```

- [ ] **Step 5: Run focused assertions**

Run:

```bash
test "$(rg -c '^\\* \\*\\*\\[' _pages/about.md)" -eq 2
rg -q 'EffiSkill.*EACL 2027' _pages/about.md
! sed -n '/Featured Work/,/Experience/p' _pages/about.md | rg -q 'Simple Agent Lab|Building Reliable Long-Horizon'
rg -q '^link: "https://arxiv.org/abs/2603.27850"$' _publications/2026-03-29-effiskill.md
! rg -q '^paperurl:' _publications/2026-03-29-effiskill.md
test "$(rg -l 'external_only: true' _publications/*.md | wc -l | tr -d ' ')" -eq 2
rg -q 'unless post.external_only' _includes/archive-single.html
rg -q 'unless post.external_only' _includes/archive-single-cv.html
```

Expected: all commands exit successfully.

- [ ] **Step 6: Commit the publication and homepage changes**

```bash
git add _pages/about.md _publications/2026-03-29-effiskill.md _publications/2026-07-01-long-horizon-agents-survey.md _includes/archive-single.html _includes/archive-single-cv.html
git commit -m "feat: refine featured work and publication links"
```

### Task 2: Update the web CV

**Files:**
- Modify: `_pages/cv.md:17-58`

**Interfaces:**
- Consumes: the existing hand-authored `/cv/` Markdown page and publication collection.
- Produces: a Professional Experience section for the ByteDance role while retaining all existing historical CV sections and the unchanged PDF download link.

- [ ] **Step 1: Record CV assertions that currently fail**

Run:

```bash
rg -q '^Professional Experience$' _pages/cv.md
rg -q 'Large Language Model Engineering Intern, Douyin AI, ByteDance.*May 2026.*Present' _pages/cv.md
rg -q 'Simple Evolve Agent' _pages/cv.md
```

Expected: all three commands fail because the section does not yet exist.

- [ ] **Step 2: Add Professional Experience before Research Experience**

Insert this section after Education:

```markdown
Professional Experience
======

* **Large Language Model Engineering Intern, Douyin AI, ByteDance** - May 2026–Present
  * Leading the development of Simple Evolve Agent, infrastructure for reproducible agent self-evolution with sandboxed evaluation, provenance tracking, and reliability guardrails.
  * Contributing to Simple Agent Lab, a compact framework for understandable, verifiable long-horizon agent workflows and reproducible evaluation.
  * Supporting research and evaluation on reliable long-horizon agents, including system design, benchmarks, and failure recovery.
```

Keep Education, Research Experience, Teaching, Skills, and Selected
Publications unchanged apart from the publication metadata rendered through the
collection.

- [ ] **Step 3: Run CV assertions**

Run:

```bash
rg -q '^Professional Experience$' _pages/cv.md
rg -q 'Large Language Model Engineering Intern, Douyin AI, ByteDance.*May 2026.*Present' _pages/cv.md
rg -q 'Leading the development of Simple Evolve Agent' _pages/cv.md
rg -q 'Contributing to Simple Agent Lab' _pages/cv.md
rg -q 'reliable long-horizon agents' _pages/cv.md
rg -q '^\\[Download full resume \\(PDF\\)\\]\\(/files/Zimu_Wang_Resume.pdf\\)$' _pages/cv.md
```

Expected: all commands exit successfully.

- [ ] **Step 4: Commit the web CV**

```bash
git add _pages/cv.md
git commit -m "feat: add ByteDance role to web CV"
```

### Task 3: Build, inspect, and publish

**Files:**
- Create: `_site/` build output (ignored)
- Verify: `files/Zimu_Wang_Resume.pdf`
- Verify: `_portfolio/01-simple-evolve-agent.md`
- Verify: `_portfolio/02-simple-agent-lab.md`
- Verify: `.DS_Store`
- Commit: `docs/superpowers/specs/2026-07-30-publication-and-web-cv-refresh-design.md`
- Commit: `docs/superpowers/plans/2026-07-30-publication-and-web-cv-refresh.md`

**Interfaces:**
- Consumes: the complete Jekyll source tree.
- Produces: a successful static build and a pushed `main` branch.

- [ ] **Step 1: Build the site**

Run:

```bash
bundle exec jekyll build
```

Expected: exit code 0 and generated pages under `_site/`.

- [ ] **Step 2: Inspect rendered homepage, publications, and CV**

Run:

```bash
rg -q 'Simple Evolve Agent' _site/index.html
rg -q 'EffiSkill: Agent Skill Based Automated Code Efficiency Optimization' _site/index.html
! sed -n '/Featured Work/,/Experience/p' _site/index.html | rg -q 'Simple Agent Lab|Building Reliable Long-Horizon'
rg -q 'href="https://arxiv.org/abs/2603.27850"' _site/publications/index.html
rg -q 'href="https://building-reliable-long-horizon-agent.github.io/"' _site/publications/index.html
! rg -q 'Download Paper|title="permalink"' _site/publications/index.html
rg -q 'Professional Experience' _site/cv/index.html
rg -q 'Large Language Model Engineering Intern, Douyin AI, ByteDance' _site/cv/index.html
! rg -q 'Download Paper|title="permalink"' _site/cv/index.html
```

Expected: all commands exit successfully.

- [ ] **Step 3: Verify protected scope and repository state**

Run:

```bash
git diff --name-only
git status --short
git diff -- files/Zimu_Wang_Resume.pdf
rg -q 'Simple Evolve Agent' _portfolio/01-simple-evolve-agent.md
rg -q 'Simple Agent Lab' _portfolio/02-simple-agent-lab.md
```

Expected: the PDF has no diff, both project entries remain, and `.DS_Store` is
the only unrelated modified file.

- [ ] **Step 4: Commit the approved specification and plan**

```bash
git add docs/superpowers/specs/2026-07-30-publication-and-web-cv-refresh-design.md docs/superpowers/plans/2026-07-30-publication-and-web-cv-refresh.md
git commit -m "docs: record publication and web CV refresh"
```

- [ ] **Step 5: Review the complete branch diff**

Run:

```bash
git diff main...HEAD --check
git diff --stat main...HEAD
git log --oneline main..HEAD
git status --short
```

Expected: no whitespace errors; only approved source and documentation files
are committed; `.DS_Store` remains unstaged.

- [ ] **Step 6: Merge and push**

Switch to `main`, merge the feature branch with a merge commit, and push:

```bash
git switch main
git merge --no-ff codex/publication-web-cv-refresh
git push origin main
```

Expected: the merge succeeds, `origin/main` advances, and `.DS_Store` remains
unstaged and uncommitted.

# Publication Order and Author Presentation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Point RSIHub to GitHub and present EffiSkill first on the Publications page with its complete author list and Zimu Wang underlined.

**Architecture:** Keep publication content in collection front matter and make the archive renderer conditionally display author metadata. Add explicit numeric ordering to both publication records, then sort only the Publications page by that field so dates remain accurate and unrelated collection consumers are unaffected.

**Tech Stack:** Jekyll 3.9, Liquid templates, Markdown/YAML front matter, Ruby 3.1, shell assertions

## Global Constraints

- The homepage RSIHub URL must be exactly `https://github.com/simple-agent-lab/RSIHub`.
- EffiSkill must render before the long-horizon survey without changing either publication date.
- The EffiSkill author line must be exactly `<u>Zimu Wang</u>, Yuling Shi, Mengfan Li, Zijun Liu, Jie M. Zhang, Chengcheng Wan, Xiaodong Gu`.
- The long-horizon survey must not display an author line.
- Preserve the existing theme, typography, spacing, excerpts, venue copy, and CV/resume files.
- Add no CSS and no new dependencies.

---

### Task 1: Update the Homepage RSIHub Destination

**Files:**
- Modify: `_pages/about.md`
- Test: shell assertions against `_pages/about.md`

**Interfaces:**
- Consumes: the existing Markdown link in the Selected Work section.
- Produces: one RSIHub homepage link targeting the canonical GitHub repository.

- [ ] **Step 1: Run the failing source assertion**

Run:

```bash
rg -n '\* \*\*\[RSIHub\]\(https://github\.com/simple-agent-lab/RSIHub\)\*\*' _pages/about.md
```

Expected: FAIL with no matching line because the link still targets `simpleagentlab.com`.

- [ ] **Step 2: Replace only the RSIHub URL**

Change the Selected Work entry to begin with:

```markdown
* **[RSIHub](https://github.com/simple-agent-lab/RSIHub)** — **Primary developer; built the project from 0→1.**
```

Keep the remainder of the existing description unchanged.

- [ ] **Step 3: Run positive and negative assertions**

Run:

```bash
rg -n '\* \*\*\[RSIHub\]\(https://github\.com/simple-agent-lab/RSIHub\)\*\*' _pages/about.md
! rg -n '\[RSIHub\]\(https://simpleagentlab\.com/(RSIHub|rsihub)/?\)' _pages/about.md
```

Expected: PASS; the GitHub URL matches once and no old homepage RSIHub destination remains.

- [ ] **Step 4: Commit the focused link change**

```bash
git add _pages/about.md
git commit -m "Update RSIHub homepage link"
```

---

### Task 2: Add Explicit Publication Ordering and EffiSkill Authors

**Files:**
- Modify: `_pages/publications.html`
- Modify: `_includes/archive-single.html`
- Modify: `_publications/2026-03-29-effiskill.md`
- Modify: `_publications/2026-07-01-long-horizon-agents-survey.md`
- Test: generated `_site/publications/index.html`

**Interfaces:**
- Consumes: `post.display_order` as an integer and optional `post.authors` as an HTML string from publication front matter.
- Produces: an ascending `ordered_publications` collection and an author paragraph rendered only when `post.authors` exists.

- [ ] **Step 1: Run failing source assertions for the new metadata contract**

Run:

```bash
rg -n '^display_order: 1$' _publications/2026-03-29-effiskill.md
rg -n '^authors: "<u>Zimu Wang</u>, Yuling Shi, Mengfan Li, Zijun Liu, Jie M\. Zhang, Chengcheng Wan, Xiaodong Gu"$' _publications/2026-03-29-effiskill.md
rg -n '^display_order: 2$' _publications/2026-07-01-long-horizon-agents-survey.md
rg -n "assign ordered_publications = site\.publications \| sort: 'display_order'" _pages/publications.html
```

Expected: each command FAILS because the metadata and sorting variable do not exist yet.

- [ ] **Step 2: Add publication front-matter metadata**

Add to EffiSkill front matter:

```yaml
display_order: 1
authors: "<u>Zimu Wang</u>, Yuling Shi, Mengfan Li, Zijun Liu, Jie M. Zhang, Chengcheng Wan, Xiaodong Gu"
```

Add to the survey front matter:

```yaml
display_order: 2
```

Do not add an `authors` field to the survey.

- [ ] **Step 3: Sort the Publications page by display order**

Immediately after `{% include base_path %}`, assign:

```liquid
{% assign ordered_publications = site.publications | sort: 'display_order' %}
```

Replace both Publications-page loops over `site.publications reversed` with loops over `ordered_publications`. Preserve category filtering and all surrounding markup.

- [ ] **Step 4: Render optional author metadata**

In `_includes/archive-single.html`, immediately before the existing collection-specific venue block, add:

```liquid
{% if post.collection == 'publications' and post.authors %}
  <p class="archive__item-authors">{{ post.authors }}</p>
{% endif %}
```

Do not add CSS for `archive__item-authors`.

- [ ] **Step 5: Parse front matter and run source assertions**

Run:

```bash
ruby -ryaml -rdate -e 'ARGV.each { |f| s=File.read(f); YAML.safe_load(s.split(/^---\s*$\n?/)[1], permitted_classes: [Date, Time], aliases: true) }; puts "front matter parsed"' _publications/*.md
rg -n '^display_order: 1$' _publications/2026-03-29-effiskill.md
rg -n '^authors: "<u>Zimu Wang</u>, Yuling Shi, Mengfan Li, Zijun Liu, Jie M\. Zhang, Chengcheng Wan, Xiaodong Gu"$' _publications/2026-03-29-effiskill.md
rg -n '^display_order: 2$' _publications/2026-07-01-long-horizon-agents-survey.md
! rg -n '^authors:' _publications/2026-07-01-long-horizon-agents-survey.md
rg -n "assign ordered_publications = site\.publications \| sort: 'display_order'" _pages/publications.html
```

Expected: PASS with `front matter parsed` and matching metadata/template lines.

- [ ] **Step 6: Build the site with the compatible repository runtime**

Run:

```bash
PATH=/opt/homebrew/opt/ruby@3.1/bin:/opt/homebrew/lib/ruby/gems/3.1.0/bin:$PATH bundle exec jekyll build --trace
```

Expected: exit 0 and `done`.

- [ ] **Step 7: Assert generated order, author markup, and survey omission**

Run:

```bash
ruby -e 'html=File.read("_site/publications/index.html"); effi=html.index("EffiSkill: Agent Skill Based Automated Code Efficiency Optimization"); survey=html.index("Building Reliable Long-Horizon Agents: A Survey"); abort "missing publication title" unless effi && survey; abort "EffiSkill is not first" unless effi < survey; puts "publication order verified"'
rg -n '<u>Zimu Wang</u>, Yuling Shi, Mengfan Li, Zijun Liu, Jie M\. Zhang, Chengcheng Wan, Xiaodong Gu' _site/publications/index.html
test "$(rg -o 'class="archive__item-authors"' _site/publications/index.html | wc -l | tr -d ' ')" = "1"
```

Expected: PASS with `publication order verified`, the complete author line, and exactly one author paragraph.

- [ ] **Step 8: Commit the publication presentation change**

```bash
git add _pages/publications.html _includes/archive-single.html _publications/2026-03-29-effiskill.md _publications/2026-07-01-long-horizon-agents-survey.md
git commit -m "Refine publication order and authors"
```

---

### Task 3: Final Regression and Responsive Verification

**Files:**
- Verify: `_site/index.html`
- Verify: `_site/publications/index.html`
- Verify: protected CV/resume files against `b75dc86`

**Interfaces:**
- Consumes: the complete generated site from Tasks 1 and 2.
- Produces: fresh evidence that the refinement is buildable, scoped, responsive, and ready to push to the existing PR branch.

- [ ] **Step 1: Run the full build and content checks together**

Run:

```bash
set -eu
PATH=/opt/homebrew/opt/ruby@3.1/bin:/opt/homebrew/lib/ruby/gems/3.1.0/bin:$PATH bundle exec jekyll build --trace
rg -n 'href="https://github.com/simple-agent-lab/RSIHub"' _site/index.html
ruby -e 'html=File.read("_site/publications/index.html"); abort unless html.index("EffiSkill") < html.index("Building Reliable Long-Horizon Agents")'
rg -n '<u>Zimu Wang</u>, Yuling Shi, Mengfan Li, Zijun Liu, Jie M\. Zhang, Chengcheng Wan, Xiaodong Gu' _site/publications/index.html
test "$(rg -o 'class="archive__item-authors"' _site/publications/index.html | wc -l | tr -d ' ')" = "1"
git diff --quiet b75dc86 -- _pages/cv.md _data/cv.json Zimu_Resume.pdf files/Zimu_Wang_Resume.pdf
git diff --check
```

Expected: exit 0 with the new GitHub link, correct publication order, complete underlined author line, one author paragraph, unchanged protected files, and no whitespace errors.

- [ ] **Step 2: Inspect desktop and mobile Publications rendering**

Serve `_site`, inspect `/publications/` at approximately `1440×900` and `390×844`, and verify:

- EffiSkill appears first.
- The complete author line appears directly below its title.
- `Zimu Wang` is underlined.
- The author line wraps within the viewport with no horizontal overflow.
- The survey has no author line.
- Existing typography and spacing remain intact.

- [ ] **Step 3: Confirm branch scope and push the existing PR branch**

Run:

```bash
git status -sb
git log --oneline origin/codex/personal-website-content-polish..HEAD
git push origin codex/personal-website-content-polish
```

Expected: a clean worktree before the push, only the approved refinement commits ahead of origin, and a successful push updating draft PR #1.

# Remove Empty Footer Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the empty gray footer bar from all standard and CV pages while preserving the scripts currently loaded through the custom footer include.

**Architecture:** Delete the visual `.page__footer` wrapper from both top-level layouts. Keep the custom footer include directly in the document body before the main scripts include so MathJax and Mermaid continue loading without an empty visual container.

**Tech Stack:** Jekyll, Liquid templates, HTML, Bundler

## Global Constraints

- Apply the change to standard pages and the CV layout.
- Preserve `_includes/footer/custom.html` and its MathJax and Mermaid behavior.
- Preserve `{% include scripts.html %}`.
- Do not modify theme colors or footer Sass.
- Do not add replacement footer content.
- Do not modify or commit the unrelated `.DS_Store` working-tree change.

---

### Task 1: Remove the empty visual footer from both layouts

**Files:**
- Modify: `_layouts/default.html:21-26`
- Modify: `_layouts/cv-layout.html:29-34`

**Interfaces:**
- Consumes: `_includes/footer/custom.html` for MathJax and Mermaid scripts and `_includes/scripts.html` for the site's JavaScript bundle.
- Produces: standard and CV page bodies with no `.page__footer` markup while retaining both script includes in their existing order.

- [ ] **Step 1: Run the pre-change assertions**

Run:

```bash
test "$(rg -l 'class="page__footer"' _layouts/default.html _layouts/cv-layout.html | wc -l | tr -d ' ')" -eq 2
test "$(rg -l '\{% include footer/custom.html %\}' _layouts/default.html _layouts/cv-layout.html | wc -l | tr -d ' ')" -eq 2
test "$(rg -l '\{% include scripts.html %\}' _layouts/default.html _layouts/cv-layout.html | wc -l | tr -d ' ')" -eq 2
```

Expected: all commands pass, proving both layouts currently contain the visual
footer and the script includes that must be preserved.

- [ ] **Step 2: Remove the footer wrappers**

In `_layouts/default.html`, replace:

```liquid
    <div class="page__footer">
      <footer>
        {% include footer/custom.html %}
        {% include footer.html %}
      </footer>
    </div>

    {% include scripts.html %}
```

with:

```liquid
    {% include footer/custom.html %}
    {% include scripts.html %}
```

Apply the identical replacement in `_layouts/cv-layout.html`.

- [ ] **Step 3: Run source assertions**

Run:

```bash
! rg -q 'page__footer|\{% include footer.html %\}' _layouts/default.html _layouts/cv-layout.html
test "$(rg -l '\{% include footer/custom.html %\}' _layouts/default.html _layouts/cv-layout.html | wc -l | tr -d ' ')" -eq 2
test "$(rg -l '\{% include scripts.html %\}' _layouts/default.html _layouts/cv-layout.html | wc -l | tr -d ' ')" -eq 2
```

Expected: no visual footer references remain, and both layouts still contain
the custom and main script includes.

- [ ] **Step 4: Build the site**

Run:

```bash
BUNDLE_FORCE_RUBY_PLATFORM=true bundle exec jekyll build
```

Expected: exit code 0 and generated pages under `_site/`.

- [ ] **Step 5: Verify representative rendered pages**

Run:

```bash
for page in _site/index.html _site/publications/index.html _site/projects/index.html _site/cv/index.html; do
  ! rg -q 'page__footer' "$page"
  rg -q 'MathJax-script' "$page"
  rg -q 'mermaid.initialize' "$page"
  rg -q 'assets/js/main.min.js' "$page"
  rg -q 'id="site-nav"' "$page"
done
```

Expected: all assertions pass for the homepage, Publications, Projects, and CV.

- [ ] **Step 6: Verify protected scope**

Run:

```bash
git diff --exit-code -- _sass/layout/_footer.scss _includes/footer/custom.html files/Zimu_Wang_Resume.pdf
git status --short
```

Expected: only the two layouts and this implementation plan are changed in the
isolated worktree. In the main checkout, `.DS_Store` remains the only unrelated
modified file.

- [ ] **Step 7: Commit the implementation**

```bash
git add _layouts/default.html _layouts/cv-layout.html docs/superpowers/plans/2026-07-30-remove-empty-footer.md
git commit -m "style: remove empty footer bar"
```

### Task 2: Merge, reverify, and publish

**Files:**
- Verify: the complete merged Jekyll source tree

**Interfaces:**
- Consumes: the verified `codex/remove-empty-footer` feature branch.
- Produces: a built, verified, and pushed `main` branch.

- [ ] **Step 1: Review the branch**

Run:

```bash
git diff main...HEAD --check
git diff --stat main...HEAD
git log --oneline main..HEAD
test -z "$(git status --short)"
```

Expected: no whitespace errors, only approved files are committed, and the
feature worktree is clean.

- [ ] **Step 2: Merge into current main**

Run from the main checkout:

```bash
git pull --ff-only
git merge --no-ff codex/remove-empty-footer -m "Merge empty footer removal"
```

Expected: main is current and the merge succeeds without conflicts.

- [ ] **Step 3: Rebuild the merged tree**

Run:

```bash
GEM_HOME=/private/tmp/codex-jekyll-gems/ruby/2.6.0 GEM_PATH=/private/tmp/codex-jekyll-gems/ruby/2.6.0 /private/tmp/codex-jekyll-gems/ruby/2.6.0/bin/jekyll build
```

Expected: exit code 0.

- [ ] **Step 4: Reverify rendered output and local user change**

Run:

```bash
for page in _site/index.html _site/publications/index.html _site/projects/index.html _site/cv/index.html; do
  ! rg -q 'page__footer' "$page"
  rg -q 'MathJax-script' "$page"
  rg -q 'mermaid.initialize' "$page"
  rg -q 'assets/js/main.min.js' "$page"
done
test "$(git status --short | wc -l | tr -d ' ')" -eq 1
git status --short | rg -q '^ M \.DS_Store$'
```

Expected: the merged pages have no footer bar, scripts remain, and `.DS_Store`
is the sole uncommitted change.

- [ ] **Step 5: Push main**

Run:

```bash
git push origin main
```

Expected: `origin/main` advances to the verified merge commit.

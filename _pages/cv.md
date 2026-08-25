---
layout: archive
title: "CV"
permalink: /cv/
author_profile: true
redirect_from:
  - /resume
---

{% include base_path %}

Download
======

[Download full resume (PDF)](/files/Zimu_Wang_Resume.pdf)

Education
======

* **University of California, Berkeley** - B.A. in Computer Science
* **GPA:** 3.92 / 4.0

Professional Experience
======

* **LLM Engineering Intern, Douyin AI, ByteDance** - Summer 2026
  * Primary author of [RSIHub](https://github.com/simple-agent-lab/RSIHub), a recursive self-improvement framework that evolves agent prompts, skills, harnesses, and code.
  * Designed a modular evolution engine that isolates mutable agent components from fixed evaluators and tracks every generation in Git for reproducibility.
  * Built a plugin-style operator SDK with automatic discovery, subprocess isolation, and declarative configuration schemas.
  * Benchmarked four self-improvement strategies across MiniSWE and Codex agent harnesses: Terminal-Bench 2 with MiniSWE improved from 56.2% to 69.7% (+13.5 points), and Tau3-Bench Banking with Codex improved from 24.7% to 34.0% (+9.3 points).
  * Built a lazy-loading skill system and modular agent starter for [Simple Long Horizon Agent](https://github.com/simple-agent-lab/simple-long-horizon-agent), consolidating four agent variants behind a shared session and tool lifecycle with config-driven MCP support.

Research Experience
======

* **Undergraduate Researcher, University of California, Berkeley** - Spring 2026; Fall 2026–Present
  * Advised by [Professor Avideh Zakhor](https://www2.eecs.berkeley.edu/Faculty/Homepages/zakhor.html).
  * Studied whole-body motion-control methods and trained control policies in MuJoCo and Isaac Lab for the Unitree G1 humanoid robot.
  * Investigated simulation-to-real deployment and hardware-integration challenges on the Unitree G1 platform.

* **Researcher, Shanghai Jiao Tong University** - Summer 2025–Spring 2026
  * Mentored by [Yuling Shi](https://yerbasite.github.io/) under the supervision of [Professor Xiaodong Gu](https://guxd.github.io/).
  * Developed EffiSkill, a two-stage LLM framework that mines reusable optimization skills from slow/optimized program pairs and applies them to unseen programs for execution-free rewriting.
  * Built inference and evaluation pipelines on EffiBench-X (623 tasks, Python and C++), improving optimization success rate over the strongest baseline by 3.69–12.52 percentage points.
  * Built an end-to-end SFT + GRPO post-training pipeline for Qwen3-8B code judges on 48K examples with verl/vLLM on 8×A100 GPUs, lifting agreement with ground truth from 54% to 69% and surpassing Qwen3-32B (66%) with one-quarter the parameters.

* **Research Assistant, University of California, Berkeley** - Fall 2025
  * Advised by [Professor Park Sinchaisri](https://haas.berkeley.edu/faculty/park-sinchaisri/).
  * Built end-to-end processing pipelines for a 1.2M-row gig-economy dataset and produced validated, analysis-ready datasets for collaborators.
  * Ran 30+ linear regressions and generated 40+ plots with robustness checks using statsmodels and scikit-learn.

Teaching
======

* **Data 8 Tutor, University of California, Berkeley** - Fall 2024
  * Led weekly tutoring sessions, a discussion section, and office hours for Data 8, covering Python, statistical inference, and data analysis.

Skills
======

* **Languages:** Python, C++, Java, SQL, Bash
* **ML / Agents:** PyTorch, Hugging Face Transformers, verl, vLLM, SFT, GRPO, RLHF, MCP, agent evaluation
* **Infrastructure / Tools:** Docker, Weights & Biases, Git, Linux, NumPy, Pandas

Selected Publications
======

<ul>{% assign ordered_publications = site.publications | sort: 'display_order' %}
{% for post in ordered_publications %}
  {% unless post.show_on_cv == false %}
    {% include archive-single-cv.html %}
  {% endunless %}
{% endfor %}</ul>

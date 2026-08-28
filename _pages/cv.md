---
layout: archive
title: "CV"
permalink: /cv/
author_profile: true
redirect_from:
  - /resume
---

{% include base_path %}

## Download

[Download full resume (PDF)](/files/Zimu_Wang_Resume.pdf)

## Education

* **University of California, Berkeley** - B.A. in Computer Science
* **GPA:** 3.92 / 4.0
* **Expected graduation:** May 2027
* **Coursework:** Neural Networks, Deep Reinforcement Learning, Computer Vision, Optimization, Probability Theory, Databases, Data Structures & Algorithms

## Professional Experience

* **LLM Engineer Intern, ByteDance** - Summer 2026
  * Drove [RSIHub](https://github.com/simple-agent-lab/RSIHub)'s development as lead developer, delivering an open-source recursive self-improvement framework that evolves agent prompts, skills, harnesses, and code.
  * Architected a modular evolution engine that isolates mutable agent components from fixed evaluators and records every candidate generation in Git, preserving score integrity and commit-level reproducibility.
  * Shipped a plugin operator SDK with automatic discovery, subprocess isolation, and declarative schemas, enabling new operators and strategies without core changes.
  * Demonstrated best full-benchmark gains of +13.5 points on Terminal-Bench 2 with MiniSWE (56.2% → 69.7%) and +9.3 points on Tau3 Banking with Codex (24.7% → 34.0%) across four self-improvement strategies and all 186 tasks in the two benchmark suites.
  * For [Simple Long Horizon Agent](https://github.com/simple-agent-lab/simple-long-horizon-agent), shipped an on-demand skill runtime with package discovery, compact prompt menus, explicit skill selection, and a bundled reusable skill library.
  * Unified four agent presets behind a composable `AgentSession`/toolset API, standardizing session and tool lifecycles while adding config-driven MCP support to evaluation runners.

## Research Experience

* **Undergraduate Researcher, University of California, Berkeley** - Spring 2026; Fall 2026–Present
  * Advised by [Professor Avideh Zakhor](https://www2.eecs.berkeley.edu/Faculty/Homepages/zakhor.html).
  * Studied whole-body motion-control methods and trained control policies in MuJoCo and Isaac Lab for the Unitree G1 humanoid robot.
  * Investigated simulation-to-real deployment and hardware-integration challenges on the Unitree G1 platform.

* **Researcher, Shanghai Jiao Tong University** - Summer 2025–Spring 2026
  * Mentored by [Yuling Shi](https://yerbasite.github.io/) under the supervision of [Professor Xiaodong Gu](https://guxd.github.io/).
  * **EffiSkill:** designed a two-stage LLM framework that mines reusable Operator and Meta Skills from slow/optimized program pairs, retrieves relevant skills, and composes optimization plans for new programs without execution feedback.
  * Built the inference and evaluation stack and benchmarked all 623 EffiBench-X tasks in both Python and C++, with optimization success rates 3.69–12.52 percentage points above the strongest baseline.
  * **CodeJudge:** built and scaled a pipeline to train Qwen3-8B to assess code correctness with 48K examples on 8×A100 GPUs, using SFT and reinforcement learning, custom rewards, and distributed verl/vLLM rollouts.
  * Raised held-out ground-truth agreement from 54% to 69%, outperforming Qwen3-32B (66%) while using 25% as many parameters.

* **Research Assistant, University of California, Berkeley** - Fall 2025
  * Advised by [Professor Park Sinchaisri](https://haas.berkeley.edu/faculty/park-sinchaisri/).
  * Built end-to-end processing pipelines for a 1.2M-row gig-economy dataset and produced validated, analysis-ready datasets for collaborators.
  * Ran 30+ linear regressions and generated 40+ plots with robustness checks using statsmodels and scikit-learn.

## Teaching

* **Data 8 Tutor, University of California, Berkeley** - Fall 2024
  * Led weekly tutoring sessions, a discussion section, and office hours, teaching Python-based data analysis and visualization alongside hypothesis testing, regression, and classification.

## Skills

* **Languages:** Python, C++, Java, SQL, Bash
* **ML / Agents:** PyTorch, Hugging Face Transformers, verl, vLLM, SFT, GRPO, RLHF, MCP, agent evaluation
* **Infrastructure / Tools:** Docker, Weights & Biases, Git, Linux, NumPy, Pandas

## Selected Publications

<ul>{% assign ordered_publications = site.publications | sort: 'display_order' %}
{% for post in ordered_publications %}
  {% unless post.show_on_cv == false %}
    {% include archive-single-cv.html %}
  {% endunless %}
{% endfor %}</ul>

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
* **GPA:** 3.94 / 4.0

Professional Experience
======

* **Large Language Model Engineering Intern, Douyin AI, ByteDance** - May 2026–Present
  * Leading the development of Simple Evolve Agent, infrastructure for reproducible agent self-evolution with sandboxed evaluation, provenance tracking, and reliability guardrails.
  * Contributing to Simple Agent Lab, a compact framework for understandable, verifiable long-horizon agent workflows and reproducible evaluation.
  * Supporting research and evaluation on reliable long-horizon agents, including system design, benchmarks, and failure recovery.

Research Experience
======

* **Researcher, Shanghai Jiao Tong University** - Spring 2026
  * Developed EffiSkill, a two-stage LLM framework for automated code-efficiency optimization based on reusable optimization skills mined from slow and optimized program pairs.
  * Built scalable inference and evaluation pipelines on EffiBench-X across Python and C++, supporting top-k generation, public/private ranking, and offline runtime evaluation.
  * Improved optimization success rate over the strongest baseline by 3.69 to 12.52 points across model and language settings.

* **Research Assistant, University of California, Berkeley** - Fall 2025
  * Built end-to-end processing pipelines for a 1.2M-row gig-economy dataset and produced validated, analysis-ready datasets for collaborators.
  * Ran 30+ linear regressions and generated 40+ plots with robustness checks using statsmodels and scikit-learn.

* **Researcher, Shanghai Jiao Tong University** - Summer 2025
  * Implemented an SFT + GRPO training pipeline for code LLMs using KodCode, including prompt standardization, reward parsing, and automated evaluation.
  * Trained for 100k+ steps on 8 x A100 GPUs and established a reproducible RL fine-tuning workflow and evaluation stack.

Teaching
======

* **Teaching Assistant, University of California, Berkeley** - Fall 2024
  * Mentored students in foundational data science and Python programming through discussion sections, office hours, and project support.

Skills
======

* **Languages:** Python, Java, SQL
* **ML / LLM:** PyTorch, HuggingFace, VeRL, vLLM, RLHF
* **Data / Tools:** NumPy, Pandas, scikit-learn, Matplotlib, Git, Linux, LaTeX
* **Technical Foundations:** Machine Learning, Reinforcement Learning, Neural Networks, Computer Vision, Data Structures, Algorithms, Probability, Optimization, Linear Algebra

Selected Publications
======

<ul>{% for post in site.publications reversed %}
  {% include archive-single-cv.html %}
{% endfor %}</ul>

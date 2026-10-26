---
type: resource
cover: https://commons.wikimedia.org/wiki/Special:FilePath/ISO_7010_W001.svg
status: active
area: statistics
kind: paper
url: https://doi.org/10.1093/biomet/63.3.581
created: 2026-10-26
updated: 2026-10-26
author: Eskolx Labs
tags: []
publish-status: draft
---

![Rubin (1976) — Inference and Missing Data cover](https://commons.wikimedia.org/wiki/Special:FilePath/ISO_7010_W001.svg)

# Rubin (1976) — Inference and Missing Data

## What it is

Donald B. Rubin, "Inference and Missing Data," *Biometrika*, 63(3), 1976, pp. 581–592. [doi:10.1093/biomet/63.3.581](https://doi.org/10.1093/biomet/63.3.581).

The paper made missingness a mechanism, not a nuisance. It defines three cases:

- **MCAR**: missing completely at random. The missingness does not depend on the data, observed or unobserved.
- **MAR**: missing at random. The missingness may depend on the observed values, but not on the unobserved values, given the observed values.
- **MNAR**: missing not at random. The missingness depends on the unobserved value itself.

The paper then shows when a complete-case analysis is valid and when it is biased. It also shows what a likelihood or Bayesian analysis can recover under MAR.

## Why we recommend it

Week 1 uses one missing-value policy: drop and report. That policy is a claim, not a convenience. It is valid under MCAR. Under MAR it can bias a summary. Under MNAR it usually does. Rubin gives the terms to state which claim the code makes. He also gives counterexamples that show why "just drop the missing values" is not neutral.

The paper is also a model for how this lab handles assumptions. Name them, state when they fail, and make the failure visible in the output. `missing_report` exists because of this paper.

## How to use it

- Read sections 1 to 3 for the definitions and the counterexamples. You need the mechanisms, not the full likelihood derivation.
- Map each mechanism to one small dataset of your own. Write down the complete-case mean under each mechanism. State whether each result is defensible.
- Put the mechanism that your function assumes in the docstring. If the function cannot know the mechanism, say that too. It is honest to write "Unknown. The caller must state the mechanism."
- Do not add imputation to week 1. Imputation is a model, and this phase has no model for it yet. Read ahead if you want, but do not ship it.

## Related Concepts

- [[Population vs Sample]]
- [[Sampling Bias]]
- [[Tukey (1962) — The Future of Data Analysis]]
- [[Box (1976) — Science and Statistics]]
- [[Ross — Introduction to Probability and Statistics]]

## Notes

A useful test for the docstring is this. Can a reader tell, from the docstring alone, whether the missing count is reported, whether the drop is silent, and which mechanism would make the result wrong? If not, the docstring is not finished.

The three mechanisms describe the data-generating process. They do not describe the size of the missing share. A dataset with 1% missing can be MNAR, and a dataset with 40% missing can be MCAR. The percentage is not the argument.

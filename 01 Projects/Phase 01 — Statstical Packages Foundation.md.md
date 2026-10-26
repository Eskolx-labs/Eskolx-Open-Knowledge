---
type: project
cover: https://commons.wikimedia.org/wiki/Special:FilePath/OOjs_UI_icon_book-ltr.svg
status: planned
priority: high
area: statistics
owner: Natnael-Getahun
created: 2026-09-06
updated: 2026-10-26
author: Natnael
tags:
  - statistics
  - distributions
  - inference
  - onboarding
  - projects
publish-status: draft
---

![Phase 01 — Statstical Packages Foundation cover](https://commons.wikimedia.org/wiki/Special:FilePath/OOjs_UI_icon_book-ltr.svg)

# Tl;Dr

This is the first of the four major phases we have in plan. This pahse is planned to last 3 months. We will build the statstical foundational package needed for machine learning and our future phases.

The way it works:
- we read a selected cannonical book
- we convert the book to code
- we supplment everything with research papers
- we write notes and draw tldraw diagrams to explain everything (this is also how we know you've actually understood things even if you use AI)

# The Book

Use the first half (upto and inclduing chapter 8) of *Introduction to Probability and Statistics for Engineers and Scientists*, sixth edition, by Sheldon M. Ross. This is a clear, applied, upper-undergraduate book. It begins with data collection and descriptive statistics, moves through random variables and named distributions, then builds sampling distributions, estimation, and hypothesis tests. The later chapters carry on to regression, ANOVA, categorical analysis, resampling, and machine learning.

We will be using Python as our language of implmentaion.

# How the team works

Every person works on the same phase at the same time:

1. Everyone works on descriptive statistics for weeks 1 through 3.
2. Everyone works on probability distributions for weeks 4 through 9.
3. Everyone works on inference and hypothesis testing for weeks 10 through 12.
4. Everyone should be thinking about and working on a novel, impressive individual research that uses the packages we develop. The paper with related code and materials should be submitted sometime after week 12.

There are no permanent descriptive, probability, or inference teams.

# Exampe Weekly Rhythm

| Day                    | Work                                                                                                                            |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Tuesday                | A 45-minute planning call. Assign pages, exercises, lanes, reviewers, and pull request titles.                                  |
| Wednesday and Thursday | Read, solve, write notes, and start implementation.                                                                             |
| Friday                 | Every contributor opens a real pull request. It can be a draft, but it must contain real work.                                  |
| Saturday               | Review, test, and cut work that cannot meet the quality gate. Tldraw canvas explanation. Pull request and peer review deadline. |
| Sunday                 | One-to-one meetings, in person or remote.                                                                                       |
| Monday                 | The core team decides on progress and the next steps.                                                                           |

# Definition of done

Each feature PR must include:

1. Inputs, outputs, parameterization, support, assumptions, errors report, and examples.
2. A public-vault note linked to the textbook section, a tldraw diagram implemented using tldraw's obsidian plugin, and a deeper source material if one was used.
3. Hand-worked results, usual cases demonstration, boundary cases, and tests.
4. A controlled comparison against a trusted library.
5. Review by somebody other than the author.
6. Proof you have conducted as many peer-reviews of other people's works (we can't stress enough how importatn this is).
7. One documentation example that runs in a clean environment.

# Release scope

### Descriptive statistics, weeks 1 to 3

- numeric-data validation and one clear missing-value policy
- count, min, max, range, mean, median, mode, quantiles, IQR, sample variance, sample standard deviation, coefficient of variation, skewness, and kurtosis
- frequency tables and histogram bin counts
- covariance and Pearson correlation
- stable mean and variance where it changes the result for real data
- any additional material from the book

### Probability distributions, weeks 4 to 9

This package models and evaluates distributions. It does **not** become a general library for solving arbitrary probability puzzles, set operations, counting rules, or Bayes calculations.

- one documented distribution interface: `pmf` or `pdf`, `cdf`, `sf`, `ppf`, `mean`, `var`, and reproducible `rvs` where appropriate
- Bernoulli, Binomial, Geometric, Negative Binomial, Hypergeometric, Poisson, Uniform, Normal, Exponential, Gamma, Chi-square, Student t, and F
- explicit support, parameterization, invalid-parameter errors, and tail-accuracy policy for every supported distribution
- sampling-distribution helpers required by the inference package
- any additional material from the book

### Inference and hypothesis testing, weeks 10 to 12

- one-sample and two-sample confidence intervals for means
- one-sample t test, Welch two-sample t test, paired t test, and one- and two-proportion tests
- chi-square goodness-of-fit and independence tests only if the team finishes the required work by the end of week 11
- a result object with statistic, p-value, degrees of freedom where relevant, confidence interval where relevant, alternative, method, and assumptions
- condition checks and plain-language warnings. A function must not return a p-value when its own input rules fail.
- any additional material from the book

# The first 12 weeks

This schedule is flexible and can be changed as we go deeper.

| Week | Shared reading                                                              | Shared phase and build target                                                                                                                                    | Saturday PR evidence                                                                                                                                                    | Sunday presentation                                                              |
| ---: | --- | --- | --- | --- |
|     1 | Ch. 1, introduction to statistics, data collection, samples and populations | Descriptive. Package skeleton, numeric input contract, missingness policy, data audit, count, min, max, range.                                                   | Empty input, invalid values, a hand-checked small dataset with a visible missing count, and the audit report. Book examples and exercises solved with our package.      | Explain the data contract and one refusal.                                       |
|     2 | Ch. 2.1 to 2.3, describing datasets: center, spread, and quantiles          | Descriptive. Mean, median, mode, quantiles, IQR, sample variance, sample standard deviation, coefficient of variation.                                           | Textbook examples reproduced by hand and in code, the quantile rule named, and a constant-value case. Book examples and exercises solved with our package.              | Show how mean and median disagree on a skewed dataset.                           |
|     3 | Ch. 2.4 to 2.6, tables, shape, paired data, and correlation                 | Descriptive. Frequency tables, histogram counts, skewness, kurtosis, covariance, Pearson correlation, stable online moments. Descriptive v0.1 release candidate. | Constant values, tied values, a histogram bin case, a numerical-stability comparison, and a documentation example. Book examples and exercises solved with our package. | Demonstrate one summary that can mislead.                                        |
|     4 | Ch. 3, elements of probability                                              | Distributions. Read probability as background only. Define the distribution interface and implement Bernoulli and Binomial.                                      | PMF sums to one, support and parameter errors, known moments. Book examples and exercises solved with our package.                                                      | Explain the interface and what the package will not do.                          |
|     5 | Ch. 4, random variables and expectation                                     | Distributions. Implement Geometric, Negative Binomial, Hypergeometric, Poisson, plus moments and random sampling.                                                | Known values, seeded draws, CDF limits. Book examples and exercises solved with our package.                                                                            | Present one distribution and its parameterization.                               |
|     6 | Ch. 5.1 to 5.4, special random variables                                    | Distributions. Implement Uniform and Normal. Add shared `cdf`, `sf`, and `ppf` test cases.                                                                       | CDF and quantile round trips, tail values, comparison tolerance.                                                                                                        | Explain why tail probabilities are harder than ordinary values.                  |
|     7 | Ch. 5.5 to 5.9, Normal, Exponential, Gamma, related distributions           | Distributions. Implement Exponential, Gamma, Chi-square, Student t, and F.                                                                                       | Boundary values, moments, extreme inputs, reference checks. Book examples and exercises solved with our package.                                                        | Explain one numerical method or approximation.                                   |
|     8 | Ch. 6.1 to 6.3, sampling statistics and the central limit theorem           | Distributions. Add sampling-distribution examples and the helpers inference will need.                                                                           | A reproducible CLT simulation and a written interpretation.                                                                                                             | Show the bridge between distribution code and inference.                         |
|     9 | Ch. 6.4 to 6.6, sample variance and normal-population sampling              | Distributions. Finish parameter validation, API consistency, examples, and release notes. Probability-distributions v0.1 release candidate.                      | Clean install and full distribution regression suite. Book examples and exercises solved with our package.                                                              | Live review against a reference library.                                         |
|    10 | Ch. 7, parameter estimation and interval estimates                          | Inference. Implement result object, one-sample mean interval and test, and two-mean intervals.                                                                   | Hand-calculated textbook case and invalid-condition tests. Book examples and exercises solved with our package.                                                         | Explain confidence intervals without the usual false claim.                      |
|    11 | Ch. 8.1 to 8.4, significance levels and mean tests                          | Inference. Implement Welch two-sample t test, paired t test, and one- and two-proportion tests.                                                                  | Known p-values for each alternative, paired-data cases. Book examples and exercises solved with our package.                                                            | Explain Type I error, Type II error, and power with one dataset.                 |
|    12 | Ch. 8.5 to 8.7, variance, Bernoulli, and Poisson tests                      | Inference. Finish tests, documentation, mini-study, changelog, release tag, and retrospective. Start chi-square only if all required tests passed by Saturday.     | Clean install, reproducible mini-study, all examples and links checked. Book examples and exercises solved with our package.                                            | Final release. Each person explains one contribution and one current limitation. |

## Papers by week

Full citations are in `03 Resources/`. Add the resource note in the week you read the paper. Do not add papers that nobody has opened.

| Week | Code-bearing paper | Direction paper | Why these two |
| ---: | --- | --- | --- |
| 1 | Rubin (1976), *Inference and Missing Data* | Tukey (1962), *The Future of Data Analysis* | The mechanism behind the missingness policy. The argument for data analysis as its own science. Box (1976) is read-only. |
| 2 | Hyndman & Fan (1996), *Sample Quantiles in Statistical Packages*; Welford (1962) | Anscombe (1973), *Graphs in Statistical Analysis* | Nine quantile definitions. The code must name the definition it uses. The case for looking before summarizing. |
| 3 | Freedman & Diaconis (1981), *On the Histogram as a Density Estimator*; Chan, Golub & LeVeque (1983) | Tukey (1962), revisit | Bin width is a modelling choice. The updating formula is a numerical one. |
| 4 | Kolmogorov (1933), *Grundbegriffe der Wahrscheinlichkeitsrechnung* (excerpt); Bernoulli (1713), *Ars Conjectandi* (excerpt) | — | The axioms behind the interface. The first binomial. |
| 5 | Poisson (1837), *Recherches sur la probabilité des jugements*; Greenwood & Yule (1920) | — | The count model and the over-dispersion that breaks it. |
| 6 | Cody (1969), *Rational Chebyshev Approximations for the Error Function*; Wichura (1988), *Algorithm AS 241* | Abramowitz & Stegun (1964), *Handbook of Mathematical Functions* | The normal cdf and ppf are algorithms, not formulas. |
| 7 | Student (1908), *The Probable Error of a Mean*; Fisher (1925), *Statistical Methods for Research Workers* (excerpt) | Box (1953), *Non-Normality and Tests on Variances* | Where t and F come from, and when they stop being robust. |
| 8 | Pearson (1900), *On the Criterion...*; Lindeberg (1922) | Neyman (1934), *On the Two Different Aspects of the Representative Method* | The chi-square statistic and the central limit theorem. What "representative" means. |
| 9 | Chan, Golub & LeVeque (1983), revisit; Kahan (1965) | Higham (2002), *Accuracy and Stability of Numerical Algorithms* (ch. 1) | The algorithm changes the number. The error analysis says by how much. |
| 10 | Neyman (1937), *Outline of a Theory of Statistical Estimation*; Student (1908), revisit | Fisher (1925), revisit | Confidence intervals as a procedure, not a probability about a parameter. |
| 11 | Welch (1947); Neyman & Pearson (1933) | Wasserstein & Lazar (2016), *The ASA Statement on p-Values* | The unequal-variance test and the error-rate framework. What a p-value is not. |
| 12 | Pearson (1900), revisit; Fisher (1922), *On the Interpretation of Chi-Square* | Ioannidis (2005), *Why Most Published Research Findings Are False*; Box (1976), revisit | The last tests. The case for committing to the research question before you see the data. |

## The research thread

Every person keeps `04 Research/Question — <Name>.md` from week 1. Write one question and one paragraph. Revise the note each Sunday. Do not write a solution before week 6. The week-12 deliverable is a two-page proposal. It states the question, the population, the data source, the method from the package, the failure modes, and what would change your mind. The paper is written after the phase.

| Week | Prompt |
| ---: | --- |
| 1 | What decision would this dataset change, and who bears the cost if it is wrong? |
| 2 | Which single summary would lie about your data, and to whom? |
| 3 | Which relationship survives a plot but dies in a correlation, or the reverse? |
| 4 | Which uncertainty is structural and which is sampling? |
| 5 | Which count model fits your process, and what does it assume about memory? |
| 6 | Where does the normal approximation stop being good enough? |
| 7 | Which tail are you actually relying on? |
| 8 | How large does n have to be before the central limit theorem saves you, and how would you know? |
| 9 | Which number changes when you change the algorithm? |
| 10 | What interval would you defend in public? |
| 11 | What would you refuse to publish at p < 0.05? |
| 12 | What is the smallest study that could change your mind? |

## Gates

A gate is a list of conditions, not a date. If the conditions are not met, the release does not happen. Apply the cut rules.

- **End of week 3: descriptive v0.1 RC.** The contract is frozen. Every function is documented. The boundary pack passes. Every block has a reference comparison with a stated tolerance. The clean-environment demo runs. The notes are in `review`. Every pull request has a reviewer who is not the author.
- **End of week 9: distributions v0.1 RC.** The interface is frozen. Every `pmf` or `pdf` sums or integrates to 1 within a stated tolerance. `cdf`, `sf`, and `ppf` round-trip. Support and parameter errors are explicit. Every distribution has a tail policy and seeded `rvs`. The regression suite covers every family.
- **End of week 12: inference v0.1.** The result object carries the statistic, the p-value, the degrees of freedom, the interval, the alternative, the method, and the assumptions. A function refuses when its own input rules fail. Known p-values match the textbook. The clean install, changelog, mini-study, and one research proposal per person are done.

## Cut rules

When the phase falls behind, cut in this order:

1. Chi-square tests. They are already conditional.
2. Skewness and kurtosis. Move them to v0.2 and keep variance and standard deviation.
3. Automatic histogram binning. Ship explicit edges only.
4. Hypergeometric and negative binomial. Move them to v0.2 and keep Bernoulli, Binomial, Geometric, and Poisson.
5. The second paper of the week. Keep the code-bearing paper.

Never cut the data contract, the missingness policy, the refusal behaviour, the hand-worked evidence, the reference comparison, or the clean-environment example.

# How to read and research

The book is mandatory. Each person reads the assigned pages and solves the exercises that use the functions we build. Each implementation uses the book as its order, the papers from the map below as its method, and numpy, pandas, scipy, or statsmodels as its reference check. It also needs a tldraw diagram and a note in the open Eskolx vault that links the code, the papers, and the diagram.

Each week has at least one **code-bearing** paper. The block implements that paper. The block owner reads it before writing the function and cites it in the docstring and the note. Most weeks add a **direction** paper. Everyone reads it before the review. The block does not implement it, and it changes what the team accepts as evidence. Two is the ceiling, not a target.

At the end of the week, each person reviews the work of at least two other people and verifies that the work is correct.


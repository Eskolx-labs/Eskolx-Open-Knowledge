---
type: project
cover:
status: planned
priority: high
area: statistics
owner: Natnael-Getahun
created: 2026-09-06
updated: 2026-09-06
author: Natnael
tags:
  - statistics
  - distributions
  - inference
  - onboarding
  - projects
publish-status: draft
---
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

| Day                   | Work                                                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Monday                | A 45-minute planning call. Assign pages and material, exercises from selected book, reviewers, etc.                 |
| Tuesday and Wednesday | Read, solve, write notes, and start implementation.                                                                 |
| Thursday              | Every contributor opens a real PR. It may still be a draft, but it must contain actual work.                        |
| Friday                | Review, test, and cut work that cannot meet the quality gate. Tldraw canvas explation. PR and peer review deadline. |
| Saturday              | One-to-one meetings (in-person or remote)                                                                           |
| Sunday                | Core team decides on progress and next steps.                                                                       |

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

| Week | Shared reading                                                              | Shared phase and build target                                                                                                                                | Saturday PR evidence                                                                                                                      | Sunday presentation                                                              |
| ---: | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
|    1 | Ch. 1, introduction to statistics, data collection, samples and populations | Descriptive. Package skeleton, numeric input contract, missing-data decision, count, min, max, range.                                                        | Empty input, invalid values, and a hand-checked small dataset. Book examples and exercises solved with our package.                       | Explain the data contract.                                                       |
|    2 | Ch. 2.1 to 2.4, describing and summarizing datasets                         | Descriptive. Mean, median, mode, quantiles, IQR, variance, standard deviation, frequency tables, histogram counts.                                           | Textbook examples reproduced by hand and in code. Book examples and exercises solved with our package.                                    | Show how mean and median disagree on a skewed dataset.                           |
|    3 | Ch. 2.5 to 2.6, normal datasets, paired data, correlation                   | Descriptive. Covariance, Pearson correlation, skewness, kurtosis, stable online moments. Descriptive v0.1 release candidate.                                 | Constant values, tied values, numerical-stability comparison, documentation example. Book examples and exercises solved with our package. | Demonstrate one summary that can mislead.                                        |
|    4 | Ch. 3, elements of probability                                              | Distributions. Read probability as background only. Define the distribution interface and implement Bernoulli and Binomial.                                  | PMF sums to one, support and parameter errors, known moments. Book examples and exercises solved with our package.                        | Explain the interface and what the package will not do.                          |
|    5 | Ch. 4, random variables and expectation                                     | Distributions. Implement Geometric, Negative Binomial, Hypergeometric, Poisson, plus moments and random sampling.                                            | Known values, seeded draws, CDF limits. Book examples and exercises solved with our package.                                              | Present one distribution and its parameterization.                               |
|    6 | Ch. 5.1 to 5.4, special random variables                                    | Distributions. Implement Uniform and Normal. Add shared `cdf`, `sf`, and `ppf` test cases.                                                                   | CDF and quantile round trips, tail values, comparison tolerance.                                                                          | Explain why tail probabilities are harder than ordinary values.                  |
|    7 | Ch. 5.5 to 5.9, Normal, Exponential, Gamma, related distributions           | Distributions. Implement Exponential, Gamma, Chi-square, Student t, and F.                                                                                   | Boundary values, moments, extreme inputs, reference checks. Book examples and exercises solved with our package.                          | Explain one numerical method or approximation.                                   |
|    8 | Ch. 6.1 to 6.3, sampling statistics and the central limit theorem           | Distributions. Add sampling-distribution examples and the helpers inference will need.                                                                       | A reproducible CLT simulation and a written interpretation.                                                                               | Show the bridge between distribution code and inference.                         |
|    9 | Ch. 6.4 to 6.6, sample variance and normal-population sampling              | Distributions. Finish parameter validation, API consistency, examples, and release notes. Probability-distributions v0.1 release candidate.                  | Clean install and full distribution regression suite. Book examples and exercises solved with our package.                                | Live review against a reference library.                                         |
|   10 | Ch. 7, parameter estimation and interval estimates                          | Inference. Implement result object, one-sample mean interval and test, and two-mean intervals.                                                               | Hand-calculated textbook case and invalid-condition tests. Book examples and exercises solved with our package.                           | Explain confidence intervals without the usual false claim.                      |
|   11 | Ch. 8.1 to 8.4, significance levels and mean tests                          | Inference. Implement Welch two-sample t test, paired t test, and one- and two-proportion tests.                                                              | Known p-values for each alternative, paired-data cases. Book examples and exercises solved with our package.                              | Explain Type I error, Type II error, and power with one dataset.                 |
|   12 | Ch. 8.5 to 8.7, variance, Bernoulli, and Poisson tests                      | Inference. Finish tests, documentation, mini-study, changelog, release tag, and retrospective. Start chi-square only if all required tests passed by Friday. | Clean install, reproducible mini-study, all examples and links checked. Book examples and exercises solved with our package.              | Final release. Each person explains one contribution and one current limitation. |

# How to read and research

The book is mandatory. Each person reads the assigned pages and solves exercises from the book that are supposed to be done with their developed functions. Implementation should be supported by the book, a minimum of two canonical research papers of importance in the field of statistics, evidence of same results using numpy/pandas/statsmodels/scipy, a tldraw canvas simplified explanation for presentation, and a note in the open Eskolx obsidian vault linking all of these together.

Examples of papers include Welford for online variance, a numerical reference for Normal CDF and quantiles, or Welch for unequal-variance testing.

At the end of the week, each person is responsible for reviewing the work of a minimum of two other people and verifying their work is correct.


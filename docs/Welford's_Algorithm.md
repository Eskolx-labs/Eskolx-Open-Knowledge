---
type: note
status: draft
author: Brhanu Kefe
created: 2026-10-05
updated: 2026-10-05
tags:
  - statistics
  - algorithms
  - welford
  - python
publish-status: unpublished
---


# Welford's Algorithm for Online Mean and Variance Computation

## Overview
Welford introduced a single-pass, numerically stable algorithm for estimating online sample mean and sample variance over streaming numerical data. Unlike naive textbook approaches, Welford's formulation updates running statistics incrementally, eliminating catastrophic cancellation when processing large offset inputs.

---


## Core Formulas & Flowchart Logic

### State Variables
- $n$: Count of valid numerical samples processed
- $\bar{x}_n$: Current running mean
- $M_{2,n}$: Accumulated sum of squared deviations

### Step-by-Step Update Rule
$$\Delta_n = x_n - \bar{x}_{n-1}$$
$$\bar{x}_n = \bar{x}_{n-1} + \frac{\Delta_n}{n}$$
$$M_{2,n} = M_{2,n-1} + \Delta_n \cdot (x_n - \bar{x}_n)$$

### Output Estimators ($n \ge 2$)
$$\text{Sample Variance } (s^2) = \frac{M_{2,n}}{n - 1}$$
$$\text{Sample Std Dev } (s) = \sqrt{s^2}$$


---

## Architectural Flowchart

Below is the embedded visual workflow detailing the algorithm's state updates across each step:

![[welford's diagram_brhanu_kefe]]

---

## Implementation Details & Contract Compliance

* **Missing Data:** None and nan values are safely skipped and accounted for in dropped_count.
* **Fail-Fast Type Checking:** Non-numeric inputs (e.g., strings or collections) trigger an explicit TypeError.
* **Boundary Handling:** When valid counts (n < 2), variance and standard deviation evaluate to math.nan without raising runtime errors.


---

## What Was Cut

 **Naive Two-Pass Formula ($\sum x^2 - \frac{(\sum x)^2}{n}$):** Omitted due to loss of numerical precision caused by catastrophic cancellation when subtracting large, nearly equal floating-point numbers (e.g., 10^9 + [1, 2, 3]).


---

## Related Links & References
* Welford, B. P. (1962). "Note on a Method for Calculating Corrected Sums of Squares and Products." *Technometrics*.
* Yao et al. (2022). "ReAct: Synergizing Reasoning and Acting in Language Models."
* [Algorithms for calculating variance - Wikipedia](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm)

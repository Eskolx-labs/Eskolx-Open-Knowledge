---
type: concept
cover: https://upload.wikimedia.org/wikipedia/commons/1/1a/Boxplot_vs_PDF.svg
status: draft
area: statistics
created: 2026-11-10
updated: 2026-11-10
author: Hanna Desalegn
tags: []
publish-status: draft
---

![Box plot and the normal curve](https://upload.wikimedia.org/wikipedia/commons/1/1a/Boxplot_vs_PDF.svg)

# Measures of Spread

## Definition

Spread says how far the values of a data set sit from each other. This note covers the four used in stateskol: the sample variance, the sample standard deviation, the sample quantile (percentile) and the interquartile range (IQR). Source: [[Ross — Introduction to Probability and Statistics]], sections 2.3.2 and 2.3.3.

- Sample variance: $s^2 = \frac{1}{n-1}\sum_{i=1}^{n}(x_i - \bar{x})^2$
- Sample standard deviation: $s = \sqrt{s^2}$, in the same units as the data.
- Sample 100p percentile: a value with at least $np$ of the data at or below it and at least $n(1-p)$ at or above it.
- IQR: $Q_3 - Q_1$, the 75th minus the 25th percentile.

## Intuition

Two data sets can share a mean and still look nothing alike. 1001, 1002, 1003 and 992, 1002, 1012 both have mean 1002, but the second is ten times as spread out ($s = 1$ against $s = 10$).

Variance uses every value, so one extreme value moves it a lot. The IQR only looks at the middle half of the sorted data, so it ignores the tails.

## Why it matters

A mean alone hides how much the data varies. Spread is what tells you whether a mean is a good summary, and it is the base for later work: standard errors, z-scores and Chebyshev's inequality (Ross 2.4) all divide by $s$. It is also the first block of the stateskol library, so every other block depends on getting it right.

## How it works

![[spread (Hanna Desalegn).tldr]]

*Diagram: one Welford step, Ross's quantile rule, and the IQR of the Ross 2.3.i noise data. The scene is a plain `.tldr` file with default tldraw styles and no local settings, laid out as three columns: Welford loop, quantile decision, IQR example.*

**Variance in one pass (Welford, 1962).** Keep a count $n$, a running mean $m$ and a running corrected sum of squares $S$. For each new value $x$:

1. $n \leftarrow n + 1$
2. $d = x - m$, using the old mean
3. $S \leftarrow S + \frac{n-1}{n} d^2$ (Formula I)
4. $m \leftarrow m + d / n$

At the end, $s^2 = S / (n-1)$. The textbook shortcut $\sum x_i^2 - n\bar{x}^2$ subtracts two huge, almost equal numbers. For data near $10^9$ it loses every digit.

**Quantile (Ross's rule).** Sort the data and compute $k = np$.

- If $k$ is not a whole number, take the value at position $\lceil k \rceil$.
- If $k$ is a whole number, average the values at positions $k$ and $k+1$.

$p = 0$ gives the minimum and $p = 1$ the maximum. This is numpy's `method="averaged_inverted_cdf"`, not numpy's default linear method.

## Example

**Variance by hand**, data 2, 4, 4, 4, 5, 5, 7, 9:

| n | x | d | m | S |
|---|---|---|---|---|
| 1 | 2 | 2 | 2 | 0 |
| 2 | 4 | 2 | 3 | 2 |
| 3 | 4 | 1 | 3.33 | 2.67 |
| 4 | 4 | 0.67 | 3.5 | 3 |
| 5 | 5 | 1.5 | 3.8 | 4.8 |
| 6 | 5 | 1.2 | 4 | 6 |
| 7 | 7 | 3 | 4.43 | 13.71 |
| 8 | 9 | 4.57 | 5 | 32 |

$s^2 = 32/7 = 4.571$, $s = 2.138$.

**Ross examples:**
- 2.3.f: data 3, 4, 6, 7, 10. Mean 6, deviations -3, -2, 0, 1, 4, so $S = 30$ and $s^2 = 30/4 = 7.5$.
- 2.3.g: airline accidents, shifted by 18. $s^2 = 34.75$.

**Quartiles of the noise data** (Ross 2.3.i, $n = 36$):
- $Q_1$: $k = 9$ is whole, so average the 9th and 10th values, $(75 + 77)/2 = 76$.
- Median: $k = 18$, giving 89.5.
- $Q_3$: $k = 27$, giving 104.5.
- $\text{IQR} = 104.5 - 76 = 28.5$.

**Stability:** for $10^9 + [4, 7, 13, 16]$ the true variance is 30. The shortcut formula gives 0. Welford gives 30.

## Common Mistakes

- Dividing by $n$ instead of $n - 1$. numpy's `np.var` does this by default, so compare with `ddof=1`.
- Assuming every library computes quantiles the same way. On the noise data, numpy's default gives $Q_1 = 76.5$ and $Q_3 = 103.25$, while Ross's rule gives 76 and 104.5. Always name the method.
- Trusting the book's printed answer. Ross 2.3.i prints $Q_1 = 74.5$, but its own rule and numpy both give 76.
- Computing $np$ in floating point. $25 \times 0.28$ is $7.000000000000001$ in float, so numpy takes the 8th value where Ross averages the 7th and 8th. Doing the product in decimal keeps the rule exact.
- Asking for the variance of one value. $n - 1 = 0$, so it is undefined. stateskol raises an error instead of returning a silent NaN.

## Implementation

Pure Python, no numpy, in [stateskol PR #13](https://github.com/Eskolx-labs/stateskol/pull/13), file `src/stateskol/spread (Hanna Desalegn).py`:

```python
def welford_variance(values):
    n, m, s = 0, 0.0, 0.0
    for x in values:
        n += 1
        d = x - m
        s += (n - 1) / n * d * d
        m += d / n
    return s / (n - 1)

print(welford_variance([2, 4, 4, 4, 5, 5, 7, 9]))  # 4.571428571428571
print(welford_variance([1e9 + v for v in [4, 7, 13, 16]]))  # 30.0
```

Missing values (None, NaN) are dropped and counted, never filled in. bool, strings, complex and infinite values raise an error at their index.

## Related Concepts

- [[Population vs Sample]]: $s^2$ divides by $n - 1$ because it estimates the spread of the population from a sample.
- [[Sampling Bias]]: a biased sample gives a misleading spread no matter how it is computed.
- [[Ross — Introduction to Probability and Statistics]]

## References

- Ross, S. M. (2020). *Introduction to Probability and Statistics for Engineers and Scientists*, 6th ed., Academic Press. Sections 2.3.2, 2.3.3, 2.4.
- Welford, B. P. (1962). Note on a method for calculating corrected sums of squares and products. *Technometrics*, 4(3), 419–420.
- Hyndman, R. J. and Fan, Y. (1996). Sample quantiles in statistical packages. *The American Statistician*, 50(4), 361–365.

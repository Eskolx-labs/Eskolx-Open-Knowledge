---
type: concept
cover: https://upload.wikimedia.org/wikipedia/commons/1/1a/Boxplot_vs_PDF.svg
status: draft
area: statistics
created: 2026-11-23
updated: 2026-11-23
author: Hanna Desalegn
tags: []
publish-status: draft
---

![Box plot and density](https://upload.wikimedia.org/wikipedia/commons/1/1a/Boxplot_vs_PDF.svg)

# Center and Spread

## Definition

A center summary says where the data sits. A spread summary says how far the values are from that center. stateskol ships two of each kind ([[Ross — Introduction to Probability and Statistics|Ross §2.1–2.3]]):

- **mean**: the sum of the values divided by n.
- **median**: the middle value of the sorted data; for even n, the average of the two middle values.
- **sample variance and standard deviation**: the average squared distance from the mean, dividing by n − 1, and its square root.
- **IQR**: Q3 − Q1, the width of the middle half, with quantiles under type 7.

## Intuition

The mean and the standard deviation use every value, including how far away each one is, so a single extreme value pulls them. The median and the IQR only use positions in the sorted data, so a value far out in the tail moves them by at most one position.

Which one lies depends on the shape. On symmetric data they agree. On skewed data, or data with one outlier, the mean and standard deviation describe a case that does not exist in the data.

## Why it matters

Every summary answers a question you may not have asked. [[Anscombe (1973) — Graphs in Statistical Analysis|Anscombe (1973)]] built four datasets with the same means and nearly the same variances and four completely different pictures. A pipeline that reports a mean without the median, or a standard deviation without the IQR, cannot tell those cases apart.

## How it works

![[center and spread (Hanna Desalegn).tldr]]

*Diagram: top, where the nine quantile rules put the 25th percentile of 1 2 3 4 5 on one sorted axis; bottom, the same nine values with and without one outlier of 48, with the mean and median marked. A plain `.tldr` file with default tldraw styles.*

**The median and type 7.** [[Hyndman & Fan (1996) — Sample Quantiles in Statistical Packages|Hyndman and Fan (1996)]] list nine quantile rules. stateskol ships type 7, h = (n − 1)p + 1. At p = 0.5 that gives the middle value for odd n and the average of the two middle values for even n, so `median(data)` always equals `quantile(data, 0.5)`. On 1 2 3 4 5 the 25th percentile is 1 under type 3, 1.5 under type 6, 1.667 under type 8 and 2 under type 7. See [[The Nine Quantile Definitions]] for all nine.

**The variance algorithm.** The definition is fixed, the algorithm is not. stateskol uses Welford's one-pass update ([[Welford (1962) — Corrected Sums of Squares|Welford, 1962]]), because the textbook shortcut loses every digit when the values are large and close together. See [[Variance - One Definition, Many Algorithms (yeabsira)]].

## Example

**Hand-worked audit**, data 2 4 4 4 5 5 7 9 (n = 8):

| summary | by hand | stateskol |
|---|---|---|
| mean | 40 / 8 = 5 | `5.0` |
| median | sorted 4th and 5th are 4 and 5, so 4.5 | `4.5` |
| mode | 4 occurs three times | `[4.0]` |
| sample variance | squared deviations 9 1 1 1 0 0 4 16, sum 32, 32 / 7 | `4.571428571428571` |
| standard deviation | √(32/7) | `2.138089935299395` |

**One outlier**, data 1 2 2 3 4 4 5 6 7, then the same data plus 48:

| summary | without 48 | with 48 | moved by |
|---|---|---|---|
| mean | 3.78 | 8.20 | 4.42 |
| median | 4.00 | 4.00 | 0 |
| standard deviation | 1.99 | 14.11 | 12.12 |
| IQR (type 7) | 3.0 | 3.5 | 0.5 |

The mean of the second sample is 8.20, but nine of the ten values are 7 or less. The standard deviation grows sevenfold from one value. The median and IQR barely move.

## Common Mistakes

- Reporting the mean of skewed data alone. On the sample above it describes a "typical" value of 8.20 that no observation is close to.
- Reading the median as robust to everything. It ignores the size of the tail entirely: 1 2 2 3 4 4 5 6 7 and the same data plus 48,000 have the same median.
- Quoting a percentile without its rule. Type 6 and type 7 give 13.5 and 12.5 for the 75th percentile of 2 4 4 5 7 9 11 13 15 18.
- Treating mode as one number. 1 2 2 3 4 4 5 has two modes, and stateskol returns both.
- Summarizing first and looking later. Anscombe's point: plot the data before choosing the summary.

## Implementation

Code: `mean`, `median`, `mode` in the Core A block of `src/stateskol/descriptive.py`, tests in `tests/test_center.py` (stateskol, branch `week-03/hanna/center`). They read the data through the week 2 contract, see [[The Data Contract]].

```python
import math

def mean(values):
    return math.fsum(values) / len(values)

def median(values):
    xs = sorted(values)
    mid = len(xs) // 2
    return xs[mid] if len(xs) % 2 else xs[mid - 1] / 2 + xs[mid] / 2

sample = [1, 2, 2, 3, 4, 4, 5, 6, 7]
print(round(mean(sample), 2), median(sample))  # 3.78 4
print(mean(sample + [48]), median(sample + [48]))  # 8.2 4.0
```

## Related Concepts

- [[The Data Contract]]: what counts as data before any summary runs
- [[The Nine Quantile Definitions]]
- [[Variance - One Definition, Many Algorithms (yeabsira)]]
- [[Population vs Sample]]: why the variance divides by n − 1
- [[Sampling Bias]]

## References

- Ross, S. M. (2020). *Introduction to Probability and Statistics for Engineers and Scientists*, 6th ed., §2.1–2.3.
- Hyndman, R. J. and Fan, Y. (1996). Sample quantiles in statistical packages. *The American Statistician*, 50(4), 361-365.
- Welford, B. P. (1962). Note on a method for calculating corrected sums of squares and products. *Technometrics*, 4(3), 419-420.
- Anscombe, F. J. (1973). Graphs in statistical analysis. *The American Statistician*, 27(1), 17-21.

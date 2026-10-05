---
type: concept
cover: 
status: draft
area: statistics
created: 2026-10-05
updated: 2026-10-05
author: mekhluqat
tags:
  - variance
  - online-algorithms
publish-status: draft
---

# Welford Online Variance (mekhluqat)

## Definition
Welford's method computes the mean and the sample variance of a list of numbers in **one pass**, keeping only three running values: the count `n`, the running `mean`, and `M2`, the running sum of squared distances from the mean. The sample variance is `M2 / (n - 1)`. It comes from Welford (1962), see References.

## Intuition
Instead of storing every value, each new number nudges the running mean toward itself. `M2` grows by how far the new number was from the old mean, times how far it is from the new mean. The data never has to be kept or read twice.

## Why it matters
The textbook shortcut `sum(x*x) - sum(x)**2 / n` subtracts two huge, nearly equal numbers when the data sits far from zero, and the answer can be destroyed by rounding. Welford only ever works with small deviations from the mean, so it stays accurate. It also works on streams, where values arrive one at a time.

## How it works
For each new value `x`:

1. `n = n + 1`
2. `delta = x - mean` (distance from the old mean)
3. `mean = mean + delta / n`
4. `delta2 = x - mean` (distance from the new mean)
5. `M2 = M2 + delta * delta2`

At the end the sample variance is `M2 / (n - 1)` and the sample standard deviation is its square root. We divide by `n - 1`, not `n`, because the mean was estimated from the same data, so the sample variance would otherwise come out too small. See [[Population vs Sample]].

## Example
Hand-worked on `[2, 4, 6, 8]`:

| x | n | delta | mean | delta2 | M2 |
|---|---|-------|------|--------|----|
| 2 | 1 | 2 | 2 | 0 | 0 |
| 4 | 2 | 2 | 3 | 1 | 2 |
| 6 | 3 | 3 | 4 | 2 | 8 |
| 8 | 4 | 4 | 5 | 3 | 20 |

Result by hand: count 4, mean 5, variance 20 / 3 = 6.667, standard deviation 2.582.
Result from the code: `WelfordResult(count=4, mean=5.0, variance=6.666666666666667, std=2.581988897471611, dropped=0)`. The two agree.

**Numerical stability.** Data `[1e9 + 4, 1e9 + 7, 1e9 + 13, 1e9 + 16]`. By hand the mean is 1e9 + 10, the deviations are -6, -3, 3, 6, so M2 = 90 and the variance is 30. The naive formula returned **0.0** in our run, which is completely wrong. Welford returned **30.0**, and numpy also gave 30.0.

**Reference comparison.** On 1000 random values, the relative difference between Welford and numpy's variance was about 5.6e-16, so the tolerance of 1e-9 (relative) holds with a wide margin. That tolerance is far above rounding noise and far below any real mistake, such as dividing by `n` instead of `n - 1`.

## Common Mistakes
- Dividing by `n` instead of `n - 1` when the data is a sample.
- Using the naive sum-of-squares formula on data with a large offset.
- Silently filling missing values. Our rule drops `None` and `nan` and reports how many were dropped.
- Forgetting that one value has no sample variance: `n - 1` is zero, so the result is `nan`.

## Implementation
Code lives in the stateskol repo: pull request https://github.com/Eskolx-labs/stateskol/pull/5, file `src/stateskol/welford (mekhluqat).py`. The package uses only the standard library. Decisions: empty input gives count 0 and `nan` values; a single value gives `nan` variance; constant values give variance 0.0; `str`, `bool` raise `TypeError`; `inf` raises `ValueError`; missing values are dropped and counted.

Diagram: ![[welford (mekhluqat).tldr]]
*Caption: the five update steps Welford applies to each new value. The loop arrow repeats them for the next value, and the variance is computed once after the last value. Drawn by hand with the Obsidian tldraw plugin.*

## Related Concepts
- [[Population vs Sample]]
- [[Sampling Bias]]

## References
- B. P. Welford, "Note on a method for calculating corrected sums of squares and products", Technometrics 4(3), 1962, pp. 419 to 420.

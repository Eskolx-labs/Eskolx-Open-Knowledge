---
type: concept
cover: "   https://commons.wikimedia.org/wiki/Special:FilePath/Normal-distribution-cumulative-density-function.svg?width=800"
status: draft
area:
created: 2026-10-04
updated: 2026-10-04
author:
tags: []
publish-status: draft
---



# Welford Online Variance (Yosef Bezabih)

   ![Normal distribution curve](https://commons.wikimedia.org/wiki/Special:FilePath/Normal-distribution-cumulative-density-function.svg?width=800)
   

## Definition
Welford's method computes the mean and the sum of squared deviations of a data set in a single pass. It keeps only three numbers: the count $n$, the running mean $m_n$, and the running corrected sum of squares $S_n = \sum_{i=1}^{n}(x_i - m_n)^2$. Each value is used once and never stored (Welford, 1962).

## Intuition
When a new value arrives, the old mean was a little wrong. Welford's update measures how far the new value is from the old mean, moves the mean by a $1/n$ share of that gap, and adds the matching amount to the spread. The data never needs to be read again.

## Why it matters
The textbook formula $\sum x^2 - (\sum x)^2/n$ subtracts two huge, nearly equal numbers, which destroys significant digits when the mean is large compared with the spread. Welford only handles small deviations from the running mean, so it stays accurate, and it works on streams or files too big to hold in memory.

## How it works
For each new value $x_n$, let $\delta = x_n - m_{n-1}$ (the gap from the **old** mean). Then:

$$m_n = m_{n-1} + \frac{\delta}{n}$$

$$S_n = S_{n-1} + \frac{n-1}{n}\,\delta^2$$

The second line is formula I from Welford (1962). It is equivalent to $S_n = S_{n-1} + (x_n - m_{n-1})(x_n - m_n)$, because $x_n - m_n = \tfrac{n-1}{n}(x_n - m_{n-1})$.

The sample variance is $s^2 = S_n/(n-1)$, and the standard deviation is $s = \sqrt{s^2}$. Start with $n = 0$, $m_0 = 0$, $S_0 = 0$.

   ![[welford (Yosef Bezabih).tldr]]
   *Diagram: one Welford update step for each new value. Only the count, the mean and the sum of squares S are kept, and the data is never stored. The method then repeats with the next value.*
   

## Example
Data: `[2, 4, 4, 4, 5, 5, 7, 9]`. At each step $\delta = x_n - m_{n-1}$ (the old mean), then $m_n = m_{n-1} + \delta/n$ and $S_n = S_{n-1} + \frac{n-1}{n}\delta^2$.

| n | x | δ | mean | S |
|---|---|---|---|---|
| 1 | 2 | 2 | 2 | 0 |
| 2 | 4 | 2 | 3 | 2 |
| 3 | 4 | 1 | 3.3333 | 2.6667 |
| 4 | 4 | 0.6667 | 3.5 | 3.0 |
| 5 | 5 | 1.5 | 3.8 | 4.8 |
| 6 | 5 | 1.2 | 4.0 | 6.0 |
| 7 | 7 | 3 | 4.4286 | 13.7143 |
| 8 | 9 | 4.5714 | 5.0 | 32.0 |

**By hand:** $n = 8$, mean $= 5$, $S = 32$, sample variance $= 32/7 \approx 4.5714$, standard deviation $\approx 2.1381$.

**Cross-check (two-pass route):** the squared deviations from 5 are $9+1+1+1+0+0+4+16 = 32$, the same $S$.

**By code** (`welford([2, 4, 4, 4, 5, 5, 7, 9])`): count 8, mean 5.0, variance 4.571428571428571, std 2.138089935299395.

**Stability check.** For `[1e9+4, 1e9+7, 1e9+13, 1e9+16]` the exact sample variance is 30. The naive formula $\sum x^2 - (\sum x)^2/n$ returns **0.0**, because it subtracts two numbers near $4\times10^{18}$ and float64 keeps only about 16 digits. Welford returns **30.0**.

## Common Mistakes
- **Updating the mean before computing δ.** The formula needs the *old* mean $m_{n-1}$. With the new mean the result is wrong.
- **Dividing by $n$ when a sample variance is wanted.** $S_n$ is a sum of squared deviations; the sample variance divides by $n-1$.
- **Asking for a sample variance of one value.** With $n-1 = 0$ it is undefined.
- **Comparing floats for exact equality.** Rounding makes results differ in the last digits, so compare with a tolerance, for example `rtol=1e-9`.
- **Forgetting `ddof` when comparing with numpy.** `np.var` defaults to the population variance (`ddof=0`).

## Implementation
Python implementation in `stateskol`: `src/stateskol/welford (Yosef Bezabih).py` (pull request link to be added).

```python
count += 1
delta = x - mean
mean += delta / count
s += (count - 1) / count * delta * delta
```

Design choices: `None` and NaN are dropped and counted, never filled; strings, bools and infinities raise errors; empty input raises `ValueError`; one value raises for the sample variance (`ddof=1`); constant data gives exactly 0.0. Tested against hand-worked values, Python's `statistics` module and numpy, with a relative tolerance of 1e-9.

## Related Concepts
- [[Population vs Sample]]
- [[Welford (1962)]]

## References
- B. P. Welford (1962). Note on a Method for Calculating Corrected Sums of Squares and Products. *Technometrics* 4(3), 419–420. <http://dx.doi.org/10.1080/00401706.1962.10490022>
- G. E. P. Box and J. S. Hunter (1959). Condensed calculations for Evolutionary Operation Programs. *Technometrics* 1(1), 77–95.
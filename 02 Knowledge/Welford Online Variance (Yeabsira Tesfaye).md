---
type: concept
cover: https://commons.wikimedia.org/wiki/Special:FilePath/Standard_deviation_diagram.svg
status: draft
area: numerical-methods
created: 2026-10-05
updated: 2026-10-05
author: Yeasira Tesfaye
tags:
  - numerical-methods
publish-status: draft
---

![Standard deviation diagram](https://commons.wikimedia.org/wiki/Special:FilePath/Standard_deviation_diagram.svg)

# Welford Online Variance (Yeasira Tesfaye)

## Definition

Welford's method computes the **mean** and the **corrected sum of squares** $S=\sum_{i=1}^{n}(x_i-\bar{x})^2$ of a list of numbers in a single pass. Each value is read once and never stored. The **sample variance** is then $S/(n-1)$ and the sample standard deviation is its square root.

Source: B. P. Welford (1962), [Note on a Method for Calculating Corrected Sums of Squares and Products](https://doi.org/10.1080/00401706.1962.10490022), *Technometrics* 4(3), 419-420.

## Intuition

Keep two running numbers, the mean so far ($m$) and the sum of squared distances from the mean so far ($S$). When a new value $x_n$ arrives, work out how far it is from the **old** mean. That one distance tells you how much to move the mean and how much to add to $S$. You only ever handle small distances, never the huge totals that the textbook formula subtracts.

![[welford (Yeasira Tesfaye).tldr]]

*Diagram: the cancellation problem, the two-step update loop with the paper's formulas, the same lines in my code, my design decisions, the numpy check, and the hand-worked trace of 2, 4, 4, 4, 5, 5, 7, 9.*

## Why it matters

The usual recipe is the "crude" sum of squares minus a correction factor, $\sum x^2-(\sum x)^2/n$. Welford's first paragraph explains the flaw: the subtraction "results in a loss of significant figures", which on a computer can leave fewer accurate digits than the computer normally keeps. The two alternatives he lists either need the data twice (first the mean, then the deviations) or need a good guess of the mean in advance. His method needs neither, so it also works on data arriving one value at a time.

## How it works

With $m_n$ the mean of the first $n$ values and $S_n$ the corrected sum of squares of the first $n$ values, the paper gives:

$$m_n=\frac{n-1}{n}\,m_{n-1}+\frac{1}{n}\,x_n \qquad \text{(equation 1)}$$

$$S_n=S_{n-1}+\frac{n-1}{n}\,(x_n-m_{n-1})^2 \qquad \text{(Formula I)}$$

Formula I needs the **old** mean $m_{n-1}$, so in code $S$ is updated **before** $m$.

The paper reaches Formula I by splitting $\sum_{i=1}^{n}(x_i-m_n)^2$ into the first $n-1$ terms plus the last term, and using identities (2) and (3). Identity (3) is the useful one:

$$x_n-m_n=\frac{n-1}{n}\,(x_n-m_{n-1})$$

It shows why many programs write the update as $S \mathrel{+}= (x_n-m_{n-1})(x_n-m_n)$: multiply the two factors and you get $\frac{n-1}{n}(x_n-m_{n-1})^2$, which is Formula I again. Both forms are the same algebra.

Finally, the sample variance is $S_n/(n-1)$. With a single value, $n-1=0$, so the variance is undefined.

## Example

**Hand-worked.** Data: 2, 4, 4, 4, 5, 5, 7, 9. Plain method: $n=8$, sum $=40$, mean $=5$, squared distances $9+1+1+1+0+0+4+16=32$, so variance $=32/7\approx4.571429$ and standard deviation $\approx2.138090$.

Welford trace (exact fractions, computed with the two formulas above):

| n | x | S_n | m_n | variance so far |
|--:|--:|---|---|---|
| 1 | 2 | 0 | 2 | undefined |
| 2 | 4 | 2 | 3 | 2.0000 |
| 3 | 4 | 8/3 ≈ 2.6667 | 10/3 ≈ 3.3333 | 1.3333 |
| 4 | 4 | 3 | 7/2 = 3.5 | 1.0000 |
| 5 | 5 | 24/5 = 4.8 | 19/5 = 3.8 | 1.2000 |
| 6 | 5 | 6 | 4 | 1.2000 |
| 7 | 7 | 96/7 ≈ 13.7143 | 31/7 ≈ 4.4286 | 2.2857 |
| 8 | 9 | **32** | **5** | **4.5714** |

It lands on the same $S=32$ and mean $5$ as the plain method.

Code output (from the demo file, same data):

```text
count = 8  mean = 5.0  variance = 4.571429  std = 2.13809
by hand: count = 8  mean = 5  variance = 32/7 = 4.571429  std = 2.13809
```

**Numerical stability.** Data: $10^9+4,\ 10^9+7,\ 10^9+13,\ 10^9+16$. The mean is $10^9+10$ and the distances from it are $-6,-3,3,6$, so $S=90$ and the true variance is $90/3=30$.

| Method | Result |
|---|---|
| Naive: $(\sum x^2-(\sum x)^2/n)/(n-1)$ in float64 | **0.0** |
| Welford | **30.0** |

Why the naive result is wrong: $\sum x^2\approx4.00000008\times10^{18}$ and $(\sum x)^2/n$ is almost exactly the same number. Float64 numbers near $4\times10^{18}$ are spaced $512$ apart, but the answer to find is only $90$, so the difference is smaller than the smallest step the numbers can represent. The digits that held the answer were rounded away. This is **catastrophic cancellation**: subtracting two nearly equal large numbers. Welford only ever subtracts values that are close to the mean, such as $x-m$, which are small here.

**Reference check.** Compared with `np.var(x, ddof=1)` (numpy is used only in the reference file; the function itself never calls it). Relative error of the variance:

| Data (n) | Error | Tolerance used |
|---|---|---|
| hand-worked set (8) | 0 | 1e-12 |
| normal(0, 1) (100,000) | 6.7e-16 | 1e-12 |
| normal(100, 15) (100,000) | 8.0e-15 | 1e-12 |
| uniform(−1000, 1000) (100,000) | 8.2e-15 | 1e-12 |
| normal(1e6, 1), big mean (100,000) | 4.6e-11 | 2.2e-10 |
| stability set (4) | 0 | 4e-8 |
| 2000 random small datasets, worst | 6.7e-14 | 1e-12 |

The tolerance rule is $\max(10^{-12},\ \varepsilon\,|\bar{x}|/s)$ with $\varepsilon=2.2\times10^{-16}$. The floor of $10^{-12}$ sits about two orders above the errors seen on ordinary data and far below any real mistake (dividing by $n$ instead of $n-1$ is off by about $10^{-5}$ at $n=10^5$). The second term exists because the error grows when the mean is large compared with the spread. On normal(1e6, 1) the error was 4.6e-11 against an exact value computed with fractions, while numpy (two passes) was exact. The rule is a rule of thumb fitted to what I measured, not a proven bound.

## Common Mistakes

- Dividing by $n$ instead of $n-1$ when the data is a sample (see [[Population vs Sample]]).
- Updating the mean **before** $S$ when using Formula I. Formula I needs the old mean.
- Using the textbook formula on data with a large mean and a small spread, as in the stability set.
- Letting a missing value (NaN) into the loop: it spreads into the mean and the variance silently. The code drops missing values and reports how many.
- Treating `True` and `False` as numbers. They are rejected on purpose.

## Implementation

The function `welford(data)` returns a dictionary with `count`, `mean`, `variance`, `std` and `dropped`. The update inside the loop is exactly the paper's:

```python
n = n + 1
S = S + ((n - 1) / n) * (x - m) ** 2   # Formula I (uses the OLD mean)
m = ((n - 1) / n) * m + x / n          # equation (1)
```

Design decisions, each covered by a test:

| Case | Behaviour |
|---|---|
| Missing values (`None`, NaN) | dropped, counted in `dropped` |
| Empty input, or all values missing | `ValueError` |
| One value | count 1, mean = the value, variance and std = NaN |
| Constant values | variance 0.0 (a tiny leftover such as 1.9e-29 on 1000 copies of 3.7, from rounding in equation 1) |
| Strings, `True`/`False` | `TypeError` |
| `inf`, `-inf` | `ValueError` |

Known limits: this implements Formula I (sums of squares) only, not the products formula II or the higher powers formula III from the paper. It does not merge partial results from two data sets.

- Code PR: [Add Welford online variance (Yeabsira Tesfaye) by yeab-sira1 · Pull Request #10 · Eskolx-labs/stateskol](https://github.com/Eskolx-labs/stateskol/pull/10)
- Files: `welford (Yeabsira Tesfaye).py`, `test_welford (Yeabsira Tesfaye).py`, `welford_demo (Yeabsira Tesfaye).py`, `welford_reference (Yeabsira Tesfaye).py`

## Related Concepts

- [[Population vs Sample]]
- [[Sampling Bias]]
- [[Phase 01 — Statstical Packages Foundation.md]]

## References

- Welford, B. P. (1962). Note on a Method for Calculating Corrected Sums of Squares and Products. *Technometrics*, 4(3), 419-420. [doi:10.1080/00401706.1962.10490022](https://doi.org/10.1080/00401706.1962.10490022)
- Box, G. E. P. and Hunter, J. S. (1959). Condensed calculations for Evolutionary Operation Programs. *Technometrics*, 1(1), 77-95. Cited by Welford as a similar formula; not read for this note.

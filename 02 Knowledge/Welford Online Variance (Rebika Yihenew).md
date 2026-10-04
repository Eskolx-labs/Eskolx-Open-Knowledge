---
type: concept
cover: https://upload.wikimedia.org/wikipedia/commons/3/3a/Standard_deviation_diagram_micro.svg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original
status: draft
area: numerical-methods
created: 2026-10-03
updated: 2026-10-03
author: Rebika Yihenew
tags:
  - numerical-methods
publish-status: draft
---
# Welford Online Variance (Rebika Yihenew)

[[welford (Rebika Yihenew).tldr]] 
![[welford (Rebika Yihenew).tldr]]
_Diagram: one new value updates the running count n, mean m and corrected sum of squares S (Formula I); variance is S / (n - 1). Drawn by hand in the Obsidian tldraw plugin._

## Definition

Welford's method (Welford, 1962) computes the **count, mean and sample variance of a stream of numbers in a single pass**, keeping only three running numbers: the count $n$, the mean $m_n$, and $S_n = \sum_{i=1}^{n}(x_i - m_n)^2$, the corrected sum of squares (deviations from the _current_ mean). The sample variance is

$$s^2 = \frac{S_n}{n-1}, \qquad s = \sqrt{s^2}.$$

## Intuition

The textbook formula needs the mean first, then a second pass over the data to measure deviations from it. The shortcut "mean of squares minus square of the mean" needs only one pass, but it subtracts two huge, nearly equal numbers and can lose every digit of accuracy.

Welford's note describes exactly this problem: the usual way subtracts a correction factor from the "crude" sum of squares, which loses significant figures; the alternatives are to shift the values to an origin near the mean, or to take two passes over the data. His third method needs neither.

Welford keeps the mean _moving_. Each new value $x$ pulls the mean toward itself by a $1/n$ share, and the sum of squares grows by $\frac{n-1}{n}$ times the squared distance from $x$ to the old mean. Only small differences are ever computed, never squares of large numbers.

## Why it matters

- **Streaming:** the data is read once and never stored, so it works on generators and data too big for memory.
- **Accuracy:** it avoids the catastrophic cancellation of the naive formula (see the stability case below).
- It is the building block for running statistics and for combining statistics of separate chunks.

## How it works

Start with $n = 0$, $m = 0$, $S = 0$. For each new value $x$ (the paper's $x_n$):

```text
n   = n + 1
dev = x - m                    # x_n - m_(n-1): deviation from the mean of the previous values
S   = S + (n - 1) / n * dev**2 # Formula I
m   = m + dev / n              # identity (1), rearranged
```

At the end the sample variance is $S/(n-1)$ and the standard deviation is its square root.

**Why the update is right.** Let $\delta = x_n - m_{n-1}$. Then $m_n = m_{n-1} + \delta/n$ and $x_n - m_n = \delta(n-1)/n$ (identities (1) and (3) below). Re-centring the first $n-1$ points on the new mean, the cross term vanishes because deviations from a mean sum to zero, leaving $(n-1)\delta^2/n^2$. Adding the new point's own term $\delta^2(n-1)^2/n^2$ gives

$$S_n = S_{n-1} + \frac{n-1}{n},\delta^2.$$

Note that the coefficient $(n-1)/n$ matters: leaving it out would add $\delta^2$ instead and overstate the sum of squares. And $\delta$ must be measured from the mean of the **previous** values $m_{n-1}$, which is why the deviation is computed _before_ the mean is updated.

**Why $n-1$ (Bessel's correction).** The sample mean is computed from the same data, so points sit closer to it than to the true mean; dividing by $n$ would underestimate the variance on average. With the mean fixed, only $n-1$ deviations are free. For a single value $n-1 = 0$, so the sample variance is undefined.

**In the paper's notation.** Welford writes $m_n$ for the running mean and $S_n$ for the corrected sum of squares, and states three identities:

1. $m_n = \frac{n-1}{n},m_{n-1} + \frac{1}{n},x_n$
2. for $i<n$: $x_i - m_n = x_i - m_{n-1} - \frac{1}{n}(x_n - m_{n-1})$
3. $x_n - m_n = \frac{n-1}{n},(x_n - m_{n-1})$

Squaring and summing gives his **Formula I**:

$$S_n = S_{n-1} + \frac{n-1}{n},(x_n - m_{n-1})^2.$$

|paper|code|
|---|---|
|$m_{n-1}$, $m_n$|`m` before, `m` after the update|
|$S_n$|`S`|
|$x_n - m_{n-1}$|`dev`|

The code is Formula I verbatim. Identity (1) is evaluated in the equivalent form $m_n = m_{n-1} + (x_n - m_{n-1})/n$, since $\frac{n-1}{n}m_{n-1} + \frac{1}{n}x_n = m_{n-1} + \frac{1}{n}(x_n - m_{n-1})$. In floating point the two are not identical: the form printed in the paper rounds $\frac{n-1}{n}m + \frac{x}{n}$ at every step, so constant data drifts (variance about $10^{-15}$ instead of exactly $0$ for a constant $10^9+0.5$ in my measurements), while the rearranged form adds exactly $0$ when $x = m$ and keeps constants exactly constant. Accuracy on non-constant data was the same in both.

The paper defines only the corrected sum of squares $S$; dividing by $n-1$ to get the sample variance is the standard step added on top. The same recursion also holds for sums of products (his Formula II, the basis of running covariance) and higher powers (Formula III); this note and the code cover only squares ($r=2$).

## Example

**Hand-worked** on the data $[2, 4, 4, 4, 5, 5, 7, 9]$:

|step|x|n|m after|S after|
|---|---|---|---|---|
|1|2|1|2.0|0.0|
|2|4|2|3.0|2.0|
|3|4|3|3.3333|2.6667|
|4|4|4|3.5|3.0|
|5|5|5|3.8|4.8|
|6|5|6|4.0|6.0|
|7|7|7|4.4286|13.7143|
|8|9|8|5.0|32.0|

Check from the definition: mean $= 40/8 = 5$; squared deviations $9,1,1,1,0,0,4,16$ sum to $32$; variance $= 32/7 \approx 4.5714$; standard deviation $= \sqrt{32/7} \approx 2.1381$.

|quantity|by hand|`welford()`|
|---|---|---|
|count|8|8|
|mean|5|5.0|
|sample variance|32/7 = 4.5714|4.571428571428571|
|sample std. dev.|2.1381|2.138089935299395|

**Numerical stability.** Data $= 10^9 + [4, 7, 13, 16]$ has true variance exactly $30$.

|method|result|
|---|---|
|naive $\overline{x^2} - \bar{x}^2$|**0.0**|
|Welford|30.0|
|numpy (two-pass)|30.0|

The naive formula squares numbers near $10^{18}$, where float64 spacing is about 100, so the answer is lost. Welford only forms small differences. A harder case, 2000 values of $10^9 + \text{N}(0,1)$, compared with exact rational arithmetic: relative error naive $\approx 128$, Welford $\approx 3\times10^{-8}$, numpy two-pass $\approx 2\times10^{-16}$. Welford's note says that at no stage are significant figures lost; the measured $3\times10^{-8}$ shows that in floating point this should be read as "far fewer than the naive formula", not "none". So Welford is far better than the naive formula, but when the mean is huge compared with the spread, a two-pass method is still more accurate; Welford's advantage is one pass and no stored data.

**Reference check tolerance** (relative error against `numpy.var(..., ddof=1)`): $10^{-10}$ for ordinary data (summation error is bounded by about $n\varepsilon$, $\varepsilon = 2.2\times10^{-16}$, so about $2\times10^{-11}$ for $n = 10^5$); $10^{-6}$ for the stress data (error grows like $\varepsilon,\kappa$ with $\kappa = |\text{mean}|/\text{std} = 10^9$, about $2\times10^{-7}$).

## Common Mistakes

- Dropping the $(n-1)/n$ factor of Formula I (adding $\delta^2$ instead), or measuring $\delta$ from the **new** mean instead of $m_{n-1}$. The sum of squares is then wrong.
- Dividing by $n$ instead of $n-1$ for a _sample_ variance (and forgetting numpy needs `ddof=1`).
- Using `mean(x**2) - mean(x)**2` on data with a large offset.
- Treating `NaN` as an ordinary number: one `NaN` poisons every later value. The implementation drops missing values and reports how many.
- Calling a single value's variance 0: it is undefined, not zero. Constant data with at least two values really does have variance 0.

## Implementation

Pure Python, standard library only: `welford(data)` returns `(count, mean, variance, std, n_dropped)`.

- Missing values (`None`, `NaN`) are dropped and counted, never filled.
- Empty input, all values missing, or a single valid value raise `ValueError`.
- Non-numbers and `bool` raise `TypeError`; `±inf` raises `ValueError`.
- Constant data returns variance exactly `0.0`.

Code, tests, demo and numpy reference: [stateskol PR branch](https://github.com/Eskolx-labs/stateskol/pull/4) 
## Related Concepts

- [[Sampling Bias]]
- [[Population vs Sample]]

## References

- Welford, B. P. (1962). Note on a method for calculating corrected sums of squares and products. _Technometrics_, 4(3), 419-420. https://doi.org/10.1080/00401706.1962.10490022
- Box, G. E. P. and Hunter, J. S. (1959). Condensed calculations for evolutionary operation programs. _Technometrics_, 1(1), 77-95. (The earlier work Welford says his Formula I resembles; cited in the paper, pages as printed there.)
- Stateskol implementation (see Implementation above).
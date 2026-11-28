---
type: concept
cover: https://upload.wikimedia.org/wikipedia/commons/e/ec/Anscombe%27s_quartet_3.svg
status: draft
area: statistics
created: 2026-11-28
updated: 2026-11-28
author: Umer
tags:
  - numerical-methods
  - missing-data
publish-status: draft
---

# Association — Covariance, Correlation and Where Numbers Lie

![](https://upload.wikimedia.org/wikipedia/commons/e/ec/Anscombe%27s_quartet_3.svg)

*Anscombe's quartet: four datasets, one regression line, and a correlation coefficient that is the same to three decimals in three of them. Image: Schutz and Avenue, Wikimedia Commons.*

## Definition

Two variables measured on the **same units of the sample** are summarised by their co-movement.

**Sample covariance** over $n$ complete pairs, with $x$ and $y$ centred on their own means:

$$\operatorname{cov}(x, y) = \frac{1}{n - \text{ddof}} \sum_{i=1}^{n} (x_i - \bar{x})(y_i - \bar{y})$$

**Pearson correlation** divides that co-moment by the product of the two spreads:

$$r = \frac{\sum_i (x_i - \bar{x})(y_i - \bar{y})}{\sqrt{\sum_i (x_i - \bar{x})^2}\sqrt{\sum_i (y_i - \bar{y})^2}} = \frac{\operatorname{cov}(x,y)}{s_x s_y} \quad (\text{same ddof on all three})$$

Both are statements about **pairs**. A pair with a missing side is not a pair, and the value it would have taken is not recoverable from the other column. See [[Missing Data Mechanisms]] and [[Rubin (1976) — Inference and Missing Data]].

## Intuition

Covariance is an **area**: its unit is the unit of $x$ times the unit of $y$, so its size belongs to the measuring tape as much as to the data.

Correlation is a **ratio of areas**. By Cauchy–Schwarz, $|\textstyle\sum dx\,dy| \le \sqrt{\sum dx^2}\sqrt{\sum dy^2}$, so $r \in [-1, 1]$ is not a rule somebody imposed on the formula — it is the geometry of one rectangle fitting inside another. $r$ is what fraction of the largest covariance those two spreads could produce actually occurred.

That single reading gives three consequences for free:

- $r = \pm 1$ exactly when the deviations are proportional: $dy_i = k\,dx_i$ for every $i$ with $k \ne 0$. The data are collinear; no other pattern reaches $\pm 1$.
- $r$ is **undefined** when $s_x s_y = 0$. A constant column has no spread to normalise against, and the fraction has zero denominator. This is a refusal, not a small number.
- $r = 0$ says only that the deviations are **orthogonal**. Orthogonality is a statement about one function — the line — not about dependence.

## Why it matters

Act I ends by moving from one column to two. Everything after this — least squares in Act IV, the sampling distribution of $r$, a regression's residual analysis — consumes `covariance` and `pearson_r`. If the pairing rule is wrong, every one of them inherits the error, and the error is invisible: a mis-paired sample returns a clean number.

The brief's own framing is sharper: **a correlation of zero does not mean an absence of pattern, and a correlation of 0.99 does not mean a true relationship.** The only defence is the plot the correlation replaces, which is [[Tukey (1962) — The Future of Data Analysis]]'s whole argument.

## How it works

### 1. The sample is the pairs, not the columns

Given `x = [1, None, 3]` and `y = [10, 20, 30]`:

| rule | pairs kept | $n$ | covariance |
|---|---|---|---|
| **complete-case** (what stateskol does) | $(1,10), (3,30)$ | 2 | **20.0** |
| drop each column on its own | $(1,10), (3,20)$ | 2 | 10.0 |

Both return a number and both report $n = 2$. The second one pairs `3` with `20`, a combination nobody measured. The audit therefore counts **dropped pairs**, not dropped values, and a length mismatch between the two series is refused outright rather than resolved by `zip()` truncation. See [[The Data Contract]].

### 2. The sums come from one pass

Three separate passes over $x$ and $y$ — one for each mean, one for each spread, one for the co-moment — can disagree if the input is a stream, and the disagreement is undetectable afterwards. One accumulator cannot:

$$\bar{x}_k = \bar{x}_{k-1} + \frac{x_k - \bar{x}_{k-1}}{k}, \qquad C_k = C_{k-1} + \frac{k-1}{k}(x_k - \bar{x}_{k-1})(y_k - \bar{y}_{k-1})$$

This is the bivariate form of Welford's method, from [[Chan, Golub & LeVeque (1983) — Algorithms for Computing the Sample Variance]] (1983). See [[Welford Online Variance (Umer)]]. Dividing the final $C$ by $n - \text{ddof}$ gives the covariance; $m_{2,x}$ and $m_{2,y}$ from the same pass give the two variances, and $r$ needs nothing else.

### 3. Why not the textbook formula

$$\operatorname{cov}(x,y) \stackrel{?}{=} \frac{\sum x_iy_i - \sum x_i\sum y_i / n}{n-1}$$

Algebraically identical, numerically ruinous. On $x = [10^9{+}1, 10^9{+}2, 10^9{+}3, 10^9{+}4]$, $y = 2x$:

| algorithm | result | truth is $10/3 = 3.3333333333333335$ |
|---|---|---|
| naive $\sum xy$ form | **0.0** | annihilated |
| two-pass, centred | 3.3333333333333335 | recovered |
| one-pass CGL | 3.3333333333333335 | recovered |

$\operatorname{sum}(x_iy_i)$ is $4.00000003 \times 10^{18}$, where one double resolves to $512$ — 153 times the answer being hidden inside it.

The hand-worked state after every pair, which is what the tests pin:

| $k$ | $\bar{x}_k$ | $\bar{y}_k$ | $m_{2,x}$ | $m_{2,y}$ | $C_k$ |
|---|---|---|---|---|---|
| 1 | 1000000001.0 | 1000000002.0 | 0.0 | 0.0 | 0.0 |
| 2 | 1000000001.5 | 1000000003.0 | 0.5 | 2.0 | 1.0 |
| 3 | 1000000002.0 | 1000000004.0 | 2.0 | 8.0 | 4.0 |
| 4 | 1000000002.5 | 1000000005.0 | 5.0 | 20.0 | 10.0 |

Every step is a dyadic rational, so nothing rounds. That is also why this particular case cannot fail: any sane algorithm recovers it. The harder case is the same magnitude with ordinary values — `x = [3,1,4,1,5,9,2,6,5,3,5,8]`, `y = [2,7,1,8,2,8,1,8,2,8,4,5]`, both shifted by $10^9$, exact covariance $0.7575757575757576$:

| algorithm | result | absolute error |
|---|---|---|
| naive | 0.0 | 7.576e-01 |
| two-pass | 0.7575757575757559 | 1.665e-15 |
| one-pass | 0.7575757855601503 | 2.798e-08 |

The one-pass update's floor is **the ulp of its own running mean**, not of the covariance: a double near $10^9$ sits on a grid of step $2^{-23} \approx 1.192\text{e-}07$, the increment $\bar{x} \mathrel{+}= dx/k$ is smaller than that, so it is quantised and $dx = x - \bar{x}$ inherits the loss. CGL's own remedy is their algorithm S — subtract the first observation before accumulating — which restores one-ulp accuracy. Stating a tolerance without naming its unit hides this entirely.

## Example

Four things a correlation gets wrong, all reproducible in the standard library.

**Covariance is a unit, not a magnitude.** The same five hand-span and grip-strength measurements:

| units | covariance | $r$ |
|---|---|---|
| cm, N | 47.250000 | 0.9466462292 |
| m, kgf | 0.048182 | 0.9466462292 |

The covariance moved by a factor of 980.665 = 100 × 9.80665 — the conversion, not the data. $r$ did not move at all. That is the entire reason Pearson normalises: it is the only one of the two that can be compared across studies.

**$r = 0$ with a deterministic relationship.** Nine points, $x = -4 \dots 4$, $y = x^2$:

$$\operatorname{cov} = 0.0, \qquad r = 0.0 \quad \text{exactly}$$

Not approximately. Every $+x$ has a matching $-x$ with the same $y$, so the products cancel to zero, and the parabola is as deterministic as a relationship gets. A symmetric quadratic, a circle $x^2 + y^2 = 1$, and a sine all sit near $r = 0$ while being perfectly predictable.

**One point manufactures a correlation.** Same nine $x$, $y = |x|$ — a V, still with no linear component ($r = 2.9\text{e-}17$, and floating point gives that instead of an exact zero because $20/9$ is not representable). Add a single high-leverage observation at $(20, 20)$:

$$r = 0.90150$$

Ninety-one percent of the variance explained, by one point out of ten. Remove it and the "relationship" disappears; that point is not evidence of a trend, it *is* the trend. This is [[Anscombe's quartet]]'s fourth panel in miniature.

**Anscombe's quartet, actually measured.** All four datasets through one pass:

| dataset | $r$ | covariance | slope | intercept |
|---|---|---|---|---|
| I — linear | 0.816421 | 5.5010 | 0.50009 | 3.0001 |
| II — parabola | 0.816237 | 5.5000 | 0.50000 | 3.0009 |
| III — line with one outlier | 0.816287 | 5.4970 | 0.49973 | 3.0025 |
| IV — vertical cluster | 0.819083 | 5.5100 | 0.50091 | 2.9827 |

The week 4 brief states that all four share $r = 0.816$. Panels I–III do, to five decimals. Panel IV is **0.8191** — a single point at $x = 19$ moves $r$ in the third decimal, which is precisely the point of the fourth panel and is worth having straight before quoting it.

## Common Mistakes

- **Reading $r = 0$ as independence.** It is the absence of a *line*. Check what the pairs look like before saying what they are not.
- **Reading $r = 0.99$ as a validated model.** Check whether one row is doing it: drop the most extreme $x$ and recompute. If $r$ moves much, the sample said less than the number.
- **Comparing covariances across datasets.** The unit differs, so the magnitude is meaningless. Divide by $s_x s_y$ or don't say it.
- **Reporting $r$ for a constant column.** $s_x s_y = 0$ is not a small correlation. `pearson_r` must raise, and a package that returns `nan` or `0.0` invites the caller to average over it.
- **Dropping missing values per column.** See the table above: the sample changes and the reported $n$ does not notice.
- **`zip()`-ing two series of different length.** Silent truncation is a claim that the tail was never measured. Refuse and report both lengths.
- **The naive $\sum xy$ formula.** Timestamps, GPS coordinates and tick prices are routinely in the $10^{9}$–$10^{15}$ range, which is where this returns 0.0.
- **Trusting one printed digit of a failure.** `naive_covariance` of a nine-point tied pair returns **256.0** on CPython ≤ 3.11 and **0.0** from 3.12, because `sum()` gained Neumaier compensation for floats. Both are wrong by at least the answer — the truth is $13/3$ and the formula can only produce a multiple of 128 there — but only the *bound* survives an interpreter upgrade. A numerical claim belongs in ulps of a named quantity, never in a residue.

## Implementation

Pure standard library, one pass per pair, as shipped in stateskol:

```python
class BivariateState:
    """Running bivariate moments, Chan-Golub-LeVeque (1983)."""

    def __init__(self):
        self.n = 0
        self.mean_x = self.mean_y = 0.0
        self.m2_x = self.m2_y = self.co_moment = 0.0

    def add(self, x, y):
        self.n += 1
        dx = x - self.mean_x
        dy = y - self.mean_y          # both deltas against the PREVIOUS means
        self.mean_x += dx / self.n
        self.mean_y += dy / self.n
        self.m2_x += dx * (x - self.mean_x)
        self.m2_y += dy * (y - self.mean_y)
        # C_k = C_{k-1} + ((k-1)/k) * (x_k - xbar_{k-1}) * (y_k - ybar_{k-1})
        self.co_moment += (self.n - 1) / self.n * dx * dy

    def covariance(self, ddof=1):
        return self.co_moment / (self.n - ddof)

    def correlation(self):
        return self.co_moment / (self.m2_x * self.m2_y) ** 0.5


x = [1e9 + 1, 1e9 + 2, 1e9 + 3, 1e9 + 4]
y = [1e9 + 2, 1e9 + 4, 1e9 + 6, 1e9 + 8]
s = BivariateState()
for a, b in zip(x, y):
    s.add(a, b)
print(s.covariance(), s.correlation())   # 3.3333333333333335 1.0
```

Run it: the state after each `add` is exactly the table in *How it works*, and the result agrees with `stateskol.descriptive.BivariateState` field for field.

Note the order inside `add`. Both deltas are taken against the **previous** means; the means advance after that; and each `m2` term multiplies the old delta by the new one — $dx_{\text{old}} \cdot dx_{\text{new}}$, never $dx_{\text{new}}^2$. Writing `dy` after the mean update gives 2.3333333333333335 and $r = 0.837$ for this pair, which I did on the first pass at this code block, so the sequence is the bug and not a footnote.

The shipped version additionally validates every input through the contract, counts dropped pairs, refuses mismatched lengths, and raises on an undefined divisor rather than returning `inf`. See **stateskol PR #28** for the code, the 48 tests, and the tolerance table; `examples/numerics_demo.py` there runs the tables in this note in a clean environment with nothing installed.

## Related Concepts

- [[Population vs Sample]] — why `ddof` is 1 for a sample and what changes at 0
- [[Sampling Bias]] — pairing preserves the sample only if the gaps are unrelated to the values
- [[The Data Contract]] — what arrives as a measurement, and what is refused
- [[Missing Data Mechanisms]] — MCAR, MAR, MNAR, and why complete-case needs the mechanism stated
- [[Center and Spread]] — $s_x$ and $s_y$ are the denominator of $r$
- [[Welford Online Variance (Umer)]] — the univariate form of the same update
- [[Histogram Binning and Density Estimation]] — the paired marginal view, and the sibling week 4 note
- [[Shape Estimators: Skewness and Kurtosis]] — third and fourth moments of one column
- [[Tukey (1962) — The Future of Data Analysis]] — the argument for plotting before summarising
- [[Rubin (1976) — Inference and Missing Data]]
- [[Ross — Introduction to Probability and Statistics]] — §2.6, the paired specification this note implements

## References

- Anscombe, F. J. (1973). "Graphs in Statistical Analysis". *The American Statistician* 27(3): 14–15.
- Chan, T. F., Golub, G. H., & LeVeque, R. J. (1983). "Algorithms for Computing the Sample Variance: Analysis and Recommendations". *The American Statistician* 37(3): 242–247.
- Fisher, R. A. (1921). "On the 'probable error' of a coefficient of correlation deduced from a small sample". *Metron* 1: 3–32.
- Freedman, D., & Diaconis, P. (1981). "On the Histogram as a Density Estimator: Two Views". *Probability Theory and Related Fields* 57(4): 455–476.
- Ross, S. *Introduction to Probability and Statistics*, 6th ed., §2.4–2.6.
- Rubin, D. B. (1976). "Inference and Missing Data". *Biometrika* 63(3): 581–592.
- Tukey, J. W. (1962). "The Future of Data Analysis". *Annals of Mathematical Statistics* 33(1): 1–67.
- Code: [stateskol PR #28](https://github.com/Eskolx-labs/stateskol/pull/28) — Numerics lane, `bivariate_online_update`.
- Cover image: [File:Anscombe's quartet 3.svg](https://commons.wikimedia.org/wiki/File:Anscombe%27s_quartet_3.svg), Schutz and Avenue, Wikimedia Commons.

> [!note] Diagram still owed
> The brief asks for a tldraw scene of the binning sensitivity and the geometry of correlation failure. A `.tldr` scene has to be authored in the vault with the tldraw plugin and verified to render, so it is not faked here: the scene goes in `90 Attachments/animations/` and gets embedded above *Example*. This note stays `publish-status: draft` until it is in.

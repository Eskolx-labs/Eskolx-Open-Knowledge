---
type: concept
cover: https://thumb.wikimedia.org/wikipedia/commons/thumb/6/64/Variance_visualisation.svg/960px-Variance_visualisation.svg.png
status: draft
area: statistics
created: 2026-10-05
updated: 2026-10-06
author: Hanna Desalegn
tags:
  - statistics
  - numerical-methods
publish-status: draft
---

# Welford Online Variance (Hanna Desalegn)

![Variance visualisation|157](https://thumb.wikimedia.org/wikipedia/commons/thumb/6/64/Variance_visualisation.svg/960px-Variance_visualisation.svg.png)

**Code:** [Eskolx-labs/stateskol PR #6](https://github.com/Eskolx-labs/stateskol/pull/6) · **Paper:** [Welford (1962)](https://doi.org/10.1080/00401706.1962.10490022) · **Diagram:** [[welford (Hanna Desalegn).tldr]]

## Definition

Welford's method is a one-pass way to compute the mean and the **corrected sum of squares** of a set of values, without storing the values and without subtracting two large, nearly equal sums.

For the first $n$ values Welford (1962) defines the running mean and the corrected sum of squares:

$$
m_n = \frac{1}{n}\sum_{i=1}^{n} x_i,
\qquad
S_n = \sum_{i=1}^{n} (x_i - m_n)^2
$$

The paper stops at $S_n$. The **sample** variance and standard deviation follow from it (see [[Population vs Sample]] for why we divide by $n-1$):

$$
\boxed{s^2 = \frac{S_n}{n-1}}, \qquad s = \sqrt{s^2}
$$

## Intuition

Imagine the current mean is $m$. When a new value $x$ arrives, measure how far it is from the mean of **all the values before it**. That single number, $x - m_{n-1}$, is enough to update both the mean and $S$. The mean moves toward $x$ by a fraction $1/n$ of that distance, and $S$ grows by a fraction $\tfrac{n-1}{n}$ of its square.

Every quantity the update touches is a *deviation*, so it is small when the data is close together, even if the data itself is huge (like values near $10^9$). That is why far fewer significant figures are lost.

## Why it matters

The textbook shortcut is

$$
s^2 = \frac{\sum x_i^2 - \left(\sum x_i\right)^2 / n}{n-1}
$$

Welford's paper opens with the problem: the "crude" sum of squares and the correction factor are both huge, and subtracting them throws away significant figures. The paper lists two older fixes, both with a cost:

1. shift the data to an origin near the mean, which needs a guess of the mean first;
2. compute the mean, then sum squared deviations, which needs **two passes** over the data (store it, or read it twice).

Welford's method needs neither: each value is used once, in one pass, and need not be stored. This makes it the right tool for streams and for data too large to keep in memory.

## How it works

### The identities from the paper

Welford (1962) proves these for $n = 1, 2, \dots$:

$$
\text{identity (1):}\quad m_n = \frac{n-1}{n}\, m_{n-1} + \frac{x_n}{n}
$$

$$
\text{identity (2):}\quad x_i - m_n = (x_i - m_{n-1}) - \frac{1}{n}(x_n - m_{n-1}) \quad (i < n)
$$

$$
\text{identity (3):}\quad x_n - m_n = \frac{n-1}{n}\,(x_n - m_{n-1})
$$

### Formula I

Substituting (2) and (3) into the definition of $S_n$, expanding the squares, and using $\sum_{i<n}(x_i - m_{n-1}) = 0$ gives the paper's **Formula I**:

$$
\boxed{S_n = S_{n-1} + \frac{n-1}{n}\,(x_n - m_{n-1})^2}
$$

The only new information in each step is $d = x_n - m_{n-1}$, the deviation of the new value from the mean of the values **before** it.

### The update, in the order the code runs it

Start with $n = 0,\ m = 0,\ S = 0$. For each new value $x$:

1. count it: $n \leftarrow n + 1$
2. deviation from the old mean: $d = x - m_{n-1}$
3. Formula I: $S_n = S_{n-1} + \frac{n-1}{n} d^2$
4. new mean: $m_n = m_{n-1} + \frac{d}{n}$

Step 4 is identity (1) written differently: $\frac{n-1}{n}m_{n-1} + \frac{x_n}{n} = m_{n-1} + \frac{x_n - m_{n-1}}{n}$. Both are equal on paper. I use the second because it keeps constant data *exactly* constant in floating point: once $m = x$, $d$ is exactly $0$, so $S$ stays exactly $0.0$. The paper's form computes $\frac{n-1}{n}m$ and $\frac{x}{n}$ separately and can be off in the last bit.

After the last value: $s^2 = S/(n-1)$ and $s = \sqrt{s^2}$.

![[welford (Hanna Desalegn).tldr]]

The diagram shows one pass of the loop: count, deviation from the old mean, Formula I, new mean. Missing values branch off before the count, invalid values stop the run, and the variance is formed only after the last value.

### The same update written as $\delta \cdot \delta_2$

Many references (and my first version) write step 3 as $S \leftarrow S + \delta\,\delta_2$ with $\delta = x_n - m_{n-1}$ and $\delta_2 = x_n - m_n$. This is Formula I in another form. By identity (3), $\delta_2 = \frac{n-1}{n}\delta$, so

$$
\delta\,\delta_2 = \frac{n-1}{n}\,\delta^2 = \frac{n-1}{n}(x_n - m_{n-1})^2
$$

which is exactly the term Formula I adds. The test `test_delta_times_delta2_equals_formula_I` checks this in exact fractions, and `test_code_agrees_with_paper_formulas` runs the paper's formulas directly and compares them with the code.

## Example

### Hand-worked: $[2, 4, 6, 8]$ with Formula I

| step | $x_n$ | $n$ | $d = x_n - m_{n-1}$ | $\frac{n-1}{n}d^2$ | $S_n$ | $m_n = m_{n-1} + d/n$ |
|---|---|---|---|---|---|---|
| start | | 0 | | | 0 | 0 |
| 1 | 2 | 1 | 2 | $0 \cdot 4 = 0$ | 0 | 2 |
| 2 | 4 | 2 | 2 | $\tfrac12 \cdot 4 = 2$ | 2 | 3 |
| 3 | 6 | 3 | 3 | $\tfrac23 \cdot 9 = 6$ | 8 | 4 |
| 4 | 8 | 4 | 4 | $\tfrac34 \cdot 16 = 12$ | 20 | 5 |

Check against the definition: deviations from 5 are $-3, -1, 1, 3$, so $S = 9 + 1 + 1 + 9 = 20$. ✓

$$
s^2 = \frac{20}{4-1} = \frac{20}{3} \approx 6.6667, \qquad s = \sqrt{20/3} \approx 2.5820
$$

### Second hand-worked set: $[3, 7, 8, 10]$

| step | $x_n$ | $d$ | $\frac{n-1}{n}d^2$ | $S_n$ | $m_n$ |
|---|---|---|---|---|---|
| 1 | 3 | 3 | 0 | 0 | 3 |
| 2 | 7 | 4 | $\tfrac12 \cdot 16 = 8$ | 8 | 5 |
| 3 | 8 | 3 | $\tfrac23 \cdot 9 = 6$ | 14 | 6 |
| 4 | 10 | 4 | $\tfrac34 \cdot 16 = 12$ | 26 | 7 |

Check: deviations from 7 are $-4, 0, 1, 3$, so $S = 16 + 0 + 1 + 9 = 26$ ✓, and $s^2 = 26/3 \approx 8.6667$.

### Hand vs code

Output of `welford()` in [stateskol PR #6](https://github.com/Eskolx-labs/stateskol/pull/6):

| dataset | quantity | by hand | code |
|---|---|---|---|
| $[2,4,6,8]$ | count | 4 | 4 |
| | mean | 5 | 5.0 |
| | variance | $20/3 \approx 6.6667$ | 6.666666666666667 |
| | std | $\sqrt{20/3} \approx 2.5820$ | 2.581988897471611 |
| | dropped | 0 | 0 |
| $[3,7,8,10]$ | mean | 7 | 7.0 |
| | variance | $26/3 \approx 8.6667$ | 8.666666666666666 |
| $[2,4,\text{None},6,8,\text{NaN}]$ | count / dropped | 4 / 2 | 4 / 2 |
| | variance | $20/3$ (same as without the gaps) | 6.666666666666667 |

The last row shows the missing-value rule: the gaps are skipped, not filled, so the answer equals the one for $[2,4,6,8]$.

## Boundary cases and decisions

| input | result | why |
|---|---|---|
| empty `[]`, or only `None`/NaN | count 0; mean, variance, std = NaN | nothing to average |
| one value `[7]` | count 1, mean 7.0; variance, std = NaN | $n - 1 = 0$, sample variance undefined |
| constant `[5, 5, 5]` | variance = std = 0.0 exactly | every $d$ after the first is exactly 0 |
| `None`, NaN (incl. `numpy.nan`) | dropped, counted in `dropped` | missing, never filled |
| `bool`, `str`, complex, `Decimal`, list | `TypeError`, with the index of the bad value | not real-number data |
| ±inf, integer too big for a float (`10**400`) | `ValueError`, with the index of the bad value | cannot be a finite float64 |
| `data` is a `str`/`bytes`, a dict, or not iterable | `TypeError` | text/bytes are not numbers; a dict would silently give its keys |
| numpy arrays, numpy scalars, `Fraction` | accepted, converted with `float()` | they are real numbers |

**Why NaN and not an exception for $n < 2$?** The mean is still defined at $n = 1$, and a streaming caller with a short window should get a result, not a crash. The cost: a caller who ignores `count` can carry a NaN variance forward. The docstring states this so the caller knows to check `count`.

## Numerical stability

### Exact large-offset case

Data $10^9 + [4, 7, 13, 16]$. By hand: mean $10^9 + 10$, deviations $-6, -3, 3, 6$, $S = 90$, $s^2 = 30$.

| offset | naive formula | Welford | numpy |
|---|---|---|---|
| 0 | 30 | 30 | 30 |
| $10^4$ | 30 | 30 | 30 |
| $10^6$ | 30 | 30 | 30 |
| $10^8$ | 29.333… | 30 | 30 |
| $10^9$ | **0** | 30 | 30 |

The naive formula subtracts two numbers near $4 \times 10^{18}$. A float64 carries about 16 significant digits, so at that size the gap between neighbouring floats is 512, much bigger than the true $S = 90$. The answer is lost entirely. Welford only ever squares deviations like 6 and 3, so it stays exact.

### Noisy stress case

That case is easy for Welford because every value is an exact integer. A harder one: 2000 values $10^9 + \mathcal{N}(0, 1)$ (seed 1), where every value is rounded. Ground truth is exact rational arithmetic (`fractions.Fraction`):

| method | relative error vs exact |
|---|---|
| naive formula | $1.3 \times 10^{2}$ (off by more than 100×) |
| **Welford** | $3.0 \times 10^{-8}$ |
| numpy `var(ddof=1)` (two-pass) | $2.2 \times 10^{-16}$ |

**What this shows:** Welford is not magic. Near $10^9$ a float64 can only store steps of about $1.2\times10^{-7}$ (`math.ulp(1e9)`). The running mean sits near $10^9$, so every deviation $d = x - m$ carries an error of about $10^{-7}$ compared to a spread of 1. The measured error, $3\times10^{-8}$, matches that. Welford keeps about 8 digits where the naive formula keeps none. numpy keeps more, but only because it reads the data twice and subtracts one fixed mean. Welford's advantage is one pass and no storage.

## Reference comparison against numpy

`examples/welford_reference (Hanna Desalegn).py` compares mean, variance and std with `numpy.mean`, `numpy.var(ddof=1)` and `numpy.std(ddof=1)`, and exits with an error if any tolerance is not met.

| data | relative-error tolerance | why |
|---|---|---|
| normal: both hand sets, gauss(0,1), gauss(50,10) with $n = 10^5$, uniform, exponential | $10^{-10}$ | measured $\le 7\times10^{-15}$. A real bug is much bigger: dividing by $n$ instead of $n-1$ changes the variance by about $1/n$, which is $10^{-5}$ even at $n = 10^5$. |
| hard: $10^9 + \mathcal{N}(0,1)$ | $10^{-6}$ | the step size near $10^9$ is $1.2\times10^{-7}$, measured $3\times10^{-8}$, so $10^{-6}$ gives a safe margin. |

The mean keeps the $10^{-10}$ tolerance even on hard data, because its relative error stays tiny.

My first version used one tolerance, $10^{-12}$, for everything. It only passed because its stress data were exact integers. On the noisy stress data a correct implementation fails $10^{-12}$, so the tolerance has to follow the data.

## Common Mistakes

1. **Dividing by $n$ instead of $n-1$.** That is the population variance. This implementation is always the sample variance (`ddof=1`).
2. **Using the naive sum-of-squares formula.** It loses every digit on large-offset data (table above).
3. **Using the new mean in Formula I.** Formula I needs $x_n - m_{n-1}$, the deviation from the mean *before* the update. Updating the mean first and then squaring $x_n - m_n$ gives a wrong $S$. (The $\delta\delta_2$ form uses one of each, which is why it is still right.)
4. **Treating missing values as zero.** Zero is a real value. Missing values are skipped and counted.
5. **Silently accepting bad input.** `True`, `"2"` or `b"12"` must not become numbers. The code stops at the first bad value and gives its index.
6. **One tolerance for every dataset.** How many digits a correct method can keep depends on the data, so the tolerance must too.

## Implementation

The code is in [stateskol PR #6](https://github.com/Eskolx-labs/stateskol/pull/6), standard library only:

- `src/stateskol/welford (Hanna Desalegn).py`: `welford(data)`. The update is one marked block, from `# Welford update, Formula I from Welford (1962)` to `# end of Welford update`.
- `tests/test_welford (Hanna Desalegn).py`: both hand-worked sets, the paper's formulas run directly, identity (3) in exact fractions, every boundary case, the index of the first bad value, and both stability cases against exact arithmetic.
- `examples/welford_demo (Hanna Desalegn).py`: runs with only the package installed (no numpy).
- `examples/welford_reference (Hanna Desalegn).py`: the numpy comparison above.

The core loop:

```python
n += 1
d = x - m                  # distance from the mean of the values before x
s += (n - 1) / n * d * d   # Formula I
m += d / n                 # new mean, same as (n-1)/n * m + x/n in the paper
```

### Running the example in a clean environment

```bash
python -m venv .venv && source .venv/bin/activate
pip install -e .
python "examples/welford_demo (Hanna Desalegn).py"
```

## Related Concepts

- [[Population vs Sample]]: why the sample variance divides by $n-1$
- Sibling Welford notes by other applicants (open vault PRs): [#34](https://github.com/Eskolx-labs/Eskolx-Open-Knowledge/pull/34), [#35](https://github.com/Eskolx-labs/Eskolx-Open-Knowledge/pull/35), [#36](https://github.com/Eskolx-labs/Eskolx-Open-Knowledge/pull/36), [#39](https://github.com/Eskolx-labs/Eskolx-Open-Knowledge/pull/39)

## References

- Welford, B. P. (1962). *Note on a Method for Calculating Corrected Sums of Squares and Products*. Technometrics, 4(3), 419–420. [doi:10.1080/00401706.1962.10490022](https://doi.org/10.1080/00401706.1962.10490022)
- Yao, S., Zhao, J., Yu, D., Du, N., Shafran, I., Narasimhan, K., & Cao, Y. (2022). *ReAct: Synergizing Reasoning and Acting in Language Models*. [arXiv:2210.03629](https://arxiv.org/abs/2210.03629)
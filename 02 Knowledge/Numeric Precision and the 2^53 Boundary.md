---
type: concept
cover: https://upload.wikimedia.org/wikipedia/commons/a/a9/Float_example.svg
status: draft
area: statistics
created: 2026-11-18
updated: 2026-11-18
author: Hanna Desalegn
tags: []
publish-status: draft
---

![IEEE 754 float layout](https://upload.wikimedia.org/wikipedia/commons/a/a9/Float_example.svg)

# Numeric Precision and the 2^53 Boundary

## Definition

A Python `float` is an IEEE 754 double: 1 sign bit, 11 exponent bits and a 53-bit significand. It can hold every integer from $-2^{53}$ to $2^{53}$ exactly. Past that, the gap between neighbouring floats is 2 or more, so some integers have no float of their own. The largest finite double is about $1.797 \times 10^{308}$. `nan` and `inf` are special values, not numbers you can measure.

## Intuition

Think of floats as marks on a ruler whose marks get further apart as the numbers grow. Near 1 the marks are $2.2 \times 10^{-16}$ apart. At $2^{53}$ they are 2 apart, so $2^{53} + 1$ falls between two marks and gets pushed onto $2^{53}$. Two different measurements become the same number, and nothing warns you.

## Why it matters

[[Ross — Introduction to Probability and Statistics|Ross, Ch. 1]] treats data as recorded measurements of a population. If the computer stores a different number than the one recorded, every summary afterwards is about data nobody collected. [[Tukey (1962) — The Future of Data Analysis|Tukey (1962)]] puts computing inside the method of data analysis, so the limits of the machine are part of the analysis, not a detail to ignore. [[Box (1976) — Science and Statistics|Box (1976)]] says a model is an approximation used for a purpose, and the check belongs inside the method. A float is that kind of model of a real number: useful, wrong at the edges, and in need of a check where it can fail.

## How it works

![[numerics (Hanna Desalegn).tldr]]

*Diagram: the path of one raw value through the stateskol v0.1 contract, with the three places floats break shown in the side notes. It is a plain `.tldr` file with default tldraw styles and no local settings.*

The contract (see [[The Data Contract]]) does three numeric things before any summary runs:

1. **Missing first.** `None` and `nan` leave through the missing-value policy. `nan` has no order: `min([nan, 3, 1])` is `nan` but `min([3, nan, 1])` is `1`, so leaving it in makes the answer depend on input order. Dropping it is a claim about the data, unbiased only when values are missing completely at random ([[Rubin (1976) — Inference and Missing Data|Rubin, 1976]]).
2. **Refuse ints that would round.** An `int` with $|n| > 2^{53}$ is refused, because `float(n)` would change it silently. The rule is about converting ints. A `float` such as `1e16` or `1e308` is already a float, so nothing is converted and it is accepted.
3. **Refuse infinite values.** `inf` is a data error, not a large measurement.

After the contract, one more check is needed in the arithmetic itself. Two finite floats can have an infinite difference, so `data_range` should use `checked_difference(hi, lo)`, which raises `OverflowError` instead of returning `inf`.

## Example

**The 2^53 boundary, by hand.** $2^{53} = 9{,}007{,}199{,}254{,}740{,}992$.

| x | gap to the next float | every integer fits? |
|---|---|---|
| 1 | $2^{-52} \approx 2.2 \times 10^{-16}$ | yes |
| $2^{52}$ | 1 | yes |
| $2^{53}$ | 2 | no, $2^{53}+1$ has no float |
| $10^{16}$ | 2 | no, so `1e16 + 1 == 1e16` |
| $10^{308}$ | $\approx 2 \times 10^{292}$ | no |

`float(2**53 + 1) == float(2**53)` is `True`, so `2**53 + 1` is refused and `2**53` is accepted.

**The stability case: range overflow.** Data: `[-1e308, 0.5, 1e308]`. All three are finite and accepted.

- min = $-10^{308}$, max = $10^{308}$
- true range = $2 \times 10^{308}$, which is bigger than the largest double ($1.797 \times 10^{308}$)
- plain `max - min` gives `inf`, with no error
- `checked_difference(1e308, -1e308)` raises `OverflowError`

A finite data set produced an infinite summary. In an unattended pipeline that `inf` would flow into the next step as if it were a number.

## Common Mistakes

- Applying the 2^53 rule to floats. It exists because converting an int can round. Refusing `1e16` as a float rejects valid data.
- Thinking the 2^53 bound is exact. $2^{60}$ is exactly representable but still refused. The bound is conservative on purpose: one simple rule is easier to state and test.
- Checking `type(x) in (int, float)`. That refuses `numpy.float64`, which subclasses `float` and converts exactly. Checking `isinstance` accepts it, while `numpy.int64` and `numpy.float32` stay refused because they are not `int` or `float`.
- Leaving `nan` in before `min` or `max`. The answer then depends on the order of the input.
- Trusting `max - min` on extreme values. Finite inputs do not guarantee a finite difference.

## Implementation

Code: `checked_difference` and `float_spacing` in the numerics block of `src/stateskol/descriptive.py`, with tests in `tests/test_descriptive.py` (stateskol, branch `week-02/hanna/numerics`).

```python
import math

def checked_difference(hi, lo):
    diff = float(hi) - float(lo)
    if math.isinf(diff):
        raise OverflowError("range overflows a float")
    return diff

print(float(2**53 + 1) == float(2**53))  # True
print(math.ulp(2.0**53))  # 2.0
print(checked_difference(9.0, 2.0))  # 7.0
try:
    checked_difference(1e308, -1e308)
except OverflowError as e:
    print("refused:", e)
```

## Related Concepts

- [[The Data Contract]]: the accept, refuse and missing rules this note explains from the numeric side
- [[Population vs Sample]]
- [[Sampling Bias]]
- [[Ross — Introduction to Probability and Statistics|Ross, Ch. 1]]
- [[Tukey (1962) — The Future of Data Analysis|Tukey (1962)]]
- [[Rubin (1976) — Inference and Missing Data|Rubin (1976)]]
- [[Box (1976) — Science and Statistics|Box (1976)]]

## References

- IEEE (2019). *IEEE Standard for Floating-Point Arithmetic* (IEEE 754-2019).
- Goldberg, D. (1991). What every computer scientist should know about floating-point arithmetic. *ACM Computing Surveys*, 23(1), 5-48.
- Ross, S. M. (2020). *Introduction to Probability and Statistics for Engineers and Scientists*, 6th ed., Chapter 1.
- Tukey, J. W. (1962). The future of data analysis. *Annals of Mathematical Statistics*, 33(1), 1-67.
- Rubin, D. B. (1976). Inference and missing data. *Biometrika*, 63(3), 581-592.
- Box, G. E. P. (1976). Science and statistics. *Journal of the American Statistical Association*, 71(356), 791-799.

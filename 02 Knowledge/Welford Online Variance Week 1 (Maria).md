---
type: concept
cover:
status: draft
area:
created: 2026-11-07
updated: 2026-11-07
author:
tags: []
publish-status: draft
---



# Welford Online Variance Week 1 (Maria)

## Definition
variance_welford(data) computes the sample variance in a single pass, using Welford's method. It keeps a running mean and a running sum of squared deviations (m2), and updates both as each value arrives. At the end the variance is m2 / (n - 1).
![[welford-week1(Maria)]]

## Intuition
Instead of storing all the numbers and going through them twice, you walk through them once. Each new number nudges the running mean a little and adds a small piece to the running spread. You only ever hold three numbers: the count, the mean and m2.

## Why it matters
There is a shortcut formula for variance: (sum of squares - n x mean squared) / (n - 1). It subtracts two huge, nearly equal numbers when the mean is large, and a float only holds about 16 significant digits, so the difference is lost (catastrophic cancellation). On [1e9+1, 1e9+2, 1e9+3] the true variance is 1.0, but the shortcut returns 0.0, silently. Welford's method returns 1.0, and it also works on data that streams in and cannot be stored.

## How it works
Start with n = 0, mean = 0, m2 = 0. For each new value x:
1. n = n + 1
2. delta = x - mean
3. mean = mean + delta / n
4. m2 = m2 + delta x (x - new mean)   (this uses the updated mean)

At the end: variance = m2 / (n - 1). Fewer than 2 values raises ValueError.

## Example
Data: [2, 4, 6]

x = 2: n = 1, delta = 2, mean = 2, m2 = 0
x = 4: n = 2, delta = 2, mean = 3, m2 = 2
x = 6: n = 3, delta = 3, mean = 4, m2 = 8

Variance = 8 / (3 - 1) = 4, the same as the two-pass method.

Large-mean test: [1e9+1, 1e9+2, 1e9+3]
- shortcut formula: 0.0 (wrong)
- variance_welford: 1.0 (correct)

## Common Mistakes
- Using the old mean instead of the new mean in the m2 update. Step 4 must use the mean after step 3.
- Dividing by n instead of n - 1.
- Using the shortcut formula on data with a large mean.
- Forgetting that fewer than 2 values is an error.

## Implementation
```python
def variance_welford(data):
    values = _validate(data)
    if len(values) < 2:
        raise ValueError("sample variance needs at least 2 values")
    n = 0
    mean_ = 0.0
    m2 = 0.0
    for x in values:
        n += 1
        delta = x - mean_
        mean_ += delta / n
        m2 += delta * (x - mean_)
    return m2 / (n - 1)
```

Tests: 4.0 on [2, 4, 6], 1.0 on the large-mean data, and agreement with variance() on [70, 85, 85, 90, 100]. Reference comparison: np.var with ddof=1 on the large-mean data, tolerance 1e-12.

## Related Concepts

- [[Sample Variance (Maria)]]
- [[Sample Standard Deviation (Maria)]]
- [[Welford Online Variance (Maria)]]
- [[Input Contract (Maria)]]

## References
- Welford, B. P. (1962), Note on a method for calculating corrected sums of squares and products, Technometrics. Confirm the title against the paper itself.
- Ross, S. M., Introduction to Probability and Statistics for Engineers and Scientists, 6th ed., chapter 2 (sample variance). Check the section number in your copy.
- NumPy documentation: numpy.var (the ddof parameter).

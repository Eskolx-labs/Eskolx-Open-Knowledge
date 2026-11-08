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



# Sample Standard Deviation (Maria)

## Definition
std(data) is the sample standard deviation: the square root of the sample variance. It measures spread in the same units as the data.
![[std(Maria)]]
## Intuition
Variance is measured in squared units. If the data is in points, the variance is in points squared, which is hard to picture. Taking the square root brings it back to points, so the number reads as a typical distance from the mean.

## Why it matters
Standard deviation is the most common way to report spread. It is easy to compare directly with the mean and with individual values. Because it is built on variance, it inherits the same rules: the data is validated first, and at least 2 values are needed.

## How it works
1. Call variance(data). This validates the data and divides by n - 1.
2. Return the square root of the result.

Fewer than 2 values raises ValueError, and constant data gives exactly 0.

## Example
Data: [2, 4, 6]
Variance = 4, so std = 2.

Data: [70, 85, 85, 90, 100]
Variance = 117.5, so std = square root of 117.5, about 10.84.

NumPy check: np.std(data, ddof=1) gives the same value. Without ddof=1, NumPy divides by n and gives a smaller number.

## Common Mistakes
- Forgetting ddof=1 when comparing with NumPy, which gives the population standard deviation instead of the sample one.
- Confusing standard deviation with variance. One is the square root of the other.
- Calling it on a single value, which raises ValueError.
- Expecting a negative result. A square root of a variance is never negative.

## Implementation
```python
def std(data):
    return math.sqrt(variance(data))
```

Tests: 2.0 on [2, 4, 6], 0 for constant data, and an error for a single value. Reference comparison: np.std(data, ddof=1), tolerance 1e-12.

## Related Concepts

- [[Sample Variance (Maria)]]
- [[Welford Online Variance Week 1 (Maria)]]
- [[IQR (Maria)]]
- [[Input Contract (Maria)]]

## References
- Ross, S. M., Introduction to Probability and Statistics for Engineers and Scientists, 6th ed., chapter 2 (sample variance and standard deviation). Check the section number in your copy.
- NumPy documentation: numpy.std (the ddof parameter).

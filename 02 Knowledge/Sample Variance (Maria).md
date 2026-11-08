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



# Sample Variance(Maria)

## Definition
variance(data) is the sample variance: the average squared distance of the values from their mean, dividing by n - 1 instead of n. It uses the two-pass method: first the mean, then the squared deviations.
![[variance(Maria)]]
## Intuition
Variance answers: on average, how far is each number from the middle? Distances are squared so that values below the mean and values above it cannot cancel each other out.

## Why it matters
Variance is the main measure of spread. Standard deviation is its square root, and many other statistics build on it. Dividing by n - 1 (Bessel's correction) matters because the data is a sample: dividing by n would underestimate the spread of the whole population.

## How it works
1. Validate the data with the input contract.
2. Fewer than 2 values raises ValueError, because n - 1 would be 0.
3. Compute the mean.
4. Subtract the mean from each value and square the result.
5. Add the squares and divide by n - 1.

Subtracting the mean before squaring keeps the numbers small, which is why this version stays accurate even when the mean is huge.

## Example
Data: [2, 4, 6]
Mean = 4. Deviations: -2, 0, 2. Squares: 4, 0, 4. Sum = 8.
Variance = 8 / (3 - 1) = 4

Data: [70, 85, 85, 90, 100]
Mean = 86. Deviations: -16, -1, -1, 4, 14. Squares: 256, 1, 1, 16, 196. Sum = 470.
Variance = 470 / 4 = 117.5

NumPy check: np.var(data, ddof=1) gives 117.5. Without ddof=1, NumPy divides by n and gives 94.0.

## Common Mistakes
- Dividing by n instead of n - 1. NumPy's default does this, so always pass ddof=1 when comparing.
- Using the one-pass shortcut (sum of squares minus n x mean squared) on data with a large mean. It suffers catastrophic cancellation and can return 0.0 when the true answer is 1.0.
- Calling it on a single value. Sample variance needs at least 2 values.
- Forgetting that constant data gives a variance of exactly 0.

## Implementation
```python
def variance(data):
    values = _validate(data)
    if len(values) < 2:
        raise ValueError("sample variance needs at least 2 values")
    m = mean(values)
    squared = [(v - m) ** 2 for v in values]
    return sum(squared) / (len(values) - 1)
```

Tests: 4.0 on [2, 4, 6], 0 for constant data, and an error for a single value. Reference comparison: np.var(data, ddof=1), tolerance 1e-12.

## Related Concepts

- [[Welford Online Variance Week 1 (Maria)]]
- [[Sample Standard Deviation (Maria)]]
- [[Input Contract (Maria)]]
- [[Population vs Sample]]

## References
- Ross, S. M., Introduction to Probability and Statistics for Engineers and Scientists, 6th ed., chapter 2 (sample variance and standard deviation). Check the section number in your copy.
- NumPy documentation: numpy.var (the ddof parameter).

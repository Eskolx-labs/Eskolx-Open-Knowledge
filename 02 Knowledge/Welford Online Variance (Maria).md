---
type: concept
cover:
status: draft
area: statistics
created: 2026-10-06
updated: 2026-10-06
author: Maria Biruk
tags:
  - statistics
  - variance
  - welford
publish-status: draft
---

# Welford Online Variance

## Definition

Welford’s Online Variance is a numerically stable method for calculating the mean and variance of a sequence of numbers one value at a time.

It is useful when data arrives continuously or when we do not want to store all values in memory.

The method keeps three main values:

- `n` — number of valid values seen
- `mean` — current mean
- `M2` — sum of squared differences from the current mean

For each new value `x`, the algorithm updates these values incrementally.

## Why it matters

A simple variance calculation can suffer from numerical problems when the numbers are very large but their differences are small.

For example, when values are around `1,000,000,000`, the naive sum-of-squares method can suffer from **catastrophic cancellation**.

In my numerical-stability test, the naive calculation produced `-128.0`, which is impossible for a variance.

Welford’s method avoids this problem by updating the mean and the squared differences incrementally.

## How it works

For every valid value `x`:

````text
n = n + 1

delta = x - mean

mean = mean + delta / n

M2 = M2 + delta * (x - mean)

After processing all values:

```text
sample variance = M2 / (n - 1)```


The sample standard deviation is:

standard deviation = sqrt(sample variance)

Missing values such as None and NaN are ignored and counted as dropped values.

Strings and booleans are rejected with TypeError, while infinite values are rejected with ValueError.

## Example

For the dataset:

[2, 4, 4, 4, 5, 5, 7, 9]

The result is:

count = 8
mean = 5.0
sample variance = 4.571428571428571
sample standard deviation = 2.138089935299395

The sum of squared deviations from the mean is 32.
## Numerical Stability

I compared my Welford implementation with NumPy.

For normal data, the results matched.

For values around 1e9, Welford remained stable, while the naive sum-of-squares method produced an incorrect negative variance of -128.0.

This shows why Welford's method is more numerically stable.

## Implementation and Testing

The implementation was written in Python without using a library variance or standard-deviation function inside the algorithm.

The project includes:

- `welford (Maria).py` — main implementation
- `test_welford (Maria).py` — tests
- `welford_demo (Maria).py` — demonstration
- `welford_reference (Maria).py` — NumPy comparison

The test suite contains 11 tests, and all 11 tests passed.
## References

- Welford, B. P. (1962). *Note on a Method for Calculating Corrected Sums of Squares and Products.*
- Welford Online Variance implementation and tests: Stateskol code repository.
- Welford diagram: `welford (Maria).tldr`

## Key Idea

Welford's algorithm updates the mean and variance as each value arrives. This makes it useful for online data and helps avoid numerical problems that can occur with the naive variance calculation.

````
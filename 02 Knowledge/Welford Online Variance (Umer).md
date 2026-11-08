---
type: concept
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Running_variance.svg/1200px-Running_variance.svg.png
status: draft
area: statistics
created: 2026-11-08
updated: 2026-11-08
author: Umer
tags:
  - numerical-methods
  - monte-carlo
publish-status: draft
---

# Welford Online Variance

## Definition

**Welford's online variance algorithm** is a numerically stable method for computing the [[Variance|variance]] of a stream of data in a single pass. Unlike the naive two-pass algorithm (which first computes the mean, then the variance), Welford's method updates both the running mean and a running sum of squared differences incrementally as each new observation arrives.

## Intuition

Imagine you are counting votes at a polling station, one ballot at a time. After each ballot, you update your estimate of the average and how spread out the votes are. You never need to go back and re-read earlier ballots. That is what Welford's algorithm does: it maintains a running summary that is updated with each new data point, using only the current summary values and the new observation.

The key insight is that when a new value arrives, you compute how far it is from the *current* mean (the "delta"), update the mean, then compute how far the new value is from the *updated* mean (the "delta2"). The product of these two deltas is added to a running accumulator called M2, which ultimately gives you the variance.

## Why it matters

- **Single pass**: You never need to store all the data or make a second pass. This is essential for streaming data, online learning, and large datasets that do not fit in memory.
- **Numerical stability**: The naive formula $\sigma^2 = \frac{1}{n}\sum x_i^2 - \mu^2$ suffers from catastrophic cancellation when values are large and close together. Welford's method avoids this by working with differences from the running mean.
- **Foundation for distributed computing**: The algorithm can be extended (Chan's parallel algorithm) to combine statistics from multiple batches, making it useful in parallel and distributed computing.
- **Used in**: [[Monte Carlo Simulation|Monte Carlo]] methods, reinforcement learning, A/B testing, real-time analytics, and the [[stateskol|stateskol]] Python package.

## How it works

![[welford (Umer).tldr]]

### Initialization

Set three variables to zero:

$$n = 0, \quad \bar{x} = 0, \quad M_2 = 0$$

### Update step (for each new observation $x$)

1. **Increment count**: $n \leftarrow n + 1$
2. **Compute delta**: $\delta \leftarrow x - \bar{x}$
3. **Update mean**: $\bar{x} \leftarrow \bar{x} + \frac{\delta}{n}$
4. **Compute delta2**: $\delta_2 \leftarrow x - \bar{x}$ (using the *updated* mean)
5. **Update M2**: $M_2 \leftarrow M_2 + \delta \cdot \delta_2$

### Final results

After processing all $n$ observations:

- **Population variance**: $\sigma^2 = \frac{M_2}{n}$
- **Sample variance**: $s^2 = \frac{M_2}{n - 1}$ (Bessel's correction)
- **Standard deviation**: $\sigma = \sqrt{\sigma^2}$ or $s = \sqrt{s^2}$

## Example

Suppose we observe the values: $4, 7, 13, 2, 1$

| Step | $x$ | $n$ | $\delta$ | $\bar{x}$ | $\delta_2$ | $M_2$ |
|------|-----|-----|----------|-----------|------------|-------|
| Init | —   | 0   | —        | 0         | —          | 0     |
| 1    | 4   | 1   | 4        | 4         | 0          | 0     |
| 2    | 7   | 2   | 3        | 5.5       | 1.5        | 4.5   |
| 3    | 13  | 3   | 7.5      | 8         | 5          | 42    |
| 4    | 2   | 4   | -6       | 6.5       | -4.5       | 69    |
| 5    | 1   | 5   | -5.5     | 5.4       | -4.4       | 93.2  |

**Result**: Mean = 5.4, Population variance = 93.2 / 5 = 18.64, Sample variance = 93.2 / 4 = 23.3

## Common Mistakes

- **Using the old mean for delta2**: After updating the mean in step 3, you must use the *new* mean to compute $\delta_2$ in step 4. Using the old mean gives wrong results.
- **Dividing by $n$ instead of $n-1$**: For sample variance (unbiased estimator), divide $M_2$ by $n-1$, not $n$. Use $n$ only for population variance.
- **Integer division**: In languages like Python 2 or integer-only contexts, $\delta / n$ may truncate. Use floating-point division.
- **Overflow with large values**: While Welford's method is stable, extremely large values can still cause issues. Consider Kahan summation for the mean update if precision is critical.

## Implementation

```python
def welford_online_variance(data):
    """Compute mean and variance in a single pass using Welford's algorithm."""
    n = 0
    mean = 0.0
    m2 = 0.0

    for x in data:
        n += 1
        delta = x - mean
        mean += delta / n
        delta2 = x - mean
        m2 += delta * delta2

    population_variance = m2 / n
    sample_variance = m2 / (n - 1)

    return mean, population_variance, sample_variance


# Test with the example above
data = [4, 7, 13, 2, 1]
mean, pop_var, sample_var = welford_online_variance(data)
print(f"Mean: {mean}")
print(f"Population variance: {pop_var}")
print(f"Sample variance: {sample_var}")
```

## Related Concepts

- [[Population vs Sample]] — why we divide by $n-1$ for sample variance
- [[Sampling Bias]] — Welford's assumes observations arrive without systematic bias
- [[Monte Carlo Simulation]] — online variance estimation is critical in simulation
- [[stateskol]] — Python implementation of statistical methods including Welford's

## References

- Welford, B. P. (1962). "Note on a method for systematically computing the variance of a stream of data". *Technometrics*. 4 (3): 419–420.
- Knuth, D. E. (1997). *The Art of Computer Programming*, Vol 2, Section 4.2.2.
- Chan, T. F., Golub, G. H., & LeVeque, R. J. (1983). "Algorithms for computing the sample variance: Analysis and recommendations". *The American Statistician*. 37 (3): 242–247.

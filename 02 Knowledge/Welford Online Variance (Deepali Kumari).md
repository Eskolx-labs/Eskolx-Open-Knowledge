---
type: concept
cover:
status: draft
area: numerical-methods
created: 2026-10-03
updated: 2026-10-03
author: Deepali Kumari
tags: []
publish-status: draft
---



# Welford Online Variance (Deepali Kumari)

## Definition
Welford's online variance algorithm is a one-pass method for calculating the mean and variance of a sequence of numerical observations as the data arrives.

Instead of storing all observations or repeatedly recalculating the variance, the algorithm maintains three running values:

- `count (n)` — the number of valid observations seen so far.
- `mean` — the current running mean.
- `M2` — the running sum of squared deviations from the current mean.

For `n >= 2`, the sample variance is calculated as:

`sample variance = M2 / (n - 1)`

and the sample standard deviation is:

`sample standard deviation = sqrt(sample variance)`

The method was described by B. P. Welford in his 1962 paper, *Note on a Method for Calculating Corrected Sums of Squares and Products*, published in *Technometrics*, 4(3), 419–420.

Reference: https://doi.org/10.1080/00401706.1962.10490022
## Intuition
Welford's algorithm can be understood as keeping a small summary of the data seen so far instead of keeping the complete dataset.

When a new value arrives, we ask:

1. How many values have we seen?
2. How much did the mean change after adding the new value?
3. How much additional squared variation does the new value contribute?

The important idea is that we do not need to go back and calculate the deviations of all previous values every time a new observation arrives.

For each new value `x`, the algorithm first measures its difference from the old mean:

`delta = x - mean`

It then updates the mean and measures the difference again using the new mean:

`delta2 = x - new_mean`

The product:

`delta * delta2`

is added to `M2`, which stores the accumulated squared variation.

So the algorithm only needs three running values — `count`, `mean`, and `M2` — to keep updating the statistics as new observations arrive.

This makes Welford's method useful when data arrives one observation at a time or when storing the entire dataset is unnecessary.

## Why it matters
Welford's algorithm matters because variance can be difficult to calculate accurately when the values are very large but their differences are small.

A direct formula can involve subtracting two large and nearly equal numbers. With floating-point arithmetic, this can cause loss of precision and produce inaccurate results.

Welford's method avoids this problem by updating the mean and the accumulated squared deviations incrementally. This gives better numerical behavior while processing the data in a single pass.
It is also useful when:

- data arrives as a stream and new observations are continuously added;
- the complete dataset does not need to be stored;
- statistics need to be updated after every observation;
- we want an `O(n)` calculation with constant extra memory.

For this project, these properties are important because the goal is not only to calculate variance, but to understand how an online and numerically stable calculation works.

## How it works
Welford's algorithm processes one observation at a time.

For every new value `x`, we maintain:

- `n` — number of observations processed.
- `mean` — mean of the observations processed so far.
- `M2` — sum of squared deviations from the current mean.
![[welford (Deepali Kumari).tldr]]
### Step 1: Calculate the difference from the old mean

For a new observation `x`:

`delta = x - mean`

This tells us how far the new value is from the current mean.

### Step 2: Update the count

Increase the number of observations:

`n = n + 1`

### Step 3: Update the mean

The new mean is:

`mean = mean + delta / n`

The mean therefore moves toward the new observation, with the amount of movement depending on the new count.

### Step 4: Calculate the difference from the new mean

After updating the mean:

`delta2 = x - mean`

This uses the new mean rather than the old mean.

### Step 5: Update M2

The accumulated squared deviation is updated as:

`M2 = M2 + delta * delta2`

After processing all observations, `M2` represents:

`M2 = sum((x_i - mean)^2)`

where `mean` is the final mean of the observations.

### Step 6: Calculate sample variance

For at least two valid observations:

`sample variance = M2 / (n - 1)`

The denominator is `n - 1` because this implementation calculates sample variance with `ddof=1`.

### Step 7: Calculate sample standard deviation

Finally:

`sample standard deviation = sqrt(sample variance)`

### Algorithm summary

For each valid observation:


delta = x - mean
n = n + 1
mean = mean + delta / n
delta2 = x - mean
M2 = M2 + delta * delta2


## Example
A small hand-worked example helps show how the running values change.

Consider the data:

`[2, 4, 6]`

We start with:

- `n = 0`
- `mean = 0`
- `M2 = 0`

### Observation 1: x = 2

Calculate:

`delta = 2 - 0 = 2`

Update the count:

`n = 1`

Update the mean:

`mean = 0 + 2 / 1 = 2`

Calculate the second difference:

`delta2 = 2 - 2 = 0`

Update `M2`:

`M2 = 0 + 2 * 0 = 0`

Current state:

- `n = 1`
- `mean = 2`
- `M2 = 0`

### Observation 2: x = 4

Calculate:

`delta = 4 - 2 = 2`

Update the count:

`n = 2`

Update the mean:

`mean = 2 + 2 / 2 = 3`

Calculate:

`delta2 = 4 - 3 = 1`

Update `M2`:

`M2 = 0 + 2 * 1 = 2`

Current state:

- `n = 2`
- `mean = 3`
- `M2 = 2`

### Observation 3: x = 6

Calculate:

`delta = 6 - 3 = 3`

Update the count:

`n = 3`

Update the mean:

`mean = 3 + 3 / 3 = 4`

Calculate:

`delta2 = 6 - 4 = 2`

Update `M2`:

`M2 = 2 + 3 * 2 = 8`

Final state:

- `n = 3`
- `mean = 4`
- `M2 = 8`

### Final sample variance

Because there are three observations:

`sample variance = M2 / (n - 1)`

`sample variance = 8 / (3 - 1)`

`sample variance = 4`

### Final sample standard deviation

`sample standard deviation = sqrt(4) = 2`

Therefore, for `[2, 4, 6]`:

- **Count:** `3`
- **Mean:** `4`
- **Sample variance:** `4`
- **Sample standard deviation:** `2`

This hand calculation matches the result produced by the Python implementation.

## Common Mistakes
Welford's algorithm is simple once the update order is understood, but several mistakes can lead to incorrect results.

### 1. Updating the mean in the wrong order

`delta` must be calculated using the old mean.

Correct order:

`delta = x - mean`

then update the count and mean.

If the mean is changed before calculating `delta`, the update no longer follows the Welford recurrence.

### 2. Using the old mean for `delta2`

After updating the mean, `delta2` must use the new mean:

`delta2 = x - mean`

Using the old mean changes the value added to `M2`.

### 3. Confusing M2 with variance

`M2` is not the final sample variance.

For `n >= 2`:

`sample variance = M2 / (n - 1)`

The division by `n - 1` is required for the sample variance used in this implementation.

### 4. Dividing by zero for a single observation

When there is only one valid observation, sample variance is undefined because `n - 1 = 0`.

This implementation therefore returns:

- `variance = None`
- `std_dev = None`

for a single valid observation.

### 5. Silently replacing missing values

Missing values should not be silently converted to zero or another value.

In this implementation, `None` and `NaN` are treated as missing, dropped, and counted in `missing_count`.

### 6. Accepting invalid numerical values

Non-numeric values, boolean values, and infinite values are rejected with `ValueError`.

This makes invalid input fail fast instead of producing misleading statistics.

### 7. Comparing against a reference library without matching the definition

A comparison with NumPy must use the same variance definition.

This implementation uses sample variance with `ddof=1`, so the NumPy comparison also uses:

`np.var(data, ddof=1)`

Otherwise, the two calculations would be using different definitions of variance.
## Implementation
The implementation is written in Python using only the standard library.

The function is:

`welford(data)`

It accepts an iterable of real numeric values and returns a dictionary containing:

- `count`
- `mean`
- `variance`
- `std_dev`
- `missing_count`

### Input handling

The function first converts `data` into an iterator. If the input is not iterable, it raises `ValueError`.

For each value:

- `None` is treated as missing.
- `NaN` is treated as missing.
- Missing values are skipped and counted in `missing_count`.
- Boolean values are rejected because they are not intended to represent numerical observations.
- Non-numeric values are rejected with `ValueError`.
- Infinite values are rejected with `ValueError`.

### Running state

The algorithm starts with:

`count = 0`

`mean = 0.0`

`M2 = 0.0`

For every valid observation, the Welford update is applied:

`delta = value - mean`

`count = count + 1`

`mean = mean + delta / count`

`delta2 = value - mean`

`M2 = M2 + delta * delta2`

Only these running values are required; the complete dataset does not need to be stored.

### Final calculation

After all valid observations have been processed:

`variance = M2 / (count - 1)`

This is sample variance with `ddof=1`.

The sample standard deviation is:

`std_dev = sqrt(variance)`

If exactly one valid observation is present, sample variance and sample standard deviation are undefined, so both are returned as `None`.

If there are no valid observations after removing missing values, the function raises `ValueError`.

### Complexity

For `n` input values, the algorithm processes each value once.

- Time complexity: `O(n)`
- Additional space: `O(1)`

The returned `missing_count` also makes the missing-value behavior explicit instead of silently hiding dropped observations.

## Related Concepts

- [[Mean]]
- [[Variance]]
- [[Standard Deviation]]
- [[Online Algorithms]]
- [[Numerical Stability]]

## References
- Welford, B. P. (1962). *Note on a Method for Calculating Corrected Sums of Squares and Products*. Technometrics, 4(3), 419–420. https://doi.org/10.1080/00401706.1962.10490022
- Yao, S., Zhao, J., Yu, D., Du, N., Shafran, I., Narasimhan, K., & Cao, Y. (2022). *ReAct: Synergizing Reasoning and Acting in Language Models*. https://arxiv.org/abs/2210.03629
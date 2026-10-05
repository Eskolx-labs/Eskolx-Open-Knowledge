---
type: concept
cover: https://thumb.wikimedia.org/wikipedia/commons/thumb/6/64/Variance_visualisation.svg/960px-Variance_visualisation.svg.png
status: draft
area: statistics
created: 2026-10-05
updated: 2026-10-05
author: Hanna Desalegn
tags:
  - statistics
publish-status: draft
---



# Welford Online Variance (Hanna Desalegn)

![Variance visualisation|157](https://thumb.wikimedia.org/wikipedia/commons/thumb/6/64/Variance_visualisation.svg/960px-Variance_visualisation.svg.png)
## Definition
Welford's online variance algorithm is a one-pass method for calculating a running mean and sample variance without storing all observations or computing the variance from the difference between two large sums.

For each new observation, the algorithm updates the count, mean, and a running sum of squared deviations called $M_2$. After at least two valid observations, the sample variance is:

$$
\boxed{s^2 = \frac{M_2}{n-1}}
$$

where $n$ is the number of valid observations and $n-1$ is the sample-variance denominator.
## Intuition
The main idea is to update the statistics as each observation arrives instead of waiting until the entire dataset is available.

Imagine that the current mean is $m$. When a new value $x$ arrives, first measure how far it is from the current mean:

$$
\delta = x - m
$$

The new mean moves toward $x$ by only a fraction of this difference. At the same time, the algorithm uses the old mean and the updated mean to update $M_2$, which keeps track of the total squared deviation needed for the variance.

This avoids calculating variance by subtracting two large quantities. That subtraction can lose precision when the values are large but their actual differences are small.
## Why it matters
Variance is often written using a formula that requires calculating the sum of the observations and the sum of their squared values, then subtracting one large quantity from another. When the observations are large and their actual variation is small, this subtraction can lose significant digits because of floating-point rounding.

Welford's method avoids this cancellation problem by updating the mean and the running squared-deviation total together as each observation arrives.

It is also useful when data arrives as a stream. The algorithm only needs the current count, mean, and $M_2$, so it does not need to store the complete dataset in memory or make a second pass through it.
## How it works
Welford's method maintains three main values while processing the observations:

- $n$: the number of valid observations processed so far

- $m$: the current mean

- $M_2$: the running sum of squared deviations from the current mean


For each new observation $x_n$, the update is performed in this order.

### 1. Count the observation

Increase the number of observations:

$$
n \leftarrow n + 1
$$

### 2. Calculate the difference from the old mean

Before changing the mean, calculate:

$$
\delta = x_n - m_{n-1}
$$

This measures how far the new observation is from the previous mean.

### 3. Update the mean

Move the mean toward the new observation:

$$
m_n = m_{n-1} + \frac{\delta}{n}
$$

The new observation therefore changes the mean by its deviation divided by the new count.

### 4. Update $M_2$

Now calculate the difference between the new observation and the updated mean:

$$
\delta_2 = x_n - m_n
$$

Then update the running squared-deviation total:

$$
M_{2,n} = M_{2,n-1} + \delta\delta_2
$$

The important detail is that $\delta$ uses the old mean, while $\delta_2$ uses the updated mean.

### 5. Calculate sample variance

Once at least two valid observations have been processed:

$$
s^2 = \frac{M_2}{n-1}
$$

### 6. Calculate sample standard deviation

The sample standard deviation is the square root of the sample variance:

$$
s = \sqrt{s^2}
$$

The algorithm therefore needs only the current count, mean, and $M_2$ while processing the data. The observations do not need to be stored for the calculation.
![[welford (Hanna Desalegn).tldr]]

This diagram shows the one-pass Welford update from a new observation to the running mean, $M_2$, sample variance, and standard deviation.
## Example
Consider the observations:

$$
[2,4,6,8]
$$

We start with:

$$
n=0,\qquad m=0,\qquad M_2=0
$$

We process one observation at a time.

### Observation 1: $x_1=2$

Increase the count:

$$
n=1
$$

Calculate the difference from the old mean:

$$
\delta = 2-0 = 2
$$

Update the mean:

$$
m = 0+\frac{2}{1}=2
$$

Calculate the difference from the new mean:

$$
\delta_2 = 2-2=0
$$

Update $M_2$:

$$
M_2 = 0+(2)(0)=0
$$

Current state:

$$
n=1,\qquad m=2,\qquad M_2=0
$$

### Observation 2: $x_2=4$

$$
n=2
$$

$$
\delta = 4-2=2
$$

$$
m = 2+\frac{2}{2}=3
$$

$$
\delta_2 = 4-3=1
$$

$$
M_2 = 0+(2)(1)=2
$$

Current state:

$$
n=2,\qquad m=3,\qquad M_2=2
$$

### Observation 3: $x_3=6$

$$
n=3
$$

$$
\delta = 6-3=3
$$

$$
m = 3+\frac{3}{3}=4
$$

$$
\delta_2 = 6-4=2
$$

$$
M_2 = 2+(3)(2)=8
$$

Current state:

$$
n=3,\qquad m=4,\qquad M_2=8
$$

### Observation 4: $x_4=8$

$$
n=4
$$

$$
\delta = 8-4=4
$$

$$
m = 4+\frac{4}{4}=5
$$

$$
\delta_2 = 8-5=3
$$

$$
M_2 = 8+(4)(3)=20
$$

Final state:

$$
n=4,\qquad m=5,\qquad M_2=20
$$

Because we are calculating **sample variance**, we divide $M_2$ by $n-1$:

$$
s^2 = \frac{20}{4-1}
= \frac{20}{3}
\approx 6.6667
$$

The sample standard deviation is:

$$
s = \sqrt{\frac{20}{3}}
\approx 2.582
$$

So the final results are:

- Count: $4$
- Mean: $5$
- Sample variance: $\frac{20}{3}\approx6.6667$
- Sample standard deviation: $\sqrt{\frac{20}{3}}\approx2.582$
- Dropped observations: $0$
## Common Mistakes

Welford's algorithm is simple, but several mistakes can produce incorrect or unstable results.

### 1. Using $n$ instead of $n-1$

For sample variance, the denominator is:

$$
n-1
$$

Using $n$ calculates population variance instead. The implementation in this project uses sample variance with `ddof=1`.

### 2. Using the naive variance formula

A common formula is:

$$
s^2 =
\frac{\sum x_i^2-\frac{(\sum x_i)^2}{n}}{n-1}
$$

This can be numerically unstable when the observations are large but their actual differences are small. The subtraction between large, nearly equal quantities can lose significant precision.

Welford's method avoids this subtraction by updating the mean and $M_2$ incrementally.

### 3. Using the wrong mean when updating $M_2$

The two differences in the update use different means:

$$
\delta = x_n-m_{n-1}
$$

and

$$
\delta_2=x_n-m_n
$$

The first uses the old mean, while the second uses the updated mean. Using the same mean for both changes the recurrence and produces incorrect results.

### 4. Treating missing values as zero

A missing observation should not automatically become zero because zero is a real numerical value.

In this implementation, `None` and `NaN` are treated as missing values, skipped from the calculation, and counted in `dropped`.

### 5. Ignoring boundary cases

Sample variance is undefined when there are fewer than two valid observations.

Therefore:

- Empty input returns `count = 0` and `NaN` for mean, variance, and standard deviation.
- One valid observation returns its mean, but variance and standard deviation are `NaN`.
- Constant observations have variance and standard deviation equal to `0`.

These cases should be tested explicitly rather than relying on the normal calculation path.

### 6. Accepting invalid observations silently

The implementation rejects boolean values, non-numeric values, and positive or negative infinity.

This prevents invalid input from producing misleading statistics.

A clear error is preferable to silently converting or ignoring a value that is not defined as missing.
## Implementation
The Python implementation follows the Welford recurrence described in the paper.

The function keeps four pieces of state:

- `count`: number of valid observations processed
- `mean`: current running mean
- `m2`: running sum of squared deviations
- `dropped`: number of missing observations skipped

At the beginning, all four values are initialized to zero.

For each valid observation, the code performs the Welford update:

$$
\delta = x - mean
$$

$$
mean = mean + \frac{\delta}{count}
$$

$$
\delta_2 = x - mean
$$

$$
m2 = m2 + \delta\delta_2
$$

Here, `delta` is calculated using the old mean, while `delta_2` is calculated after the mean has been updated.

After all observations are processed, the implementation calculates sample variance using:

$$
variance = \frac{m2}{count-1}
$$

The standard deviation is then:

$$
std = \sqrt{variance}
$$

The function does not store the complete dataset. It updates these values as observations arrive, so the input only needs to be processed once.

Before applying the Welford update, the function also handles missing and invalid values according to the documented rules. `None` and `NaN` are dropped and counted, while invalid numeric types and infinite values raise errors.
The implementation and tests for this note are in the [Welford code repository](https://github.com/hannaDesalegn/stateskol/tree/applicant/hanna-desalegn/welford).

## Running the Example in a Clean Environment

From a fresh clone of the code repository, create a virtual environment:

    python -m venv .venv

Activate the virtual environment, then install the package:

    pip install -e .

Run the demonstration:

    python "examples/welford_demo (Hanna Desalegn).py"

The package implementation uses only the Python standard library. NumPy is used only for the reference comparison and tests.
## Related Concepts

- [[Population vs Sample]]
## References

- Welford, B. P. (1962). *Note on a Method for Calculating Corrected Sums of Squares and Products*. Technometrics, 4(3), 419-420. [DOI](https://doi.org/10.1080/00401706.1962.10490022)
- Yao, S., Zhao, J., Yu, D., Du, N., Shafran, I., Narasimhan, K., & Cao, Y. (2022). *ReAct: Synergizing Reasoning and Acting in Language Models*. [arXiv:2210.03629](https://arxiv.org/abs/2210.03629)
- Chan, T. F., Golub, G. H., & LeVeque, R. J. (1983). *Algorithms for Computing the Sample Variance: Analysis and Recommendations*. The American Statistician, 37(3), 242-247. [Chan, Golub & LeVeque 1983 PDF](https://math.pku.edu.cn/teachers/litj/notes/numer_anal/AmerStat_37_242_Chan_Variance.pdf)

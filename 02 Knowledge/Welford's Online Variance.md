\---



type: concept

cover:

status: draft

area: numerical-methods

created: 2026-10-06

updated: 2026-10-07

author: Salahudin Nuredin

tags:



\* numerical-methods

\* statistics

\* algorithms

&#x20; publish-status: draft



\---



\# Welford's Online Variance Algorithm



\## Definition



Welford's algorithm is a numerically stable, one-pass method for calculating a running mean and the corrected sum of squares needed for variance.



Instead of storing every observation or calculating variance from the potentially unstable expression



$$

\\sum x\_i^2 - \\frac{(\\sum x\_i)^2}{n},

$$



the algorithm maintains three quantities:



\* $n$: number of valid observations

\* $\\bar{x}$: running mean

\* $M\_2$: sum of squared deviations from the running mean



For a sample, the variance is:



$$

s^2 = \\frac{M\_2}{n-1}

$$



and the sample standard deviation is:



$$

s = \\sqrt{s^2}.

$$



\## Intuition



The key idea is to update the mean and accumulated squared deviation whenever a new observation arrives.



Suppose the current mean is $\\bar{x}\_{n-1}$ and a new observation $x\_n$ arrives.



First calculate how far the new observation is from the old mean:



$$

\\delta = x\_n - \\bar{x}\_{n-1}

$$



Then update the mean:



$$

\\bar{x}\_n =

\\bar{x}\_{n-1} + \\frac{\\delta}{n}

$$



The new mean changes the deviation of the incoming observation, so calculate:



$$

\\delta\_2 = x\_n - \\bar{x}\_n

$$



Then update:



$$

M\_{2,n} = M\_{2,n-1} + \\delta\\delta\_2

$$



This means the algorithm never needs the complete history of observations. It only needs the current count, mean, and $M\_2$.



\## Why it matters



A naive variance calculation can suffer from \*\*catastrophic cancellation\*\* when observations are large but their deviations from the mean are relatively small.



For example, values around:



$$

10^{12}

$$



may have a relatively small variance. Computing large squared values and then subtracting two nearly equal large quantities can lose significant precision.



Welford's method works directly with deviations from the running mean, making it substantially more numerically stable.



The original 1962 paper by B. P. Welford introduced an iterative method for corrected sums of squares and emphasized that the calculation can proceed without storing all observations.



\## How it works



The algorithm starts with:



$$

n=0,\\qquad \\bar{x}=0,\\qquad M\_2=0

$$



For each valid observation $x$:



1\. Increment the count.

2\. Compute the difference between the observation and the old mean.

3\. Update the mean.

4\. Compute the difference between the observation and the new mean.

5\. Update $M\_2$.



Pseudocode:



```text

count = 0

mean = 0

M2 = 0



for x in observations:

&#x20;   count += 1



&#x20;   delta = x - mean

&#x20;   mean += delta / count



&#x20;   delta2 = x - mean

&#x20;   M2 += delta \* delta2



sample\_variance = M2 / (count - 1)

sample\_std\_dev = sqrt(sample\_variance)

```



For sample variance, at least two valid observations are required.



\### Missing and invalid values



The Stateskol implementation makes the following explicit choices:



\* `None` is treated as missing and dropped.

\* floating-point `NaN` is treated as missing and dropped.

\* the number of dropped observations is returned.

\* boolean values are rejected rather than interpreted as integers.

\* non-numeric values raise `TypeError`.

\* infinite values raise `ValueError`.

\* fewer than two valid observations raises `ValueError` because sample variance is undefined.



These are implementation assumptions rather than properties of Welford's mathematical recurrence itself.



\## Example



Consider:



$$

\[2,4,6,8]

$$



Start with:



$$

n=0,\\quad \\bar{x}=0,\\quad M\_2=0

$$



\### Observation 1: $x=2$



$$

n=1

$$



$$

\\delta=2-0=2

$$



$$

\\bar{x}=0+\\frac{2}{1}=2

$$



$$

\\delta\_2=2-2=0

$$



$$

M\_2=0+(2)(0)=0

$$



State:



$$

n=1,\\quad\\bar{x}=2,\\quad M\_2=0

$$



\### Observation 2: $x=4$



$$

\\delta=4-2=2

$$



$$

\\bar{x}=2+\\frac{2}{2}=3

$$



$$

\\delta\_2=4-3=1

$$



$$

M\_2=0+(2)(1)=2

$$



State:



$$

n=2,\\quad\\bar{x}=3,\\quad M\_2=2

$$



\### Observation 3: $x=6$



$$

\\delta=6-3=3

$$



$$

\\bar{x}=3+\\frac{3}{3}=4

$$



$$

\\delta\_2=6-4=2

$$



$$

M\_2=2+(3)(2)=8

$$



State:



$$

n=3,\\quad\\bar{x}=4,\\quad M\_2=8

$$



\### Observation 4: $x=8$



$$

\\delta=8-4=4

$$



$$

\\bar{x}=4+\\frac{4}{4}=5

$$



$$

\\delta\_2=8-5=3

$$



$$

M\_2=8+(4)(3)=20

$$



Final state:



$$

n=4,\\quad\\bar{x}=5,\\quad M\_2=20

$$



Therefore:



$$

s^2=\\frac{20}{4-1}=\\frac{20}{3}

\\approx6.6666666667

$$



and:



$$

s=\\sqrt{\\frac{20}{3}}

\\approx2.5819888975

$$



So the result is:



```text

count = 4

mean = 5.0

sample variance = 6.666666666666667

sample standard deviation = 2.581988897471611

dropped = 0

```



\## Common Mistakes



\### Using population variance accidentally



Welford maintains $M\_2$. The denominator determines whether the result is population or sample variance:



$$

\\sigma^2=\\frac{M\_2}{n}

$$



for population variance, while:



$$

s^2=\\frac{M\_2}{n-1}

$$



is sample variance.



The Stateskol implementation intentionally uses the sample definition.



\### Updating the mean incorrectly



The new mean must use the new count:



$$

\\bar{x}\_n=\\bar{x}\_{n-1}+\\frac{x\_n-\\bar{x}\_{n-1}}{n}

$$



Using the wrong denominator changes every subsequent state.



\### Updating $M\_2$ with the same delta twice



The stable recurrence uses:



$$

M\_2 \\leftarrow M\_2+\\delta\\delta\_2

$$



where $\\delta$ uses the old mean and $\\delta\_2$ uses the updated mean.



\### Storing all observations unnecessarily



One advantage of the algorithm is that the calculation is online. Storing the entire dataset defeats one of its principal advantages.



\### Ignoring numerical stability



A mathematically equivalent formula is not necessarily computationally equivalent in floating-point arithmetic. The direct sum-of-squares formula can lose precision through cancellation.



\## Implementation



The Stateskol implementation is:



`src/stateskol/welford\_salahudin\_nuredin.py`



The core state is:



```python

count = 0

mean = 0.0

m2 = 0.0



for value in data:

&#x20;   count += 1



&#x20;   delta = value - mean

&#x20;   mean += delta / count



&#x20;   delta2 = value - mean

&#x20;   m2 += delta \* delta2

```



The implementation returns:



```text

(count, mean, sample\_variance, sample\_std\_dev, dropped\_count)

```



The package implementation uses only the Python standard library. NumPy is used only as an independent reference in the tests and reference example, not as part of the algorithm.



The implementation is covered by tests for:



\* ordinary datasets

\* empty input

\* a single valid observation

\* constant values

\* negative values

\* missing values

\* NaN values

\* generators

\* non-numeric input

\* infinite input

\* boolean input

\* numerical stability with large values

\* comparison against NumPy



\## Validation



For the independent reference dataset:



```text

\[12.5, 8.25, 17.75, 3.5, 21.0, 14.25, 9.75, 18.5]

```



both Welford's implementation and NumPy produced:



```text

mean = 13.1875

sample variance = 34.53125

sample standard deviation = 5.87632963677158

dropped = 0

```



The automated test suite contains 13 tests, all passing.



The implementation was also tested on:



```text

\[1\_000\_000\_000\_001,

&#x20;1\_000\_000\_000\_002,

&#x20;1\_000\_000\_000\_003,

&#x20;1\_000\_000\_000\_004]

```



to check numerical stability when observations are large relative to their spread.



\## Related Concepts



\* \[\[Mean]]

\* \[\[Variance]]

\* \[\[Standard Deviation]]

\* \[\[Numerical Stability]]

\* \[\[Online Algorithms]]

\* \[\[Sampling and Estimation]]



\## References



1\. B. P. Welford (1962). \*Note on a Method for Calculating Corrected Sums of Squares and Products\*. Technometrics, 4(3), 419–420. DOI: `10.1080/00401706.1962.10490022`.

2\. Eskolx Stateskol assignment implementation: `welford\_salahudin\_nuredin.py`.

3\. NumPy reference implementation using `numpy.mean`, `numpy.var(ddof=1)`, and `numpy.std(ddof=1)`.

4\. Yao et al. (2022). \*ReAct: Synergizing Reasoning and Acting in Language Models\*. arXiv:2210.03629. Reviewed separately as part of the Stateskol screening assignment.



\## Diagram



!\[\[welford-algorithm.tldr]]




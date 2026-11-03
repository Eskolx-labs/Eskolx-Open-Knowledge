---
type: concept
cover:
status: draft
area: statistics
created: 2026-11-03
updated: 2026-11-03
author: Robel Eyob
tags:
  - statistics
publish-status: draft
---
![[Welford's algorithm.tldr]]
[Open welford_robel.py](https://github.com/RobelKefa/stateskol/blob/applicant/RobelKefa/welford/src/stateskol/welford_robel.py)
# Welford 1962 - Online Variance Algorithm

## Definition
Welford's algorithm is an online method for calculating statistical quantities, particularly the mean and variance, as observations arrive one at a time.
Instead of storing all observations and recalculating the statistics whenever new data arrive, the algorithm updates previously calculated values using the new observation.
Welford (1962) described methods for calculating corrected sums of squares and products. These methods can also be extended to calculate higher-order statistical moments.
## Intuition
Imagine receiving students' examination scores one at a time.
After receiving the first score, we calculate the mean. When the second score arrives, we update the existing mean instead of calculating everything from the beginning.
We continue this process for every new score.
The same idea applies to variance and other statistical quantities: keep the previous results and update them whenever new information arrives.
## Why it matters
- **Efficiency:** We update statistics without repeatedly processing the entire dataset.
- **Memory:** We can calculate statistics without keeping every observation in memory.
- **Numerical stability:** The corrected-sum approach avoids some numerical problems associated with calculating variance using the difference between two large quantities.
- **Streaming data:** It is useful when observations arrive continuously.
- **Extensibility:** The method can be used for variance, covariance, and higher-order moments.
## How it works
### Formula I — Corrected Sum of Squares
The running mean is updated using:
M(n-1)=SUM Xi/n-1    while i=1,2,3,....,n-1
M(n)=M(n-1) +X(n)-M(n-1) / n
The corrected sum of squares is updated using:
Sn=SUM (Xi-M(n))^2  where i=1,2,3,....,n
Sn=S(n-1)+(n-1)/n * (Xn-M(n-1)^2
The sample variance is:
S^2=Sn/n-1
### Formula II — Corrected Sum of Products
For paired observations (x, y):
Sn=S(n-1) +(n-1)/n * (Xi-Mn) * (Yn-Mn)
### Formula III — Higher-Order Moments
Higher-order corrected sums are defined as:
Sn^r=SUM (Xi-Mn)^r
They extend the method beyond variance.
- S₂: corrected sum of squares.
- S₃: third central moment.
- S₄: fourth central moment.
The higher-order quantities can be updated recursively using the binomial expansion.
## Example
Consider the observations:
2, 4, 6

| Observation | Count | Running Mean |
|---|---:|---:|
| 2 | 1 | 2 |
| 4 | 2 | 3 |
| 6 | 3 | 4 |

Final mean:
Mn=2+4+6 / 3= 4

Corrected sum of squares:
S2=(2-4)^2+(4-4)^2+(6-4)^2
S2=4+0+4=8
Sample variance:
s^2=8/(3-1)=4

Sample standard deviation:
s=sqrt(4)=2
## Common Mistakes
1. Dividing by n instead of n-1 when calculating sample variance.
2. Using the old mean instead of the updated mean in the corrected-sum update.
3. Confusing corrected sum of squares with variance.
4. Updating paired observations incorrectly when calculating covariance.
5. Using previously updated moments instead of the old moments in a higher-order recurrence.
6. Forgetting to handle missing or invalid observations.
## Implementation
### Main implementation

`src/stateskol/welford_robel.py`

### Main functions

| Function | Responsibility |
|---|---|
| `WelfordAccumulator` | Maintains running statistical values |
| `welford()` | Calculates mean, variance, and standard deviation |
| `welford_products()` | Calculates corrected sums of products and covariance |
| `welford_moments()` | Calculates higher-order moments |

### Supporting files

- `examples/welford_demo_robel.py` — Demonstrates the algorithm.
- `examples/welford_reference_robel.py` — Compares results with NumPy.
- `tests/test_welford_robel.py` — Tests the implementation.

### Verification
- 14 unit tests passed.
- NumPy comparison passed.
- Demonstration executed successfully.
## Related Concepts

- [[Mean]]
- [[Variance]]
- [[Sample Variance]]
- [[Covariance]]
- [[Central Moments]]
- [[Skewness]]
- [[Kurtosis]]
- [[Numerical Stability]]
- [[Streaming Algorithms]]
- [[Binomial Theorem]]
- [[Python Classes]]

## References
1. Welford, B. P. (1962). *Note on a Method for Calculating Corrected Sums of Squares and Products.*
2. Ross, S. M. (2014). *Introduction to Probability and Statistics for Engineers and Scientists* (6th edition).
3. NumPy documentation: used for independent numerical verification of the Python implementation.
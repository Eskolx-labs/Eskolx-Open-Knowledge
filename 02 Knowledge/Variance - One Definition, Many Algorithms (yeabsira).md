---
type: concept
status: draft
area: statistics
author: yeabsira
created: 2026-11-21
updated: 2026-11-21
tags:
  - statistics
  - variance
  - numerics
  - welford
  - floating-point
  - stateskol
publish-status: draft
---

# Variance: One Definition, Many Algorithms

![[variance one definition many algorithms.tldr]]

The definition of variance is fixed. The algorithm is not, and the wrong algorithm returns zero for data that has visible spread. First the ideas, one at a time. Then one problem, solved from start to end with every idea used in order.

## Part 1. The ideas

### Variance and standard deviation
The sample variance measures how far the data sits from its own mean. For data x1, ..., xn with sample mean x-bar:

s2 = sum((xi - x-bar)^2) / (n - 1)

The standard deviation is its square root. Write S for the top part, the **corrected sum of squares**: S = sum((xi - x-bar)^2). Then s2 = S / (n - 1).

### ddof
"ddof" says what the sum is divided by: n - ddof.
- ddof = 1 divides by n - 1: the **sample** variance (the package default).
- ddof = 0 divides by n: the **population** variance.
With one value and ddof = 1 the division is by zero, so the sample variance does not exist. The package refuses instead of returning a number.

### Two facts from Ross that make a good test
Ross, section 2.3.2: adding a constant to every value does not change the sample variance; multiplying every value by b multiplies it by b squared. So the variance of 1e9+1, 1e9+2, 1e9+3, 1e9+4 must equal the variance of 1, 2, 3, 4. That gives the true answer of the problem below without any big numbers.

### Three algorithms for one definition
1. **Naive (the shortcut).** S = sum(xi^2) - n * x-bar^2. Ross shows this identity in 2.3.2 to ease hand computation. It is exact in real arithmetic. We keep it in the code only to show the failure.
2. **Two-pass.** First scan: compute the mean. Second scan: add up (xi - mean)^2. Stable, and the method numpy uses. It must read the data twice, so it needs the data in memory.
3. **Welford (1962), one pass.** Keep a running mean and a running S, and update both with each new value.

### Floating-point, in four sentences
A float64 keeps about 16 decimal digits (53 binary digits). Near a number x, neighbouring floats are one **ulp** apart, and the ulp grows with x: it is 128 near 1e18. An integer is stored exactly only up to 2^53 = 9007199254740992, and 2^53 + 1 becomes 2^53. The week 2 contract refuses any value above 2^53 for exactly this reason.

### Cancellation
When two large, nearly equal numbers are subtracted, the leading digits cancel and what is left is mostly the rounding error of the two numbers. The naive formula subtracts sum(x^2) from n * mean^2. Both are about the size of the data squared, and the answer, the spread, lives in the last digits.

### Welford's update
Welford (1962), equation (1) and Formula I, with m(n) the running mean and S(n) the running corrected sum of squares:

- m(n) = ((n-1)/n) * m(n-1) + x(n) / n
- S(n) = S(n-1) + ((n-1)/n) * (x(n) - m(n-1))^2

The code uses the equivalent form below, because by identity (3) of the paper, x(n) - m(n) = ((n-1)/n) * (x(n) - m(n-1)):

- delta = x - mean
- mean = mean + delta / n
- S = S + delta * (x - mean)

Each step adds a non-negative amount to S, so S never goes below zero, and constant data gives exactly 0. Nothing large is ever subtracted from something nearly as large.
Ross, Chapter 2, Problem 18 gives the same idea as a recursion on s2: mean(j+1) = mean(j) + (x(j+1) - mean(j)) / (j+1) and s2(j+1) = (1 - 1/j) * s2(j) + (j+1) * (mean(j+1) - mean(j))^2. A test checks that this textbook recursion and the Welford code agree.

### How much error is acceptable: the tolerance
Compare every result with the **exact** variance, computed with Python fractions (no rounding), and allow a relative error of

n * EPS * kappa

- EPS = 2^-52, the float64 rounding unit.
- kappa = sqrt(sum(x^2) / S) measures how big the numbers are compared with their spread. For 1, 2, 3, 4 it is about 1. For 1e9+1..4 it is about 9e8.
- Reason: each value adds one rounding error, so the error grows with n, and it is magnified by kappa because a number 1e9 big carries about seven digits of the spread. A bound of this shape appears in the numerical-analysis literature on variance (Chan, Golub and LeVeque, 1983; I have not read it), so I do not rely on it. I measured: the worst Welford error over 1617 random sets was 0.27 of this tolerance. If it ever exceeded 1, the rule would be wrong.
- When n * EPS * kappa is 1 or more, no algorithm can be expected to keep any digit, so the dataset is reported but not judged.

## Part 2. One problem, solved step by step

**Problem.** Find the sample variance of x = 1e9+1, 1e9+2, 1e9+3, 1e9+4 with each algorithm.

**Step 1. The true answer, by hand.** Shift every value down by 1e9 (Ross: the variance does not change). The data become 1, 2, 3, 4. n = 4, sum = 10, mean = 2.5. Deviations: -1.5, -0.5, 0.5, 1.5. Squares: 2.25 + 0.25 + 0.25 + 2.25 = 5, so S = 5. s2 = 5 / 3 = **1.6666666666666667**.

**Step 2. Naive.** mean = 1000000002.5. sum(x^2) is about 4e18, and n * mean^2 is about the same. Floats near 4e18 are 512 apart, near 1e18 they are 128 apart. A difference of 5 is far smaller than the gap, so the two big numbers cancel to **0.0**. The spread disappeared. (Population version, ddof = 0: also 0.0.)

**Step 3. Two-pass.** The mean 1000000002.5 is exact. Deviations -1.5, -0.5, 0.5, 1.5 are small and exact. Squares sum to 5. 5 / 3 = **1.6666666666666667**.

**Step 4. Welford, traced by hand.** Write every mean as 1e9 + the number shown.

| n | x | delta = x - mean | mean = mean + delta/n | S = S + delta * (x - mean) |
|---|---|---|---|---|
| 1 | 1 | 1e9 + 1 (from 0), times 0 below | 1 | 0 + (1e9 + 1) * 0 = 0 |
| 2 | 2 | 1 | 1.5 | 0 + 1 * 0.5 = 0.5 |
| 3 | 3 | 1.5 | 2 | 0.5 + 1.5 * 1 = 2 |
| 4 | 4 | 2 | 2.5 | 2 + 2 * 1.5 = 5 |

S = 5, so s2 = 5 / 3 = **1.6666666666666667**. Every number in the table is small, so no digits are lost.

**Step 5. The three numbers.**

| Algorithm | Result | Relative error vs the exact value |
|---|---|---|
| Naive | 0.0 | 1.0 (all of it) |
| Two-pass | 1.6666666666666667 | 0 |
| Welford | 1.6666666666666667 | 0 |

**Step 6. The tolerance on this problem.** kappa = sqrt(sum(x^2)/S) = about 8.9e8, n = 4, EPS = 2.2e-16, so the allowed relative error is 4 * 2.2e-16 * 8.9e8 = about 7.9e-7. Welford's error is 0, inside it. The naive error of 1.0 is a million times outside it.

**Step 7. The edge of the contract.** Take the four exact floats 2^53 - 3, 2^53 - 2, 2^53 - 1, 2^53. The true variance is again 5/3. Welford gives 1.6666666666666667. Two-pass gives **2.0**: the sum of the values is above 2^53, so the mean is not exact and the answer is off by 20 percent. This is why week 2 limits values to 2^53, and why a stable method matters even inside the limit.

**Step 8. The same four numbers, different offsets.** Welford returns 5/3 for the same four numbers at offsets 1e3, 1e6, 1e9, 1e12 and 1e15. At 1e15 the tolerance rule is 0.79, so it is reported but not judged, and it is still exact on this data because the values are exact floats.

**Step 9. When Welford is not perfect.** On 100000 normal values around 1e9 with spread 1, the relative error is 4.6e-9, while the naive formula's relative error is 6700 (wrong by thousands of times). kappa is 1e9 here, so the tolerance rule allows up to 2e-2 and the measured error is far inside it. Welford keeps about eight digits, which is close to the best any algorithm can do with that data.

## Part 3. What the variance hides (the Anscombe question)

A variance of 1.67 says nothing about the shape, the outliers or the ties. Anscombe (1973) built four datasets with the same means and almost the same variances and four different pictures. The brief gives the numbers as mean 9 and 7.50, variances 11.00 and about 4.12.
In our problem the variance hides **where the data sits**: it is identical for 1, 2, 3, 4 and for 1e9+1..4, which is correct, but a reader of "1.67" cannot tell which one they have. It also hides the outliers: one value of 48 added to nine values moves the mean from 3.78 to 8.20 and the variance by a factor of about 50 (tested).

## Part 4. Known limits
- Welford keeps about as many digits as the data allows, not more. If the spread is smaller than the float spacing at the data's size, the answer is lost for every algorithm.
- Only ddof 0 and 1 are accepted. Other values raise DomainError (numpy accepts any).
- One value with ddof = 1 raises DomainError (my proposal; week 0 returned NaN; the Contract lane decides).
- The tolerance bound comes from the literature and is checked by measurement only.
- Not here: skewness, kurtosis, stable online higher moments (week 4), merging results from two data sets (parallel Welford, Chan et al.).

## Part 5. Checks
44 tests (hand-worked, the 1e9 case, the 2^53 edge, Ross shift, scale and Problem 18, boundaries, random data). Ten deliberately broken versions of the code were each caught. Reference comparison against the exact fraction, the standard library, numpy and pandas on 15 datasets and 2000 random sets: `examples/reference_numerics.py`. Runnable example: `examples/variance_1e9_demo.py`.

## References and links
- Ross, *Introduction to Probability and Statistics for Engineers and Scientists*, 6th ed., section 2.3.2 (sample variance, the shortcut, shift and scale), and Chapter 2, Problem 18 (the running update). Section 2.1 and 2.2 not used here.
- Welford, B. P. (1962). Note on a method for calculating corrected sums of squares and products. *Technometrics* 4(3), 419-420. DOI 10.1080/00401706.1962.10490022.
- Hyndman, R. J. and Fan, Y. (1996). Sample quantiles in statistical packages. *The American Statistician* 50(4). Linked only: quantiles are the Core B lane. Status: ADD-STATUS.
- Anscombe, F. J. (1973). Graphs in statistical analysis. *The American Statistician* 27(1). Status: ADD-STATUS (the numbers above come from the week 3 brief, not from the paper).
- Chan, T. F., Golub, G. H. and LeVeque, R. J. (1983). Algorithms for computing the sample variance: analysis and recommendations. *The American Statistician* 37(3). Not read.
- Week 2 notes: [[The Data Contract]], [[Missing Data Mechanisms]], [[Data Audit]]
- Earlier notes: [[Welford Online Variance (Yeasira Tesfaye)]], [[Histograms and the Bin Rule (Yoseph)]]
- Code PR: [Pull requests · Eskolx-labs/stateskol](https://github.com/Eskolx-labs/stateskol/pull/24)

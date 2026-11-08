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



# IQR(Maria)

## Definition
iqr(data) is the interquartile range: the third quartile (Q3) minus the first quartile (Q1). It is the width of the middle half of the data. Stateskol computes both quartiles with the quantile function (linear interpolation, Type 7).
![[90 Attachments/animations/iqr(Maria)]]

## Intuition
Line up the data from smallest to largest, then ignore the lowest quarter and the highest quarter. The IQR is how wide the middle half is. A few extreme values at either end cannot change it much.

## Why it matters
The IQR measures spread without being pulled around by outliers, which makes it more reliable than the range (maximum minus minimum). It is also the input to the Freedman-Diaconis rule, which sets the default histogram bin width as 2 x IQR x n^(-1/3).

## How it works
1. Compute Q1 with quantile(data, 0.25).
2. Compute Q3 with quantile(data, 0.75).
3. Return Q3 - Q1.

Because it reuses quantile, it inherits the input contract and the stated quantile method. The IQR is never negative, and it is 0 for constant data.

## Example
Data: [1, 2, 3, 4]
Q1 = 1.75, Q3 = 3.25, so IQR = 3.25 - 1.75 = 1.5

Data: [70, 85, 85, 90, 100]
Q1 = 85, Q3 = 90, so IQR = 5
(n = 5, so the positions are 0.25 x 4 = 1 and 0.75 x 4 = 3, which land exactly on 85 and 90.)

## Common Mistakes
- Confusing the IQR with the range. The range uses the minimum and maximum, so a single outlier changes it a lot.
- Mixing quantile methods. A different method gives slightly different quartiles, so the IQR can differ from another library's.
- Expecting a negative value. Q3 is never below Q1.

## Implementation
```python
def iqr(data):
    return quantile(data, 0.75) - quantile(data, 0.25)
```

Tests: 1.5 on [1, 2, 3, 4]. Reference comparison: np.quantile at 0.75 minus np.quantile at 0.25, tolerance 1e-12.

## Related Concepts

- [[Quantile (Maria)]]
- [[Sample Variance (Maria)]]
- [[Sample Standard Deviation (Maria)]]
- [[Input Contract (Maria)]]

## References
- Ross, S. M., Introduction to Probability and Statistics for Engineers and Scientists, 6th ed., chapter 2 (quartiles). Check the section number in your copy.
- Freedman, D. and Diaconis, P. (1981), On the histogram as a density estimator, which uses the IQR to set the bin width.
- NumPy documentation: numpy.quantile.

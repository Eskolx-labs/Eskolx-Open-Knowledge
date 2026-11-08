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



# Quantile (Maria)

## Definition
quantile(data, q) returns the value below which a fraction q of the data lies. The 0.5 quantile is the median, 0.25 is the first quartile (Q1) and 0.75 is the third quartile (Q3). Stateskol uses linear interpolation (Type 7, the NumPy default), and the method is named here because textbooks and libraries disagree on how to compute quantiles.
![[quartile(Maria)]]
## Intuition
Line up all the values from smallest to largest. A quantile is a spot along that line. If the spot falls between two values, you take a point part of the way from one to the other.

## Why it matters
Quantiles describe where the data sits without being pulled around by extreme values. They are the base of the IQR, and the IQR sets the histogram bin width. Different methods give slightly different answers, so the method must be stated in the docstring and matched exactly when comparing with a library.

## How it works
1. Check the data with the input contract, then sort it.
2. Compute the position: `pos = q * (n - 1)`. This is a 0-based index and may be fractional.
3. Split it: `lo` is the whole part and `frac` is the leftover decimal.
4. If `frac` is 0, return `values[lo]`. This also handles q = 1, where there is no next value to interpolate with.
5. Otherwise return `values[lo] + frac * (values[lo+1] - values[lo])`.
6. q outside 0 to 1 raises ValueError.

## Example
Data: [1, 2, 3, 4], so n = 4.

q = 0.5:  pos = 0.5 x 3 = 1.5, lo = 1, frac = 0.5. Result: 2 + 0.5 x (3 - 2) = 2.5
q = 0.25: pos = 0.75, lo = 0, frac = 0.75. Result: 1 + 0.75 x (2 - 1) = 1.75
q = 0.75: pos = 2.25, lo = 2, frac = 0.25. Result: 3 + 0.25 x (4 - 3) = 3.25
q = 1.0:  pos = 3, frac = 0. Result: 4

The 0.5 quantile equals the median (2.5), as it should.

## Common Mistakes
- Assuming every library uses the same method. NumPy's default is linear (Type 7), and others differ by small amounts.
- Using a 1-based position instead of a 0-based one.
- Reading values[lo + 1] when q = 1, which does not exist. The frac == 0 check prevents this.
- Forgetting to sort the data first.
- Allowing q outside 0 to 1.

## Implementation
```python
# Quantile: linear interpolation (Type 7, the NumPy default).
# position = q * (n - 1) on sorted data; q must be in [0, 1].
def quantile(data, q):
    values = sorted(_validate(data))
    n = len(values)
    if not 0 <= q <= 1:
        raise ValueError("q must be between 0 and 1")
    pos = q * (n - 1)
    lo = int(pos)
    frac = pos - lo
    if frac == 0:
        return values[lo]
    return values[lo] + frac * (values[lo + 1] - values[lo])
```

Tests: the hand values above, the edges q = 0 and q = 1, an empty list and q = 1.5. Reference comparison: np.quantile (linear by default) at seven values of q, with tolerance 1e-12.

## Related Concepts
- [[Input Contract (Maria)]]
- [[IQR (Maria)]]
- [[Sample Variance (Maria)]]
- [[Population vs Sample]]



## References
- Ross, S. M., Introduction to Probability and Statistics for Engineers and Scientists, 6th ed., chapter 2 (sample percentiles and quartiles). Check the section number in your copy.
- Hyndman, R. J. and Fan, Y. (1996), Sample quantiles in statistical packages, The American Statistician. This is where the quantile "types" come from.
- NumPy documentation: numpy.quantile (default method is linear).


---
type: concept
status: draft
area: statistics
author: Yeasira Tesfaye
created: 2026-11-06
updated: 2026-11-08
tags:
  - statistics
  - histogram
  - descriptive
  - quantile
  - iqr
  - stateskol
publish-status: draft
---

# Histograms and the Bin Rule

![[histograms and the bin rule (Yeabsira).tldr]]

First the ideas, one at a time. Then one problem, solved from start to end with every idea used in order.

## Part 1. The ideas

### Bin (class interval)
A bin is a range of values, for example 5 up to 8. A histogram cuts the number line into bins and counts how many data values fall in each one. The height of a bar is that count. The ends of the bins are the **edges** (Ross: class boundaries). k bins need k + 1 edges.

### Why the choice of bins matters
The data does not tell you where the bins start or how wide they are. Those are choices, and they change the picture. A rule that fixes the choices, written down, makes the histogram repeatable. That is the job of the bin rule below.

### Edge rule: what happens to a value exactly on an edge
If a value is exactly 8 and one bin ends at 8 while the next starts at 8, which bin gets it? Ross uses **left-end inclusion**: a bin holds its left end but not its right end, written [left, right). So 8 goes into the bin that starts at 8.
Problem: the largest value would sit on the last edge and belong to no bin. So the **last bin also holds its right end**: [left, right]. Nothing is lost.

### Sorted data
Write the data in order: x[0] <= x[1] <= ... <= x[n-1]. Position numbers start at 0. The smallest is x[0], the largest is x[n-1].

### Quantile
A quantile for a fraction p (between 0 and 1) is a value with about a fraction p of the data at or below it. p = 0.5 is the median.
Usually p falls between two data points, so we must choose how to fill the gap. We use **linear interpolation** (Hyndman and Fan type 7, the numpy default):
1. position = (n - 1) * p
2. low = the whole part of position; high = low + 1
3. fraction = position - low
4. quantile = x[low] + (x[high] - x[low]) * fraction
In words: walk to that position along the sorted list. If you land between two values, go the right fraction of the way from the lower to the upper one.

### Quartiles
The three quantiles that cut the sorted data into four equal parts:
- **Q1** is p = 0.25 (a quarter of the data is below it)
- **Q2** is p = 0.5 (the median)
- **Q3** is p = 0.75

### IQR (interquartile range)
IQR = Q3 - Q1. It is the width of the interval holding the middle half of the data. It measures spread, and a few extreme values hardly move it. The range (max - min) is the opposite: one outlier changes it completely. That is why a bin rule built on the IQR is not fooled by outliers.

### The bin rule (Freedman and Diaconis, 1981)
- **Width** h = 2 * IQR * n^(-1/3), where n is the number of values used. The cube root means: more data allows narrower bins.
- **Origin**: the bins start at the smallest value.
- **Number of bins** k = ceil((max - min) / h). We round **up** so the bins cover the whole range.
- **Real step** = (max - min) / k. This is a little smaller than h, because k was rounded up. The k bins are equal and cover exactly min to max.
- **Edges**: min + i * step, for i = 0 to k. The last edge is set to exactly the maximum so rounding cannot lose it.
- Two special cases, so nothing divides by zero:
  - all values equal: one bin [value - 0.5, value + 0.5]
  - IQR = 0 (more than half the values equal) but not all equal: one bin [min, max]. For more detail, pass your own edges.

### Your own edges
If you want a different rule (for example Ross's classes of 100), give the function a list `edges`. It uses them exactly. They must be at least 2 numbers, increasing. A value outside the first and last edge raises an error. We never drop a value silently.

### Missing and invalid values
None and NaN are dropped and counted. Text, True/False raise `TypeError`. Infinity raises `ValueError`. No usable value left raises `ValueError`.

## Part 2. One problem, solved step by step

**Problem.** A list of 13 measurements, one of them missing:
`2, 3, 3, 4, None, 5, 6, 6, 7, 8, 9, 10, 14`
Build the histogram with the default bin rule.

**Step 1. Clean.** The `None` is missing: drop it and count it. dropped = 1. We keep 12 values, so n = 12.

**Step 2. Sort.** 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 10, 14. Positions 0 to 11.

**Step 3. Min and max.** min = 2, max = 14, range = 12. They differ, so the special case "all equal" does not apply.

**Step 4. Q1.**
- position = (12 - 1) * 0.25 = 2.75
- low = 2, high = 3, fraction = 0.75
- x[2] = 3 and x[3] = 4
- Q1 = 3 + (4 - 3) * 0.75 = **3.75**

**Step 5. Q3.**
- position = 11 * 0.75 = 8.25
- low = 8, high = 9, fraction = 0.25
- x[8] = 8 and x[9] = 9
- Q3 = 8 + (9 - 8) * 0.25 = **8.25**

**Step 6. IQR.** 8.25 - 3.75 = **4.5**. Not 0, so the second special case does not apply.

**Step 7. Width.** h = 2 * 4.5 * 12^(-1/3). The cube root of 12 is 2.2894, so 12^(-1/3) = 0.4368. h = 9 * 0.4368 = **3.931**.

**Step 8. Number of bins.** (14 - 2) / 3.931 = 12 / 3.931 = 3.053. Round up: k = **4**. (Rounding down would give 3 bins of width 3.931 that stop at 13.8 and miss the 14. That is why we round up.)

**Step 9. Real step.** 12 / 4 = **3**. It is smaller than h = 3.931, as expected.

**Step 10. Edges.** Origin 2, step 3: 2, 5, 8, 11, 14. The last edge is exactly the maximum.
Bins: [2, 5), [5, 8), [8, 11), [11, 14].

**Step 11. Count, with the edge rule.**
- [2, 5): 2, 3, 3, 4 gives **4**
- [5, 8): 5, 6, 6, 7 gives **4**. The 5 is on an edge and goes in the bin that starts at 5 (left end included).
- [8, 11): 8, 9, 10 gives **3**. The 8 is on an edge and goes right.
- [11, 14]: 14 gives **1**. The 14 is the last edge; the last bin includes its right end. Without that rule it would be lost.
Check: 4 + 4 + 3 + 1 = 12 = n, and 12 + dropped 1 = 13 values given.

**Answer.**
`counts = [4, 4, 3, 1]`, `edges = [2.0, 5.0, 8.0, 11.0, 14.0]`, `dropped = 1`.

**Check with the code and numpy.** `histogram_counts([2, 3, 3, 4, None, 5, 6, 6, 7, 8, 9, 10, 14])` returns exactly this. `np.histogram_bin_edges(x, bins="fd")` gives the same edges and `np.histogram(x, bins="fd")` the same counts.

**Now a different rule.** Suppose we want bins of width 4 starting at 0: `edges=[0, 4, 8, 12, 16]`. Then [0,4): 2, 3, 3 gives 3; [4,8): 4, 5, 6, 6, 7 gives 5; [8,12): 8, 9, 10 gives 3; [12,16]: 14 gives 1. Counts `[3, 5, 3, 1]`. Same data, different picture, and that is why the rule must be stated.

## Part 3. Known limits
- If the IQR is tiny compared with the range (a few far outliers), h is tiny and k is huge. There is no cap.
- If the IQR is 0 we give one bin. It is safe but shows nothing.
- A different quantile method changes Q1 and Q3 a little, so it can change h and sometimes the number of bins. We name ours (linear) in the docstring.
- Not in this block: ogives, stem and leaf plots, relative frequencies (divide counts by n).

## Part 4. Checks
36 tests (hand counts, usual cases, boundaries, bad input). Six deliberately broken versions were all caught. Against numpy (`np.histogram_bin_edges` with `"fd"`, and `np.histogram`): counts equal exactly, edges within 1e-12 of the data range, measured difference 0.0.

## Part 5. Freedman-Diaconis walk-through (to write after reading the paper)
- What they minimise:
- Why the width goes like n^(-1/3):
- Why the IQR and not the standard deviation:

## References and links
- Ross, *Introduction to Probability and Statistics for Engineers and Scientists*, 6th ed., section 2.2.3 (class intervals, left-end inclusion, Table 2.3 and 2.4).
- Freedman, D. and Diaconis, P. (1981). On the histogram as a density estimator: L2 theory. *Probability Theory and Related Fields* 57(4), 453-476. DOI 10.1007/BF01025868. Not yet read in full; the rule is as used by numpy.
- Hyndman, R. and Fan, Y. (1996). Sample quantiles in statistical packages. *The American Statistician* 50(4).
- Sibling note: [[Welford Online Variance (Yeasira Tesfaye)]]
- Code PR: [feat:Add histogram_counts and the bin rule (owner: Yeabsira) by yeab-sira1 · Pull Request #16 · Eskolx-labs/stateskol](https://github.com/Eskolx-labs/stateskol/pull/16)

---
type: concept
cover:
status: draft
area: statistics
created: 2026-11-22
updated: 2026-11-22
author: Maria Biruk
tags:
  - quantiles
publish-status: draft
---



## The problem
A quantile looks like one number, but it depends on a rule. There are nine published rules for where the p-th quantile sits in a sorted sample, and they don't agree. On 1 2 3 4 5, the 25th percentile is 1.0 under type 3, 1.5 under type 6, and 2.0 under type 7. None of these is wrong, but a number is only wrong when the rule is missing, because then nobody can reproduce it or audit it.

## The nine rules
Each rule sets a position h in the sorted sample, then interpolates. Values below are p25 of 1 2 3 4 5 and p75 of 2 4 4 5 7 9 11 13 15 18.

| Type | Position h | Who ships it | p25 of 1..5 | p75 of the ten |
|---|---|---|---|---|
| 1 | n·p, no interpolation | textbook step function | 2.0 | 13.0 |
| 2 | n·p, average at a jump | | 2.0 | 13.0 |
| 3 | n·p, nearest even order | SAS | 1.0 | 13.0 |
| 4 | n·p, linear on the ecdf | | 1.25 | 12.0 |
| 5 | n·p + ½ | Hazen, hydrology | 1.75 | 13.0 |
| 6 | (n+1)·p | Minitab, SPSS, Excel PERCENTILE.EXC | 1.5 | 13.5 |
| **7** | **(n−1)·p + 1** | **R, numpy, Excel PERCENTILE.INC** | **2.0** | **12.5** |
| 8 | (n+⅓)·p + ⅓ | Hyndman & Fan's recommendation | 1.667 | 13.167 |
| 9 | (n+¼)·p + ⅜ | normal-unbiased | 1.688 | 13.125 |

## Our choice: type 7
Stateskol ships type 7, where the position is h = (n − 1)p + 1 and the value is interpolated linearly between the two neighbours. I chose it for two reasons. First, it is the default in R, numpy and Excel PERCENTILE.INC, so a reviewer can check any number with a tool they already have. Second, it keeps the median of an even-length sample equal to the average of the two middle values, and the four quartiles of a box plot match the ones our function returns. Hyndman and Fan recommend type 8, but type 8 would make our numbers disagree with the tools most people use to check them. Any other method raises `UnsupportedRuleError` and names the rule it refused, so the rule is never hidden.

## The proof on real data
On 1 2 3 4 5, the 25th percentile is 2.0 under type 7 and 1.5 under type 6.
On 2 4 4 5 7 9 11 13 15 18, the 75th percentile is 12.5 under type 7 and 13.5 under type 6.
On 2 4 4 5 7 9 11 13 15 18, the 75th percentile is 12.5 under type 7 and 13.5 under type 6. A gap of 1.0 on data that runs from 2 to 18 is a modelling choice, not rounding, and it is large enough to move an outlier fence, a bonus band or a quality-control limit.


## Diagram
![[Quantile positions]]

## Links
- [[Ross — Introduction to Probability and Statistics]] §2.1-2.3
- [[Hyndman & Fan (1996) — Sample Quantiles in Statistical Packages]]
- [[Welford (1962) — Corrected Sums of Squares]]
- [[Anscombe (1973) — Graphs in Statistical Analysis]]
- [[The Data Contract]]
- Code: (the stateskol PR link goes here later)

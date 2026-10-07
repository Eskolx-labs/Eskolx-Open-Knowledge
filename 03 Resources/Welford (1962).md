---
type: resource
cover:
status: active
area: numerical-methods
kind: paper
url: http://dx.doi.org/10.1080/00401706.1962.10490022
created: 2026-10-06
updated: 2026-10-06
author: Yosef Bezabih
tags:
  - numerical-methods
publish-status: draft
---



# Welford (1962)

## What it is
B. P. Welford (1962), "Note on a Method for Calculating Corrected Sums of Squares and Products", *Technometrics* 4(3), 419–420. A two-page note showing how to update the corrected sum of squares one value at a time, using each value only once. DOI: <http://dx.doi.org/10.1080/00401706.1962.10490022>

## Why we recommend it
It is short, readable and the origin of the standard one-pass algorithm for variance. It explains the numerical problem it solves (lost significant figures when subtracting the correction factor) and then gives the fix with a short derivation.

## How to use it
Read the derivation of formula I, then implement it yourself and check it on a small data set by hand. Formula II extends it to sums of products (covariance), and formula III to higher powers. The paper's reference to Box and Hunter (1959) is a related earlier result.

## Related Concepts
- [[Welford Online Variance (Yosef Bezabih)]]
- [[Population vs Sample]]

## Notes
The paper gives the corrected sum of squares $S_n$. The sample variance $S_n/(n-1)$ is a step you derive yourself.
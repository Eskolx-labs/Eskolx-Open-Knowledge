---
type: concept
cover:
status: draft
area: statistics
created: 2026-11-13
updated: 2026-11-13
author: Maria Biruk
tags:
  - data-contract
publish-status: draft
---


A data contract is the written promise a function makes about what it will accept, what it will refuse, and what it will do when a value is missing. Every rule below is a test in `tests/test_contract.py`, and every refusal raises a named error, so a person who was not in the room can trust the number that comes out.

The contract exists because the check belongs inside the method, not after it (see [[Box (1976) — Science and Statistics]] and [[Tukey (1962) — The Future of Data Analysis]]. A function that quietly repairs bad input produces a number nobody can defend.

## The rules

|Input|Behaviour|Error|Why|Example|
|---|---|---|---|---|
|`int`, `float`|Accepted|none|The only numeric types v0.1 understands|`as_numeric([1, 2.5])` gives `[1.0, 2.5]`|
|`bool`|Rejected|`InvalidTypeError`|`True` is an `int` in Python, but it is not a measurement|`as_numeric([1, True])` raises|
|`str`|Rejected|`InvalidTypeError`|No coercion: `"3"` is not a number because it looks like one|`as_numeric([1, "3"])` raises|
|`Decimal`, `Fraction`|Rejected|`InvalidTypeError`|The contract states its boundary in v0.1|`as_numeric([Fraction(1, 2)])` raises|
|`None`, `float("nan")`|Missing|none (drop) or `MissingDataError` (strict)|Handled by the policy, never by arithmetic|`as_numeric([1, None, 3.5])` gives `[1.0, 3.5]`|
|`inf`, `-inf`|Rejected|`InvalidValueError`|An infinite observation is a data error, not a large number|`as_numeric([float("inf")])` raises|
|`abs(n) > 2**53`|Rejected|`InvalidValueError`|Converting to float would round it silently|`2**53` is accepted, `2**53 + 1` raises|
|empty input|`count` returns 0; `minimum`, `maximum`, `data_range` raise|`EmptyDataError`|An empty file is a finding, not a value|`count([])` is `0`; `minimum([])` raises|
|all values missing|`minimum`, `maximum`, `data_range` raise; the audit reports it|`EmptyDataError`|The policy ran and left nothing, so say so|`minimum([None, float("nan")])` raises|
|generator|Read exactly once|none|The function never iterates twice|`audit(x for x in [1, None, 3])` reads it once|
|a bare string or a non-iterable|Rejected|`InvalidTypeError`|Not a collection of numbers|`as_numeric("123")` and `as_numeric(5)` raise|
|unknown `policy`|Rejected|`ValueError`|Only `"drop"` and `"strict"` exist|`as_numeric([1], policy="impute")` raises|

All four error classes inherit from `StateskolError`. `InvalidTypeError` is also a `TypeError`, and the other three are also a `ValueError`, so ordinary Python code that catches those still works.

## The missing-value decision

The package uses one policy by default: **drop and report**. A caller who needs an error instead passes `policy="strict"`. The package never fills, imputes or coerces.

Dropping a value is not a neutral act. It is a claim that the values went missing completely at random (MCAR). Under MAR it can bias a summary, and under MNAR it usually does [[Rubin (1976) — Inference and Missing Data]]; see also [[Missing Data Mechanisms]]). The function cannot know the mechanism, so the audit records the assumption and says so: "Unknown. The caller must state the mechanism."

What the package will not do: mean or median imputation, forward or backward fill, zero for missing, string-to-number coercion, a silent drop, or a summary string that hides the policy.

## A worked example

Data `[4, 1, None, 9, nan, 6]`: six items, two missing (positions 2 and 4), four present. `count` is 4, `minimum` is 1, `maximum` is 9, `data_range` is 9 − 1 = 8. The audit line reads: `6 total, 4 present, 2 missing at [2, 4]; min=1.0 max=9.0 range=8.0`. See [[Data Audit]].

## In my own words: what I took from the sources

- [[Ross — Introduction to Probability and Statistics]], Ch. 1: _(write 2 to 3 sentences in your own words)_
- Tukey (1962): _(your words: what the argument is and how it shapes this contract)_
- Rubin (1976), sections 1 to 3: _(your words: MCAR, MAR, MNAR and why drop is a claim)_
- Box (1976): _(your words: a model is an approximation, and the check belongs inside the method)_

## Related notes

- [[Population vs Sample]] and [[Sampling Bias]]: a contract only protects the numbers you were given. It cannot tell you whether the data represents the population.
- [[Missing Data Mechanisms]] and [[Data Audit]]: the other two Week 2 notes. If they do not exist yet, record them as intentional gaps in the pull request.

## Code

Implemented in `Eskolx-labs/stateskol`: _(link your code pull request here)_. Tests: `tests/test_contract.py`. Demo: `examples/data_audit_demo.py`. Reference check: `examples/reference_check_week2.py` (exact match with numpy and pandas).
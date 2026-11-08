---
type: concept
cover:
status: draft
area:
created: 2026-11-05
updated: 2026-11-05
author: Maria Biruk
tags:
  - stateskol
  - input-contract
  - week-1
publish-status: draft
---



# Input Contract (Maria)

## Definition
The numeric input contract is the set of rules that decides what counts as valid data in Stateskol. The helper `_validate(data)` checks every input before any calculation runs and fails fast with a clear error.
![[input-contract(Maria)]]
## Intuition

Think of a security check at a door. Only clean numbers get in. Anything else is stopped immediately, with a message that says what is wrong.
## Why it matters
Failing fast tells the user exactly what to fix, before any math runs. Every function in the package calls `_validate` first, so the rule is written once and applies everywhere.

## How it works
1. Convert the input to a list, so generators work too.
2. Empty list: raise ValueError("data is empty").
3. Item is not an int or float: raise TypeError. bool is rejected on purpose, because Python treats True as 1 and mean([True, False]) would quietly give 0.5.
4. Item is nan or inf: raise ValueError, because either one poisons every result.
5. Otherwise return the list.

## Example
[1, 2, "a"]       -> TypeError: invalid value: 'a'
[1, 2, nan]       -> ValueError: invalid value: nan
[]                -> ValueError: data is empty
[True, False]     -> TypeError: invalid value: True
[2, 4, 6]         -> accepted, returned as a list

## Common Mistakes
- Forgetting that bool is a kind of int in Python, so True slips through unless it is checked first.
- Calling math.isnan on text, which raises an error. The type check must come before the nan check.
- Using a generator twice. list(data) is called once and the result is reused.

## Implementation
```python
def _validate(data):
    values = list(data)
    if not values:
        raise ValueError("data is empty")
    for v in values:
        if isinstance(v, bool) or not isinstance(v, (int, float)):
            raise TypeError("invalid value: " + repr(v))
        if math.isnan(v) or math.isinf(v):
            raise ValueError("invalid value: " + repr(v))
    return values
```

Tests: empty, text, nan, inf and bool inputs. The shared boundary pack runs the same bad inputs through every function.

## Related Concepts

- [[Drop Missing (Maria)]]
- [[Sample Variance (Maria)]]
- [[Quantile (Maria)]]
- [[Population vs Sample]]

## References
- Ross, S. M., Introduction to Probability and Statistics for Engineers and Scientists, 6th ed., chapter 1 (data collection, samples and populations).
- Stateskol Week 1 brief, Eskolx Labs (the numeric input contract and missing-data rule).
- Python documentation: math.isnan and math.isinf (standard library).

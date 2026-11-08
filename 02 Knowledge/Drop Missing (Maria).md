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



# Drop Missing(Maria)

## Definition
drop_missing(data) is the missing-data rule in Stateskol. It removes None and nan from a dataset and reports exactly how many values were removed. It never fills missing values in silently.
![[drop-missing(Maria)]]

## Intuition
Think of sorting a basket of fruit and throwing away the rotten ones. You also count how many you threw away, so you always know how much of the basket was lost.

## Why it matters
Real datasets have blanks. There are three ways to handle them: fill them in with a guess, ignore them without telling anyone, or drop them and report the count. The first two hide a problem from the user. Dropping and reporting keeps the result honest, because the caller sees dropped = 2 and can decide whether that is acceptable.

## How it works
1. Convert the input to a list.
2. Keep every value that is not None and is not a float nan.
3. Return two things: the kept list and the dropped count (original length minus kept length).
4. The check isinstance(v, float) runs before math.isnan(v), because math.isnan("a") would raise an error on text.

## Example
[1, 2, None, 4, nan]  -> ([1, 2, 4], 2)
[1, 2, 3]             -> ([1, 2, 3], 0)
[None, nan]           -> ([], 2)

Hand check: [1, 2, None, 4, nan] has 5 items and 3 are usable, so dropped = 5 - 3 = 2. The mean of the kept values is (1 + 2 + 4) / 3 = 7/3, about 2.3333.

## Common Mistakes
- Calling math.isnan on a non-number, which raises an error. Check the type first.
- Forgetting that nan is never equal to itself, so v == nan does not work. Use math.isnan.
- Dropping silently without returning the count.
- When everything is missing, the kept list is empty and the next function raises "data is empty". That is correct, because inventing an answer would be worse.

## Implementation
```python
def drop_missing(data):
    values = list(data)
    kept = [v for v in values if v is not None and not (isinstance(v, float) and math.isnan(v))]
    return kept, len(values) - len(kept)
```

Tests: two values dropped, nothing to drop, and all values missing.

## Related Concepts

- [[Input Contract (Maria)]]
- [[Sample Variance (Maria)]]
- [[Population vs Sample]]

## References
- Ross, S. M., Introduction to Probability and Statistics for Engineers and Scientists, 6th ed., chapter 1 (data collection).
- Stateskol Week 1 brief, Eskolx Labs (missing-data rule: drop and report the count, no silent filling).
- Python documentation: math.isnan (standard library).

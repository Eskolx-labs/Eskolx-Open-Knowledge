---
type: concept
cover:
status: draft
area:
created: 2026-11-12
updated: 2026-11-15
author: Robel Eyob
tags:
  - statistics
publish-status: draft
---
![[90 Attachments/Data contract|Data contract]]


## Definition
A data contract is a formal agreement that specifies the expected structure, types, constraints, and behavior of data exchanged between components of a software system.

In statistical computing, it defines which observations are accepted, which are rejected, how missing values are handled, and what guarantees a function provides.
## Intuition
Think of a data contract as a set of rules at the entrance of a building.

Before people enter, the building has rules about who can enter and what is allowed. Similarly, before data enters a statistical function, the function needs rules about what data it can safely process.

For example, imagine a function that calculates the average of a dataset. Should it accept numbers, text, or Boolean values? What should happen if the dataset contains missing values? What if it contains infinity?

A data contract answers these questions before calculations begin
## Why it matters
Data contracts are important because they:

1. **Prevent unexpected behavior:** Invalid data is identified before it causes incorrect calculations.
    
2. **Improve reliability:** Functions behave consistently when they receive valid or invalid inputs.
    
3. **Make assumptions explicit:** Users understand how missing values and other special cases are handled.
    
4. **Improve communication:** Developers and users share a clear understanding of how a function works.
    
5. **Make testing easier:** Each rule can be converted into a test case.
    
6. **Protect statistical results:** Incorrect input handling can produce misleading summaries and conclusions.
    

Without a clear data contract, two functions may process the same dataset differently and produce inconsistent results.
## How it works
A data contract generally defines four important things:

### 1. Input requirements

These describe what kind of data a function accepts.

For our Week 2 statistics project:

- Integers and floating-point numbers are accepted.
    
- Boolean values and strings are rejected.
    
- Decimal and Fraction objects are rejected.
    
- Infinite values are rejected.
    
- Integers whose absolute value exceeds (2^{53}) are rejected to avoid unsafe numerical precision.
    

### 2. Missing-value policy

Missing observations need an explicit handling rule.

Our project supports two policies:

- **drop:** Missing observations are excluded from calculations, but their number and original positions are recorded.
    
- **strict:** The function raises an error when missing observations are encountered.
    

Missing values include `None` and `NaN`.

Importantly, dropping missing observations does not automatically prove that the remaining data is unbiased.

### 3. Output guarantees

The contract also defines what users can expect from a function.

For example:

- `count(data)` returns the number of valid observations.
    
- `maximum(data)` returns the largest valid observation.
    
- `data_range(data)` returns the difference between the maximum and minimum.
    
- `missing_report(data)` reports the total, present, and missing observations and their positions.
    
- `audit(data)` returns a structured audit of the dataset.
    

An empty dataset can have a count of zero, but minimum, maximum, and range calculations raise `EmptyDataError` when no valid observations exist.

### 4. Error handling

Invalid input should not silently produce misleading results.

The function should raise an appropriate error when the input violates the contract.

For example, strings, Boolean values, and infinite numbers must not be treated as valid numerical observations.
## Example
Consider the following dataset:

```python
data = [10, 20, None, 30, float("nan"), 40]
```

It contains:

- 6 total observations
    
- 4 valid numerical observations
    
- 2 missing observations
    

Under the `drop` policy, the missing observations are excluded from numerical calculations and recorded.

The resulting valid dataset is:

```python
[10, 20, 30, 40]
```

Its minimum is 10, maximum is 40, and range is 30.

Under the `strict` policy, the function raises an error because missing observations are present.

The same input produces different behavior depending on the explicitly selected policy. That behavior is part of the data contract.
## Common Mistakes
Consider the following dataset:

```python
data = [10, 20, None, 30, float("nan"), 40]
```

It contains:

- 6 total observations
    
- 4 valid numerical observations
    
- 2 missing observations
    

Under the `drop` policy, the missing observations are excluded from numerical calculations and recorded.

The resulting valid dataset is:

```python
[10, 20, 30, 40]
```

Its minimum is 10, maximum is 40, and range is 30.

Under the `strict` policy, the function raises an error because missing observations are present.

The same input produces different behavior depending on the explicitly selected policy. That behavior is part of the data contract.

## Common Mistakes

1. **Accepting every numerical-looking value:** A value should not be accepted simply because it can be converted into a number.
    
2. **Treating Boolean values as ordinary numbers:** In Python, `True` and `False` behave like 1 and 0 in some numerical operations, but our contract rejects them.
    
3. **Silently ignoring missing values:** Missing observations should be handled according to a documented policy.
    
4. **Confusing missingness with invalid data:** A missing value is not necessarily the same as an invalid value.
    
5. **Assuming dropping missing data is always safe:** Dropping observations can introduce bias depending on the missingness mechanism.
    
6. **Failing to document errors:** Users should know when and why a function raises an error.
    
7. **Ignoring boundary cases:** Empty datasets, single observations, constant values, and very large numbers need explicit consideration.
## Implementation
In our `stateskol` project, the data contract is implemented in:

`src/stateskol/descriptive.py`

Important implementation components include:

- `_validate_observation()` — checks whether an observation satisfies the input requirements.
    
- `_is_missing()` — identifies missing observations.
    
- `_prepare_data()` — prepares observations according to the selected missing-value policy.
    
- `EmptyDataError` — represents cases where a numerical summary cannot be calculated because there are no valid observations.
    
- `missing_report()` — reports missing observations and their positions.
    
- `audit()` — provides a structured overview of the dataset.
    

The implementation is supported by tests in:

`tests/test_descriptive.py`

These tests check valid inputs, invalid inputs, missing-value policies, empty datasets, boundary cases, and expected errors.
## Related Concepts

- [[Descriptive Statistics Foundations]]
    
- [[Missing Data Mechanisms]]
    
- [[Data Audit]]
    
- [[Data Validation]]
    
- [[Population]]
- [[Sample]]

## References
- **Tukey (1962), _The Future of Data Analysis_.**
- **Rubin (1976), _Inference and Missing Data_**
- **Box (1976), _Science and Statistics_**

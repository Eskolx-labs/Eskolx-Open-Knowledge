---
type: concept
cover:
status: draft
area:
created: 2026-11-07
updated: 2026-11-07
author: Robel Eyob
tags:
  - statistics
publish-status: draft
---
![[Descriptive Statistics Foundations (RobelKefa)]]


# Descriptive Statistics Foundations (Robelkefa)

## Definition
Descriptive statistics are methods used to organize, summarize, and describe the main characteristics of a dataset.
In this project, I implemented five basic descriptive statistics functions in Python:

- `count()`: Counts the number of valid observations.
    
- `min()`: Finds the smallest observation.
    
- `max()`: Finds the largest observation.
    
- `range()`: Calculates the difference between the largest and smallest observations.
    
- `frequency_table()`: Counts how many times each unique value appears.
    

These functions are implemented using Python's standard library without relying on NumPy, pandas, or other statistical libraries.
## Intuition
Imagine a company has recorded the daily sales of one of its products:

`[10, 20, 20, 30, 40, 40, 40, 50]`

Instead of examining every number individually, we can summarize the dataset:

- How many valid sales records are there?
    
- What was the lowest sale?
    
- What was the highest sale?
    
- How far apart are the lowest and highest sales?
    
- How frequently did each sales value occur?
    

These questions help us understand a dataset before performing more advanced statistical analysis.
## Why it matters
Descriptive statistics are important because they turn raw data into understandable information.

In business, organizations use descriptive statistics to:

- Count customers, transactions, products, or employees.
    
- Identify the highest and lowest sales figures.
    
- Understand the spread between the largest and smallest values.
    
- Identify frequently occurring values.
    
- Check and summarize data before further analysis.
    

These functions also provide a foundation for more advanced statistical methods, including variance, standard deviation, and data distribution analysis.
## How it works
The implementation contains five public functions and one shared helper function called `_prepare_data()`.

### 1. `_prepare_data()`

This helper validates the input and prepares the observations before the statistical functions use them.

Its responsibilities are:

- Check whether the input is iterable.
    
- Reject invalid data types such as strings, Boolean values, and complex numbers.
    
- Treat `None` and floating-point `NaN` as missing observations.
    
- Report the number of missing observations through a warning.
    
- Reject positive and negative floating-point infinity.
    
- Return the valid observations and the number of dropped observations.
    

The helper prevents each public function from repeating the same validation logic.

### 2. `count()`

Counts the number of valid observations.

**Formula:**

[  
n = \text{number of valid observations}  
]

For the dataset:

`[10, 20, 20, 30, 40, 40, 40, 50]`

The result is:

`count(data) = 8`

### 3. `min()`

Finds the smallest observation in the dataset.

For the example dataset:

`min(data) = 10`

The function starts with the first observation as the current minimum and compares every remaining observation against it.

### 4. `max()`

Finds the largest observation in the dataset.

For the example dataset:

`max(data) = 50`

The function starts with the first observation as the current maximum and updates it whenever it encounters a larger value.

### 5. `range()`

Measures the difference between the largest and smallest observations.

**Formula:**

[  
\text{Range} = \text{Maximum} - \text{Minimum}  
]

For the example dataset:

[  
50 - 10 = 40  
]

Therefore:

`range(data) = 40`

### 6. `frequency_table()`

Counts the occurrences of every unique observation.

For the example dataset, the result is:

```python
{
    10: 1,
    20: 2,
    30: 1,
    40: 3,
    50: 1
}
```

The function uses a dictionary:

- Each unique observation becomes a key.
    
- Its frequency becomes the corresponding value.
    
- The resulting dictionary is sorted by numerical value.
## Example
Consider a company that records the number of products sold by a salesperson over eight days.

```python
sales = [10, 20, 20, 30, 40, 40, 40, 50]
```

We can summarize the sales using our five functions:

```python
from stateskol.descriptive import (
    count,
    min,
    max,
    range,
    frequency_table,
)

print("Number of observations:", count(sales))
print("Minimum sales:", min(sales))
print("Maximum sales:", max(sales))
print("Sales range:", range(sales))
print("Frequency table:", frequency_table(sales))
```

Expected output:

```text
Number of observations: 8
Minimum sales: 10
Maximum sales: 50
Sales range: 40
Frequency table: {10: 1, 20: 2, 30: 1, 40: 3, 50: 1}
```

**Business interpretation:**

The salesperson recorded eight valid observations. The lowest daily sales figure was 10 products, while the highest was 50. The difference between them was 40 products. The value 40 occurred most frequently, appearing on three days.
## Common Mistakes
1. **Counting missing observations:** Missing values should not be included in the valid observation count under the current implementation's input policy.
    
2. **Confusing range with the number of observations:** Range is the difference between the maximum and minimum, not the count of values.
    
3. **Forgetting empty datasets:** `count([])` returns `0`, while `min()`, `max()`, `range()`, and `frequency_table()` raise `ValueError` when no valid observations remain.
    
4. **Accepting Boolean values as numbers:** In Python, `bool` is a subclass of `int`. The implementation explicitly rejects `True` and `False`.
    
5. **Ignoring invalid values:** Strings and complex numbers are rejected with `TypeError`; floating-point infinity is rejected with `ValueError`.
    
6. **Silently dropping missing observations:** The implementation warns the user when `None` or `NaN` values are removed.
    
7. **Modifying the original dataset:** The functions should not change the input data.
## Implementation
**File:** `src/stateskol/descriptive.py`

The implementation uses:

- `collections.abc.Iterable` to describe iterable inputs.
    
- `numbers.Real` to validate real-number observations.
    
- `math` to detect floating-point `NaN` and infinity.
    
- `warnings` to report missing observations.
    

A key design decision is using `_prepare_data()` as a shared validation function. This keeps the public functions simpler and makes the input-handling rules consistent.

**Time and space complexity:**

|Function|Time complexity|Auxiliary space|
|---|---|---|
|`_prepare_data()`|O(n)|O(n)|
|`count()`|O(n)|O(n)|
|`min()`|O(n)|O(n)|
|`max()`|O(n)|O(n)|
|`range()`|O(n)|O(n)|
|`frequency_table()`|O(n + k log k)|O(n + k)|

Here, `n` is the number of input observations and `k` is the number of unique valid observations.

The public functions use O(n) auxiliary space because the shared helper materializes the input into a list.

**Testing:**

The implementation is tested in:

`tests/test_descriptive.py`

The test suite checks ordinary inputs, boundary cases, invalid values, missing observations, large integers, and whether the original input remains unchanged.

Current test result:

`25 passed`
## Related Concepts

- [[Descriptive Statistics]]
    
- [[Welford 1962 - Online Variance Algorithm]]
    
- [[Measures of Central Tendency]]
    
- [[Measures of Dispersion]]
    
- [[Frequency Distribution]]
## References
*Introduction to Probability and Statistics for Engineers and Scientists*, sixth edition, by Sheldon M. Ross.*
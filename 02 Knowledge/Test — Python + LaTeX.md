---
type: concept
status: draft
area: statistics
topic: probability
created: 2026-08-14
updated: 2026-08-14
publish-status: draft
---

# Test — Python + LaTeX

## LaTeX Math

Inline math: $E[X] = \sum_x x \cdot P(X = x)$

Display math:

$$
f(x; \mu, \sigma^2) = \frac{1}{\sqrt{2\pi\sigma^2}} e^{-\frac{(x-\mu)^2}{2\sigma^2}}
$$

## Python Execution

```python
import numpy as np
x = np.linspace(0, 1, 5)
print(x)
print("mean:", x.mean())
```

Click the **Run** button (▶) on the code block to execute.

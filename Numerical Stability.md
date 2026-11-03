**Numerical stability** refers to an algorithm's ability to control the accumulation of rounding and approximation errors during computation. Since computers represent numbers with finite precision, repeated arithmetic operations can introduce small errors that grow over time. A numerically stable algorithm minimizes these effects and produces reliable results.

For example, directly computing variance using:

$Var(X)=E[X2]−(E[X])^2$

can lead to significant precision loss for large numbers. More stable algorithms, such as Welford's method, avoid this issue.

**Applications:** Scientific computing, machine learning, optimization, and numerical analysis.
[[Welford 1962 - Online Variance Algorithm]]
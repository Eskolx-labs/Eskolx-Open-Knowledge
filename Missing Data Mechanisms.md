## **1. Missing Data Mechanisms**

Main reading: Rubin (1976), Sections 1–3

### **1.1 What is missing data?**

Missing data occurs when a value that should have been recorded in a dataset is unavailable or unobserved.

For example, imagine a university collects information from 500 students.

|Student ID|Age|Gender|Monthly income|GPA|
|---|---|---|---|---|
|001|21|Male|3,000|3.4|
|002|23|Female|Missing|3.7|
|003|20|Male|2,500|Missing|
|004|22|Female|4,000|3.2|
|005|24|Male|Missing|3.5|

There are missing values in the income and GPA variables.

The important statistical question is not simply:

_How many values are missing?_

It is also:

**Why are those values missing?**

This is the central question addressed by Donald Rubin in his 1976 paper, _Inference and Missing Data_.

Rubin explains that ignoring missing values involves assumptions about the process that caused them to be missing.

people.csail.mit.edu+1

### **1.2 The three missing data mechanisms**

The three commonly used categories are:

1. Missing Completely At Random (MCAR).
    
2. Missing At Random (MAR).
    
3. Missing Not At Random (MNAR).
    

These categories describe the relationship between the probability of a value being missing and the data themselves.

#### **A. Missing Completely At Random (MCAR)**

**Definition:** Data are MCAR when the probability of a value being missing is completely unrelated to both observed and unobserved data.

In simple language, the missingness occurs randomly.

Example:

A researcher collects the heights of 200 students. During data entry, a computer error randomly deletes 10 height measurements.

The deleted measurements have no relationship with:

- Students' heights.
    
- Students' ages.
    
- Students' genders.
    
- Any other recorded characteristics.
    

The missingness is unrelated to the characteristics being studied.

**Important point:** Under MCAR, the observed data are effectively a random subset of the original data.

This makes complete-case analysis less likely to introduce systematic selection bias, although it still reduces the sample size and precision.

#### **B. Missing At Random (MAR)**

**Definition:** Data are MAR when the probability of missingness depends on observed information but does not additionally depend on the missing value itself, after conditioning on the observed information.

Example:

Suppose a university conducts a survey about students' monthly income.

You discover that students with lower recorded ages are more likely to leave the income question unanswered.

The probability of income being missing depends on age, which is observed.

If, after accounting for age, missingness does not depend on the actual unobserved income, the mechanism is MAR.

**Important point:** Missingness is not necessarily completely random. However, it can be explained by information that is already observed.

#### **C. Missing Not At Random (MNAR)**

**Definition:** Data are MNAR when the probability of missingness still depends on the missing value itself, even after accounting for the observed information.

Example:

A researcher asks 200 individuals about their monthly income.

Individuals with particularly high incomes are more likely to refuse to report their income.

Even after accounting for their observed characteristics, the probability of nonresponse depends on the income that is missing.

This is MNAR.

**Important point:** The missingness mechanism contains information about the unobserved values themselves.

### **1.3 Comparison of MCAR, MAR, and MNAR**

MCAR

**Missingness is unrelated to the data.**

Example: Random computer failure deletes some measurements.

MAR

**Missingness depends on observed data.**

Example: Nonresponse depends on students' recorded ages.

MNAR

**Missingness depends on the missing values themselves.**

Example: People with higher incomes are less likely to report their income.

### **1.4 Mathematical understanding**

Let:

- \(Y\) = the variable containing the values we want to study.
    
- \(R\) = an indicator showing whether a value is observed.
    
- \(X\) = other observed variables.
    

We can represent the mechanisms conceptually as follows:

| Mechanism | Relationship                                                   |
| --------- | -------------------------------------------------------------- |
| MCAR      | P(R\| Y,X)=P(R)\)                                              |
| MAR       | P(R\| Y,X)=P(R\mid X)\)                                        |
| MNAR      | P(R\|Y,X)\) depends on \(Y\), even after conditioning on \(X\) |

Here, \(R=1\) means observed and \(R=0\) means missing.

These equations are simplified modern representations of the mechanisms. Rubin's 1976 paper develops the formal missing-data indicator framework and defines MAR alongside the additional condition of observed-at-random (OAR) for certain sampling-distribution inferences.

people.csail.mit.edu+1

### **1.5 Why does the mechanism matter?**

Imagine that you want to calculate the average monthly income of 1,000 university students.

However, 200 students do not report their income.

You have two possible approaches:

1. Ignore the 200 missing observations.
    
2. Apply an appropriate missing-data method.
    

The correct decision depends on the mechanism.

|Mechanism|Statistical implication|
|---|---|
|MCAR|Complete-case analysis can be unbiased under appropriate sampling assumptions, but loses precision.|
|MAR|Methods such as multiple imputation or likelihood-based approaches may be appropriate if their assumptions are satisfied.|
|MNAR|Ordinary MAR-based methods may be inadequate; additional assumptions and sensitivity analysis are needed.|

**Why not simply delete missing values?**

Because deleting them can change the composition of our sample.

For example, if higher-income students systematically refuse to report income, deleting their records can make the calculated average income too low.

This means that the resulting sample may no longer represent the target population.
    

**Main lesson from Rubin:** Missing data are not merely empty cells in a spreadsheet. The process responsible for their absence can influence statistical inference.
![[Missing Data]]

**Related topics**
[[02 Knowledge/Data contract]]
[[Data Audit]]
[[Data Validation]]
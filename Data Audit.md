### **2.1 What is a data audit?**

A data audit is a systematic examination of a dataset to understand its condition, quality, structure, completeness, and suitability for a particular analysis.

In simple language:

**A data audit is checking whether your dataset is trustworthy and ready for analysis.**

Suppose a company gives you an Excel file containing 50,000 customer records and asks you to analyze customer purchasing behavior.

Would you immediately calculate the average purchase amount?

No.

First, you need to understand what the data contain and whether they are reliable.

That is where a data audit comes in.

### **2.2 Objectives of a data audit**

A data audit helps you:

1. Understand the dataset.
    
2. Identify missing values.
    
3. Identify duplicate observations.
    
4. Detect unusual values and potential errors.
    
5. Examine the consistency of variables.
    
6. Understand the source of the data.
    
7. Determine whether the dataset is appropriate for the research objective.
    

### **2.3 Main components of a data audit**

**A. Dataset structure**

Examine the overall organization.

Questions:

- How many rows are there?
    
- How many columns are there?
    
- What does each row represent?
    
- What does each column represent?
    
- What are the variable names?
    
- What are the data types?
    

Example:

|Variable|Data type|Description|
|---|---|---|
|Student_ID|String|Student identification|
|Age|Integer|Student's age|
|GPA|Decimal|Grade point average|
|Gender|Categorical|Student's gender|
|Income|Decimal|Monthly income|

**B. Missing-value examination**

Determine:

- How many values are missing?
    
- Which variables contain missing values?
    
- What percentage of each variable is missing?
    
- Are missing values concentrated in particular groups?
    

A useful formula:

$[ \text{Missing Percentage}= \frac{\text{Number of Missing Values}} {\text{Total Expected Values}}\times100 ]$

Example:

Suppose a dataset contains 1,000 students, and 150 students have missing income information.
[frac{150}\{1000}\times100=15%]

Therefore, 15% of the income observations are missing.

 This calculation tells us how much data is missing, not why it is missing.

**C. Duplicate examination**

A duplicate occurs when a record is repeated.

Example:

|Student ID|Age|GPA|
|---|---|---|
|001|21|3.4|
|002|22|3.5|
|002|22|3.5|
|003|23|3.8|

Student 002 appears twice.

However, not every repeated value represents an error.

For example, two students may legitimately have the same age and GPA.

You should identify duplicates using the appropriate unique identifier or combination of variables.

**D. Outlier examination**

An outlier is an observation that is unusually far from the other observations.

Example:

[ 25,27,29,30, 31, 32,150 ]

The value 150 is unusually high compared with the other observations.

However, an outlier is not automatically an error.

It could be:

- A genuine observation.
    
- A data-entry mistake.
    
- A measurement problem.
    
- An observation from a different population.
    

Tukey's paper is particularly relevant here because he discusses the importance of dealing with unusual observations and developing methods for examining irregular or incomplete data.



**E. Source and provenance examination**

You should also investigate where the data came from.

Questions:

- Who collected the data?
    
- When were they collected?
    
- How were they collected?
    
- What population was covered?
    
- Were the observations obtained through a survey, experiment, or administrative records?
    
- Were any transformations made before you received the dataset?
    

This is important because a dataset can be technically clean but still unsuitable for the research question.

### **2.4 Example of a practical data audit**

Imagine that you receive this dataset:

**University student dataset**

Total records

**1,000**

Variables

**8**

Missing income values

**150**

Duplicate IDs

**12**

**Audit findings**

- 15% of income values are missing.
    
- 12 records have repeated IDs requiring investigation.
    
- Three GPA observations are outside the expected range.
    
- The collection date is not documented.
    

The audit does not automatically correct these problems.

Instead, it documents them so that you can decide how to proceed.
### **2.5 Connection to Tukey and Box**

**Tukey's contribution**

Tukey argues that data analysis is broader than statistical inference.

It includes:

- Planning data collection.
    
- Examining data.
    
- Interpreting results.
    
- Developing appropriate analytical procedures.
    
- Using computing to improve data analysis.
    

This means you should not treat data analysis as simply applying formulas to an existing dataset.

**Box's contribution**

Box argues that scientific learning involves repeated interaction between theory and practice.

You develop a model, compare its implications with actual data, identify discrepancies, and revise your understanding.

He also emphasizes that models are approximations, not perfect representations of reality.

**Application to data auditing:** You should examine whether your data and the assumptions behind your analysis are compatible with the actual problem.
![[90 Attachments/Data Audit|Data Audit]]
**Related concepts**
[[Missing Data Mechanisms]]
[[02 Knowledge/Data contract]]
[[Data Validation]]
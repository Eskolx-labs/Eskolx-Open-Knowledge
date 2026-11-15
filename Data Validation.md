### **3.1 What is data validation?**

Data validation is the process of checking whether data satisfy predefined rules, conditions, formats, and logical requirements.

In simple language:

**Data validation checks whether the values entered into a dataset are acceptable according to established rules.**

For example, imagine a university dataset containing students' ages.

You have established that the dataset concerns undergraduate students aged between 15 and 60.

If one observation has an age of 250, that value should be flagged for investigation.

### **3.2 Objectives of data validation**

Data validation helps ensure:

1. Accuracy of data entry.
    
2. Consistency of formats.
    
3. Appropriate data types.
    
4. Valid numerical ranges.
    
5. Logical relationships between variables.
    
6. Compliance with predefined requirements.
    

### **3.3 Types of data validation**

#### **A. Data type validation**

Checks whether the data have the correct type.

Example:

|Variable|Expected type|Invalid example|
|---|---|---|
|Age|Integer|Twenty|
|GPA|Decimal|Excellent|
|Student ID|Text|An unintended numeric conversion|
|Enrollment date|Date|Yesterday|

For example, if the age variable should contain numerical values, entering "Twenty" violates the expected data type.

#### **B. Range validation**

Checks whether a value falls within an acceptable range.

Example:

Suppose GPA is measured on a 0–4 scale.

$[ 0\leq GPA\leq4 ]$

| GPA | Validation result |     |
| --- | ----------------- | --- |
| 3.2 | Valid             |     |
| 2.5 | Valid             |     |
| 4.0 | Valid             |     |
| 4.5 | Invalid           |     |
| -1  | Invalid           |     |

#### **C. Format validation**

Checks whether values follow a specified format.

Example:

A date should follow:

\[ YYYY-MM-DD \]

Valid:

2026-11-15

Invalid:

15/45/2026

#### **D. Uniqueness validation**

Checks whether values that should be unique are repeated.

For example, each student should have a unique student ID.

|Student ID|Result|
|---|---|
|ST001|Valid|
|ST002|Valid|
|ST003|Valid|
|ST002|Flagged duplicate|

#### **E. Consistency validation**

Checks whether related variables agree logically.

Example:

|Age|Employment status|Validation|
|---|---|---|
|22|Employed|Valid|
|25|Unemployed|Valid|
|30|Employed|Valid|

The values above are not inherently inconsistent.

However, consider a dataset with:

- Date of birth: 2005-01-01
    
- Recorded age: 45
    

If the dataset is intended to describe current ages in 2026, the two variables do not agree.

This record should be investigated.

#### **F. Referential integrity validation**

This is especially important in databases.

It checks whether a reference to another table corresponds to an existing record.

Example:

A student table contains:

|Student ID|Department ID|
|---|---|
|001|D01|
|002|D02|
|003|D09|

The department table contains:

|Department ID|Department|
|---|---|
|D01|Statistics|
|D02|Mathematics|
|D03|Economics|

D09 does not exist in the department table.

Therefore, the third student record violates referential integrity.
**Related topics**
[[Missing Data Mechanisms]]
[[Data Audit]]
[[02 Knowledge/Data contract]]
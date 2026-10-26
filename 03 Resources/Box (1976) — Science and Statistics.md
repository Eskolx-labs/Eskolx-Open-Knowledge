---
type: resource
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Scale_of_justice_2_new.jpeg/500px-Scale_of_justice_2_new.jpeg
status: active
area: statistics
kind: paper
url: https://doi.org/10.1080/01621459.1976.10480949
created: 2026-10-26
updated: 2026-10-26
author: Eskolx Labs
tags: []
publish-status: draft
---

![Box (1976) — Science and Statistics cover](https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Scale_of_justice_2_new.jpeg/500px-Scale_of_justice_2_new.jpeg)

# Box (1976) — Science and Statistics

## What it is

George E. P. Box, "Science and Statistics," *Journal of the American Statistical Association*, 71(356), 1976, pp. 791–799. [doi:10.1080/01621459.1976.10480949](https://doi.org/10.1080/01621459.1976.10480949).

Box argues that statistics is the science of investigation. Investigation is an iterative process. You build a model, check it against data, learn from the difference, and revise. A model is an approximation used for a purpose. It is not a statement to be proved true. The paper also warns against treating a single significance test as the end of an inquiry.

## Why we recommend it

It asks a different question from the rest of the phase. Weeks 2 to 12 teach methods that produce numbers. Box asks what the number is for, what it leaves out, and what should happen when the data disagree with the model.

The paper is read-only. There is no code for it. You will answer questions about it in the one-to-one. A contributor who can implement a test and cannot say what the test assumes is not finished.

## How to use it

- Read the whole paper. It is short.
- Write three sentences before the review. State what a model is for, what it means for a model to be wrong, and what iteration looks like in your week-1 block.
- Bring one assumption in your code that you would defend and one that you would mark provisional. The difference is the point.
- Do not use the paper to argue that "anything goes because models are wrong". Box argues the opposite. Because models are approximations, the assumptions and the checks must be explicit.

## Related Concepts

- [[Tukey (1962) — The Future of Data Analysis]]
- [[Rubin (1976) — Inference and Missing Data]]
- [[Ross — Introduction to Probability and Statistics]]
- [[Population vs Sample]]

## Notes

The one-to-one question for week 1 is this. Which assumption in your code would you defend, and which would you mark provisional? A good answer names the mechanism, for example MCAR for the drop policy, and states what evidence would change the answer. A weak answer says "the data is clean" or "the function works".

The paper is often reduced to an aphorism about models being wrong. The argument is more useful than the aphorism. It tells you to build the check into the method. A docstring, a boundary test, and a reference comparison are that check.

---
type: resource
cover: https://commons.wikimedia.org/wiki/Special:FilePath/OOjs_UI_icon_book-ltr.svg
status: active
area: statistics
kind: book
url: https://www.educate.elsevier.com/book/details/9780128243466
created: 2026-10-26
updated: 2026-10-26
author: Eskolx Labs
tags: []
publish-status: draft
---

![Ross — Introduction to Probability and Statistics for Engineers and Scientists cover](https://commons.wikimedia.org/wiki/Special:FilePath/OOjs_UI_icon_book-ltr.svg)

# Ross — Introduction to Probability and Statistics for Engineers and Scientists

## What it is

Sheldon M. Ross, *Introduction to Probability and Statistics for Engineers and Scientists*, 6th edition, Academic Press, 2020. ISBN 978-0-12-824346-6.

The first half, up to and including chapter 8, sets the order for Phase 01. Chapter 1 is data, populations, samples, and study design. Chapters 2 and 3 are descriptive statistics and probability. Chapters 4 and 5 are random variables, expectation, and the named distributions. Chapter 6 is sampling distributions. Chapters 7 and 8 are estimation and hypothesis testing.

## Why we recommend it

It is an applied upper-undergraduate text. It explains why a method exists before it uses notation. The examples are concrete, and the exercises are solvable by hand. The chapter order matches the order in which the package must be built.

The book also states the assumptions behind each procedure. Those assumptions matter most to this phase. It is not a mathematical-statistics text, and it does not give measure-theoretic foundations. That is acceptable here. The goal is a working, tested package and a correct account of what each function assumes.

## How to use it

- Read the assigned pages before the kickoff call. Bring the definitions you cannot restate.
- Solve the exercises with the functions we build. Do not solve them by hand alone, and do not solve them with numpy alone. Do both, then compare the results. The difference shows what the function adds or hides.
- When an exercise needs a method that the package does not have yet, write it down. That list is the backlog.
- Cite the section in the docstring and in the vault note. "See the book" is not a citation.

Chapter map for the phase:

| Week | Chapter |
| ---: | --- |
| 1 | 1 |
| 2 | 2.1–2.3 |
| 3 | 2.4–2.6 |
| 4 | 3 |
| 5 | 4 |
| 6 | 5.1–5.4 |
| 7 | 5.5–5.9 |
| 8 | 6.1–6.3 |
| 9 | 6.4–6.6 |
| 10 | 7 |
| 11 | 8.1–8.4 |
| 12 | 8.5–8.7 |

The later chapters on regression, ANOVA, categorical analysis, and resampling are not in this phase. They start the next phase.

## Related Concepts

- [[Population vs Sample]]
- [[Sampling Bias]]
- [[Tukey (1962) — The Future of Data Analysis]]
- [[Rubin (1976) — Inference and Missing Data]]
- [[Box (1976) — Science and Statistics]]

## Notes

The book is the specification for what a function accepts and returns. The papers explain why the method is right and where it fails. A function built from the book alone is usually correct on the usual case and silent on the boundary. A function built from the paper alone is usually correct on the boundary and disconnected from the textbook that the cohort shares.

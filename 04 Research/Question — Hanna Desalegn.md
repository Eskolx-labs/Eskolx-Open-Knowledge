---
type: research
cover: 
abstract: Does dropping ungradable retinal images bias the measured accuracy of diabetic retinopathy screening in Ethiopian clinics?
keywords: [missing data, diabetic retinopathy, screening, image quality, correlation]
status: question
area: statistics
project: 
owner: Hanna Desalegn
created: 2026-11-10
updated: 2026-11-24
author: Hanna Desalegn
tags: []
publish-status: draft
---

# Research Question: Hanna Desalegn

> [!question] Question
> In Ethiopian clinics, how much does the measured accuracy of a diabetic retinopathy screening model change when retinal images that are too poor to grade are dropped instead of reported, and is image quality missing at random?

Screening studies often report accuracy only on the images that could be graded and leave out the rest. In clinics with older cameras, undilated pupils and patients with cataracts, a large share of images can be ungradable, and those patients may not be a random slice of the population. Older patients and patients with more advanced disease may be the ones whose images fail. If so, the missing images are not missing completely at random, and an accuracy figure computed only on the gradable images describes a healthier, easier group than the one the clinic actually serves. I want to find out how large that gap is, what the missingness depends on, and what a screening study should report so that its accuracy number can be trusted by someone who was not in the room.

## Week 4 Revision: A relationship a correlation would hide

> [!question] Revised question
> In Ethiopian diabetic retinopathy screening, a correlation between patient age and image gradability will look weak, even though gradability drops sharply after about age 60, so a study that checks missingness with a correlation table would wrongly conclude that age does not drive which images go missing.

Pearson r measures how well a straight line fits, and it can stay small when the true pattern is a threshold or a curve. Image quality may be fine and flat for most adult ages and then fall quickly once cataracts and small pupils become common. A scatter plot or a gradability rate by age band would show that bend, while a single r near zero would hide it. This matters for my Week 2 question: if the missing images depend on age in a way a correlation cannot see, a study could report its images as missing at random when they are not, and the accuracy figure on gradable images would again describe an easier, younger group than the clinic serves.

## Motivation

## Method

## Results

## Discussion

## Open Questions

## Related Concepts

- [[Population vs Sample]]
- [[Sampling Bias]]
- [[Rubin (1976) — Inference and Missing Data|Rubin (1976), Inference and Missing Data]]
- [[Center and Spread]]

## References

- Rubin, D. B. (1976). Inference and missing data. *Biometrika*, 63(3), 581-592.
- Tukey, J. W. (1962). The future of data analysis. *The Annals of Mathematical Statistics*, 33(1), 1-67.

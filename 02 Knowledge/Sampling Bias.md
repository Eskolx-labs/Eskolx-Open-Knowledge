---
type: concept
cover: https://commons.wikimedia.org/wiki/Special:FilePath/ISO_7010_W001.svg
status: draft
area: statistics
created: 2026-09-04
updated: 2026-09-04
author:
tags: []
publish-status: draft
---



# Sampling Bias

## Definition
Sampling bias occurs when a sample is collected in a way that makes some members of the population systematically more or less likely to be included than others, so the sample no longer represents the population it's supposed to describe.
## Intuition
Imagine trying to estimate the average height of everyone in a stadium, but you only measure people sitting in the front row nearest the exit. You didn't pick a "random" front row on purpose  but if that row happens to be where the basketball team is seated, every measurement you take is pulled toward "tall" before you've even started counting. No amount of extra measuring in that same row fixes it; you're measuring the wrong row, not too few people in the right one.
## Why it matters
Sampling bias is more dangerous than plain random error because it does not shrink as the sample grows. A biased survey of 10,000 people is often worse than an unbiased survey of 100, because the large biased sample gives false confidence  the estimate looks precise (small variability) while still being systematically wrong (inaccurate). Recognizing sampling bias is what separates "we have data" from "we have data we can trust."
## How it works
Bias enters through _who gets a chance to be in the sample_ and _who among those chosen actually ends up measured_. Common mechanisms:

- **Selection bias** — the sampling frame itself excludes part of the population (e.g. surveying only landline owners misses people without a landline).
- **Under coverage** — some groups are harder to reach and are underrepresented even if technically included in the frame.
- **Non-response bias** — the people who choose _not_ to respond differ systematically from those who do (e.g. only satisfied customers bother leaving reviews).
- **Voluntary response bias** — the sample is made of people who opted themselves in, who tend to have stronger or more extreme opinions than average.
- **Convenience sampling** — the sample is whoever was easiest to reach (classmates, people passing by), not who was representative.
The fix is not "collect more data" it's designing the selection process (e.g. simple random sampling, stratified sampling) so every population member has a known, nonzero chance of being included.
## Example
A university wants to estimate what fraction of _all_ students support a new library policy. If the survey is only posted in the library itself, only students who already visit the library can respond a group probably more pro-library than the student body as a whole. Even 5,000 responses collected this way will overestimate support; the number needed isn't more responses, it's a different collection method (e.g. sampling from the full student registry).
## Common Mistakes
- Believing a bigger sample size automatically fixes a biased collection method.
- Treating "everyone who responded" as if it were "everyone who was asked"  ignoring non-response bias.
- Confusing sampling bias (a flaw in _how_ the sample was collected) with sampling error (natural randomness that shrinks with sample size) they are not the same problem and don't have the same fix.
## Implementation
```
import numpy as np

# True population: heights of 10,000 people, mean 165 cm
population = np.random.normal(loc=165, scale=8, size=10000)

# Unbiased: simple random sample of 200
unbiased_sample = np.random.choice(population, size=200, replace=False)

# Biased: sample skewed toward the taller half of the population
# (simulates "convenience sampling" from a non-representative subgroup)
tall_subgroup = population[population > np.median(population)]
biased_sample = np.random.choice(tall_subgroup, size=200, replace=False)

print(f"Population mean: {population.mean():.2f}")
print(f"Unbiased sample mean: {unbiased_sample.mean():.2f}")
print(f"Biased sample mean: {biased_sample.mean():.2f}")
```
## Related Concepts
[[Population vs Sample]], [[Sampling Distribution]], [[Random Sampling]], [[Non-Response Bias]], [[Central Limit Theorem]]

## References
- Freedman, D., Pisani, R., & Purves, R. (2007). _Statistics_ (4th ed.). W. W. Norton & Company.
- Diez, D., Barr, C., & Çetinkaya-Rundel, M. _OpenIntro Statistics_ (4th ed.). [https://openintro.org/book/os/](https://openintro.org/book/os/)
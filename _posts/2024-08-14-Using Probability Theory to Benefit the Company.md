---
title: Using Probability Theory to Benefit the Company
date: 2024-08-14 01:20:00 +/-0000
categories: [Mathematics]
tags: [maths, gaming, lethal-company, probabilities]
description: A Probability Theory Analysis of Lethal Company’s Profit Quota System
math: true
---

> This post delves somewhat deeply into some mathematical topics which may not be straightforward to understand. Even I am just trying to learn them! If you'd like to join me in this endeavour, go ahead and read the entire post. If not, feel free to skip to the Results section at the end!
{: .prompt-info }

# A Quick Lesson in Probability Theory

## What Even Is Randomness, Anyway?

Imagine you're flipping a fair coin. How many things can happen?

1. The coin lands on Heads;
2. The coin lands on Tails.

Those are our only two possible _outcomes_. Now, **what are the chances** that each of these actually happens? Intuitively, we know that if we have a fair coin then it's a 50/50 chance of it landing on Heads or Tails... but how do we formalise this mathematically?

Let's try "inventing" a way to do this. Say we have a letter $$X$$ which we define to denote our concept of _outcome_. Next, let's assign a number to each outcome. For simplicity, let's say "1" for when our coin lands on Heads, and "2" for when our coin lands on Tails.

Using this, we can express formulae for concepts like "The probability that the coin lands on Tails is 50%", which becomes $$\Pr(X = 2) = 1/2$$. That is, we have denoted the probability that our outcome (which side the coin lands on) is $$2$$, which is the number we assigned to the event that it lands on Tails, is $$1/2 = 50\%$$.

## Measure-Theoretic Definition of Random Variables

That's all it takes, mostly! We've just defined a [random variable](https://en.wikipedia.org/wiki/Random_variable). Formally, we've come up with a [measurable function](https://en.wikipedia.org/wiki/Measurable_function) $$X : \Omega \rightarrow E$$, where $$\Omega$$ is our _sample space_ and $$E$$ is an arbitrary [measurable space](https://en.wikipedia.org/wiki/Measurable_space). Intuitively, this just means $$X$$ takes one of our possible outcomes, i.e. landing on Heads or Tails, and assigns it a quantity in $$E$$. For this example, we could say $$\Omega = \{\text{Heads}, \text{Tails}\}$$ and $$E = \{1, 2\}$$.

If you want to be **really** pedantic, then the axiomatic [measure-theoretic definition](https://en.wikipedia.org/wiki/Random_variable#Measure-theoretic_definition) of random variables says we need $$\Omega$$ to be the sample space of a [probability space](https://en.wikipedia.org/wiki/Probability_space) $$(\Omega,\mathcal{F},P)$$. This is a fancy way of saying that $$\mathcal{F}$$ is the _event space_, i.e. a set which itself contains sets of possible outcomes, and $$P$$ is the _probability measure_, which assigns each element of the event space a probability between 0 and 1 (i.e. 0% and 100%).

Going back to our coin example, we could have $$\mathcal{F} = 2^\Omega = \{\{\}, \{\text{Heads}\}, \{\text{Tails}\}, \{\text{Heads}, \text{Tails}\}\}$$[^powerset], where the events represent the cases where the coin lands on...

- $$\{\}$$, the empty set, is "Neither heads nor tails";
- $$\{\text{Heads}\}$$ is "Heads";
- $$\{\text{Tails}\}$$ is "Tails";
- $$\{\text{Heads}, \text{Tails}\}$$ is "Either heads or tails".

Intutively, we know there's a 50/50 chance of landing on one of the sides, and we'll always land on one of them (and never in neither), so we could define our proability measure as $$P(\{\}) = 0$$, $$P(\{\text{Heads}\}) = P(\{\text{Tails}\}) = 1/2$$, and $$P(\{\text{Heads}, \text{Tails}\}) = 1$$.

[^powerset]: $$2^A$$ denotes the [power set](https://en.wikipedia.org/wiki/Power_set) of a set $$A$$, which is the set of all possible subsets (combinations of elements) of $$A$$. A _set_ is just a collection of elements.

The standard usage is when $$E = \mathbb{R}$$, in which case we say we have a _real-valued random variable_, or simply a _random variable_ if it's clear from the context.[^realnumbers]

[^realnumbers]: The symbol $$\mathbb{R}$$ denotes the set of [real numbers](https://en.wikipedia.org/wiki/Real_number), which is basically whatever number you can think of: $$2$$ is a real number, so is $$1.2349862342734$$, so are $$\pi$$ and $$\sqrt{5}$$, etc.

## Expected Value (or Average) and Variance

When dealing with things that are random, it's common to say something will happen a certain way "on average". What does this mean for all the formal definitions we're setting up?

When we have a random variable $$X$$ defined as above, it's common to denote the "average outcome", or _expected value_, using $$\text{E}[X]$$. The most formal definition uses the [Lebesgue integral](https://en.wikipedia.org/wiki/Lebesgue_integral) of $$X$$ over $$\Omega$$ with respect to the probability measure $$P$$ as they were defined above, i.e.

$$\text{E}[X] := \int_\Omega X dP,$$

which is essentially a fancy way of saying we go over every possible outcome (even if there's an infinite number of them; welcome to integral calculus) and tally up the probability of each of those outcomes occurring.

Let's look at a simple example. Returning to our coin, remember we assigned the quantity $$1$$ to the outcome that the coin lands on Heads, and $$2$$ for Tails. Then, calculating the average value amounts to the following sum:

$$\text{E}[X] = 1\Pr(X = 1) + 2\Pr(X = 2) = 1\cdot 1/2 + 2\cdot 1/2 = 1/2 + 1 = 3/2 = 1.5.$$

The natural question you could ask would be something along the lines of "1.5? What? That's not one of the quantities we defined!" And you'd be absolutely right! The expected value doesn't always have such a straightforward interpretation. In this case, we could say that the expected value, $$1.5$$, falls right inbetween $$1$$ and $$2$$, which correspond to Heads and Tails, which speaks to the fact that our coin is fair and thus each side is equally probable. If we had a coin that's weighted to fall on Heads more, we might have an expected value closer to $$1$$.

One of the cool things about the expected value is that it constitutes a _linear operator_. That is, if we have two random variables $$X$$ and $$Y$$ and two numbers $$a$$ and $$b$$, then $$\text{E}[aX+bY] = a\text{E}[X] + b\text{E}[Y]$$. This simplifies a lot of calculations, as we'll see later!

Of course, the expected value only gives us an average outcome, and certainly many attempts might yield values that aren't exactly equal to that average outcome. Thus, it might be natural to inquire how we can measure the _deviation_ of any trial from the expected value. This is where the concepts of _variance_ and _standard deviation_ come in! Intuitively, the variance gives us a measure of how far a set of values is spread out from their expected value. The standard deviation is a more easily-interpretable description of how much the values deviate from their expected value. 

Turns out, the variance is defined in terms of the expected value,

$$\text{Var}(X) = \text{E}\left[(X-\text{E}[X])^2\right] = \text{E}[X^2] - \text{E}[X]^2,$$

and the standard deviation is just defined as $$\sqrt{\text{Var}(X)}$$. That is, the variance is the average squared distance between a random variable and its expected value, and the standard deviation is taken to be the square root of the variance. The lower the value of the variance (and therefore also the standard deviation), the closer the values will be to their average. It turns out that the variance operator has the following useful properties which we'll be using later:

1. $$\text{Var}(X + a) = \text{Var}(X)$$;
2. $$\text{Var}(aX) = a^2\text{Var}(X)$$;
3. $$\text{Var}(aX+bY) = a^2\text{Var}(X) + b^2\text{Var}(Y) + 2ab\text{Cov}(X, Y)$$.

$$\text{Cov}(X, Y)$$ denotes the [covariance](https://en.wikipedia.org/wiki/Covariance) of the variables $$X$$ and $$Y$$, and is equal to $$0$$ if the variables are [independent](https://en.wikipedia.org/wiki/Independence_(probability_theory)).

Note: the quantity $$\text{E}[X^2]$$ looks different from the expected value $$\text{E}[X]$$, but it turns out that it can be easily calculated using something called the [law of the unconscious statistician](https://en.wikipedia.org/wiki/Law_of_the_unconscious_statistician). We'll be using this later!

<br><br>

# Applying Probability Theory to Lethal Company

Now that we've established the mathematical tools we will be using, it's time to take a look at what's happening under the hood in Lethal Company.

## A Brief Overview of The Company's Terrible Business Practices

**Lethal Company** is a "co-op horror game about scavenging at abandoned moons to sell scrap to the Company."[^lcsteam] In the game, you (and up to 3 of your friends) take an autopilot spaceship to several dangerous planets in order to collect scrap items which you can sell to your enigmatic employer, only referred to as The Company. The catch is these planets are the home of several monsters or entitites which will promptly dispatch of unsuspecting scavengers who invade their territory.

The Company's ~~terrible~~ totally legal™ and ethical™ business model relies on its employees completing a sequence of _profit quotas_ which they must fulfill in the span of 3 days. Each time you complete a quota, the next quota will be higher. That is, every 3 days there is an increasing amount of profit you must achieve if you don't want the company to ~~promptly dispatch of you very violently~~ fire you with a modest compensation package. This blog post is sponsored by The Company.

[^lcsteam]: From [Lethal Company on Steam](https://store.steampowered.com/app/1966720/Lethal_Company/), as of August 15th, 2024.

## The Quota System

The general idea for the profit quotas is that, each time a player completes a quota, they're sent off to complete the next quota, which is necessarily higher than the previous one. If we look into the game's code, we can see exactly how this happens. The following is the code for the `TimeOfDay.SetNewProfitQuota` function, which handles the calculation of the next quota each time the player completes the previous one.

```csharp
if (!base.IsServer)
    return;

this.timesFulfilledQuota++;
int num = this.quotaFulfilled - this.profitQuota;
float num2 = Mathf.Clamp(1f + (float)this.timesFulfilledQuota * ((float)this.timesFulfilledQuota / this.quotaVariables.increaseSteepness), 0f, 10000f);
num2 = this.quotaVariables.baseIncrease * num2 * (this.quotaVariables.randomizerCurve.Evaluate(Random.Range(0f, 1f)) * this.quotaVariables.randomizerMultiplier + 1f);

this.profitQuota = (int)Mathf.Clamp((float)this.profitQuota + num2, 0f, 1E+09f);

this.quotaFulfilled = 0;

this.timeUntilDeadline = this.totalTime * 4f;
int overtimeBonus = num / 5 + 15 * this.daysUntilDeadline;

this.SyncNewProfitQuotaClientRpc(this.profitQuota, overtimeBonus, this.timesFulfilledQuota);
```

Let's starting by breaking down the relevant parts. The variable `num2` is the amount that gets added to the previous quota to obtain the next quota. The quota itself is, intuitively, the `this.profitQuota` variable. These calculations depend on some parameters contained in the `this.quotaVariables` variable. If we look into the game's code once more, we can see that these are the needed parameters:

| **Variable**           | **Description**       | **Value** |
|------------------------|-----------------------|-----------|
| `startingQuota`        | Starting Quota        | 130       |
| `increaseSteepness`    | Increase Steepness    | 16        |
| `baseIncrease`         | Base Increase         | 100       |
| `randomizerMultiplier` | Randomiser Multiplier | 1         |

There's also a `randomizerCurve` variable, but we'll look into that one more in-depth in the following section.

Let's begin formalising the quota system mathematically. We will use $$Q_n$$ to denote the $$n$$-th quota, i.e. $$Q_1$$ for the first quota, $$Q_2$$ for the second, and so on. We know that the next quota is calculated by adding a value to the previous quota, i.e.

$$\begin{equation}\label{eq:quota_short} Q_{n+1} = Q_n + d_n \end{equation}$$

where $$d_n$$ is the amount that gets added to the previous quota. In the code, $$Q_n$$ is clamped between 0 and $$10^9$$ (one billion), and $$d_n$$ between 0 and $$10^6$$ (one million). However, since these values can never be achieved in regular gameplay, we can ignore the clamping in order to simplify our calculations.

By analysing the code, we can see that $$d_n$$ corresponds to the `num2` variable, which is calculated in these 3 lines of code:

```csharp
this.timesFulfilledQuota++;
float num2 = Mathf.Clamp(1f + (float)this.timesFulfilledQuota * ((float)this.timesFulfilledQuota / this.quotaVariables.increaseSteepness), 0f, 10000f);
num2 = this.quotaVariables.baseIncrease * num2 * (this.quotaVariables.randomizerCurve.Evaluate(Random.Range(0f, 1f)) * this.quotaVariables.randomizerMultiplier + 1f);
```

The `timesFulfilledQuota` variable, which starts at a value of 0, is $$n$$ in our formula. Let's then, for simplicity, denote the inverse of Increase Steepness with $$s$$ (so $$s = 1/16$$), the Base Increase with $$B$$ (so $$B = 100$$), and the Randomiser Multiplier with $$m$$ (so $$m = 1$$). Let's also denote the `randomizerCurve` using a function $$R$$. This yields a formula for $$d_n$$,

$$\begin{equation}\label{eq:delta_quota} d_n = B(1+s n^2)(1 + m R(U_n)), \end{equation}$$

where $$U_n$$ denotes a [continuous uniform distribution](https://en.wikipedia.org/wiki/Continuous_uniform_distribution) in the interval $$[0, 1]$$. In terms of the code, $$R(U_n)$$ represents `randomizerCurve.Evaluate(Random.Range(0f, 1f))`. Expanding Equation $$\eqref{eq:quota_short}$$ in full using Equation $$\eqref{eq:delta_quota}$$, we get an equation fully describing the quota system:

$$\begin{equation}\label{eq:quota_full} Q_{n+1} = Q_n + B(1+s n^2)(1 + m R(U_n)), \end{equation}$$

where the base case is $$Q_1 = 130$$.

Before we analyse this formula further, we need to take a more in-depth look at the randomiser curve $$R$$.

### The Randomiser Curve

In the game's code, the _randomiser curve_ is a function[^unityanimationcurve] which takes as input a random number between 0 and 1 and outputs another value, in order to "increase the randomness" of the output. 

[^unityanimationcurve]: If you want to look into the technical aspect of it, the randomiser curve uses Unity's [AnimationCurve](https://unity.com/blog/games/animation-curves-the-ultimate-design-lever) system.

While decompiling the game's code does not offer a way to directly visualise the shape of the curve, we can hook into the code and output a bunch of values for it so we can plot it using an external graphing tool, like [Desmos](https://www.desmos.com/calculator). Here's what that looks like when using around 100 points on the curve:

![Lethal Company's randomiser curve sampled at 101 points.](/assets/img/posts/2024-08-14-Using%20Probability%20Theory%20to%20Benefit%20the%20Company/randomiser-curve-sampled.png)
*Lethal Company's randomiser curve sampled at 101 points.*

Mathematically, this defines a function $$R : [0, 1] \rightarrow [-1/2, 1/2]$$ which takes as input numbers between 0 and 1 and outputs numbers between -0.5 and 0.5.

While we do not know the exact shape of this curve, nor do we need to for the purposes of the analysis we want to conduct, it might be interesting for the more analytical reader out there to know that the curve can be approximated by a function of the form

$$mx + a \arctan(b\tan(cx+d)+k),$$

where $$m$$, $$a$$, $$b$$, $$c$$, $$d$$, and $$k$$ are constants and the domain of $$x$$ is $$[0, 1]$$. If the values for the constants in the following table are used, then the approximation is quite good, with an $$r^2$$ value of $$0.999$$[^rsquared]. 

| **Constant** | **Approximate Value** |
|--------------|-----------------------|
| $$a$$        | −0.326786244784       |
| $$b$$        | 0.115164070585        |
| $$c$$        | −3.08270565794        |
| $$d$$        | 1.57079632679         |
| $$k$$        | 0.209865018049        |
| $$m$$        | 0.165967731215        |

The explicit formula given by these coefficients is approximately

$$R(x) \approx 0.1659677x − 0.3267862 \arctan(0.1151641\tan(1.570796 − 3.082706x) + 0.2098650).$$

The [Lethal Company Wiki](https://lethal-company.fandom.com/wiki/Profit_Quota) states that the randomiser curve can be approximated using the function

$$\frac{1}{16.6063}\ln\left(\frac{x}{1-x}\right).$$

While this function goes approximate the shape of the original curve, it diverges more from the original curve than the arctangent approximation, as visible in the following comparison. Note that the original curve is coloured green, the Wiki's approximation in blue, and the arctangent approximation in red.

![Comparison between Lethal Company's Randomiser Curve and two approximations.](/assets/img/posts/2024-08-14-Using%20Probability%20Theory%20to%20Benefit%20the%20Company/randomiser-curve-approximations-comparison.png)
*Comparison between Lethal Company's Randomiser Curve and two approximations.*

Nevertheless, the simplicity of the wiki's formula offers a less precise but easier to calculate formula for approximating the randomiser curve.

I've set up [a Desmos plot](https://www.desmos.com/calculator/y9ztkygf3t) where you can play around with this curve. Feel free to play around with the shape of the approximation function!

[^rsquared]: The $$r^2$$ value, called the [coefficient of determination](https://en.wikipedia.org/wiki/Coefficient_of_determination), gives a measure of how well a function approximates a given set of points. Values closer to 1 mean better approximations.

### Explicit Formula for the $$n$$-th Quota

Equation $$\eqref{eq:quota_full}$$ gives what is known as a [recurrence relation](https://en.wikipedia.org/wiki/Recurrence_relation) describing the sequence of quotas $$Q_n$$. 

Turns out this recurrence is somewhat straightforward to solve to obtain a direct, explicit formula for the $$n$$-th quota. Let's start by applying the recurrence relation and seeing if we can notice a pattern:

1. \$$Q_1 = 130$$
2. \$$Q_2 = Q_1 + B(1+s \cdot 1^2)(1 + m R(U_1))$$
3. \$$Q_3 = Q_1 + B(1+s \cdot 1^2)(1 + m R(U_1)) + B(1+s \cdot 2^2)(1 + m R(U_2))$$
4. ...

All we did was replace $$Q_2$$ in the formula for $$Q_3$$, but hopefully you should already see a pattern starting to emerge! It looks like we take $$Q_1$$, the starting quota, then add a term for $$n=1$$, then the same term but with $$n=2$$, and so on. We won't concern ourselves with proving that this is always correct[^induction], and we thus just assume that the $$n$$-th quota is given by

$$\begin{equation}\label{eq:quota_explicit} Q_n = Q_1 + B\sum_{k=1}^{n-1} (1+s k^2)(1 + m R(U_k)). \end{equation}$$

For the less mathematically-inclined but tech-savvy readers out there, [that large scary symbol is just a `for` loop](https://x.com/FreyaHolmer/status/1436696408506212353), and it's known as the _summation operator_.

[^induction]: Although we could probably prove it using a technique known as [mathematical induction](https://en.wikipedia.org/wiki/Mathematical_induction).

In theory, this formula describes the random variable $$Q_n$$ and we could thus obtain a function, known as a _probability density_, describing the probability of $$Q_n$$ taking each possible number value. However, note that since each $$R(U_k)$$ term in the sum is itself a random variable, we're dealing with an arbitrary sum of random variables, and doing [algebra with random variables](https://en.wikipedia.org/wiki/Algebra_of_random_variables) really complicates things. You could even say it gets _convoluted_ - [literally](https://en.wikipedia.org/wiki/List_of_convolutions_of_probability_distributions).

In order to simplify our calculations, let's go back to the beginning of this post and try to analyse the **average** $$n$$-th quota.


### Calculating the Average Quota

Since we have obtained a general formula for $$Q_n$$, the $$n$$-th quota, we can simply denote its average value as $$\text{E}[Q_n]$$ and use the formula in Equation $$\eqref{eq:quota_explicit}$$, obtaining

$$\text{E}[Q_n] = \text{E}\left[Q_1 + B\sum_{k=1}^{n-1} (1+s k^2)(1 + m R(U_k))\right].$$

How on Earth do we calculate anything with this monstrosity? Well, remember how I said the expected value operator was linear? Recall that, if we have two random variables $$X$$ and $$Y$$ and two numbers $$a$$ and $$b$$, then $$\text{E}[aX+bY] = a\text{E}[X] + b\text{E}[Y]$$. This lets us simplify the above equation to the simpler form

$$\text{E}[Q_n] = Q_1 + B\sum_{k=1}^{n-1} (1+s k^2)(1 + m \text{E}[R(U_k)])$$

where, since every $$U_k$$ (for all $$k$$) is identically distributed, we can factor out the $$(1 + m \text{E}[R(U_k)])$$ to obtain

$$\text{E}[Q_n] = Q_1 + B(1 + m \text{E}[R(U)])\sum_{k=1}^{n-1} (1+s k^2).$$

Finally, it turns out that the sum gives rise to an explicit formula[^squarepyramidalnumbers], allowing us to write

$$\text{E}[Q_n] = Q_1 + \frac{1}{6} B(1+m\text{E}[R(U)])(n-1)(2s n^2 - sn + 6).$$

[^squarepyramidalnumbers]: By way of some simple algebra along with what's known as the formula for the [square pyramidal numbers](https://en.wikipedia.org/wiki/Square_pyramidal_number).

Almost there! We're so close to an explicit formula for the average $$n$$-th profit quota. All we're missing is a way to get rid of the $$\text{E}[R(U)]$$ term, which we haven't calculated yet. Thankfully, this is straightforward using the [law of the unconscious statistician](https://en.wikipedia.org/wiki/Law_of_the_unconscious_statistician):

$$\text{E}[R(U)] = \int_{-\infty}^{+\infty} R(x) f_U(x) dx = \int_{0}^{1} R(x) dx$$

But... how do we calculate the integral of $$R(x)$$ if we don't know its exact shape? Well, we don't need to! We can obtain a reasonable approximation using a [Riemann sum](https://en.wikipedia.org/wiki/Riemann_sum)[^integrability]:

$$\int_{0}^{1} R(x) dx = \lim_{N\rightarrow\infty}\sum_{i=1}^{N} R(x_i) \Delta x_i,$$

[^integrability]: Note that we're assuming the function $$R(x)$$ is [Riemann integrable](https://en.wikipedia.org/wiki/Riemann_integral#Integrability) in the interval $$[0, 1]$$.

where the points $$x_i$$ are the points we already sampled to visualise the shape of the curve! Since these points were equally-spaced and we chose $$N$$ of them, then $$\Delta x_i = 1/N$$. If we use $$N=100000$$ points, we get the following approximation:

$$\text{E}[R(U)] = \int_{0}^{1} R(x) dx \approx \frac{1}{N}\sum_{i=1}^{N} R(x_i) = 0.01196886.$$

And that's it! We have a general formula for approximating the $$n$$-th profit quota in Lethal Company:

$$\text{E}[Q_n] \approx Q_1 + \frac{1}{6} B(1+0.01196886m)(n-1)(2s n^2 - sn + 6),$$

or, by using the known values for the coefficients,

$$\text{E}[Q_n] \approx 130 + \frac{50.598443}{3}(n-1)\left(\frac{n^2}{8}  - \frac{n}{16} + 6\right).$$


### Calculating the Quota Variance

We already have an explicit formula for the average quota, but... how do we know how close the quota will actually be to this value? Can we calculate the standard deviation?

**Yes!** Let's do it. We can start by using Equation $$\eqref{eq:quota_full}$$ to write

$$\text{Var}(Q_{n + 1}) = \text{Var}\left(Q_n + B(1+s n^2)(1 + m R(U_n))\right).$$

Now, while $$Q_{n+1}$$ depends on the random value taken by $$U_n$$, the previous quota $$Q_n$$ does not depend on $$U_n$$, and we can thus say the two are independent. Then, using the properties for the variance operator we saw at the beginning of the post, we can simplify this formula to

$$\begin{equation}\label{eq:variance_full} \text{Var}(Q_{n + 1}) = \text{Var}(Q_n) + (mB(1+s n^2))^2 \text{Var}(R(U_n)). \end{equation}$$

Since $$\text{Var}(X) = \text{E}[X^2] - \text{E}[X]^2$$, we can calculate the variance of $$R(U_n)$$ to be

$$\text{Var}(R(U_n)) = \text{E}[R^2(U_n)] - \text{E}[R(U_n)]^2.$$

We already know the value for $$\text{E}[R(U_n)]$$, and $$\text{E}[R^2(U_n)]$$ can once again be obtained using the law of the unconscious statistician along with a Riemann sum:

$$\text{E}[R^2(U_n)] = \int_{0}^{1} R^2(x) dx \approx 0.02230549.$$

We can then solve the recurrence in Equation $$\eqref{eq:variance_full}$$ very similarly to how we solved Equation $$\eqref{eq:quota_full}$$, yielding the general formula

$$\text{Var}(Q_n) = \frac{m^2B^2(\text{E}[R^2(U_n)] - \text{E}[R(U_n)]^2)}{30}(n-1)(6s^2n^4-9s^2n^3+s(s+20)n^2+s(s-10)n+30),$$

or, once again using the known values for the coefficients,

$$\text{Var}(Q_n) \approx \frac{1000(0.02230549 - 0.01196886^2)}{3}(n-1)\left(\frac{3n^4}{128} - \frac{9n^3}{256} + \frac{321n^2}{256} - \frac{159n}{256} + 30\right).$$

I've set up [a Desmos plot](https://www.desmos.com/calculator/3xpasz2qsa) where you can play around with the formulae for the average quota and the variance.

### Total Scrap Required and Average Per Day

There are two more formulas which we can easily obtain from the expected quota value. Let $$T_n$$ denote the total amount of scrap value needed to meet the $$n$$-th quota, and $$D_n$$ the scrap value needed to collect per day to meet the $$n$$-th quota. Then, we have

$$T_n = \sum_{k=1}^{n} Q_k$$

and

$$D_n = \frac{T_n}{3n} = \frac{1}{3n} \sum_{k=1}^{n} Q_k.$$

Intuitively, the total scrap value needed to complete any quota is that quota along with the sum of all previous quotas, and we can divide this value by the number of days from the beginning of the game (3 days per quota) to get the daily scrap value needed.

The expected value for these quantities is given directly by the expected value of $$T_n$$,

$$\text{E}[T_n] = Q_1 + \sum_{k=2}^{n} \text{E}[Q_k] = nQ_1 + \frac{B(1+m\text{E}[R(U)])}{6}  \sum_{k=2}^{n} (k-1)(2s k^2 - sk + 6),$$

where the sum can itself be evaluated to give the general closed formula

$$\text{E}[T_n] = nQ_1 + \frac{B(1+m\text{E}[R(U)])}{12} n(n-1)(sn^2+sn+6).$$

From this, we easily obtain

$$\text{E}[D_n]= \frac{Q_1}{3} + \frac{B(1+m\text{E}[R(U)])}{36} (n-1)(sn^2+sn+6).$$

The variance (and therefore the standard deviation) of these variables cannot be easily calculated as for the $$n$$-th quota, as they are formed by sums of **dependent** random variables. We'll just have to make do with the average value.

Finally, using the explicit values for the coefficients we can write

$$\text{E}[T_n] \approx 130n + \frac{101.196886}{12} n(n-1)\left(\frac{n^2}{16}+\frac{n}{16}+6\right)$$

and

$$\text{E}[D_n] \approx \frac{130}{3} + \frac{101.196886}{36} (n-1)\left(\frac{n^2}{16}+\frac{n}{16}+6\right).$$

<br><br>

# Results

## General Formulae

The **average value of the $$n$$-th profit quota** can be approximated by

$$\text{E}[Q_n] \approx 130 + \frac{50.598443}{3}(n-1)\left(\frac{n^2}{8}  - \frac{n}{16} + 6\right).$$

The **variance of the $$n$$-th profit quota** can be approximated by

$$\text{Var}(Q_n) \approx \frac{1000(0.02230549 - 0.01196886^2)}{3}(n-1)\left(\frac{3n^4}{128} - \frac{9n^3}{256} + \frac{321n^2}{256} - \frac{159n}{256} + 30\right).$$

The **average total scrap value required to complete the $$n$$-th quota** can be approximated by

$$\text{E}[T_n] \approx 130n + \frac{101.196886}{12} n(n-1)\left(\frac{n^2}{16}+\frac{n}{16}+6\right)$$

The **average scrap value collected per day required to complete the $$n$$-th quota** can be approximated by

$$\text{E}[D_n] \approx \frac{130}{3} + \frac{101.196886}{36} (n-1)\left(\frac{n^2}{16}+\frac{n}{16}+6\right).$$

## Quota Table

The following is a table, much like [the one in the Lethal Company Wiki](), showing the average quota values, along with the total scrap value required to collect and how that translates to the average scrap value collected per day.

|   **Quota** | **Average $$\pm$$ Standard Deviation**   |   **Average Total Required** |   **Average per Day** |
|-------------|------------------------------------------|------------------------------|-----------------------|
|           1 | 130                                      |                          130 |                    43 |
|           2 | 238 $$\pm$$ 18                           |                          368 |                    61 |
|           3 | 364 $$\pm$$ 27                           |                          732 |                    81 |
|           4 | 522 $$\pm$$ 37                           |                         1254 |                   104 |
|           5 | 725 $$\pm$$ 48                           |                         1978 |                   132 |
|           6 | 984 $$\pm$$ 62                           |                         2962 |                   165 |
|           7 | 1313 $$\pm$$ 79                          |                         4275 |                   204 |
|           8 | 1724 $$\pm$$ 100                         |                         5999 |                   250 |
|           9 | 2230 $$\pm$$ 125                         |                         8228 |                   305 |
|          10 | 2843 $$\pm$$ 154                         |                        11072 |                   369 |
|          11 | 3577 $$\pm$$ 188                         |                        14649 |                   444 |
|          12 | 4444 $$\pm$$ 228                         |                        19092 |                   530 |
|          13 | 5455 $$\pm$$ 272                         |                        24548 |                   629 |
|          14 | 6626 $$\pm$$ 322                         |                        31173 |                   742 |
|          15 | 7966 $$\pm$$ 378                         |                        39140 |                   870 |
|          16 | 9491 $$\pm$$ 439                         |                        48631 |                  1013 |
|          17 | 11211 $$\pm$$ 507                        |                        59842 |                  1173 |
|          18 | 13140 $$\pm$$ 581                        |                        72982 |                  1352 |
|          19 | 15291 $$\pm$$ 662                        |                        88272 |                  1549 |
|          20 | 17675 $$\pm$$ 749                        |                       105947 |                  1766 |

If you're curious[^pythoncode], I fully generated this table using the following Python code. Feel free to use it if you want!

```python
import math
from tabulate import tabulate

def average(n: int) -> float:
    return 130 + (50.598443 / 3) * (n-1) * ((n**2)/8 - n/16 + 6)

def variance(n: int) -> float:
    coefficient = 1000 * (0.02230549 - 0.01196886**2) / 3
    return coefficient * (n - 1) * ((n**4)*3/128 - (n**3)*9/256 + (n**2)*321/256 - n*159/256 + 39)

def standard_deviation(n: int) -> float:
    return math.sqrt(variance(n))

def total(n: int) -> float:
    return 130 * n + (101.196886 / 12) * n * (n - 1) * ((n**2)/16 + n/16 + 6)

def daily(n: int) -> float:
    return total(n) / (3 * n)

table: list[list] = []
for k in range(1, 21):
    table.append([
        k,
        f'{round(average(k))} $$\\pm$$ {round(standard_deviation(k))}',
        round(total(k)),
        round(daily(k))
    ])
print(tabulate(
    table,
    headers=['**Quota**', '**Average $$\\pm$$ Standard Deviation**', '**Average Total Required**', '**Average per Day**'],
    tablefmt="github")
)
```

[^pythoncode]: And because I wholeheartedly support [reproducible research](https://en.wikipedia.org/wiki/Reproducibility#Reproducible_research).

<br><br><br><br>

**Footnotes**

---
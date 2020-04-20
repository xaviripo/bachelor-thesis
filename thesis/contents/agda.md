# A Little Bit of Agda

TODO Explain some notions of Agda


## Rewriting

One of the great challenges that proof assistants are currently facing is the proper implementation of higher inductive types.

Agda provides a powerful tool called `postulate`. The keyword `postulate`, when prepended to any element definition, converts the element into an *axiom*, in the type theoretic sense: we force Agda to act as if an element of such type existed. As a simple example, one can impose the law of the excluded middle (LEM):

```agda
postulate
  lem : ∀ {i} {A : Type i} → A + ¬ A
```

where `+` represents the union of types and `¬` the negation of a type. This function can not be proved--but it's not inconsistent with the rest of the type theory either.

It's easy to see how we can benefit from this:

```agda
data S¹ : Type₀ where
  base : S¹

postulate
  loop : base == base
```

We *impose* that `loop` exists. And even though we already knew that `base == base` is inhabited (through the reflexive path `refl`), as we are working `--without-K` Agda does not reduce `loop` to `refl`, and so we have a type with a single element and a non-trivial path: the circle. Similarly, one could go on to build higher paths with `postulate`.

But `postulate` (used like this) can be dangerous. For example, if one tries to define the interval:

```agda
data I : Type₀ where
  i0 : I
  i1 : I

postulate
  path : i0 == i1
```

it is possible to reach a contradiction, proving that `i0` is not equal to `i1` (i.e. `i0 == i1` is empty). Further technical complications can show up.

A ultimate solution has not been come up with yet, but Agda has implemented a neat feature to add on top: *rewriting*. Rewriting allows the user to tell Agda that certain expressions should reduce to particular elements. Whereas postulates just tell Agda to believe that a certain element exists, rewriting rules go deeper into its internal logic and tell it how we want to reduce axioms. As with raw postulates, this can be dangerous--even more so, as rewriting rules give us stronger power to violate type consistency. But when used with care, we can achieve this:

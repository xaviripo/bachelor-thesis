## Homotopy Type Theory in Agda {#sec:agda-hott}

### An example

Let us treat a simple hands on example: the commutativity of addition of natural numbers.
The full source code of this proof is available in the attachments.

First, as a preamble, we deactivate uniqueness of identity proofs using `{-# OPTIONS --without-K #-}`{.agda} and construct a few basic definitions regarding equality.

We begin the actual content by defining the naturals and their addition operation:

```agda
  -- Natural numbers
  data ℕ : Type lzero where
    zero : ℕ
    succ : ℕ → ℕ

  -- Addition of naturals
  _+_ : ℕ → ℕ → ℕ
  zero + m = m
  (succ n) + m = succ (n + m)
```

The definition of the natural numbers as an inductive type has already been seen.
For the addition, we take the classical recursive definition.

These two definitions might seem simple enough, but their translation into type theory actually requires quite some of the theory explained so far.
The data type is actually an inductive type, which means that it naturally has an elimination principle.
This elimination principle is implicitly used in the definition of `_+_`{.agda}, as it is a function that "eliminates" natural numbers (even if it does so into *other* natural numbers).
The appearance of the eliminator is patent in the fact that we use case analysis (also known as pattern matching) on each constructor: one entry for `zero`{.agda} and one for `succ`{.agda}.
Case analysis could be further used on the second argument, but this definition does not require it.

Now, we proceed to prove a lemma:

```agda
  -- Proof that 0 is right identity of addition
  add-right-id : (n : ℕ) → (n + zero) == n
  add-right-id zero = idp
  add-right-id (succ n) =
    (succ n) + zero
      =⟨ idp ⟩
    succ (n + zero)
      =⟨ ap (succ) (add-right-id n) ⟩
    succ n
      =∎
```

A few things to note here.

First of all, we remember that theorems (or lemmas) take the shape of types, whereas proofs are their inhabitants.
We can identify every part in the example above.
The statement of the lemma is the type of `add-right-id`{.agda}, namely `(n : ℕ) → (n + zero) == n`{.agda}.
This is the type of functions that take a natural number `n`{.agda}, and return an equality between `n + zero`{.agda} and `n`{.agda}.
The proof will be the function `add-right-id`{.agda} that we are defining.

Once again we use the eliminator through pattern matching.
In the case of `zero`{.agda}, we only write `refl`{.agda}.
This means that we trust Agda to apply the addition to the two terms (`zero + zero`{.agda}).
By the definition of `_+_`{.agda}, any addition with `zero`{.agda} as a left-hand side term, is reduced (definitionally) to the right-hand side.
Hence, we obtain `zero`{.agda}, which is equal to itself through `refl`{.agda}.
So, effectively, when building the proof, we are saying "`zero + zero`{.agda} is the same thing as `zero`{.agda}, and the proof is the path `refl`{.agda}".

The second part might look more daunting, but is not much more difficult.
Some of the imports at the top of the file define a syntax that allows us to define proofs given by the concatenation of multiple paths by writing them out in a readable way.

Suppose we have paths `p : a == b`{.agda}, `q : b == c`{.agda}, and `r : c == d`{.agda}.
Instead of just writing the concatenation of the paths `p ∙ q ∙ r`, the homotopy type theory library (and other libraries too) gives us a way to write it out as:

```agda
a =⟨ p ⟩ b =⟨ q ⟩ c =⟨ r ⟩ d =∎
```

This is actually the same as `p ∙ q ∙ r`{.agda}, but resembles much more what we have in mind when writing the proof, and so is the generally preferred style.

Back to the proof, we first state that `(succ n) + zero`{.agda} is the same thing as `succ (n + zero)`{.agda}.
We do not provide any path as proof, as they are definitionally equal (in particular, by the definition of `_+_`{.agda} when the first operator uses `succ`{.agda}).

The second step is more interesting.
We use `ap` to take a path of type `(n + zero) == n`{.agda}, apply `succ`{.agda} to both sides of the equality, and obtain a new path of type `succ (n + zero) == succ n`{.agda}.
Observe that the path of type `(n + zero) == n`{.agda} chosen is `add-right-id`{.agda} itself.
One might fear that the recursive call gets stuck for ever.
But, since we invoke `add-right-id n`{.agda} from the case of `add-right-id (succ n)`{.agda}, we are going "down" the stack of `succ`{.agda}s, and so it will end up reducing to the base case `add-right-id zero`{.agda}.
In contrast to some other programming languages, Agda is capable of knowing whether a recursive call will end or not, so we must not worry about infinite recursion.

We are now ready to prove the main theorem:

```agda
  -- Proof of the commutativity of addition
  add-comm : (n m : ℕ) → (n + m) == (m + n)
```

Similarly to the lemma, this proof is a dependent function.
It takes any two natural numbers, `n`{.agda} and `m`{.agda}, and returns a path joining `n + m`{.agda} and `m + n`{.agda}.
This proof is longer than that of the lemma, mainly because now we have to pattern match on two variables instead of one.

```agda
  add-comm zero zero = idp
```

The case for `zero + zero`{.agda} is trivial.

```agda
  add-comm (succ n) zero =
    (succ n) + zero
      =⟨ add-right-id (succ n) ⟩
    succ n
      =⟨ idp ⟩
    zero + (succ n)
      =∎
```

This case does not introduce any new tools either.
We start off by applying the lemma.
Then, `succ n`{.agda} is equal to `zero + (succ n)`{.agda} by definition of `_+_`{.agda}.

```agda
  add-comm zero (succ m) =
    zero + (succ m)
      =⟨ idp ⟩
    succ m
      =⟨ ! (add-right-id (succ m)) ⟩
    (succ m) + zero
      =∎
```

Here we do the same, but in the opposite order.
In consequence, we have to "reverse" the path of type `(succ m) + zero == succ m`{.agda} to obtain one of type `succ m == (succ m) + zero`{.agda} via `!`{.agda}, which is known as the path reversal operator $p \mapsto p^{-1}$ in homotopy type theory.

The last case is the longest:

```agda
  add-comm (succ n) (succ m) =
    (succ n) + (succ m)
      =⟨ idp ⟩
    succ (n + (succ m))
      =⟨ ap (succ) (add-comm n (succ m)) ⟩
    succ ((succ m) + n)
      =⟨ idp ⟩
    succ (succ (m + n))
      =⟨ ap (succ) (ap (succ) (add-comm m n)) ⟩
    succ (succ (n + m))
      =⟨ idp ⟩
    succ ((succ n) + m)
      =⟨ ap (succ) (add-comm (succ n) m) ⟩
    succ (m + (succ n))
      =⟨ idp ⟩
    (succ m) + (succ n)
      =∎
```

It is reduced to previous cases through recursion with the help of `ap`{.agda} and the definition of `_+_`{.agda}.

This concludes the proof.
Now, it can be applied as such:

```agda
  _ : (1 + 2) == (2 + 1)
  _ = add-comm 1 2
```

We could go a step further and mark the arguments `n`{.agda} and `m`{.agda} as implicit, so that we could invoke this theorem just by writing `add-comm`{.agda} without parameters, but we leave them explicit for illustrative purposes.

An interesting observation is that both the definitions and the theorems are implemented by defining Agda functions.
What does this entail?
First, this clearly embodies the philosophy of constructivism: the proofs are elements of a type.
The consequences are subtle but important: proving something is the same as making a valid definition.
Conversely, all definitions in type theory (and thus Agda) are "valid".
In conventional mathematics, one might impose a definition and then study it to prove it is valid in some sense.
Of course, this just is a way of hiding the fact that we prove a theorem that enables such definition to exist, we just present it in the opposite order.
In type theory the same is as true, if not even more.
The construction of an object often requires pieces that we have to previously construct, and those can sometimes be theorems, so many times we will see that defining something is as hard as proving something.
In the end, one could even argue that whether a particular term should be deemed as a "definition" or as a "proof" on paper, is a matter of opinion.


### Higher inductive types

Higher inductive types, although easy to explain, are very hard to implement.
Classical Agda does not offer a native way to implement higher inductive types.
A variant, known as Cubical Agda, which enables creating some higher inductive types, has recently been released, but the homotopy type theory project has not yet been ported to Cubical Agda.

Mathematicians have looked for alternate tricks for implementing higher inductive types.

The "naive" way to introduce higher inductive types is through postulates. `postulate`{.agda} is a keyword in Agda that introduces an axiom.
One could easily define the circle as:

```agda
data S¹ : Set where
  base : S¹

postulate
  loop : base == base
```

First, we create a type with a single point constructor `base`{.agda}, and then tell Agda that there exists a path `loop`{.agda} from `base`{.agda} to `base`{.agda}.

This method has a couple of issues.
The first and most obvious, postulates are a dangerous tool.
One could easily define:

```agda
data ⊥ : Set where
-- Nothing here

postulate
  impossible : ⊥
```

We have defined the empty type $\bot$ (what we call \zero in homotopy type theory), and through postulates we have introduced an element of the type.
This creates an inconsistency which allows us to prove anything.

Another reason why this is complicated is that we do not get the full elimination principle, as Agda is not aware that `loop` is a constructor of the higher inductive type.
This issue can be taken care of by being aware of it and introducing `loop`{.agda} "by hand" in the definitions that require it.

A refinement of this technique, due to @licata_running_2011, and which came to be known as "Licata's trick", makes it all safer by using modules.

The idea is to build the type inside a module.
Now, instead of exposing the whole type, we postulate a function that simulates the elimination principle and expose that instead.
The users of the type then only use the elimination principle as a function, which is more cumbersome but also safer, as there is not need for further postulates.
One only has to trust whoever has defined the type to do it correctly in the first place.

## The Language

Agda is a purely functional programming language.
A more common programming paradigm is imperative, in which the programmer writes instructions for the computer to execute in order, modifying the state of a program (e.g. changing the value of variables).
In contrast, a functional language does not hold any state, hence there are no varibles with mutable values, only constants.
Instead of changing the values along the way, the programmer instead tries to build a constant the value of which is obtained through chains of function applications.


### Modules {#sec:agda_language_modules}

Code in Agda is compartmentalized in modules, which can be nested (`moduleA.moduleB`{.agda}).
This is useful in order not to pollute the global namespace with lots of definitions.

Every Agda program must declare a module named after the file that contains it, for example a file `Test.agda` should expose a module:

```agda
module Test where

-- Contents of the module go here
```

If we are working on a project with multiple files, then the root module of each file has to respect the folder structure respect to some folder that we want Agda to consider the "root":

```agda
-- File this/is/a/Test.agda
module this.is.a.Test where
```

To use other modules in our project, we just import them:

```agda
import some.other.things
```

We can choose to import only part of the definitions in the module (`import A using (a1; a2; a3)`{.agda}), import all but a few (`import A hiding (a4; a5; a6)`{.agda}) or import with a different name (`import A renaming (a1 to a)`{.agda}).

It is often useful to be able to re-export the definitions in a module, as if they had been defined locally.
For example:

```agda
module A where
  a = ?

-- We can use A.a
b = A.a

open A

-- Now we can directly use the definitions of A
c = a
```


### Function types

Agda incorporates very few basic constructs.
The two most important ones are type assignment and definition.

We write

```agda
a : A
```

to express that there is a constant `a`{.agda} of type `A`{.agda}.

We write

```agda
a = b
```

To define `a`{.agda} as having value `b`{.agda}.
This makes Agda's `=`{.agda} operator equivalent to homotopy type theory's $:\equiv$, rather confusingly.
Conversely, for identity types, `≡`{.agda} is generally used, or sometimes `==`{.agda}, depending on the library.

Agda incorporates dependent function types.
A non-dependent function between types `A`{.agda} and `B`{.agda} is written like so:

```agda
f : A → B
```

If `B`{.agda} is actually a type family on `A`{.agda} (`B : A → Set`{.agda}), then we can write:

```agda
f : (a : A) → (B a)
```

Function definition can be done through $\lambda$-abstraction:

```agda
suc : Nat → Nat
suc = λ n → (n + 1)
```

But often it is done through case analysis, which corresponds to applying the principle of type induction of the domain type.

```agda
factorial : Nat → Nat
factorial 0 = 1
factorial (suc n) = (suc n) * (factorial n)
```

Agda provides many syntactic facilities for functions.
For example, we can write `(a : A) → (b : B)`{.agda} as `(a : A) (b : B)`{.agda}, and `(a : A) → (b : A)`{.agda} as `(a b : B)`{.agda}.
If we trust Agda can infer the type of an argument, we can write `(a : _)`{.agda} or `∀ a`{.agda} instead.

Functions admit optional arguments, which the type checker has to be able to deduce.
The most common use case is when a type that follows already implies the argument, such as in the case of dependent types:

```agda
f : {a : A} → (b : B a) → (C b)
{- No need to provide a as it was marked as {optional} and we can deduce it
from the type of b -}
f b = ?
```

Finally, we can present functions as infix operators by using `_`{.agda} as a placeholder for the arguments:

```agda
_+_ : Nat → Nat → Nat
0 + 0 = 0
0 + (suc n) = suc n
(suc n) + 0 = suc n
(suc n) + (suc m) = suc (suc (n + m))
```

Notice that Agda admits recursive definitions as long as they can be reduced down to an initial step, as the compiler incorporates a termination checker that ensures we do not write infinite recursions.


### Universe types

Agda provides a type `Set`{.agda} of types. The name is a little misleading, as, from a homotopy type theory point of view it represents the universe of small types, rather than the universe of sets (what we call $0$-types).
`Set`{.agda} is actually shorthand for `Set lzero`{.agda}, which represents the first type in a hierarchy of universes indexed by a type `Level`{.agda}.
This exists to avoid Russell's paradox (which makes `Set : Set`{.agda} impossible).
Instead, Agda defines a chain of universes: `Set lzero : Set (lsuc lzero)`{.agda}, etc.
While this is not relevant for the math behind the proofs we will develop, it is very much present in the actual code, especially in the form of universe polymorphism, which allows us to parametrize the universe level.
For example, if we wanted to write an identity function that applies to *all* types, we would have to do it like so:

```agda
id : {n : Level} → {A : Set n} → A → A
id x = x
```

This is saying: "`id`{.sh} is a function that, for any universe level, and for any type in that level, is the identity function".


### Record types

Besides function types and universes, Agda has a native structure called `record`{.agda}.
In broad terms, it generalizes the dependent pair type to be indexed by names.
As a trivial example, tuples can be seen as an instance of a record type:

```agda
record Pair (A B : Set) : Set where
  field
    fst : A
    snd : B
```

Now, we can instantiate a pair like so:

```agda
p : Pair Nat Nat
p = record { fst = 0; snd = 1 }
```

By providing a `constructor`{.agda} directive, we can define a custom notation for the introduction rule of that type:

```agda
record Pair (A B : Set) : Set where
  constructor _,_
  field
    fst : A
    snd : B

p : Pair Nat Nat
p = 0 , 1
```


### Data types

Finally, Agda offers the `data`{.agda} syntax that plays the role of inductive types.

```agda
data Nat : Set where
  zero : Nat
  suc  : Nat → Nat
```

Data types also admit parameters themselves:

```agda
data List (A : Set) : Set where
  [] : List A
  _∷_ : List A → List A
```

When a given parameter can have different values for each constructor, we move it to the right side of the `:`{.agda} and call it an index.
In the following example, `(A : Set)`{.agda} is a parameter but `Nat` is an index:

```agda
data Vector (A : Set) : Nat → Set where
  []  : Vector A 0
  _∷_ : {n : Nat} → A → Vector A n → Vector A (suc n)
```


### Built-ins

In some instances, Agda offers special treatment for some types, type constructors, and functions.
We explain the most common ones.

The definition of natural numbers as seen above (i.e. an inductive type with two constructors) is not really efficient from the machine's point of view.
To harness the potential of the computer but still be able to treat the naturals as an inductive type, Agda offers a `Nat`{.agda} built-in type.
In order to use it we just have to import it:

```agda
open import Agda.Builtin.Nat
```

This adds the type `Nat`{.agda} with constructors `zero`{.agda} and `suc`{.agda} to the current scope, as well as some operators like `+`{.agda} and `-`{.agda} which are also optimized.

To offer the utmost flexibility, we can also mimic these built-ins ourselves and then tell the compiler we want it to use the efficient internal representation:

```agda
data Nat : Set where
  zero : Nat
  suc  : Nat → Nat

{-# BUILTIN NATURAL Nat #-}
```

This also allows us to type natural numbers with digits (e.g. `3`{.agda} instead of `suc (suc (suc zero))`{.agda}) and have the compiler translate them to the corresponding value automatically.

Another case that appears in most programs is the equality type.
It is defined in the `Agda.Builtin.Equality`{.agda} module as follows:

```agda
data _≡_ {a} {A : Set a} (x : A) : A → Set a where
  refl : x ≡ x
```

Observe how it is defined like we would define an inductive type with a single constructor `refl`{.agda}.
Although equality types are a primitive concept in homotopy type theory, their introduction and elimination rules already suggest that they behave like inductive types.
This may help the reader get comfortable with the way path induction works.

With the tools seen so far, we can already show how programming in Agda is not as straightforward as transcribing a homotopy type theory proof from the paper to the screen.
For example, pair types can be defined in two different ways.
One, as record types:

```agda
record Σ {a b} (A : Set a) (B : A → Set b) : Set (a ⊔ b) where
  constructor _,_
  field
    fst : A
    snd : B fst
```

Another, as data types:

```agda
data Σ {a b} (A : Set a) (B : A → Set b) : Set (a ⊔ b) where
  _,_ : (x : A) → (B x) → Σ A B
```

These two work almost identically for many purposes, but each have their own advantages.
Agda will not recognize them as equal, though, so translating proofs using one to proofs using the other might sometimes be necessary.


### `--without-K`{.agda}

When run via terminal, we can pass various options to the Agda type checker.
Some of these are related to the code itself, so it is more fitting to include them with the sources.
A way to do this is by adding a special kind of comment which sets the desired options:

```agda
{-# OPTIONS [options...] #-}
```

For us, the most important option is `--without-K`{.agda}:

```agda
{-# OPTIONS --without-K #-}
```

By default, Agda allows formulating axiom K:

```agda
K : {A : Set} {a : A} (P : a ≡ a → Set) → P refl → (loop : a ≡ a) → P loop
K P p refl = p
```

Roughly, axiom K states that, in order to prove some property for all paths, it is enough to prove it for `refl`{.agda}, which implies uniqueness of identity proofs (UIP), or, in other words, that all identity types are either trivial or empty.
Although due to path induction this is true for many types in homotopy type theory ($0$-types, for example), in general it is not.
In order to prevent ourselves from accidentally writing something that implies UIP, we should use the `--without-K`{.agda} flag.
This way, formulating K or any equivalent statement will make our code not pass the type check.

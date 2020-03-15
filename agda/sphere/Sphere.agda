{-# OPTIONS --without-K #-}

module sphere.Sphere where

open import Relation.Binary.PropositionalEquality using (_≡_; refl)

data sphere : Set where
  base : sphere

data ⊥  : Set where

-- This is the naive way to have HITs in Agda. The good way is using Cubical Type Theory.
postulate
  surf : let refl-base : base ≡ base
             refl-base = refl
         in refl-base ≡ refl-base
  surf-neq-refl : (surf ≡ refl) → ⊥

-- Our goal is to prove that for any given p q : base ≡ base, then p ≡ q
simply-connected : (p q : base ≡ base) → (p ≡ q)
simply-connected refl refl = surf

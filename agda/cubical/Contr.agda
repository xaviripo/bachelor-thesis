{-# OPTIONS --cubical --without-K #-}

open import Cubical.Foundations.Prelude

module Contr where

data S1 : Set where
  base : S1
  loop : base ≡ base

contr : ∀ x → base ≡ x
contr base = refl
contr (loop i) = λ j → loop (i ∧ j)

-- contr (loop i0) = refl :check:
-- contr (loop i1) = refl :cross:
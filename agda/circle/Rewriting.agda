{-# OPTIONS --without-K --rewriting #-}

open import lib.Base
open import lib.PathOver using (↓-cst-in; apd=cst-in)

module Rewriting where

module S¹Def where
  postulate
    S¹ : Type₀
    base : S¹
    loop : base == base
open S¹Def using (S¹; base; loop)

module S¹Ind {i} {P : S¹ → Type i}
  (base* : P base)
  (loop* : base* == base* [ P ↓ loop ])
  where

  postulate
    f : Π S¹ P
    base-β : f base ↦ base*
  {-# REWRITE base-β #-}

  postulate
    loop-β : apd f loop == loop*

open S¹Ind using () renaming (f to S¹-ind)

module S¹Rec {i} {A : Type i}
  (base* : A)
  (loop* : base* == base*)
  where

  private
    -- We use a constant type family to deduce the recursion from the induction
    module M = S¹Ind {P = λ _ → A}
      base*
      (↓-cst-in loop*)

  f : S¹ → A
  f = M.f

  loop-β : ap f loop == loop*
  loop-β = apd=cst-in {f = f} M.loop-β

open S¹Rec using () renaming (f to S¹-rec)

-- Possible way to do encode-decode?
-- code : S¹ → Type₀
-- code base = ℤ

-- M = S¹-ind {P = code} ℤ (ua succ-equiv)

-- encode : {x : S¹} → (base == x) → (code x)
-- encode = M.f
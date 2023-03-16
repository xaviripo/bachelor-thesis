{-# OPTIONS --without-K --rewriting #-}

-- Basic imports
open import lib.Base
open import lib.PathGroupoid using (!)
open import lib.types.Int
open import lib.Equivalence
open import lib.Univalence
open import lib.types.Suspension.Core

-- Root module of this file
module RP2 where

{- This module contains some auxiliar lemmas and tools, not directly related
to the theorem or homotopy theory -}
module aux where

  {- Bit of a weird thing here.
  ap allows us to do: x == y → f x == f y
  in some cases, what we need is: f == g → f x == g x
  We use the "reverse apply" lambda (λ fun → fun x) to do this. -}
  ap-rev : ∀ {i j} {A : Type i} {B : Type j} {f g : A → B} (x : A)
    → (f == g → f x == g x)
  ap-rev x p = ap (λ fun → fun x) p

  -- transport == coe ap => transport-equiv == coe-equiv ap
  transport-equiv→coe-equiv : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → transport-equiv B p == coe-equiv (ap B p)
  transport-equiv→coe-equiv B idp = idp

  -- transport == –> transport-equiv
  transport→transport-equiv : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → transport B p == –> (transport-equiv B p)
  transport→transport-equiv B idp = idp

  {- This is an ugly bit. The statement of the following postulate is in fact
  true (the identity function of a type is its own inverse), but by the way
  ⁻¹ is implemented it's non-trivial to prove.

  Specifically, equivalences are defined as records (`is-equiv`), but the
  inverse operator ⁻¹ does not use that, rather it builds its own private
  module with the same fields. This makes the arguments clearly equal to one
  another but the type checker is not capable of reducing things like:
    .lib.Equivalence.M.f-g
    (record
    { g = λ x → x
    ; f-g = λ _ → idp
    ; g-f = λ _ → idp
    ; adj = λ _ → idp
    })
  to something like
    λ _ → idp
  Because the f-g in M is not the same f-g as the one in the record below.
  Thus, the identity has to be stated as a postulate.

  We then use that to prove that transport-equiv respects inverses: -}
  transport-equiv-respects-inv : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → (transport-equiv B (! p)) == (transport-equiv B p) ⁻¹
  transport-equiv-respects-inv B {x} idp = ide-is-self-inv (B x)
    where
    postulate
      ide-is-self-inv : ∀ {i} (A : Type i) → ide A == ide A ⁻¹

  -- transport B (p ∙ q) == (transport B q) ∘ (transport B p)
  transport-is-functorial : ∀ {i j} {A : Type i} (B : A → Type j)
    {x y z : A} (p : x == y) (q : y == z) → transport B (p ∙ q) == (transport B q) ∘ (transport B p)
  transport-is-functorial B idp idp = idp

open aux


module ℝP²Def where

  data ℝP² : Type₀ where
    X₀ : ℝP²

  postulate
    X₁ : X₀ == X₀
    X₂ : X₁ == (! X₁)

open ℝP²Def using (ℝP²; X₀; X₁; X₂)


module S⁰Def where

  data S⁻¹ : Type₀ where

  S⁰ = Susp S⁻¹
  S¹ = Susp S⁰
  S² = Susp S¹

  -- data S⁰ : Type₀ where
  --   north : S⁰
  --   south : S⁰

  flip : S⁰ → S⁰
  flip north = south
  flip south = north

  n-s : flip north == south
  n-s = idp

  s-n : flip south == north
  s-n = idp

  flip-flip : (x : S⁰) → flip (flip x) == x
  flip-flip north = ap s-n n-s
  flip-flip south = idp

  flip-equiv : S⁰ ≃ S⁰
  flip-equiv = equiv flip flip flip-flip flip-flip

  flip-eq = ua flip-equiv

  postulate
    flip-eq-! : flip-eq == ! flip-eq

open S⁰Def using (S⁰; S²; flip; flip-equiv; flip-eq; flip-eq-!)


module ℝP²Rec {i : ULevel} {A : Set i}
  (X₀* : A)
  (X₁* : X₀* == X₀*)
  (X₂* : X₁* == (! X₁*))
  where

  postulate
    f : ℝP² → A
    X₀-β : f X₀ ↦ X₀*
  {-# REWRITE X₀-β #-}

  postulate
    X₁-β : ap f X₁ == X₁*
    -- TODO retype this correctly
    -- X₂-β : ap (ap f) X₂ == X₁-β ∙ (X₂* ∙ (ap ! (! X₁-β)))

open ℝP²Rec using (X₁-β) renaming (f to ℝP²-rec)


module codeDef where

  code : ℝP² → Set
  code = ℝP²-rec S⁰ flip-eq flip-eq-!

  code-X₀ : code X₀ == S⁰
  code-X₀ = idp

  code-X₁ : ap code X₁ == flip-eq
  code-X₁ = X₁-β S⁰ flip-eq flip-eq-!

  -- code-X₂ is more complicated, and we don't need it so far.

open codeDef using (code)



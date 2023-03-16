{-# OPTIONS --cubical --without-K --rewriting #-}

open import Cubical.Foundations.Prelude
open import Cubical.Core.Glue using (isEquiv; _≃_)
open import Cubical.Foundations.Isomorphism using (iso; isoToPath)
open import Cubical.Foundations.Univalence using (ua)
open import Cubical.Foundations.Equiv using (isoToEquiv; invEquiv)
open import Cubical.HITs.Susp using (Susp; north; south; merid)

module RP1 where

{-# BUILTIN REWRITE _≡_ #-}

data ℝP¹ : Set where
  X₀ : ℝP¹
  X₁ : X₀ ≡ X₀

module ℤ₂Def where

  data ℤ₂ : Set where
      𝟎 : ℤ₂
      𝟏 : ℤ₂

  flip : ℤ₂ → ℤ₂
  flip 𝟎 = 𝟏
  flip 𝟏 = 𝟎

  flipflip : ∀ x → flip (flip x) ≡ x
  flipflip 𝟎 = refl
  flipflip 𝟏 = refl

  flipEquiv : ℤ₂ ≃ ℤ₂
  flipEquiv = isoToEquiv (iso flip flip flipflip flipflip)

  flipEq : ℤ₂ ≡ ℤ₂
  flipEq = ua flipEquiv

  -- TODO prove this
  postulate
    flipEquivInv : flipEquiv ≡ invEquiv flipEquiv


open ℤ₂Def using (ℤ₂; 𝟏; 𝟎; flipEq)

module ℝP¹Rec {i : Level} {A : Set i}
  (X₀* : A)
  (X₁* : X₀* ≡ X₀*)
  where

  postulate
    f : ℝP¹ → A
    X₀-β : f X₀ ≡ X₀*
  {-# REWRITE X₀-β #-}

  postulate
    X₁-β : cong f X₁ ≡ X₁*

open ℝP¹Rec using (X₀-β; X₁-β) renaming (f to ℝP¹-rec)

code : ℝP¹ → Set
code = ℝP¹-rec ℤ₂ flipEq

code-X₀ : code X₀ ≡ ℤ₂
code-X₀ = refl

code-X₁ : cong code X₁ ≡ flipEq
code-X₁ = X₁-β ℤ₂ flipEq

S¹ = Susp ℤ₂

f : Σ ℝP² code → S²
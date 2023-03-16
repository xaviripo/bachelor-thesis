{-# OPTIONS --cubical --without-K #-}
module SVK where

open import Cubical.Foundations.Prelude
open import Cubical.HITs.Pushout
open import Cubical.HITs.SetQuotients.Base
open import Cubical.HITs.SetTruncation.Base

private
  variable
    ℓ ℓ' ℓ'' : Level

module _ {A B C : Set} (f : A → C) (g : A → C) where

  P = Pushout f g

  Π₁ : (X : Set) → X → X → Set
  Π₁ X x y = ∥ x ≡ y ∥₀

  code : P → P → Set
  
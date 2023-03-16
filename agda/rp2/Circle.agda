{-
Run with Agda v2.6.1 and the cubical library v0.2
-}
{-# OPTIONS --cubical --without-K --safe #-}
module Circle where

open import Cubical.Foundations.Prelude

open import Cubical.Data.Nat.Base using (ℕ; zero; suc)
open import Cubical.Data.Nat.Properties using (injSuc)
open import Cubical.HITs.Ints.QuoInt.Base using (ℤ; pos; neg; posneg; sucPathℤ)

open import Cubical.Foundations.Id using (isEquiv)
open import Cubical.Foundations.Isomorphism using (isoToEquiv)

private
  variable
    ℓ ℓ' ℓ'' : Level


-- sucEquivℤ : ℤ ≃ ℤ
-- sucEquivℤ = isoToEquiv (iso sucℤ predℤ sucPredℤ predSucℤ)

data S¹ : Set where
  base : S¹
  loop : base ≡ base

ΩS¹ = base ≡ base

code : S¹ → Set
code base = ℤ
code (loop i) = sucPathℤ i

encode : {x : S¹} → (base ≡ x) → (code x)
encode p = transport (cong code p) (pos 0)

-- This is the function that we want
loop⁻ : ℤ → ΩS¹

loop⁻ (pos 0) = refl
loop⁻ (pos (suc n)) = (loop⁻ (pos n)) ∙ loop
loop⁻ (neg 0) = refl
loop⁻ (neg (suc n)) = (loop⁻ (neg n)) ∙ (sym loop)
loop⁻ (posneg _) = refl

-- Expand the definition to all of code, not only code base, by induction
decode : {x : S¹} → (code x) → (base ≡ x)
decode {base} = loop⁻
decode {loop i} = 
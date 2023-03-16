{-
Run with Agda v2.6.1 and the cubical library v0.2
-}
{-# OPTIONS --cubical --without-K #-}
module RP2 where

open import Cubical.Foundations.Prelude
open import Cubical.Data.NatMinusOne
open import Cubical.Functions.Bundle
open import Cubical.HITs.Pushout
open import Cubical.HITs.RPn.Base
open import Cubical.HITs.PropositionalTruncation
open import Cubical.Foundations.Univalence
open import Cubical.Foundations.Equiv
open import Cubical.Data.Bool
open import Cubical.Foundations.Structure


private
  variable
    ℓ ℓ' ℓ'' : Level

{-
Parts:
1. Define X as the synthetic real projective plane
2. Define fiber : X -> 2-EltType₀
3. Prove that the total space of X with fiber is equivalent to RP 2
-}


{- Part 1 -}

data X : Set where
  X0 : X
  X1 : X0 ≡ X0
  X2 : X1 ≡ sym X1


{- Part 2 -}

fib : X -> 2-EltType₀
fib X0 = Bool*
fib (X1 i) = ua ((λ z → false ⊕* z) , ⊕*.isEquivʳ Bool* false) i , ∣p∣ i
  where open ⊕* Bool*
        ∣p∣ = isProp→PathP (λ i → squash {A = ua (⊕*.Equivʳ Bool* false) i ≃ Bool})
                           (str Bool*) (∣ idEquiv _ ∣)
fib (X2 i j) = ua ((λ z → false ⊕* z) , ⊕*.isEquivʳ Bool* false) (((~ i) ∨ i) ∧ (i ∨ j) ∧ ((~ i) ∨ j)) , ∣p∣ (((~ i) ∨ i) ∧ (i ∨ j) ∧ ((~ i) ∨ j))
  where open ⊕* Bool*
        ∣p∣ = isProp→PathP (λ i → squash {A = ua (⊕*.Equivʳ Bool* false) i ≃ Bool})
                           (str Bool*) (∣ idEquiv _ ∣)

{-
cov⁻¹ neg1 x = Bool*
cov⁻¹ (ℕ→ℕ₋₁ n) (inl x)          = cov⁻¹ (-1+ n) x
cov⁻¹ (ℕ→ℕ₋₁ n) (inr _)          = Bool*
cov⁻¹ (ℕ→ℕ₋₁ n) (push (x , y) i) = ua ((λ z → y ⊕* z) , ⊕*.isEquivʳ (cov⁻¹ (-1+ n) x) y) i , ∣p∣ i
  where open ⊕* (cov⁻¹ (-1+ n) x)
        ∣p∣ = isProp→PathP (λ i → squash {A = ua (⊕*.Equivʳ (cov⁻¹ (-1+ n) x) y) i ≃ Bool})
                           (str (cov⁻¹ (-1+ n) x)) (∣ idEquiv _ ∣)
-}
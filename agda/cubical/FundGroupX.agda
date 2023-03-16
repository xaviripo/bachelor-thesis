{-# OPTIONS --cubical --without-K --rewriting #-}

open import Cubical.Foundations.Prelude
open import Cubical.Core.Glue using (isEquiv; _≃_)
open import Cubical.Foundations.Id using(∥_∥; ∣_∣)
open import Cubical.Foundations.Isomorphism using (Iso; iso; isoToIsEquiv; isoToPath)
open import Cubical.Foundations.Univalence using (ua)
open import Cubical.Foundations.Equiv using (isoToEquiv; idEquiv; compEquiv; invEquiv)
open import Cubical.HITs.Susp using (Susp; north; south; merid)
open import Cubical.HITs.SetTruncation.Base

module FundGroupX where

{-# BUILTIN REWRITE _≡_ #-}

data X : Set where
  X0 : X
  X1 : X0 ≡ X0
  X2 : X1 ≡ sym X1

data Z2 : Set where
  north : Z2
  south : Z2

flip : Z2 -> Z2
flip north = south
flip south = north

flipflip : (x : Z2) → flip (flip x) ≡ x
flipflip north = refl
flipflip south = refl

flipIso : Iso Z2 Z2
flipIso = iso flip flip flipflip flipflip

flipEquiv : Z2 ≃ Z2
flipEquiv = isoToEquiv flipIso

flipEq : Z2 ≡ Z2
flipEq = ua flipEquiv


postulate
  flipEquivInv : flipEquiv ≡ invEquiv flipEquiv

-- ua invEquiv ≡ sym ua
postulate
  uaRespectsInverses : {i : Level} {A B : Set i} (equiv : A ≃ B) → ua (invEquiv equiv) ≡ sym (ua equiv)

flipEqSym : flipEq ≡ sym flipEq
flipEqSym = (cong ua flipEquivInv) ∙ (uaRespectsInverses flipEquiv)



code : X -> Set
code X0 = Z2
code (X1 i) = flipEq i
code (X2 i j) = flipEqSym i j

tr : {A : Set} (P : A -> Set) {x y : A} (p : x ≡ y) -> P x -> P y
tr P {x = x} {y = y} refl = transport {A = P x} {B = P y} (cong P refl)

encode : {x : X} -> (X0 ≡ x) -> (code x)
encode p = tr code p north

-- partial1 : (i : I) → X₀ ≡ X₁ i
-- partial1 i = λ j → X₁ (i ∧ j)

if_then_else_ : {A : Set} → Z2 → A → A → A
if north then x else y = x
if south then x else y = y

-- test : {p : X} -> (code p) -> Z2
-- test {p = X0} north = north
-- test {p = X0} south = south
-- test {p = (X1 i)} x = (transport (λ j → flipEq (i ∧ (~ j))) x) {- ≡ north -}


decode : {x : X} -> (code x) -> (X0 ≡ x)
decode {x = X0} north = refl
decode {x = X0} south = X1
decode {x = (X1 i)} e = if (transport (λ j → flipEq (i ∧ (~ j))) e) {- ≡ north -} then (λ j → X1 (i ∧ (~ j))) else (X1 ∙ (λ j → X1 (i ∧ (~ j))))

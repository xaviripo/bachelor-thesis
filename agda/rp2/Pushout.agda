{-
Run with Agda v2.6.1 and the cubical library v0.2
-}
{-# OPTIONS --cubical --without-K #-}
module Pushout where

open import Cubical.Foundations.Prelude
open import Cubical.HITs.Pushout
open import Agda.Builtin.Cubical.Glue using (isEquiv)
open import Cubical.Foundations.Isomorphism using (iso; isoToIsEquiv)

{-
Given a pushout A <-f- C -g-> B, we want to prove that if f is an equivalence, then inr is as one as well:

      g
  C ---> B
  |      |
f |      | inr
  V      V
  A ---> A+B
    inl
-}

postulate
  pushoutUnicity : {A B C : Set} {f : C → A} {g : C → B} 

-- TODO these params can be changed to f and a single iso object, which can be then unpacked inside the module
module _ {A B C : Set} (f : C → A) (finv : A → C) (f-finv : ∀ a → f (finv a) ≡ a) (finv-f : ∀ c → finv (f c) ≡ c) (g : C → B) where

  -- TODO maybe just take a pushout as the module params and unpack it here?
  P = Pushout f g
  -- inr : B → p
  -- inl : A → p
  -- glue : (c : C) → inl (f c) ≡ inr (g c)

  h : P → B
  h (inl a) = g (finv a)
  h (inr b) = b
  h (push c i) = (cong g (finv-f c)) i

  h-inr : ∀ b → h (inr b) ≡ b
  h-inr b = refl {x = b}

  inr-h : ∀ b → inr (h b) ≡ b
  inr-h b = 

  thm : isEquiv {B = P} (inr)
  thm = isoToIsEquiv (iso inr h inr-h h-inr)

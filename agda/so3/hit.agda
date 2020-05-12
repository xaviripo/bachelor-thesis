{-# OPTIONS --without-K --rewriting #-}

open import lib.Base
open import lib.PathGroupoid using (!; !ᵈ; _◃_; _▹!_)
open import lib.PathOver using (↓-cst-in; ↓-cst-in2)
open import lib.PathFunctor using (apd-!)

module so3.hit where


-- Heavily inspired on HoTT's Torus.agda
postulate
  RP2 : Type₀
  X0 : RP2
  X1 : X0 == X0
  X2 : X1 == ! X1

-- Dependent eliminator (induction principle)
module RP2Ind {l} {P : RP2 → Type l}
  (X0* : P X0)
  (X1* : X0* == X0* [ P ↓ X1 ])
  (X2* : X1* == !ᵈ X1* [ (λ p → X0* == X0* [ P ↓ p ]) ↓ X2 ])
  where

  postulate
    f : Π RP2 P
    X0-β : f X0 ↦ X0*
  {-# REWRITE X0-β #-}

  postulate
    X1-β : apd f X1 == X1*

  -- lhs and rhs are helpers for the X2 reduction rule to type correctly
  private
    lhs : apd f X1 == X1*
    lhs = X1-β

    rhs : apd f (! X1) == !ᵈ X1*
    rhs =
      apd f (! X1)
        =⟨ apd-! f X1 ⟩
      !ᵈ (apd f X1)
        =⟨ ap !ᵈ X1-β ⟩
      !ᵈ X1*
        =∎

  -- TODO check the definitions of ◃ and ▹!, maybe replace them with ∙ᵈ et al?
  postulate
    X2-β : apd (apd f) X2 == lhs ◃ (X2* ▹! rhs)

open RP2Ind public using () renaming (f to RP2-ind)

-- Non-dependent eliminator (recursion principle)
module RP2Rec {i} {A : Type i}
  (X0* : A)
  (X1* : X0* == X0*)
  (X2* : X1* == ! X1*)
  where

  -- TODO See Torus.agda
  private
    module M = RP2Ind {P = λ _ → A}
      X0*
      (↓-cst-in X1*)
      -- (↓-cst-in2 X2*)
      (X2* : X1* == (!ᵈ X1*) [ (λ p → X0* == X0* [ P ↓ p ]) ↓ X2 ])
      (↓-cst-in-∙ loopT1 loopT2 loopT1* loopT2*
                         !◃ (↓-cst-in2 surfT* ▹ (↓-cst-in-∙ loopT2 loopT1 loopT2* loopT1*)))

  -- TODO also add *-β rules analog to those of RP2Ind. See Torus.agda.

-- open RP2Rec using () renaming (f to RP2-rec)
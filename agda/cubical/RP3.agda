{-# OPTIONS --cubical --without-K #-}

open import Cubical.Foundations.Prelude

module RP3 where

-- {-# BUILTIN REWRITE _≡_ #-}

data ℝP³ : Set where
-- postulate
--   ℝP³ : Set
  X₀ : ℝP³
  X₁ : X₀ ≡ X₀

  -- Now we need to define the higher paths.

  -- This is the simplest way, and it works.
  -- Thw drawback is that it doesn't allow us to build the next path.
  -- X₂ : X₁ ≡ sym X₁

  -- The following is equivalent:
  X₂ : PathP (λ _ → X₀ ≡ X₀) (λ i → X₁ i) (λ i → X₁ (~ i))

  {-
  Situation: for the next component we need a function I x I -> I s.t.:
  i,0 -> i
  i,1 -> ~i
  Unfortunately, it seems like the operators on a De Morgan algebra (like I)
  do not allow to build this.
  If I allowed pattern matching, we could solve this.
  -}

  -- This is what we need but we don't have pattern matching.
  X₃ : PathP (λ { i0 → (λ i → X₁ i) ≡ (λ i → X₁ (~ i))
                ; i1 → (λ i → X₁ (~ i)) ≡ (λ i → X₁ i)
                }) X₂ (sym X₂)

  -- X₃ : PathP (λ i → line1 i ≡ line1 i) line2 line2
  -- X₃ : X₂ ≡ sym X₂
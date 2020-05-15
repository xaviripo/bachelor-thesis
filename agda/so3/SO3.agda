{-# OPTIONS --without-K --rewriting #-}

-- Basic imports
open import lib.Base
open import lib.types.Truncation using ([_]₀)
open import lib.PathGroupoid using (!)
-- open import lib.types.Int
-- open import lib.Equivalence
-- open import lib.Univalence

-- Root module of this file
module SO3 where

-- SO(3) is homeomorphic to ℝP³, which can be built easily as a HIT:
module ℝP³Def where

  {- The projective real space of dimension n is the CW complex with one i-cell
  for each i from 0 through n -}
  data ℝP³ : Type₀ where
    X₀ : ℝP³

  postulate
    X₁ : X₀ == X₀
    X₂ : X₁ == ! X₁
    -- TODO Agda gets angry about this defn
    -- X₃ : X₂ == ! X₂

  -- This is the loop space we wish to describe
  ΩℝP³ = X₀ == X₀

  -- This is the underlying set of the fundamental group of ℝP³
  -- TODO Agda gets angry when proving this has a group structure
  π₀ℝP³ = ΩℝP³ -- [ ΩℝP³ ]₀

open ℝP³Def using (ℝP³; X₀; X₁; X₂ {-; X₃-}; π₀ℝP³)

module π₀ℝP³Group where

  -- Group related imports
  open import lib.types.Group
  open import lib.groups.Isomorphism
  open import lib.NType using (is-set; has-dec-eq; dec-eq-is-set)
  open import lib.groups.Homomorphism using (preserves-comp)

  π₀ℝP³-group-structure : GroupStructure π₀ℝP³
  π₀ℝP³-group-structure = group-structure ident inv comp unit-l assoc inv-l
    where

    -- Identity element
    ident : π₀ℝP³
    ident = idp

    -- Inverse operation
    inv : π₀ℝP³ → π₀ℝP³
    inv = !

    -- Composition of elements
    comp : π₀ℝP³ → π₀ℝP³ → π₀ℝP³
    comp = _∙_

    -- Proof that idp is left identity
    unit-l : ∀ a → comp ident a == a
    unit-l idp = idp

    -- Proof of associativity
    assoc : ∀ a b c → comp (comp a b) c == comp a (comp b c)
    assoc idp idp idp = idp

    -- Proof of left inverses being actual inverses
    inv-l : ∀ a → (comp (inv a) a) == ident
    inv-l idp = idp

  -- ΩS¹ is an inductive type with a single generator, it's a set:
  π₀ℝP³-is-set : is-set π₀ℝP³
  π₀ℝP³-is-set = dec-eq-is-set π₀ℝP³-has-dec-eq
    where
    π₀ℝP³-has-dec-eq : has-dec-eq π₀ℝP³
    π₀ℝP³-has-dec-eq idp idp = inl idp

  π₀ℝP³-group : Group₀
  π₀ℝP³-group = group π₀ℝP³ {{π₀ℝP³-is-set}} π₀ℝP³-group-structure

  -- TODO i have to use the eliminator style of HITs because otherwise Agda doesn't
  -- see or care about X₁ and thus this proof is trivial
  -- π₀ℝP³-order-2 X₁ = ap (λ p → p ∙ X₁) X₂
  π₀ℝP³-order-2 : (p : π₀ℝP³) → (p ∙ p == idp)
  π₀ℝP³-order-2 idp = idp


module ℤ₂Def where

  data ℤ₂ : Type₀ where
    0₂ : ℤ₂
    1₂ : ℤ₂

  _+₂_ : ℤ₂ → ℤ₂ → ℤ₂
  0₂ +₂ y = y
  x +₂ 0₂ = x
  1₂ +₂ 1₂ = 0₂

open ℤ₂Def using (ℤ₂; 0₂; 1₂; _+₂_)

module π₀ℝP³≃ℤ₂ where

  module π₀ℝP³→ℤ₂ where

    -- TODO

  module ℤ₂→π₀ℝP³ where

    -- TODO
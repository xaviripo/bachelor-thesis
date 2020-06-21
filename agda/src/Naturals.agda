{-# OPTIONS --without-K #-}

-- Basic imports
open import Agda.Builtin.Equality renaming (_≡_ to _==_; refl to idp)
open import Agda.Primitive using (lzero; lsuc; Level)

-- Root module of this file
module Naturals where

{- Some auxiliary tools.
These could be imported from the HoTT library, but the BUILTIN NATURAL pragma
clashes with our own Naturals. -}
module aux where

  -- Rename Set to Type to avoid confusion
  Type : (i : Level) → Set (lsuc i)
  Type i = Set i

  -- Path arithmetic helpers
  _=⟨_⟩_ : ∀ {i} {A : Type i} (x : A) {y z : A} → x == y → y == z → x == z
  _ =⟨ idp ⟩ idp = idp

  _=∎ : ∀ {i} {A : Type i} (x : A) → x == x
  _ =∎ = idp

  infixr 10 _=⟨_⟩_
  infix  15 _=∎

  -- Path reversal
  ! : ∀ {i} {A : Type i} {x y : A} → (x == y → y == x)
  ! idp = idp

  -- Function application to paths
  ap : ∀ {i j} {A : Type i} {B : Type j} (f : A → B) {x y : A}
    → (x == y → f x == f y)
  ap f idp = idp

open aux


-- The actual definitions and theorem
module main where

  -- Natural numbers
  data ℕ : Type lzero where
    zero : ℕ
    succ : ℕ → ℕ

  -- Addition of naturals
  _+_ : ℕ → ℕ → ℕ
  zero + m = m
  (succ n) + m = succ (n + m)

  -- Proof that 0 is right identity of addition
  add-right-id : (n : ℕ) → (n + zero) == n
  add-right-id zero = idp
  add-right-id (succ n) =
    (succ n) + zero
      =⟨ idp ⟩
    succ (n + zero)
      =⟨ ap (succ) (add-right-id n) ⟩
    succ n
      =∎

  -- Proof of the commutativity of addition
  add-comm : (n m : ℕ) → (n + m) == (m + n)
  add-comm zero zero = idp
  add-comm (succ n) zero =
    (succ n) + zero
      =⟨ add-right-id (succ n) ⟩
    succ n
      =⟨ idp ⟩
    zero + (succ n)
      =∎
  add-comm zero (succ m) =
    zero + (succ m)
      =⟨ idp ⟩
    succ m
      =⟨ ! (add-right-id (succ m)) ⟩
    (succ m) + zero
      =∎
  add-comm (succ n) (succ m) =
    (succ n) + (succ m)
      =⟨ idp ⟩
    succ (n + (succ m))
      =⟨ ap (succ) (add-comm n (succ m)) ⟩
    succ ((succ m) + n)
      =⟨ idp ⟩
    succ (succ (m + n))
      =⟨ ap (succ) (ap (succ) (add-comm m n)) ⟩
    succ (succ (n + m))
      =⟨ idp ⟩
    succ ((succ n) + m)
      =⟨ ap (succ) (add-comm (succ n) m) ⟩
    succ (m + (succ n))
      =⟨ idp ⟩
    (succ m) + (succ n)
      =∎

open main


-- We test that the theorem works
module test where

  -- This allows us to write 0 for zero, 1 for (succ 0), 2 for (succ 1), etc.
  {-# BUILTIN NATURAL ℕ #-}

  -- :D
  _ : (1 + 2) == (2 + 1)
  _ = add-comm 1 2

{-# OPTIONS --without-K #-}

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl; sym; cong)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _≡⟨_⟩_; _∎)

module intro.Naturals where

-- Natural numbers
data ℕ : Set where
  zero : ℕ
  succ : ℕ → ℕ

-- Addition of naturals
_+_ : ℕ → ℕ → ℕ
zero + m = m
(succ n) + m = succ (n + m)

-- Proof that 0 is right identity of addition
add-right-id : (n : ℕ) → (n + zero) ≡ n
add-right-id zero = refl
add-right-id (succ n) =
  begin
    (succ n) + zero
  ≡⟨⟩
    succ (n + zero)
  ≡⟨ cong (succ) (add-right-id n) ⟩
    succ n
  ∎

-- Proof of the commutativity of addition
add-comm : (n m : ℕ) → (n + m) ≡ (m + n)
add-comm zero zero = refl
add-comm (succ n) zero =
  begin
    (succ n) + zero
  ≡⟨⟩
    succ (n + zero)
  ≡⟨ cong (succ) (add-right-id n) ⟩
    succ n
  ∎
add-comm zero (succ m) =
  begin
    zero + (succ m)
  ≡⟨⟩
    succ m
  ≡⟨ sym (add-right-id (succ m)) ⟩
    (succ m) + zero
  ∎ 
add-comm (succ n) (succ m) =
  begin
    (succ n) + (succ m)
  ≡⟨⟩
    succ (n + (succ m))
  ≡⟨ cong (succ) (add-comm n (succ m)) ⟩
    succ ((succ m) + n)
  ≡⟨⟩
    succ (succ (m + n))
  ≡⟨ cong (succ) (cong (succ) (add-comm m n)) ⟩
    succ (succ (n + m))
  ≡⟨⟩
    succ ((succ n) + m)
  ≡⟨ cong (succ) (add-comm (succ n) m) ⟩
    succ (m + (succ n))
  ≡⟨⟩
    (succ m) + (succ n)
  ∎

-- This allows us to write 0 for zero, 1 for (succ 0), 2 for (succ 1), etc.
{-# BUILTIN NATURAL ℕ #-}

-- :D
_ : (1 + 2) ≡ (2 + 1)
_ = add-comm 1 2

{-# OPTIONS --without-K #-}

open import lib.Base

module test.Test2 where

module _ where

  private
    data #I : Type₀ where
      #zero : #I
      #one : #I

  I : Type₀
  I = #I

  zero : I
  zero = #zero

  one : I
  one = #one

  postulate
    seg : zero == one

  I-elim : ∀ {i} {P : I → Type i} (zero* : P zero) (one* : P one)
           (seg* : zero* == one* [ P ↓ seg ]) → Π I P
  I-elim zero* one* seg* #zero = zero*
  I-elim zero* one* seg* #one = one*

postulate
  P : I → Type₀
  z : P zero
  o : P one
  s s' : z == o [ P ↓ seg ]

absurd : I-elim z o s == I-elim z o s'
absurd = idp

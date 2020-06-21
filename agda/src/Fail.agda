{-# OPTIONS --without-K #-}

module Fail where

data ⊥ : Set where

data ⊤ : Set where
  * : ⊤

fail : ⊤ → ⊥
fail ()
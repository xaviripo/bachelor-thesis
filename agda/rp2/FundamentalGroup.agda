{-
Run with Agda v2.6.1 and the cubical library v0.2
-}
{-# OPTIONS --cubical --without-K #-}
module FundamentalGroup where

open import Cubical.Foundations.Prelude
open import Cubical.HITs.Pushout
open import Agda.Builtin.Cubical.Glue using (isEquiv)
open import Cubical.Foundations.Isomorphism using (iso; isoToIsEquiv)
open import Cubical.HITs.RPn.Base

{-# OPTIONS --cubical --without-K --rewriting #-}

open import Cubical.Foundations.Prelude
open import Cubical.Core.Glue using (isEquiv; _≃_)
open import Cubical.Foundations.Id using(∥_∥; ∣_∣)
open import Cubical.Foundations.Isomorphism using (Iso; iso; isoToIsEquiv; isoToPath)
open import Cubical.Foundations.Univalence using (ua)
open import Cubical.Foundations.Equiv using (isoToEquiv; idEquiv; compEquiv; invEquiv)
open import Cubical.HITs.Susp using (Susp; north; south; merid)
open import Cubical.HITs.SetTruncation.Base

module RP2 where

{-# BUILTIN REWRITE _≡_ #-}

data ℝP² : Set where
  X₀ : ℝP²
  X₁ : X₀ ≡ X₀
  X₂ : X₁ ≡ sym X₁

{-

In traditional topology, we would prove that S² is a universal cover of
ℝP², and then the fact that it's a 2-cover (each fiber has 2 elements) tells us
that the fundamental group of ℝP² has only two elements.

The cover would be expressed as the "projection" S² → ℝP²

In HoTT this is translated as a set family ℝP² → Set that, for each point in
ℝP² gives us its fiber.

X₀ → S⁰ : U
X₁ → flip : S⁰ = S⁰
X₂ → refl_flip : flip = flip⁻¹

-}


module SDef where

  data S⁻¹ : Set where

  S⁰ = Susp S⁻¹
  S¹ = Susp S⁰
  S² = Susp S¹

open SDef using (S⁰; S²)

module flipDef where

  flip : S⁰ → S⁰
  flip north = south
  flip south = north

  flipflip : (x : S⁰) → flip (flip x) ≡ x
  flipflip north = refl
  flipflip south = refl

  flipIso : Iso S⁰ S⁰
  flipIso = iso flip flip flipflip flipflip

  flipEquiv : S⁰ ≃ S⁰
  flipEquiv = isoToEquiv flipIso

  flipEq : S⁰ ≡ S⁰
  flipEq = ua flipEquiv

  -- This reaches contradiction (north ≡ south)
  -- flipEqSym : (i j : I) → Set
  -- flipEqSym = λ i j → flipEq (((~ i) ∨ i) ∧ (i ∨ j) ∧ ((~ i) ∨ j))

  postulate
    flipEquivInv : flipEquiv ≡ invEquiv flipEquiv

  -- ua invEquiv ≡ sym ua
  postulate
    uaRespectsInverses : {i : Level} {A B : Set i} (equiv : A ≃ B) → ua (invEquiv equiv) ≡ sym (ua equiv)

  flipEqSym : flipEq ≡ sym flipEq
  flipEqSym = (cong ua flipEquivInv) ∙ (uaRespectsInverses flipEquiv)

  flipEqSym' : flipEq ≡ sym flipEq
  flipEqSym' j i = hfill (λ j → λ { (i = i0) → flipEq j
                                  ; (i = i1) → flipEq (~ j) })
                         (inS S⁰)
                         j


open flipDef using (flipEq; flipEqSym)

code : ℝP² → Set
code X₀ = S⁰
code (X₁ i) = flipEq i
code (X₂ i j) = flipEqSym i j


-- Using the recursion principle
-- -----------------------------------------------------------------------------
-- module ℝP²Rec {i : Level} {A : Set i}
--   (X₀* : A)
--   (X₁* : X₀* ≡ X₀*)
--   (X₂* : X₁* ≡ sym X₁*)
--   where

--   postulate
--     f : ℝP² → A
--     X₀-β : f X₀ ≡ X₀*
--   {-# REWRITE X₀-β #-}

--   postulate
--     X₁-β : cong f X₁ ≡ X₁*
--     -- TODO take a look at Cubical.Foundations.Prelude.cong₂
--     X₂-β : cong (cong f) X₂ ≡ X₁-β ∙ (X₂* ∙ (cong sym (sym X₁-β)))

-- open ℝP²Rec using (X₁-β) renaming (f to ℝP²-rec)

-- code : ℝP² → Set
-- code = ℝP²-rec S⁰ flipEq flipEqSym

-- code-X₀ : code X₀ ≡ S⁰
-- code-X₀ = refl

-- code-X₁ : cong code X₁ ≡ flipEq
-- code-X₁ = X₁-β S⁰ flipEq flipEqSym

-- code-X₂ is more complicated, and we don't need it so far.
-- -----------------------------------------------------------------------------



-- ℝP²Contr : ∀ x → X₀ ≡ x
-- ℝP²Contr (X₀) = refl
-- ℝP²Contr (X₁ i) = λ j → X₁ (i ∧ j)
-- ℝP²Contr (X₂ i j) = λ k → X₂ (i ∧ k) (j ∧ k)


module code≡S⁰ where

  -- For each i in I, we have a path from X0 to X1 i.
  -- partial1 : (i : I) → X₀ ≡ X₁ i
  -- partial1 i = λ j → X₁ (i ∧ j)

  -- partial1U : (i : I) → code (X₁ i) ≡ S⁰
  -- partial1U i = sym (cong code (partial1 i))

  -- partial2 : (i j : I) → X₀ ≡ X₂ i j
  -- partial2 i j = λ k → X₂ (i ∧ k) (j ∧ k)

  -- partial2U : (i j : I) → code (X₂ i j) ≡ S⁰
  -- partial2U i j = sym (cong code (partial2 i j))

  partial1U : (i : I) → code (X₁ i) ≡ S⁰
  partial1U i = sym λ j → flipEq (i ∧ j)

  partial2U : (i j : I) → code (X₂ i j) ≡ S⁰
  partial2U i j = sym λ k → flipEqSym (i ∧ k) (j ∧ k)

  -- TODO fix this
  postulate
    code≡S⁰ : {x : ℝP²} → code x ≡ S⁰
  -- code≡S⁰ {x = X₀} = refl
  -- code≡S⁰ {x = X₁ i} = partial1U i
  -- code≡S⁰ {x = X₂ i j} = partial2U i j

  code→S⁰ : {x : ℝP²} → code x → S⁰
  code→S⁰ {x} = transport (code≡S⁰ {x})

  S⁰→code : {x : ℝP²} → S⁰ → code x
  S⁰→code {x} = transport (sym (code≡S⁰ {x}))

open code≡S⁰ using (code→S⁰; S⁰→code)



-- Maybe this fails because i'm using postulates to define S⁰→code?
-- g' : S² → Σ ℝP² code
-- g' north = (X₀ , S⁰→code {X₀} north)
-- g' south = (X₀ , S⁰→code {X₀} south)
-- g' (merid (north) i) = (X₁ i , S⁰→code {X₁ i} north)
-- g' (merid (south) i) = (X₁ i , S⁰→code {X₁ i} south)
-- g' (merid (merid north j) i) = (X₂ i j , S⁰→code {X₂ i j} north)
-- g' (merid (merid south j) i) = (X₂ i j , S⁰→code {X₂ i j} south)

-- f' : Σ ℝP² code → S²
-- f' (X₀ , S⁰→code {X₀} north) = 

module Thesis where

  postulate
    f : Σ ℝP² code → S²

    g : S² → Σ ℝP² code

    fg : ∀ b → f (g b) ≡ b

    gf : ∀ a → g (f a) ≡ a

  ΣℝP²code≡S² : Σ ℝP² code ≡ S²
  ΣℝP²code≡S² = isoToPath (iso f g fg gf)










-- --------------------- OLD --------------------- --

_×_ : ∀ {ℓ ℓ'} (A : Type ℓ) (B : Type ℓ') → Type (ℓ-max ℓ ℓ')
A × B = Σ A (λ _ → B)


-- TODO this shouldn't be a postulate. I think I have a proof, but it fails.
-- See below.
postulate
  ℝP²IsContr : {x : ℝP²} → X₀ ≡ x
-- ℝP²IsContr : {x : ℝP²} → X₀ ≡ x
-- ℝP²IsContr {x = X₀} = refl
-- ℝP²IsContr {x = X₁ i} = λ i' → (X₁ (i ∧ i'))
-- ℝP²IsContr {x = X₂ i j} = λ i' → (X₂ (i ∧ i') (j ∧ i'))

codeIsContr : {x : ℝP²} → S⁰ ≡ code x
codeIsContr {x} = cong code (ℝP²IsContr {x})

codeIsContrFun : (λ (_ : ℝP²) → S⁰) ≡ code
codeIsContrFun = funExt (λ x → codeIsContr {x})

-- Σ ℝP² (λ x → code x) ≡ Σ ℝP² (λ _ → S⁰)
ΣℝP²code≡ℝP²×S⁰ : Σ ℝP² code ≡ ℝP² × S⁰
ΣℝP²code≡ℝP²×S⁰ = cong (λ X → Σ ℝP² X) (sym codeIsContrFun)


-- Trying to write g
-- func : S² → ℝP² × S⁰
-- func north = (X₀ , north)
-- func south = (X₀ , south)
-- func (merid (north) i) = (X₁ i , north)
-- func (merid (south) i) = (X₁ i , south)
-- func (merid (merid north j) i) = (X₂ i j , north)
-- func (merid (merid south j) i) = (X₂ i j , south)
{-
postulate
  f : ℝP² × S⁰ → S²
  -- f (x , b) = TODO
  g : S² → ℝP² × S⁰
  -- g  = TODO

  fg : ∀ b → f (g b) ≡ b
  -- fg = TODO

  gf : ∀ a → g (f a) ≡ a
  -- gf = TODO

ℝP²×S⁰≡S² : ℝP² × S⁰ ≡ S²
ℝP²×S⁰≡S² = isoToPath (iso f g fg gf)


ΣℝP²code≡S² : Σ ℝP² code ≡ S²
ΣℝP²code≡S² = ΣℝP²code≡ℝP²×S⁰ ∙ ℝP²×S⁰≡S²

-}
module Test where
open import Agda.Primitive
open import Agda.Builtin.Equality



-- record Σ {a b} (A : Set a) (B : A → Set b) : Set (a ⊔ b) where
--   constructor _,_
--   field
--     fst : A
--     snd : B fst

-- data Σ {a b} (A : Set a) (B : A → Set b) : Set (a ⊔ b) where
--   _,_ : (x : A) → (B x) → Σ A B

-- data Nat : Set where
--   z : Nat
--   suc : Nat -> Nat

-- _+_ : Nat → Nat → Nat
-- z + z = z
-- z + (suc n) = suc n
-- (suc n) + z = suc n
-- (suc n) + (suc m) = suc (suc (n + m))

-- postulate
--   K : (A : Set) (M : A) (C : M ≡ M -> Set)
--       -> C refl
--       -> (loop : M ≡ M) -> C loop

K : {A : Set} {a : A} (P : a ≡ a → Set) → P refl → (loop : a ≡ a) → P loop
K P p refl = p
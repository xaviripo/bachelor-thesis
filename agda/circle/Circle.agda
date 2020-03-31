{-# OPTIONS --without-K --rewriting #-}

open import lib.Base
open import lib.PathGroupoid
open import lib.types.Int
open import lib.Equivalence
open import lib.Univalence

module circle.Circle where

module _ where

  -- Define the circle
  module S¹Def where

    data S¹ : Type₀ where
      base : S¹

    postulate
      loop : base == base

    module S¹Elim {i} {C : S¹ → Type i} (base* : C base) (loop* : base* == base* [ C ↓ loop ]) where
      postulate
        f : (x : S¹) → C x
        base-β : f base ↦ base*
      {-# REWRITE base-β #-}
      postulate
        loop-β : apd f loop == loop*

  open S¹Def public using (S¹; base; loop)

  -- Alias for notation only
  ΩS¹ = (base == base)

  -- We have to find two equivalences, one in each direction.
  module ΩS¹≃ℤDef where

    -- Define the code function used in both directions
    module codeDef where

      {- The idea here is to define
      code : S¹ → Type
      and then lift it to
      code-lifted : ΩS¹ → ℤ -}
      -- We need to explicitly state the ₀ in Type₀. This is because otherwise,
      -- the expression S¹ → Type has kind Set⍵, which is not a type.
      -- See: https://wiki.portal.chalmers.se/agda/pmwiki.php/ReferenceManual/UniversePolymorphism
      code : S¹ → Type₀
      code base = ℤ

      -- Part of the definition of code is that code(loop) is ua(succ).
      -- This means that applying code to the loop path results in the isomorphism
      -- between ℤ and ℤ induced by succ (taking each x to succ x).
      postulate
        code-ap : ap code loop == ua succ-equiv


      {- transport == coe ap -> transport-equiv == coe-equiv ap -}
      transport-coe-equiv : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → transport-equiv B p == coe-equiv (ap B p)
      transport-coe-equiv B idp = idp

      transport-equiv-fst : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → transport B p == –> (transport-equiv B p)
      transport-equiv-fst B idp = idp


      {- The meaning of coe is the opposite of ua:
      - coe takes a type equality and returns a map
      - ua takes a map (an equivalence) and returns an equality
      We just have to adapt this to the translation between maps and
      equivalences in Agda (see e.g. the difference between coe and coe-equiv) -}
      lemma-transport-code-succ-equiv : transport-equiv code loop == succ-equiv
      lemma-transport-code-succ-equiv =
        transport-equiv code loop
          =⟨ transport-coe-equiv code loop ⟩
        coe-equiv (ap code loop)
          =⟨ ap coe-equiv code-ap ⟩
        coe-equiv (ua succ-equiv)
        -- coe-equiv and ua are inverses, by imposition of coe-equiv-β
          =⟨ coe-equiv-β succ-equiv ⟩
        succ-equiv
          =∎

      lemma-transport-code-succ : transport code loop == succ
      lemma-transport-code-succ =
        transport code loop
          =⟨ transport-equiv-fst code loop ⟩
        –> (transport-equiv code loop)
          =⟨ ap –> lemma-transport-code-succ-equiv ⟩
        –> succ-equiv
          =⟨ idp ⟩
        succ
          =∎
      -- lemma-transport-code-succ : transport code loop == succ
      -- lemma-transport-code-succ =
      --   transport code loop
      --     =⟨ idp ⟩
      --   coe (ap code loop)
      --     =⟨ ap coe code-ap ⟩
      --   coe (ua succ-equiv)
      --     =⟨ idp ⟩
      --   –> (coe-equiv (ua succ-equiv))
      --   -- coe-equiv and ua are inverses, by imposition of coe-equiv-β
      --     =⟨ ap –> (coe-equiv-β succ-equiv) ⟩
      --   –> succ-equiv
      --     =⟨ idp ⟩
      --   succ
      --     =∎

      postulate
        ide-is-self-inv : ∀ {i} (A : Type i) → ide A == ide A ⁻¹
      -- ide-is-self-inv A =
      --   ide A
      --     =⟨ idp ⟩
      --   (idf A , record {g = idf A; f-g = (λ _ → idp); g-f = (λ _ → idp); adj = (λ _ → idp)})
      --     =⟨ idp ⟩
      --   ide A ⁻¹
      --     =∎

      transport-inverse : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → (transport-equiv B (! p)) == (transport-equiv B p) ⁻¹
      transport-inverse B {x} idp = ide-is-self-inv (B x)

      lemma-transport-code-pred : transport code (! loop) == pred
      lemma-transport-code-pred =
        transport code (! loop)
          =⟨ transport-equiv-fst code (! loop) ⟩
        –> (transport-equiv code (! loop))
          =⟨ ap fst (transport-inverse code loop) ⟩
        –> (transport-equiv code loop ⁻¹)
          =⟨ ap fst (ap _⁻¹ lemma-transport-code-succ-equiv) ⟩ -- this might need something else other than idp
        –> (succ-equiv ⁻¹)
          =⟨ idp ⟩
        pred
          =∎

    open codeDef

    -- Left-to-right: we need to use the recursion principle of S¹.
    module ΩS¹→ℤDef where

      -- TODO we should also define the inverse:
      -- transport code (! loop) == pred
      -- but we won't do it until we need it

      encode : {x : S¹} → (base == x) → (code x)
      encode p = (transport code p) 0

      -- Just some examples checking that encode works as expected
      module encode-test where

        -- transport B (p ∙ q) == (transport B q) ∘ (transport B p)
        transport-is-functorial : ∀ {i j} {A : Type i} (B : A → Type j)
          {x y z : A} (p : x == y) (q : y == z) → transport B (p ∙ q) == (transport B q) ∘ (transport B p)
        transport-is-functorial B idp idp = idp

        -- Bit of a weird thing here.
        -- ap allows us to do: x == y → f x == f y
        -- in this case, what we need is: f == g → f x == g x
        -- We use the "reverse apply" lambda (λ fun → fun x) to do this
        ap-rev : ∀ {i j} {A : Type i} {B : Type j} {f g : A → B} (x : A)
          → (f == g → f x == g x)
        ap-rev x p = ap (λ fun → fun x) p

        -- Testing encode(idp) is 0
        encode-idp : encode idp == 0
        encode-idp =
          encode idp
            =⟨ idp ⟩ -- definition of encode
          (transport code idp-base) 0
            =⟨ idp ⟩ -- definition of transport
          (coe (ap code idp-base)) 0
            =⟨ idp ⟩ -- definition of ap
          (coe (idp)) 0
            =⟨ idp ⟩ -- definition of coe
          0
            =∎
            -- At some points we need to be explicit about which idp we're
            -- talking about so that Agda can understand what we mean
            where
            idp-base : base == base
            idp-base = idp

        -- Testing encode(loop) is 1
        encode-loop : encode loop == 1
        encode-loop =
          encode loop
            =⟨ idp ⟩ -- definition of encode
          (transport code loop) 0
            =⟨ ap-rev 0 lemma-transport-code-succ ⟩ -- apply lemma-transport-code-succ
          succ 0
            =⟨ idp ⟩
          1
            =∎

        -- Testing encode(loop ∙ loop) is 2
        encode-loop-loop : encode (loop ∙ loop) == 2
        encode-loop-loop =
          encode (loop ∙ loop)
            =⟨ idp ⟩ -- definition of encode
          (transport code (loop ∙ loop)) 0
            =⟨ ap-rev 0 (transport-is-functorial code loop loop) ⟩ -- functoriality of transport
          ((transport code loop) ∘ (transport code loop)) 0
            =⟨ idp ⟩ -- definition of function composition
          (transport code loop) ((transport code loop) 0)
            =⟨ ap-rev ((transport code loop) 0) lemma-transport-code-succ ⟩ -- apply lemma-transport-code-succ twice
          succ ((transport code loop) 0)
            =⟨ ap succ (ap-rev 0 lemma-transport-code-succ) ⟩
          succ (succ 0)
            =⟨ idp ⟩
          2
            =∎

        -- TODO Testing encode(loop^-1) is -1

      open encode-test public using (transport-is-functorial; ap-rev)

      -- The particular case for base is the function (base == base) → ℤ we need
      encode' = encode {base}

    open ΩS¹→ℤDef public using (encode; transport-is-functorial; ap-rev) renaming (encode' to ΩS¹→ℤ)

    -- Right-to-left: we use iterated loop composition.
    module ℤ→ΩS¹Def where

      -- This is the function that we want
      loop⁻ : ℤ → ΩS¹

      -- For n ≥ 0 and n ≤ 0 we need auxiliar functions that use induction on ℕ
      loop⁻-n≥0 : ℕ → (base == base)
      loop⁻-n≥0 0 = idp
      loop⁻-n≥0 (S n) = (loop⁻-n≥0 n) ∙ loop

      loop⁻-n≤0 : ℕ → (base == base)
      loop⁻-n≤0 0 = idp
      loop⁻-n≤0 (S n) = (loop⁻-n≤0 n) ∙ (! loop)

      -- negsucc 0 == -1
      loop⁻ (pos n) = loop⁻-n≥0 n
      loop⁻ (negsucc n) = loop⁻-n≤0 (S n)

      -- Expand the definition to all of code, not only code base, by induction
      decode : {x : S¹} → (code x) → (base == x)
      decode {base} = loop⁻

    open ℤ→ΩS¹Def public using (loop⁻-n≤0; decode) renaming (loop⁻ to ℤ→ΩS¹)

    decode-encode : {x : S¹} (p : base == x) → decode (encode p) == p
    decode-encode {base} idp = idp

    -- Induction on ℤ doesn't work, we defer to induction on ℕ for each of the
    -- two branches (pos n and negsucc n)
    encode-decode : {x : S¹} (c : code x) → encode (decode c) == c
    encode-decode {base} (pos n) = encode-decode-pos n
      where
      encode-decode-pos : (n : ℕ) → encode (decode (pos n)) == pos n
      encode-decode-pos O = idp
      encode-decode-pos (S n) =
        encode (decode (pos (S n)))
          =⟨ idp ⟩ -- definition of decode
        encode ((decode (pos n)) ∙ loop)
          =⟨ idp ⟩ -- definition of encode
        (transport code ((decode (pos n)) ∙ loop)) 0
          =⟨ ap-rev 0 (transport-is-functorial code (decode (pos n)) loop) ⟩ -- functoriality of transport
        ((transport code loop) ∘ (transport code (decode (pos n)))) 0
          =⟨ idp ⟩ -- definition of function composition
        (transport code loop) ((transport code (decode (pos n))) 0)
          =⟨ ap-rev ((transport code (decode (pos n))) 0) lemma-transport-code-succ ⟩ -- apply lemma-transport-code-succ
        succ ((transport code (decode (pos n))) 0)
          =⟨ idp ⟩ -- definition of encode
        succ (encode (decode (pos n)))
          =⟨ ap succ (encode-decode-pos n) ⟩ -- induction on n
        succ (pos n)
          =⟨ idp ⟩ -- definition of succ for ℤ
        pos (S n)
          =∎ -- done!
    encode-decode {base} (negsucc n) = encode-decode-neg n
      where
      encode-decode-neg : (n : ℕ) → encode (decode (ℤ~ (succ (pos n)))) == ℤ~ (succ (pos n))
      encode-decode-neg O =
        encode (decode (negsucc O))
          =⟨ idp ⟩
        encode (loop⁻-n≤0 1) -- TODO clean the exports of the module that defines loop⁻-n≤0
          =⟨ idp ⟩
        encode (! loop)
          =⟨ idp ⟩
        (transport code (! loop)) 0
          =⟨ ap-rev 0 lemma-transport-code-pred ⟩ -- the other lemma
        pred 0
          =⟨ idp ⟩
        negsucc O
          =∎
      encode-decode-neg (S n) =
        encode (decode (negsucc (S n)))
          =⟨ idp ⟩ -- definition of decode
        encode ((decode (negsucc n)) ∙ (! loop))
          =⟨ idp ⟩ -- definition of encode
        (transport code ((decode (negsucc n)) ∙ (! loop))) 0
          =⟨ ap-rev 0 (transport-is-functorial code (decode (negsucc n)) (! loop)) ⟩ -- functoriality of transport
        ((transport code (! loop)) ∘ (transport code (decode (negsucc n)))) 0
          =⟨ idp ⟩ -- definition of function composition
        (transport code (! loop)) ((transport code (decode (negsucc n))) 0)
          =⟨ ap-rev ((transport code (decode (negsucc n))) 0) lemma-transport-code-pred ⟩ -- apply lemma-transport-code-pred
        pred ((transport code (decode (negsucc n))) 0)
          =⟨ idp ⟩ -- definition of encode
        pred (encode (decode (negsucc n)))
          =⟨ ap pred (encode-decode-neg n) ⟩ -- induction on n
        pred (negsucc n)
          =⟨ idp ⟩ -- definition of pred for ℤ
        negsucc (S n)
          =∎ -- done!

    -- We have a more general result, but we only care about the loops at base.
    -- The proof of the theorem though, would work for a more general type
    -- {x : S¹} → (base == x) ≃ (code x)
    -- as well. In our case, though, Agda will assume {x = base} because
    -- ΩS¹ == (base == base).
    -- TODO maybe try and write the general version and derive ΩS¹≃ℤ from it?
    ΩS¹≃ℤ : ΩS¹ ≃ ℤ
    ΩS¹≃ℤ = equiv encode decode encode-decode decode-encode

  open ΩS¹≃ℤDef public

  -- Statement of the main theorem: the loop space over S¹ is isomorphic to ℤ
  ΩS¹==ℤ : ΩS¹ == ℤ

  -- Proof of the main theorem: applying the univalence axiom to the equivalence
  ΩS¹==ℤ = ua ΩS¹≃ℤ
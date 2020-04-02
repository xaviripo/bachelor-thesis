{-# OPTIONS --without-K #-}

-- Basic imports
open import lib.Base
open import lib.PathGroupoid using (!)
open import lib.types.Int
open import lib.Equivalence
open import lib.Univalence

-- Root module of this file
module circle.Circle where

{- This module contains some auxiliar lemmas and tools, not directly related
to the theorem or homotopy theory -}
module aux where

  {- Bit of a weird thing here.
  ap allows us to do: x == y → f x == f y
  in some cases, what we need is: f == g → f x == g x
  We use the "reverse apply" lambda (λ fun → fun x) to do this. -}
  ap-rev : ∀ {i j} {A : Type i} {B : Type j} {f g : A → B} (x : A)
    → (f == g → f x == g x)
  ap-rev x p = ap (λ fun → fun x) p

  -- transport == coe ap => transport-equiv == coe-equiv ap
  transport-equiv→coe-equiv : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → transport-equiv B p == coe-equiv (ap B p)
  transport-equiv→coe-equiv B idp = idp

  -- transport == –> transport-equiv
  transport→transport-equiv : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → transport B p == –> (transport-equiv B p)
  transport→transport-equiv B idp = idp

  {- This is an ugly bit. The statement of the following postulate is in fact
  true (the identity function of a type is its own inverse), but by the way
  ⁻¹ is implemented it's non-trivial to prove.

  Specifically, equivalences are defined as records (`is-equiv`), but the
  inverse operator ⁻¹ does not use that, rather it builds its own private
  module with the same fields. This makes the arguments clearly equal to one
  another but the type checker is not capable of reducing things like:
    .lib.Equivalence.M.f-g
    (record
    { g = λ x → x
    ; f-g = λ _ → idp
    ; g-f = λ _ → idp
    ; adj = λ _ → idp
    })
  to something like
    λ _ → idp
  Because the f-g in M is not the same f-g as the one in the record below.
  Thus, the identity has to be stated as a postulate.

  We then use that to prove that transport-equiv respects inverses: -}
  transport-equiv-respects-inv : ∀ {i j} {A : Type i} (B : A → Type j) {x y : A} (p : x == y) → (transport-equiv B (! p)) == (transport-equiv B p) ⁻¹
  transport-equiv-respects-inv B {x} idp = ide-is-self-inv (B x)
    where
    postulate
      ide-is-self-inv : ∀ {i} (A : Type i) → ide A == ide A ⁻¹

  -- transport B (p ∙ q) == (transport B q) ∘ (transport B p)
  transport-is-functorial : ∀ {i j} {A : Type i} (B : A → Type j)
    {x y z : A} (p : x == y) (q : y == z) → transport B (p ∙ q) == (transport B q) ∘ (transport B p)
  transport-is-functorial B idp idp = idp

open aux


-- Define the circle
module S¹Def where

  data S¹ : Type₀ where
    base : S¹

  postulate
    loop : base == base

  -- Alias for notation only
  ΩS¹ = (base == base)

open S¹Def using (S¹; base; loop; ΩS¹)


{- Let's try to prove the equivalence between ΩS¹ and ℤ as types.
We have to find two equivalences, one in each direction. -}
module ΩS¹≃ℤDef where


  -- Define the code function used in both directions
  module codeDef where

    {- We'll be using the encode-decode method described in the HoTT book.
    The idea here is to define
        code : S¹ → Type
    and then lift it to
        encode' : ΩS¹ → ℤ

    We need to explicitly state the ₀ in Type₀. Otherwise, the expression
    S¹ → Type has kind Set⍵, which is not a type.
    See: https://wiki.portal.chalmers.se/agda/pmwiki.php/ReferenceManual/UniversePolymorphism -}
    code : S¹ → Type₀
    code base = ℤ

    {- Part of the definition of code is that code(loop) is ua(succ).
    This means that applying code to the loop path results in the isomorphism
    between ℤ and ℤ induced by succ (taking each x to succ x). -}
    postulate
      code-ap : ap code loop == ua succ-equiv

    {- coe-equiv is the inverse of ua:
    - coe-equiv takes a type equality and returns an equivalence
    - ua takes an equivalence and returns an equality
    This is postulated by coe-equiv-β.

    This is the first important piece for the definition of encode:
    we want to prove that applying code to loop functorialy results in succ. -}
    lemma-transport-code-succ-equiv : transport-equiv code loop == succ-equiv
    lemma-transport-code-succ-equiv =
      transport-equiv code loop
        =⟨ transport-equiv→coe-equiv code loop ⟩
      coe-equiv (ap code loop)
        =⟨ ap coe-equiv code-ap ⟩
      coe-equiv (ua succ-equiv)
        =⟨ coe-equiv-β succ-equiv ⟩
      succ-equiv
        =∎

    -- Now we adapt the previous result to the maps themselves
    lemma-transport-code-succ : transport code loop == succ
    lemma-transport-code-succ =
      transport code loop
        =⟨ transport→transport-equiv code loop ⟩
      –> (transport-equiv code loop)
        =⟨ ap –> lemma-transport-code-succ-equiv ⟩
      –> succ-equiv
        =⟨ idp ⟩
      succ
        =∎

    -- And we obtain the analog of lemma-transport-code-succ for pred
    lemma-transport-code-pred : transport code (! loop) == pred
    lemma-transport-code-pred =
      transport code (! loop)
        =⟨ transport→transport-equiv code (! loop) ⟩
      –> (transport-equiv code (! loop))
        =⟨ ap –> (transport-equiv-respects-inv code loop) ⟩
      –> (transport-equiv code loop ⁻¹)
        =⟨ ap –> (ap _⁻¹ lemma-transport-code-succ-equiv) ⟩
      –> (succ-equiv ⁻¹)
        =⟨ idp ⟩
      pred
        =∎

  open codeDef


  -- Left-to-right: we need to use the recursion principle of S¹
  module ΩS¹→ℤDef where

    -- This direction is easy, we just lift the path and apply it to 0
    encode : {x : S¹} → (base == x) → (code x)
    encode p = (transport code p) 0


    {- Just some examples checking that encode works as expected.
    These examples are not proven by idp basically because the definition
    of code is not computational (it's got a postulate). This means that Agda,
    when looking for the normal form of encode(...), does not apply code-ap and
    so doesn't end up converting to ℤ.
    The signatures of the functions still check because we can use the postulate
    to prove them correct, though, so it's fine. -}
    module encode-test where

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
          {- At some points we need to be explicit about which idp we're
          talking about so that Agda can understand what we mean -}
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

  open ΩS¹→ℤDef public using (encode)


  -- Right-to-left: we use iterated loop composition
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

  open ℤ→ΩS¹Def public using (loop⁻-n≤0; decode)


  {- Now we have encode and decode. To have the equivalence ΩS¹ ≃ ℤ, we must
  now prove that they are quasi-inverses. We do both proofs by induction,
  but one takes paths and the other one integers, so one is longer. -}

  -- The first composition is trivial
  decode-encode : {x : S¹} (p : base == x) → decode (encode p) == p
  decode-encode {base} idp = idp

  {- The second one is trickier. Induction on ℤ doesn't work, we defer to
  induction on ℕ for each of the two branches (pos n and negsucc n). -}
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

  -- The general result is as follows
  result : {x : S¹} → (base == x) ≃ (code x)
  result = equiv encode decode encode-decode decode-encode

  -- But we only care about the case at {x = base}
  ΩS¹≃ℤ : ΩS¹ ≃ ℤ
  ΩS¹≃ℤ = result {base}

open ΩS¹≃ℤDef public using (encode; decode; ΩS¹≃ℤ)


-- ΩS¹ is equivalent to ℤ as types
module ΩS¹==ℤ where

  -- Statement: the loop space over S¹ is isomorphic to ℤ
  ΩS¹==ℤ : ΩS¹ == ℤ

  -- Proof: applying the univalence axiom to the equivalence
  ΩS¹==ℤ = ua ΩS¹≃ℤ

open ΩS¹==ℤ using (ΩS¹==ℤ)


-- ΩS¹ is isomorphic to ℤ as groups
module ΩS¹Isoℤ where

  -- Group related imports
  open import lib.types.Group
  open import lib.groups.Isomorphism
  open import lib.NType using (is-set; has-dec-eq; dec-eq-is-set)
  open import lib.groups.Int
  open import lib.groups.Homomorphism using (preserves-comp)


  -- Prove ΩS¹ is a group with ∙, idp, ! generated by loop
  module ΩS¹Group where

    -- Luckily for us, all proofs come easily using induction
    ΩS¹-group-structure : GroupStructure ΩS¹
    ΩS¹-group-structure = group-structure ident inv comp unit-l assoc inv-l
      where

      -- Identity element
      ident : ΩS¹
      ident = idp

      -- Inverse operation
      inv : ΩS¹ → ΩS¹
      inv = !

      -- Composition of elements
      comp : ΩS¹ → ΩS¹ → ΩS¹
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
    ΩS¹-is-set : is-set ΩS¹
    ΩS¹-is-set = dec-eq-is-set ΩS¹-has-dec-eq
      where
      ΩS¹-has-dec-eq : has-dec-eq ΩS¹
      ΩS¹-has-dec-eq idp idp = inl idp

    ΩS¹-group : Group₀
    ΩS¹-group = group ΩS¹ {{ΩS¹-is-set}} ΩS¹-group-structure

  open ΩS¹Group using (ΩS¹-group)


  {- Convert our type equivalence to a group isomorphism. The only thing we are
  missing is a proof that the morphism preserves composition -}
  ΩS¹-iso-ℤ : ΩS¹-group ≃ᴳ ℤ-group
  ΩS¹-iso-ℤ = ≃-to-≃ᴳ ΩS¹≃ℤ pres-comp
    where
    -- preserves-comp Ac Bc f = ∀ a₁ a₂ → f (Ac a₁ a₂) == Bc (f a₁) (f a₂)
    pres-comp : preserves-comp _∙_ _ℤ+_ encode
    pres-comp idp idp = idp

open ΩS¹Isoℤ using (ΩS¹-iso-ℤ)

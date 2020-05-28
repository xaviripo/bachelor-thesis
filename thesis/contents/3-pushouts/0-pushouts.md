# Pushouts

As it happens when any new mathematical invariant arises, one naturally asks: how can the invariant for a union of pieces be obtained from the invariant of each of the pieces? In the case of homotopy groups of a space, the Seifert-van Kampen theorem tells us that the fundamental group of a space is determined by the fundamental group of its subspaces, given they are good enough in a certain topological sense.

It turns out, though, that the same is not true for higher homotopy groups. In fact, the best approximation we have obtained so far for this problem is the Blakers-Massey connectivity theorem. This theorem doesn't allow computing the higher homotopy groups of spaces, but rather, it only gives information on the connectivity of such spaces--a property that only relies on the triviality of its homotopy groups.

As part of an ongoing effort to formalize important algebraic topology results using homotopy type theory, the Blakers-Massey theorem has recently been translated into Agda (a programming language that implements homotopy type theory), and in fact using new techniques along the way. In this thesis these proofs will be disassembled and exposed.

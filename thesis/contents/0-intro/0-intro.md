# Introduction

Computer science was born as a tool *by* mathematicians *for* mathematicians, with the goal of aiding in repetitive calculations. Although the field has diversified a lot since its inception, this task is still in its core. The ambition of computer scientists and mathematicians, though, kept growing, up to the challenge we still face today: can computers help us prove new theorems? Homotopy type theory (HoTT for short) is a relatively new field which results from the surprising blend of algebraic topology (*homotopy*) and type theory (*type*).

In a few words, type theory is a foundation of mathematics which has a richer structure than more naive systems such as set theory or lambda calculus. Type theory assigns a *type* to every *term*, in contrast to *sets* which do not impose any semantic restriction to their *elements*. Types also differ from set theory in that they do not require any underlying logic (such as first-order logic), they are capable of representing logical propositions on their own. This is an important advantage when considering formalizing concepts in computer systems because no metatheory is necessary. Finally, type theory has native concepts for structures such as Cartesian products and functions, instead of building them on top of other primitives.

Homotopy theory is a branch of algebraic topology which deals with how paths in topological spaces can be deformed into one another. These "loose paths" starting and ending at a given base point, together with a notion of composition, lead to a natural group, called the fundamental group of the space (together with the base point.) When the base point is disregarded, the group becomes a groupoid. One can then interpret the deformation of one path into another as a 2-path, or *homotopy*, or a path in the space of paths. It can be easily seen how this builds up to an infinite tower of path spaces. This structure is known as $\infty$-groupoid in categorical terms.

Homotopy type theory is a kind of *intensional* type theory, this is to say, there is a differentiation between propositional and definitional equalities. Intensionality is a double-edged sword. The good side is that propositional equality is always given by a path, which contains the information on *how* the two terms are related. This means that a statement of the style $x = y$ also contains the proof (in fact, *all the proofs*) that $x$ equals $y$, in some sense. On the other hand, intensionality gives rise to a $\infty$-grupoid structure, such as the one of topological spaces seen above. In fact, under this point of view, types become spaces, terms become points, equalities become paths, etc. This makes homotopy type theory an ideal ground for the formalization of proofs in homotopy theory. This complex structure, though, makes identifying equality types (i.e. the types of paths between two points) a very difficult task, a generalization of a very well known problem in algebraic topology: the study of higher homotopy groups of spaces.

Computers can only understand the **machine language**, which is just a series of instructions that the processing unit is capable of executing.
In order for humans to write complex programs, compilers were created, programs capable of translating a higher level language (e.g. C) into machine language.
A compiler is not simple.
The translation process actually consists of a series of different steps.

Traditionally, the way computer programs could aid in mathematics was pretty straightforward: one writes a program in, say, C, and then compiles the code into an executable.
Then, the executable is run, yielding the desired results, for example making difficult numerical calculations.

But writing computer programs is no easy task, and is very error-prone.
Modern compilers are equipped with tons of utilities that help minimize mistakes on the side of the human programmer.
One of such tools is the **type system**.

A type system furnishes each variable and function in a program with a type (integers, floating point numbers, booleans, etc.), maybe automatically through analysis of the code, or maybe by hand by the programmer themself.
This way it is harder for the human to mistakenly assign a wrong value to a variable.
When the compiler validates that all variables match their corresponding type, we say that it is **type checking** the program.

Type systems have grown in complexity, allowing things like function types, product types, parametrized types (types that admit other types as parameters), etc.
The last big addition to type systems was dependent types.
These are types that depend on the values of other types, not unlike the type families we have seen in homotopy type theory.
It turns out that this rather innocent-looking improvement is strong enough to allow type systems to work as a foundation for mathematics.

Think about it this way: if I build a function of type `A -> void`, for some type `A`, and the compiler deems the function correct and its type valid, I have successfully proved that `A` is an empty type.

By *abusing* types in this manner, a way was found to write mathematical proofs through the type system.
When doing this, we do not care about the rest of the compilation, or even the resulting executable: we only care about whether the program type-checks or not.
Given sufficiently complex types, the mere fact that an element of such a type exists is a proof of a mathematical fact by itself.

The idea of dependent types, which is necessary for this reasoning system to be possible, is fairly recent, and has not yet been implemented to many existing programming languages, mainly due to its great technical complexity.
For the last twenty years, a few research-oriented programming languages with dependent types have been popping up.
One of them is **Agda**, a programming language developed by the universities of Chalmers and Gothenburg (Sweden) with the idea of exploiting dependent types in mind.
A mathematician types a program that constructs an element of a certain type, a type representing the statement to prove through the Curry-Howard correspondence.
The Agda type checker then validates the types, effectively verifying that the proof is correct.
Even though Agda is, in principle, more oriented to general programming than other proof assistants (e.g. Coq), its lightweight syntax and good integration of higher path types make it very suitable for the formalization of homotopy type theory.
An ongoing development in Agda has been the implementation of a kind of type theory, known as cubical type theory, which allows modeling higher inductive types natively.

A proof of the theorem presented at @sec:circle_fundamental-group has been implemented in Agda from scratch.
Although this is not, by a long shot, a new development, it is still pretty educational as an introduction to Agda and dependently-typed programming.
It is particularly good to illustrate most of the ideas in the proof without making too much use of previous results.

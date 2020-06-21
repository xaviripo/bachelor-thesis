# Introduction {.unnumbered}

\pagenumbering{arabic}

Computer science was born as a tool *by* mathematicians *for* mathematicians, with the goal of aiding in repetitive calculations.
The field has diversified a lot since its inception, but the idea of helping in mathematical research still lies in its heart.
The ambition of computer scientists and mathematicians has kept growing, up to the question posed today: can computers help us prove theorems?
Homotopy type theory is a field that can potentially help with this problem.

In a few words, type theory is a foundation of mathematics, alternative to set theory or category theory.
In set theory, one way to build the natural numbers is through the recursive definition $0 := \varnothing$, $n' := n \cup \{n\}$.
This yields a functional representation of the Peano naturals, but it also produces valid expressions like $0 \in 1$, which are often unwanted, as they mix the nature of the sets with the "pure" idea of the numbers.
Of course, this does not really suppose any trouble to the working mathematician, as it is pretty easy to just "forget" about the particular implementation of the natural numbers and think of them as objects on their own rather than sets.
This issue is only relevant when working on certain formal systems, in particular when one wants to do *computational* mathematics.
In that case, it is important for the computer to be explicitly aware of what sets represent natural numbers and what sets do not.

The problem becomes unsolvable when dealing with more complex objects.
For example, viewing functions as sets of ordered pairs makes them not generally representable in a finite setting.
Even though one can define a function by just stating its action on any element of the domain (for example, $f(x) := x + 1$), the underlying set that represents the function can easily be infinite.

Type theory tries to tackle this problem by taking a more semantic view on mathematical objects.
It operates with terms that have assigned types.
In the case of the natural numbers, for example, instead of building them out of more elementary atoms, we just state them as what we want them to be: a type with an initial term and a way to build a new term for each existing one.
Similarly, functions become simple computation rules instead of literally being made out of all the possible mappings they entail.

This philosophy---the idea that mathematical structures should be finitely describable---is known as constructivism, and is the quintessence of Martin-Löf's type theory.
Although type theories precede Martin-Löf's by some decades, the one he published, known as intuitionistic type theory, is the first one to implement predicative logic, which is vital for producing meaningful mathematics.
The notion of constructivism not only applies to objects such as algebraic structures, but also to predicates about these.
In a set-theoretic setting, constructing the set of all even natural numbers and the *statement* that such set is the set of all even numbers are two completely different things.

The first would be something like $\{n \in \naturals : 2 \mid n \}$.
This is just a set of numbers that, by definition, are all the even natural numbers.
We can name this set $E$, then forget about how it was defined, and we would lose the notion that it is the set of even naturals.
In fact, by writing $\{0,2,4,6,8,...\}$ we could describe that same set without using the notion of evenness.

The second could be expressed as $\forall n \in \naturals,\, n \in E \iff 2 \mid n$.
This assertion is expressed using predicative logic, it is not an object in the same sense as $E$.

In type theory, we record the properties we care about of objects in the objects themselves.
For example, the "set" of even naturals would be realized as a type consisting of ordered pairs, where the first component is any even number, and the second one is the *proof* that it is even.
This way, not only we obtain the object itself (all the even natural numbers), we also encode the definition of the object with it.
As a result of this technique, and the existence of certain native constructions (such as the dependent types introduced by Martin-Löf), intuitionistic type theory does not need of predicative or even propositional logic.
It just needs a formal language that allows us to introduce some syntactical rules and create new types when needed.

How is a type theory *actually* used in a computer setting?

Computers can only understand the machine language, which is just a series of instructions that the processing unit is capable of executing.
In order for humans to write complex programs, compilers were created, programs capable of translating a higher level language (e.g. C) into machine language.
A compiler is not simple.
The translation process actually consists of a series of different steps.

Traditionally, the way computer programs could aid in mathematics was pretty straightforward: one writes a program in, say, C, and then compiles the code into an executable.
Then, the executable is run, yielding the desired results, for example making difficult numerical calculations.

But writing computer programs is no easy task, and is very error-prone.
Modern compilers are equipped with tons of utilities that help minimize mistakes on the side of the human programmer.
One of such tools is the type system.

A type system furnishes each variable and function in a program with a type (integers, floating point numbers, booleans, etc.), maybe automatically through analysis of the code, or maybe by hand by the programmer themself.
This way it is harder for the human to mistakenly assign a wrong value to a variable.
When the compiler validates that all variables match their corresponding type, we say that it is type checking the program.

Type systems have grown in complexity, allowing things like function types, product types, parametrized types (types that admit other types as parameters), etc.
The last big addition to type systems was dependent types.
These are types that depend on the values of other types.
It turns out that this rather innocent-looking improvement is strong enough to allow type systems to implement an intuitionistic type theory.

By *abusing* types in this manner, a way was found to write mathematical proofs through the type system.
When doing this, we do not care about the rest of the compilation, or even the resulting executable: we only care about whether the program type-checks or not.
Given sufficiently complex types, the mere fact that an element of such a type exists is a proof of a mathematical fact by itself.

Now that we have a picture of what an (intuitionistic) type theory is, what is *homotopy* type theory?
First, we must introduce homotopy theory.

Homotopy theory is a branch of algebraic topology which deals with how paths in topological spaces can be deformed into one another.
When paths starting and ending at a given base point are "loosened" keeping only the endpoints fixed, together with an adequate notion of composition, we obtain a natural group, called the fundamental group of the space (together with the base point).
When the base point is disregarded, the group becomes a groupoid.
One can then interpret the deformation of one path into another as a 2-path, or *homotopy*, or a path in the space of paths.
This idea can be applied recursively, considering homotopies between homotopies, and so on.
It can be easily seen how this builds up to an infinite tower of path spaces.
When ignoring stronger topological structure and just looking at the paths, each topological space can be assigned what we call a homotopy type.

Homotopy type theory is a kind of *intensional* type theory, this is to say, there is a differentiation between propositional and definitional equalities.
Intensionality is a double-edged sword.
The good side is that propositional equality is always given by a type, which contains the information on *how* the two terms are related.
This means that a statement of the style $x = y$ also contains the proof (in fact, *all the proofs*) that $x$ equals $y$, in some sense.
On the other hand, intensionality gives rise to a family of types which are very hard to study, the identity types, those representing equality statements.
In fact, it turns out that identity types actually become a model for the higher path structures that appear in topological spaces, if we take equalities and think of them as paths joining the two equal things.

So, we have the word *type* in three different settings:

- As constructions used by logicians in type theory as a foundation of mathematics.
- As a method used by computer scientists in type systems in order to reduce bugs.
- As an invariant used by topologists to study and classify spaces (the homotopy type).

Homotopy type theory is what happens when these three concepts are interpreted as one.

Although homotopy type theory can be used as a basis for *all* of mathematics, it is particularly good for studying homotopy theory as it offers a synthetic setting for a subject that has traditionally been studied analytically, and, furthermore, allows it to be computerized so that the proofs can be checked automatically.

The idea of dependent types, which is necessary for this reasoning system to be possible, is fairly recent, and has not yet been implemented to many existing programming languages, mainly due to its great technical complexity.
For the last three decades, a few research-oriented programming languages with dependent types have been popping up.
One of them is **Agda**, a programming language developed by the universities of Chalmers and Gothenburg (Sweden) with the idea of exploiting dependent types in mind.
A mathematician writes a program that constructs an element of a certain type, a type representing the statement to prove through the Curry-Howard correspondence.
The Agda type checker then validates the types, effectively verifying that the proof is correct.
Even though Agda is, in principle, more oriented to general programming than other proof assistants (e.g. Coq), its lightweight syntax and good integration of higher equality types make it very suitable for the formalization of homotopy type theory.

Learning constructive mathematics is not easy.
After explaining the basic concepts of type theory, we began our journey by examining the first non-trivial proof one encounters in algebraic topology, namely that of the fundamental group of the circle \sone.
This alone led us to study the rich concept of covering spaces.
The theoretical study of this proof was accompanied by the practical implementation of an Agda program that implements it.

Afterwards, we wanted to try our luck with a more complicated case: the fundamental group of the real projective plane $\RP^2$.
While we were observing the problem, we realized that a potentially easier construction of $\RP^2$ could perhaps be made as an alternative to those found in publications.
In particular, our approach tries to remove all accessory constructions and leave only the minimal components that would give a type the homotopical structure of $\RP^2$.
The implications are that we have to work with second order inductive types, the difficulties of which we expose along the way.
Albeit we accomplish the task of obtaining the fundamental group, we have difficulties proving that the construction is indeed a projective space, although we make substantial advances towards it.

Both parts of this thesis display the elegance of translating concepts from set-theoretic topology to homotopy type theory, where many times the definitions better represent the ideas behind them.
Not only does homotopy type theory help us translate the theorems for the computer to verify, but it also succinctly encapsulates the essence of *paths* in a way that allows us to tell what topological constructions are homotopical and which are not.

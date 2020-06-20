## Homotopy Type Theory

A very brief introduction to type theory is given in this chapter.
Unfortunately, not every concept is explained as detailed as it is desirable.
The recommended reference material is the Homotopy Type Theory book [@univalent_foundations_program_homotopy_2013].


### Types and terms

In type theory, every *term* has a unique assigned *type*. Note two important differences with respect to set theory:

1. A term must belong to, at least, one type. In type theory it makes no sense to talk about a typeless term, and we cannot do much with it if we do not know its type. All the equations and computations involving a term expect it to have an assigned type.

2. A term must belong to, at most, one type. That is to say, terms cannot belong to two or more types at the same time. Note that, in particular, an analogous notion to that of a subset is not possible--at least not without some intermediate structure.

We write

$$
a : A
$$

to express that the term $a$ has type $A$. The words *element* and *point* will be used interchangeably with term.

Types themselves are regarded as terms of a special type \universe, called the "universe type".
For example, when we say "$A$ is a type", this is the same as denoting $A : \universe$.

There are two main ways to obtain types:

1. To create them from scratch, via inductive types. We will see this option in @sec:hott_inductive-types.

2. To create them from previously existing types, via type constructors.

Type constructors allow to build new types from existing ones.
We can think of them as functions whose codomain is \universe.
To specify a new type constructor, one has to give the following rules for it:

- **Formation rules**.
Preconditions to be met by the types used to build the constructed type.

- **Introduction rules** or constructors.
Ways to build new terms.
These are functions (possibly nullary) whose return type is the constructed type.

- **Elimination rules** or eliminators.
Ways to use terms.
These are functions that have, at least, one argument of the constructed type.
Eliminators can often be non-dependent (called recursion principles or recursors) or dependent (called induction principles).

- **Computation rules**.
They explain how the eliminators act on the constructors.


### Function types

The function types are special in that their elements cannot be defined from simpler type-theoretic terms.
From the function type constructor we will deduce most other constructors.
This comes from the fact that type theories are often instances of typed lambda calculi, i.e. we are furnishing functions with types, rather than adding functions to types.

- Formation rule.
Given any two types $A$ and $B$, the (non-dependent) **function type** from $A$ to $B$, denoted $A \rightarrow B$, contains all the functions $f : A \rightarrow B$ that assign to each term $a : A$ an element in $B$, $f(a)$.

- Introduction rules.
There are a few ways to define functions.
One is direct definition: $f(x) :\equiv \Phi$, where $\Phi$ is a formula that contains $x$ as an unbound variable.
Equivalently, we can use $\lambda$-abstraction: we denote by $\lambda (x : A).\Phi$ the function that takes an argument of type $A$ and replaces all occurrences of $x$ in $\Phi$ with it.
So, we can also define $f :\equiv \lambda (x : A).\Phi$.

- Elimination rule.
The obvious eliminator is application: given a function $f : A \rightarrow B$ and a term $a : A$, we can think of $f(a) : B$ as applying $a$ to $f$ to produce a term of $B$.

- Computation rule.
The computation rule for functions tells us that $a : A$ applied to $\lambda(x : A).\Phi$ is $\Phi$ with all occurences of $x$ replaced with $a$.
Observe that this goes a step further than the elimination rule, as we are describing the function in terms of its construction (as a $\lambda$-abstraction in this case).

The types of functions with codomain \universe{} ($A \rightarrow \universe$) are called **type families** or dependent types.
Think carefully about what this means.
Ordinary functions give us a value in a type for each value given.
On the other hand, dependent types give us a whole type, for each value given.

Given a type family $B : A \rightarrow \universe$, the dependent function type (also known as $\prod$-type) $\prod_{(x : A)}B(x)$ comprises the functions whose codomain is a type family depending on the input *value*, i.e., given $f : \prod_{(x : A)} B(x)$ and $a : A$, then $f(a) : B(a)$.
The rules for the dependent types are analogous to those of the non-dependent types.

If we want to build a function with two arguments, its type would be $f : A \rightarrow B \rightarrow C$.
This means that, when applied to a value $a : A$, $f$ returns a value $f(a) : B \rightarrow C$.
Then, we can apply a value $b : B$, to obtain $f(a)(b) : C$.
Although it is also possible to define multiple parameters via Cartesian products, just like in set theory, that is not the most natural way to do it in type theory.
When a function is presented in this way, we say it is curried.
We often write $f(a,b)$ to mean $f(a)(b)$, for convenience.


### Product types

As with function types, we have a both a non-dependent and a dependent version.

- Formation rule.
Types $A$ and $B$ can form a type $A \times B$ called the (non-dependent) **product type** of $A$ and $B$.
If we have types $A$ and $B : A \rightarrow \universe$, then $\prod_{(x : A)} B(x)$ is the dependent product of $A$ and $B$.
In the dependent case, $b$ has to belong to the type $B(a)$.

- Introduction rule.
Given $a : A$ and $b : B$, we obtain $(a,b) : A \times B$.

- Elimination rules.
If we have a function $f : A \rightarrow B \rightarrow C$, then this rule gives us another function $g : (A \times B) \rightarrow C$.
The dependent eliminator is akin to this one, but with $f$ a dependent function.

- Computation rule.
The eliminator tells us there exists a function $g : (A \times B) \rightarrow C$.
The computation rule tells us how this function acts on the elements created by the introduction rules, namely pairs $(a,b)$.
Imagine we have $a : A$, $b : B$, and $g : A \rightarrow B \rightarrow C$.
This rule defines $f((a,b))$ as $g(a,b)$.


### Coproduct types

The coproduct is the analogue of the disjoint union in set theory.
It does not have a dependent version.

- Formation rule.
As with product types, we take types $A$ and $B$ to obtain their **coproduct type** $A + B$.

- Introduction rule.
There are two ways to introduce elements of $A + B$.
One is, given a term $a : A$, we have a term $\inl(a) : A + B$.
The other, given $b : B$, we have $\inr(b) : A + B$.

- Elimination rule.
The non-dependent eliminator is very simple: for any type $C$, and given functions $f : A \rightarrow C$, $g: B \rightarrow C$, there is a function $h : (A + B) \rightarrow C$.

- Computation rule.
As with product types, this just tells us how to apply the eliminator on the constructor. In this case, the function $h$ given above behaves like this:
  \begin{align*}
  h(\inl(a)) &= f(a)\\
  h(\inr(b)) &= g(b)
  \end{align*}


### Identity types {#sec:preliminaries_hott_identity}

In intensional type theories, such as homotopy type theory, two terms can be definitionally equal (also known as judgmentally equal) or they can be propositionally equal.
Two terms are definitionally equal only when we impose so, and, in such case, they are fully interchangeable by one another.
We denote that $a$ and $b$ are definitionally equal by writing $a \equiv b$.
We sometimes write $a :\equiv b$ to emphasize that $a$ is being defined.
The claim that two terms are definitionally equal cannot be disputed, it is not a proposition.
This is used mainly when defining new terms and types, or for notation purposes.

On the other hand, two (not necessarily equal in the previous sense) terms of the same type can be compared for propositional equality.
This means that, given two terms $a$ and $b$ of a type $A$, it makes sense to ask whether they are equal or not.
As we will see, propositions are implemented through types in homotopy type theory, so we reserve the notation $a = b$ for the type of equalities between $a$ and $b$, or, in the homotopical sense, the type of paths between $a$ and $b$.
We call this an **identity type** or path type.

The identity type is what mainly differentiates homotopy type theory from other kinds of type theory. Given a type $A : \universe$, there exists a (possibly empty) type $a =_A b$ of identifications between $a : A$ and $b : A$.
We often omit $A$ when it is clear and just write $a = b$.
The idea is that every term in $a =_A b$ is a proof that $a$ is equal to $b$.
This type is not always trivial: two elements in a type can be equal in many different ways.
In fact, the complexity of identity types is what makes homotopy type theory interesting and what gives rise to the homotopical structure.

Path types are also type constructors. They are a bit different from the other seen so far in that they do not only require types, but also elements of such type.
We can think of the type constructor $(-=_{-}-)$ as a function of type $\prod_{(A : \universe)} A \rightarrow A \rightarrow \universe$.
Now, as a type constructor, we should also give the rules on how it behaves.

The introduction rule tells us that, given a term of a type, it is equal to itself.
In other words, for any $A : \universe$ and $a : A$, we have $\refl_a : a = a$.
The fact that this is the only introduction rule does not mean that there are not other paths.

The elimination rule for path types is one of the most important reasoning tools in homotopy type theory.
Often described in its dependent form, hence called **path induction**, it allows us to build functions and prove statements about all paths in a path type, by just proving them on a few paths of the type.
Suppose we have a type family $C$ that assigns a type to every possible path in a type $A$ (i.e. $C : \prod_{(x,y : A)} (x =_A y) \rightarrow \universe$).
We want to build a dependent function $f$ that, for each path $p : a = b$, gives us a value of $C(a,b,p)$.
The induction principle for path types states that, in order to obtain $f$, it is only necessary to define it on the paths $\refl$.
Then, the computation rule says that the $f$ that we obtain in fact respects the values we have given at each $\refl$.


### Inductive types {#sec:hott_inductive-types}

An inductive type, in its purest form, is given by introducing a series of *constructors*. The idea is that an inductive type is "freely generated" by its constructors. The simplest inductive type has no constructors:
$$\zero : \universe$$

This is known as the **empty type**.

The type with a single constructor is known as the **unit type**:
\begin{align*}
\one &: \universe\\
\star &: \one
\end{align*}

Finally, we define the **type of booleans**:
\begin{align*}
\two &: \universe\\
\zerotwo, \onetwo &: \two
\end{align*}

Inductive types accept other kinds of constructors, not just elements. For example, the **naturals** can be defined as such:
\begin{align*}
0 &: \naturals\\
\natsucc &: \naturals \rightarrow \naturals
\end{align*}

What this is telling us is that every element of the type $\naturals$ can be built as either $0$, or as $\natsucc$ applied to another element of $\naturals$. Thus, the possible naturals are $0$, $\natsucc(0)$, $\natsucc(\natsucc(0))$, etc.

Inductive types are regular enough that we can mechanically deduce what their elimination principles look like.
In simple terms, to define a function out of an inductive type, we provide the image for each constructor.

For example, to build a function with domain \naturals, we must provide a value for $0$, and a function that for every $n : \naturals$ gives us a value for $\natsucc(n)$.
In the case of the naturals, this matches the traditional notion of recursion.
Similarly, if we do this with a dependent function, we obtain the induction on the naturals.
Elementarily, when given a family of types $P : \naturals \rightarrow \universe$, if we provide an element of $P(0)$, and for every $n : \naturals$ we provide a function $P(n) \rightarrow P(\natsucc(n))$, then we effectively prove $P$ for all naturals.

Inductive types are an idea that already appears in older type theories. Homotopy type theory presents a whole new class of inductive types, known as **higher inductive types**. These allow constructors whose codomain is not only the type being described, but also path types on that.

The most iconic example is the **circle**, $\sone$, which is made up by a single point and a loop from the point to itself.
\begin{align*}
\sbase &: \sone\\
\sloop &: \sbase = \sbase
\end{align*}

Or, taking higher paths, we can build higher dimensional spheres:
\begin{align*}
\sbase &: \stwo\\
\ssurf &: \refl_{\sbase} = \refl_{\sbase}
\end{align*}


### Univalence

In type theory there is no notion of "subtype".
Hence, it can be hard to work with inclusions.
To ease this work, we introduce a series of notions related to the idea of "equivalent types".

\begin{definition}
Two functions $f, g: A \rightarrow B$ are \textbf{homotopic} when they are point-to-point equal, i.e. $\prod_{(x : A)} f(x) = g(x)$.
We write this type as $f \sim g$, and call its elements homotopies.
\end{definition}

\begin{definition}
Two types $A$ and $B$ are \textbf{equivalent} when there exist functions $f : A \rightarrow B$ and $g : B \rightarrow A$ such that $g \circ f \sim \id_{A}$ and $f \circ g \sim \id_{B}$.
We call $f$ and $g$ equivalences and say that they are mutually quasi-inverses.
We write $A \simeq B$ for the type of equivalences between $A$ and $B$.
Formally, this type is:
$$\sum_{f : A \rightarrow B} \left[\left(\sum_{g : B \rightarrow A} f \circ g \sim \id_{B}\right) \times \left(\sum_{h : B \rightarrow A} h \circ f \sim \id_{A}\right)\right]$$
\end{definition}

One of the new concepts that homotopy type theory brought was that of univalence.
Essentially, univalence is a way of easing the problem of identifying types.

\begin{lemma}[Transport]
Given a type family $P : A \rightarrow \universe$ and a path $p : x = y$ of elements $x, y : A$, there is a function $p_* : P(x) \rightarrow P(y)$.
\end{lemma}

\begin{proof}
It is enough to do path induction on the equality type $x = y$.
This means we can assume $y \equiv x$ and $p \equiv \refl_x$, and hence $P(x)$ = $P(y)$.
Thus, we can take $p_*$ to be the identity function of $P(x)$.
\end{proof}

\begin{lemma}
Given types $A$ and $B$, there is a function $\idtoeqv : (A = B) \rightarrow (A \simeq B)$.
\end{lemma}

\begin{proof}
Observe how $\id_{\universe} : \universe \rightarrow \universe$ is a type family.
Thus we can apply the transport lemma.
We want to assign $\idtoeqv(p) = p_*$.
For this, we must prove that each $p_*$ is an equivalence.
By path induction, we can suppose $p$ is $\refl_A$, and then $p_*$ is $\id_A$, which is trivially an equivalence.
\end{proof}

\begin{axiom}[Univalence]
\idtoeqv{} is an equivalence.
\end{axiom}

The inverse function of \idtoeqv{} is known as \ua{} for "univalence axiom".
It basically states that, whenever two types are equivalent, we can treat them as equal.

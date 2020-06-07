## Homotopy Type Theory

A very brief introduction to type theory is given in this chapter, although maybe not deep enough to properly follow all the details in the theorem we want to study. The recommended reference material is the Homotopy Type Theory book (TODO move this to a reference footnote and explain a little about the project and the group).


### Types and terms

In type theory, every *term* has a unique assigned *type*. Note two important differences with respect to set theory:

1. A term must belong to, at least, one type. In type theory it makes no sense to talk about a typeless term, and we can not do much with it if we do not know its type. All the equations and computations involving a term expect it to have an assigned type.

2. A term must belong to, at most, one type. That is to say, terms can not belong to two or more types at the same time. Note that, in particular, an analogous notion to that of a subset is not possible--at least not without some intermediate structure.

We write

$$
a : A
$$

to express that the term $a$ has type $A$. The words *element* and *point* will be used interchangeably with term.


### Universes

Types themselves behave as a special kind of terms of higher types, called *universes*. Universes are stratified, in a similar fashion to the Von Neuman hierarchy of sets. Exceptionally, types in universes are considered to belong to more than one universe: if they belong to a given universe $\mathcal{U}_n$, they belong to the bigger universe type $\mathcal{U}_{n+1}$ such that $\mathcal{U}_n : \mathcal{U}_{n+1}$. As with classical mathematics, we will not make explicit in which level our type belongs, rather using an ambiguous $\mathcal{U}$ notation for all universe types.
(TODO check against book all this part)


### Equalities

In intensional type theories, such as homotopy type theory, two terms can be definitionally equal (also known as judgmentally equal) or propositionally equal. Two terms are definitionally equal only when we impose so, and, in such case, they are fully interchangeable by one another. We denote that $a$ and $b$ are definitionally equal by writing $a \equiv b$. We sometimes write $a :\equiv b$ to emphasize that $a$ is being defined. The claim that two terms are definitionally equal cannot be disputed, it is not a proposition. This is used mainly when defining new terms and types, or for notation purposes.

On the other hand, two (not necessarily equal in the previous sense) terms of the same type can be compared for propositional equality. This means that, given two terms $a$ and $b$ of a type $A$, it makes sense to ask whether they are equal or not. As we will see, propositions are implemented through types in homotopy type theory, so we reserve the notation $a = b$ for the type of equalities between $a$ and $b$, or, in the homotopical sense, the type of paths between $a$ and $b$.


### Type constructors

Type constructors allow to build new types from existing ones (for example, the cartesian product is a type constructor). To specify a new type constructor, one has to give the following rules for it:

- Formation rules. Preconditions to be met by the types used to build the constructed type.

- Introduction rules or constructors. Ways to build new terms. These are functions (possibly nullary) whose return type is the constructed type.

- Elimination rules or eliminators. Ways to use terms. These are functions that have, at least, one argument of the constructed type.

- Computation rules. They explain how the eliminators act on the constructors.

Let us quickly review some type constructors.


#### Function types

The function types are special in that their elements cannot be defined from simpler type-theoretic terms. From the function type constructor we will deduce most other constructors.

- Formation rule. Given any two types $A$ and $B$, the (non-dependent) function type from $A$ to $B$, denoted $A \rightarrow B$, contains all the functions $f : A \rightarrow B$ that assign to each term $a : A$ an element in $B$, $f(a)$.

- Introduction rules.
There are a few ways to define functions.
One is direct definition: $f(x) :\equiv \Phi$, where $\Phi$ is a formula that contains $x$ as an unbound variable.
Equivalently, we can use $\lambda$-abstraction: $\lambda (x : A).\Phi$ is the function that takes an argument of type $A$ and replaces all occurrences of $x$ in $\Phi$ with it.
So, we can define $f :\equiv \lambda (x : A).\Phi$.

- Elimination rule. The obvious eliminator is application: given a function $f : A \rightarrow B$ and a term $a : A$, we can think of $f(a) : B$ as applying $a$ to $f$ to produce a term of $B$.

- Computation rule. The computation rule for functions tells us that $a : A$ applied to $\lambda(x : A).\Phi$ is $\Phi$ with all occurences of $x$ replaced with $a$.

The types of functions with codomain $\mathcal{U}$ ($A \rightarrow \mathcal{U}$) are called type families or dependent types.

Given a type family $B : A \rightarrow \mathcal{U}$, the dependent function type (also known as $\prod$-type) $\prod_{(x : A)}B(x)$ comprises the functions whose codomain type is a type family depending on the input *value*, i.e., given $f:\prod_{(x : A)}B(x)$ and $a:A$, then $f(a) : B(a)$. The rules for the dependent types are analogous to those of the non-dependent types.

If we want to build a function with two arguments, its type would be $f : A \rightarrow B \rightarrow C$.
This means that, when applied to a value $a : A$, we have $f(a) : B \rightarrow C$.
When a function is presented in this way, we say it is curried.
We often write $f(a,b)$ to mean $f(a)(b)$, for convenience.


#### Product types

As with function types, we have a both a non-dependent and a dependent version. We will only expose the non-dependent version.

- Formation rule. Types $A$ and $B$ can form a type $A \times B$ called the (non-dependent) product type of $A$ and $B$. If we have types $A$ and $B : A \rightarrow \mathcal{U}$, then $\prod_{(x : A)}B(x)$ is the dependent product of $A$ and $B$. In the dependent case, $b$ has to belong to the type $B(a)$.

- Introduction rule. Given $a : A$ and $b : B$, we obtain $(a,b) : A \times B$.

- Elimination rule. If we have a function $g : A \rightarrow B \rightarrow C$, then this rule gives us another one $f : A \times B \rightarrow C$, with the natural definition $f((a,b)) :\equiv g(a)(b)$. This principle is summed up in a special function called the recursor for product types: $\mathsf{rec}_{A \times B} : \prod_{(C : \mathcal{U})} (A \rightarrow B \rightarrow C) \rightarrow A \times B \rightarrow C$, defined as $\mathsf{rec}_{A \times B}(C,g,(a,b)) :\equiv g(a)(b)$. When generalized to dependent functions ($g : \prod_{(x : A)}\prod_{(y : B)}C((x,y))$), this is known as the induction principle:

   $$\mathsf{ind}_{A \times B} : \prod_{C : A \times B \rightarrow \mathcal{U}} \left(\prod_{x : A}\prod_{y : B}C((x,y))\right) \prod_{z : A \times B} C(z)$$

    $$\mathsf{ind}_{A \times B}(C,g,(a,b)) :\equiv g(a)(b)$$

    Again, both the recursion and induction principles exist for both non-dependent and dependent product types.

- Computation rule. Imagine we have $a : A$, $b : B$, and $g : A \rightarrow B \rightarrow C$. When applying the introduction rule to $a$ and $b$, we get the pair $(a,b)$; and, when applying the elimination rule to the function $g$, we obtain a function $f : A \times B \rightarrow C$. This rule states that $g(a,b)$ is the same as $f((a,b))$. In other words, this says that our introduction and elimination rules are coherent.


#### Inductive types

To be able to apply the type constructors above, we need some other types to start from. We introduce a different way to construct types: inductive types.

An inductive type is a type described by a set of (possibly nullary) functions whose codomain is that type. For example, the empty type $\mathbf{0} : \mathcal{U}$ is the type defined by no constructors. Similarly, the unit type $\mathbf{1} : \mathcal{U}$ is characterized by a single constructor $\star : \mathbf{1}$. Finally, we see the type of booleans $\mathbf{2} : \mathcal{U}$, given by $0\sb{\mathbf{2}}, 1\sb{\mathbf{2}} : \mathbf{2}$.

A more interesting example is the naturals $\mathbb{N} : \mathcal{U}$, given by:
\begin{align*}
0 &: \mathbb{N}\\
\mathsf{succ} &: \mathbb{N} \rightarrow \mathbb{N}
\end{align*}

Inductive types can be thought of a special case of type constructors. In the case of inductive types, though, just defining the constructors, which are its introduction rules, we can deduce the elimination rules, whereas we normally have to think them out and prove they are coherent, through the computation rule.

TODO Talk about not assuming (in)equality right away (e.g. having to prove that 0 is empty and 1 has a single element).

TODO Talk about HIT, although the equality type is needed before hand?


#### The identity type

The identity type is what mainly differentiates homotopy type theory from other kinds of type theory. Given a type $A : \mathcal{U}$, there exists a (possibly empty) type $a =_A b$ of identifications between $a : A$ and $b : A$. The idea is that every term in $a =_A b$ is a proof that $a$ is equal to $b$. This type is not always trivial: two elements in a type can be equal in many different ways. In fact, the complexity of identity types is what makes homotopy type theory interesting and what gives rise to the homotopical structure.

TODO Path induction


### Propositions as types

TODO

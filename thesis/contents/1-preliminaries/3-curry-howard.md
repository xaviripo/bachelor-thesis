## The Curry-Howard Correspondence

As we have hinted at, homotopy type theory, as a foundation for mathematics, is very apt for computation.
This is due to the **Curry-Howard correspondence**.
The Curry-Howard correspondence is the Rosetta stone between concepts in first order logic and type theory.
Each construction in classical logic has an analogue in type theory, usually as a type or type constructor.
This means that the objects carrying the statements and proofs, are of the same nature as those that contain the things talked about.
The best way to understand this is to take a look at the most relevant examples:

| First order logic                      | Type theory                            |
|----------------------------------------|---------------------------------------:|
| A statement                            | A type                                 |
| A theorem                              | An inhabited type                      |
| A proof                                | An element of a type                   |

All other principles can be deduced from these.
Some types can be regarded as statements.
When that is the case, whether its inhabited or not is equivalent to whether its true or false as a statement.
That is why type theory is regarded as *constructivist*: when we prove a theorem, what we do is build an element of a type.
We consider each term of a type to be a different proof of it.
We often call these elements **witnesses**, so we can reserve the word proof for the process of building one.
Let us see *how* to build statements out of types:

| First order logic                      | Type theory                            |
|----------------------------------------|---------------------------------------:|
| $A \wedge B$                           | $A \times B$                           |
| $A \vee B$                             | $A + B$                                |
| $A \Rightarrow B$                      | $A \rightarrow B$                      |
| $\neg A$                               | $A \rightarrow \zero$                  |

The explanations for these equivalences are very intuitive.

$A \wedge B$ (representing $A$ *and* $B$) is represented by the Cartesian product type $A \times B$.
Having a proof of $A \wedge B$ amounts to having a proof of $A$ and having a proof of $B$, or, under the type-theoretic interpretation, having an element of $A$ and an element of $B$. But, we have those two if and only if we have an element $(a,b) : A \times B$.

Similarly, having a proof of $A \vee B$ is the same as having either a proof of $A$ or a proof of $B$.
Which is the same as having an element of $A + B$, that we know must have the form $\inl(a)$, with $a : A$, or $\inr(b)$ with $b : B$.

Perhaps the most surprising one is the implication.
An implication $A \Rightarrow B$ is true whenever a proof for $A$ yields a proof for $B$.
This is exactly what a function does: given an element of $A$, we obtain an element of $B$.

And from that, we build the negation.
Although we must beware of *reductio ad absurdum* in type theory for reasons we will later see, this construction comes from the idea that something is false whenever it implies a contradiction.
In this case, if we have a function $A \rightarrow \zero$, then $A$ cannot be inhabited, as there is no point in \zero{} to take the points of $A$.

Nonetheless, it is often more comfortable for humans to describe proofs in the classical style, exposing a chain of arguments.
We have seen the key elements of propositional logic; we need to see construct quantifiers:

| First order logic                            | Type theory                            |
|----------------------------------------------|---------------------------------------:|
| For some $a$ in $A$, $P(a)$.                 | $\sum_{(a : A)} P(a)$                  |
| For all $a$ in $A$, $P(a)$.                  | $\prod_{(a : A)} P(a)$                 |

This is the key reason for which we need dependent functions and pairs, and the reason (as we will see later) that the introduction of dependent types in programming languages was so important for type theory.
Dependent types are the analogues of the universal and existential quantifiers, and so give us the full power of first order logic.

Let us unpack this.
For the existential, we provide dependent pairs. Each pair contains an element of $A$ together with the proof of the statement $P$ we claim about $a$.
Observe that, once again, the corresponding type contains *all* possible proofs of $P(a)$.
Conversely, if $b : A$ does not satisfy proposition $P$, then there does not exist any pair with $b$ as the first component.
From this point of view, $\sum_{(a : A)} P(a)$ is not only the claim that there exists an $a$ such that $P(a)$, but it is also the type-theoretical analogue of the subset $\{a \in A : P(a)\}$.

For the universal quantifier, we do not want to show *some* elements of $a : A$; we want a proof of $P(a)$ for *every* $a : A$.
This is what the dependent function does: for each $a$, it returns an element of $P(a)$.
Again, this does not only say that all $a$ satisfy $P(a)$, but also gives us the proof itself for each $a$.

We introduce the final ingredient for our recipe: identity types.

| First order logic                      | Type theory                            |
|----------------------------------------|---------------------------------------:|
| $a = b$                                | $a = b$                                |

Now that we have been introduced to identity types in @sec:preliminaries_hott_identity, this table does not say anything trivial.
The proof that $a = b$ is an element of the type $a = b$, for any two $a, b : A$.
In fact, without this last translation, we would not be able to do much at all, because a large amount of mathematical statements can be reduced to saying that two things are the same.

As an example, if we have $p : a = b$, and $q : b = c$, then we can construct an element $p \ct q : a = c$.
This matches the idea of transitivity of equality.

This is also the point where homotopy type theory diverges from other (more extensional) type theories.
Intensionality means that the type $a = b$ is not "boolean", i.e. it can have different, non-equal proofs.
As it only seemed to add complexity, this property was traditionally discarded through the introduction of an axiom known as axiom K.
Axiom K essentially imposes what we call **uniqueness of identity proofs**, or in other words, that all path types are mere propositions, either inhabited by a single path or empty.
This kills the higher homotopical structure, rendering the type theory more approachable from a certain computational point of view, but making elements less faithful to the proof they represent.
The recent study of higher path types has shown that preserving them makes for a good grounds for homotopy theory.

## The Seifert-van Kampen Theorem

We have now seen an invariant of topological spaces (the fundamental group), and a way to build a new space out of old ones (the pushout). A natural question emerges: can one compute the fundamental group of a pushout from the fundamental groups of the original spaces?

The answer is yes. The Seifert-van Kampen theorem does precisely this.

Take a path-connected space $X$ together with a base point $x \in X$.
We are given two open, path-connected subsets $Y$ and $Z$ of $X$, whose union is $X$, and whose intersection is path-connected, and contains $x$ as well.
This is a less categorical way of saying that $X$ is the pushout of the inclusions $Y \cap Z \hookrightarrow Y$ and $Y \cap Z \hookrightarrow Z$.

Then, if we regard $\pi_1$ as a functor between the category \PTop{} of pointed topological spaces and the category \Grp{} of groups, the theorem states that it preserves the described pushout.
This means that $\pi_1(X)$ is the pushout of the morphisms $\pi_1(Y) \leftarrow \pi_1(Y \cap Z) \rightarrow \pi(Z)$ induced by the inclusion maps.

In general, we say that $\pi_1$ preserves inclusion pushouts. As \Grp is cocomplete, it contains the desired pushout, and so we can compute the fundamental group of two spaces glued together appropriately.

This theorem can be translated into homotopy type theory. In fact, in this setting the result is slightly more general as it applies to all pushouts, instead of only inclusion pushouts. We will not enter into details of the statement or the proof as they do not contribute meaningful interpretation to us.

<!-- If we disregard the base point, the theorem can be extended to make the same statement for the fundamental *groupoid* $\Pi_1$.

For the homotopy type theory of the theorem, we will see the version with fundamental groupoids, as it is more natural to build.
Another difference is that it generalizes to any pushout, not just inclusion pushouts.
In fact, the complexity of the theorem in this setting lies not in the construction of the topological spaces, as it does in the classical version, but rather in describing the combinatorial nature of groups.
As with the fundamental group of the circle, we do not only try to obtain a representation of the group, but more specifically the set-truncation of a particular path space.
The method used in the proof is also encode-decode.
The objective is to build a type \code and then prove it is equivalent to the fundamental groupoid of the total space.

The fundamental groupoid $\Pi_1 X : X \rightarrow X \rightarrow \universe$ can be built as the $0$-truncation of its path spaces: $\Pi_1 X(x,y) :\equiv \norm{x = y}_0$, with induced path operations (such as concatenation, reversal, etc.) On the other hand, the \code type is defined as a complex higher inductive type that represents the pushout of groupoids. The statement of the theorem is that $\Pi_1 P(x,y) \simeq \code(x,y)$. -->

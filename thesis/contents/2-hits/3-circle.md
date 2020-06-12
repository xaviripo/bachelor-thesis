## The Fundamental Group of the Circle {#sec:circle}

In order to familiarize ourselves with spaces presented as higher inductive types, we analyze a study case: the fundamental group of the circle \sone. In classical topology, the fundamental group is defined as the quotient of the set of loops at the base point by the homotopy equivalence relationship. In homotopy type theory, the quotient is not necessary, as paths that are homotopy equivalent are *propositionally equal*. What we need to do, though, is make sure that the fundamental group is a discrete set, so we have to kill all higher order paths:

\begin{definition}
The \textbf{fundamental group} of a based type $(X,x)$, denoted as $\pi_1(X,x)$, is the $0$-truncation of its loop space at $x$, i.e.:
\[\pi_1(X,x) = \norm{\Omega(X,x)}_0\]
\end{definition}

If we had chosen to present the circle as a pushout, we could apply the Seifert-van Kampen theorem. Indeed, this will be discussed in @sec:pushouts. But right now let us concentrate on the presentation as a higher inductive type. After all, it would not be useful if we were not able to carry out elementary tasks like this one.

We remind some topological definitions which will be relevant in this section.

\begin{definition}
A \textbf{covering space} of a topological space $X$, is a space $C$ (known as the \textbf{total space}) together with a continuous function $p : C \rightarrow X$ (the \textbf{projection}) satisfying the following condition: each point $x$ in $X$ has a neighborhood $U$ such that its preimage $p^{-1}(U)$ is the disjoint union of open sets, each homeomorphic to $U$.
\end{definition}

We say that $U$ is **evenly covered** by $p^{-1}(U)$. We call the preimage of each point in $X$ its **fiber**. We can visualize $C$ as "lying over" $X$, and the fiber of each point lying over it.

The traditional way to approach the problem at hand would be to find the covering space of the circle, and from that see that each fiber is isomorphic to the integers \integers.

A more type theoretic proof jumps straight to the fibers, without the need to build the covering space first. This is due to the way covering spaces are defined in homotopy type theory. In classical topology, the notion of subspace is very important. It is easy to see how this applies to covering spaces, as their definition only already deals with subspaces of $X$ and $C$. Unfortunately, the notion of subspace, just like the notion of subset, does not translate well into homotopy type theory. The good news is that the alternative, which we will now see, is more adequate for synthetic homotopy and constructive mathematics. In general, whenever we find a definition that contains a tuple (for instance, the covering space together with its projection), we have to suspect that translating it literally into type theory will be cumbersome, because in constructive mathematics we have to carry along all the parts of the definition.

Hence, we will define directly for each point its fiber. In the case of the circle, this would be:

\begin{definition}
Define $\code : \sone \rightarrow \universe$ by circle recursion:
\begin{align*}
\code(\sbase) &= \integers\\
\ap_{\code}(\sloop) &= \ua(\natsucc)
\end{align*}
\end{definition}

The fiber at \sbase is \integers by definition. But we need to assign a fiber to all the points in \sone, not just \sbase. Instead of saying what the fiber is for a given point, we say how the path \sloop of \sone should be lifted to a path in \universe (where \integers belongs). \natsucc induces an equivalence between \integers and \integers, which can be converted into a path via the univalence axiom.

The next step consists in introducing two functions, \encode and \decode, which will become the two directions of the equivalences we want to find.

\begin{definition}
\begin{align*}
\encode &: \prod_{x : \sone} (\sbase = x) \rightarrow \code(x)\\
\encode(x,p) &= \transport^{\code}(p,0)
\end{align*}
\end{definition}

This is a natural step in the direction hinted before. Suppose a fixed $x$; we want to assign to each path joining $x$ and \sbase an element of $\code(x)$. \transport takes the path $p : \sbase = x$ to a function $\integers \rightarrow \code(x)$ (which can be thought of as $p$ lifted to the covering space).

We observe that, because \transport is functorial, \encode takes any loop on \sbase to a composition of functions, like so:

\begin{align*}
& \transport^{\code}(\sloop^{\pm1} \ct \sloop^{\pm 1} \ct \sloop^{\pm 1} \ct \cdots, -)\\
=& \transport^{\code}(\sloop^{\pm 1}, -) \circ \transport^{\code}(\sloop^{\pm 1}, -) \circ \transport^{\code}(\sloop^{\pm 1}, -) \circ \cdots\\
=& \natsucc^{\pm 1} \circ \natsucc^{\pm 1} \circ \cdots
\end{align*}

The key idea here is to think of \integers as a pointed type $(\integers, 0)$, and the application of \code to \sloop as the path from $(\integers, n)$ to $(\integers, \natsucc(n))$. Now we can see what the result of \transport above is when applied to $0$: the winding number of the path $p$, i.e., the number of "net" turns it does.

On the other hand, we have the decode function of type $\prod_{x : \sone} \code(x) \rightarrow (\sbase = x)$. The definition in this direction is not so easy: we must use circle induction. This means we have to provide an image for \sbase{} of type $\code(\sbase) \rightarrow (\sbase = \sbase)$ and a path from this function to itself lying over \sloop. For the image of \sbase, we pick the natural choice $n \mapsto \sloop^n$, which takes any integer to a loop with that as its winding number. For the path, as this is a dependent function, we have to prove $\sloop_*(\sloop^-)=\sloop^-$, or, writing the full type of the transport:

\begin{lemma}\label{circle-decode-path-lifting}
There is a path of type $\transport^{y \mapsto \code(y) \rightarrow (\sbase = y)}(\sloop, \sloop^-) = \sloop^-$.
\end{lemma}

\begin{proof}
\[\begin{array}{lllr}
& \transport^{\code(-) \rightarrow (\sbase = -)}(\sloop, \sloop^-)\\
% TODO explain the action of transport on A->B and base=x
&= \transport^{(\sbase = -)}(\sloop, -) \circ \sloop^- \circ \transport^{\code(-)}(\sloop^{-1}, -) && \text{(1)}\\
&= (- \ct \sloop) \circ \sloop^- \circ \transport^{\code(-)}(\sloop^{-1}, -) && \text{(2)}\\
&= (- \ct \sloop) \circ \sloop^- \circ \natsucc^{-1} && \text{(3)}\\
&= n \mapsto \sloop^{\natsucc^{-1}(n)} \ct \sloop && \text{(4)}\\
&= n \mapsto \sloop^{n} && \text{(5)}
\end{array}\]
(1) and (2) are by the action of \transport{} on type families of the form $y \mapsto A(y) \rightarrow B(y)$ and $y \mapsto base = y$, correspondingly.
(3) is due to the functoriality of \transport, and (4) and (5) due to reducing the function composition and then the path concatenation.
\end{proof}

\begin{definition}
Define $\decode : \prod_{x : \sone} \code(x) \rightarrow (\sbase = x)$ by circle recursion. For the image at $\sbase$, pick $\sloop^-$. For the lifting of \sloop, use the path from \autoref{circle-decode-path-lifting}.
\end{definition}

Next, we prove that \code and \decode are inverse functions:

\begin{lemma}\label{circle-inverses}
For each $x : \sone$, $p : \sbase = x$, and $c : \code(x)$, we have:
\[\decode_x(\encode_x(p)) = p\]
\[\encode_x(\decode_x(c)) = c\]
\end{lemma}

\begin{proof}
For the first equality, we apply path induction. So it suffices to prove the case $x = \sbase$, $p = \refl_{\sbase}$.
\[\begin{array}{lllr}
& \decode_{\sbase}(\encode_{\sbase}(\refl_{\sbase}))\\
&= \decode_{\sbase}(\transport^{\code}(\refl_{\sbase}, 0)) && \text{(definition of \encode)}\\
&= \decode_{\sbase}(0) && \text{(\transport{} over \refl{} is trivial)}\\
&= \sloop^0 && \text{(definition of \decode)}\\
&= \refl_{\sbase} && \text{(path composition)}
\end{array}\]

For the second equality, we apply circle induction. Usually, we would have to supply an image for \sbase{} and check that the application respects \sloop. But, in the case of \sbase, the codomain is \integers, which is a set, and sets do not have non-trivial paths. Or, in other words, any loop (including \sloop) will always be lifted to a trivial path. So we only need to check that $\encode_{\sbase}(\decode_{\sbase}(n)) = n$ for all $n : \integers$. We apply integer induction. The case for $n = 0$ is true by definition. The positive and negative cases are analogous to each other, so we do the positive case:
\[\begin{array}{lllr}
& \encode_{\sbase}(\decode_{\sbase}(\natsucc(n)))\\
&= \encode_{\sbase}(\sloop^{\natsucc(n)}) && \text{(definition of \decode)}\\
&= \transport^{\code}(\sloop^{\natsucc(n)}) && \text{(definition of \encode)}\\
&= \transport^{\code}(\sloop^n \ct \sloop, 0) && \text{(composition of paths)}\\
&= (\transport^{\code}(\sloop^n, -) \circ \transport^{\code}(\sloop, -))(0) && \text{(functoriality of \transport)}\\
&= (\natsucc^n \circ \natsucc)(0) && \text{(inductive hypothesis)}\\
&= \natsucc(n) && \text{(application)}
\end{array}\]
\end{proof}

\begin{theorem}\label{circle-equiv}
There is a family of equivalences $\prod_{x : \sone} (\sbase = x) \simeq \code(x)$
\end{theorem}

\begin{proof}
We apply \autoref{circle-inverses} to see that \encode{} and \decode{} act as mutual quasi-inverses.
\end{proof}

\begin{corollary}
\[\pi_1(\sone) = \integers\]
\end{corollary}

\begin{proof}
We use \autoref{circle-equiv} with $x = \sbase$. This gives us an equivalence $(\sbase = \sbase) \simeq \integers$. We apply the univalence axiom to obtain an equality from the equivalence. Applying $0$-truncation to both sides gives us $\norm{\sbase = \sbase}_0 = \norm{\integers}_0$. On the left side, we have the definition of $\pi_1(\sone)$. On the right, because \integers{} is a set, we obtain \integers{} again. So we have $\pi_1(\sone) = \integers$.
\end{proof}

The last step is to prove that the equivalence on \sbase{} takes path composition to addition, in order to see that it is a group homomorphism as well.

\begin{theorem}
$\pi_1(\sone)$ and \integers{} are isomorphic as groups.
\end{theorem}

\begin{proof}
%f (Ac a₁ a₂) == Bc (f a₁) (f a₂)
It is enough to see that, for all $p$, $q$ in $\pi_1(\sone)$, $\encode_{\sbase}(p \ct q) = \encode_{\sbase}(p) + \encode_{\sbase}(q)$.
\[\begin{array}{lllr}
& \encode_{\sbase}(p \ct q)\\
&= \transport^{\code}(p \ct q, 0) && \text{(definition of \encode)}\\
&= (\transport^{\code}(q, -) \circ \transport^{\code}(p, -))(0) && \text{(functoriality of transport)}\\
&= (\natsucc^{\encode_{\sbase}(q)} \circ \natsucc^{\encode_{\sbase}(p)})(0) && \text{(path lifting)}\\
&= \encode_{\sbase}(q) + \encode_{\sbase}(p) && \text{(definition of \natsucc)}\\
\end{array}\]
\end{proof}

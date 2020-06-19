## Construction as a Pushout

The common to attach cells in homotopy type theory is known as the "hub and spokes" technique.
One possible interpretation is:

```\begin{definition}```{=latex}
Suppose a type $X$, and a function $f : \sphere^{n-1} \rightarrow X$ for $n > 0$.
We define the **attachment of an $n$-cell** to $X$ via $f$ as the higher inductive type $\hat{X}$ defined by:

- an inclusion function $i : X \rightarrow \hat{X}$,
- a "hub" point $h : \hat{X}$, and
- a family of "spokes" $s : \prod_{(p : \sphere^{n-1})} f(x) = h$.

```\end{definition}```{=latex}

We visualize the attachment as taking $X$, and gluing an $n$-cell along the image of $f$.

Most often, we do not use this definition but rather apply the concept of attachment *ad hoc*.
For example, this can be done through the pushout:

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(\sphere^{n-1}\)};
\node (Y) at (2,0) {\(X\)};
\node (Z) at (0,-2) {\(\one\)};
\node (P) at (2,-2) {\(P\)};
\draw[->] (X) -- (Y) node[midway,above] {$f$};
\draw[->] (X) -- (Z);
\draw[->] (Y) -- (P) node[midway,right] {$\inr$};
\draw[->] (Z) -- (P) node[midway,below] {$\inl$};
\end{tikzpicture}
\end{center}

which also attaches an $n$-cell via the path family $\glue : \prod_{(p : \sphere^{n-1})} \inr(f(x)) = \inl(\star)$, with $\inl(\star)$ acting as the hub.

We will now see how to build the projective spaces in homotopy type theory.
Using pushouts, we can build $\RP^{n+1}$ from $\RP^n$ as such:

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(\sphere^n\)};
\node (Y) at (2,0) {\(\one\)};
\node (Z) at (0,-2) {\(\RP^n\)};
\node (P) at (2,-2) {\(\RP^{n+1}\)};
\draw[->] (X) -- (Y);
\draw[->] (X) -- (Z) node[midway,left] {$\alpha_n$};
\draw[->] (Y) -- (P);
\draw[->] (Z) -- (P);
\end{tikzpicture}
\end{center}

This amounts to attaching an $n+1$ cell to $\RP^n$, as we said before.
The function $\alpha_n$, which defines *how* to attach the cell, is not as easy to define, though.

Instead of forcing this definition, we can take a closer look at that $\sphere^n$ in the pushout diagram.
We have just seen that the sphere is a covering space of $\RP^n$.
This suggests rewriting the diagram as:

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(\sum_{(x : \RP^n)} \cov^n(x)\)};
\node (Y) at (3,0) {\(\one\)};
\node (Z) at (0,-2) {\(\RP^n\)};
\node (P) at (3,-2) {\(\RP^{n+1}\)};
\draw[->] (X) -- (Y);
\draw[->] (X) -- (Z);
\draw[->] (Y) -- (P);
\draw[->] (Z) -- (P);
\end{tikzpicture}
\end{center}

where $\cov^n(x)$ is the fiber of $x : \RP^n$.
Now, instead of defining the covering space and deducing the shape of the fibers from that, we do it the other way around: we have to define $\RP^n$ and $\cov^n$ inductively on $n$, and from that prove that the total space $\sum_{(x : \RP^n)} \cov^n(x)$ is indeed equivalent to $\sphere^n$ in order to convince ourselves that this is indeed the projective spaces that we are building.

For each $n \geq -1$, we define both $\RP^n$ and $\cov^n$ inductively.
As the fiber of a covering space, we would usually define \cov to be fo type $\cov^n : \RP^n \rightarrow \universe$.
In this case, though, we need a little bit more precision, and so we first define the "subuniverse" $\universe_{\szero}$ of $2$-element sets, so that we can have $\cov^n : \RP^n \rightarrow \universe_{\szero}$.
As there are no subtypes in homotopy type theory, this is actually a fibration itself:

\begin{definition}
The \textbf{universe of $2$-sets} $\universe_{\szero}$ consists of types together with a proof that they are equal to $\szero$, i.e. $\sum_{(A : \universe)} \norm{A = \szero}_{-1}$.
\end{definition}
Luckily, the fibers are mere propositions, so we can omit them for brevity without changing the constructions, and treat $\universe_{\szero}$ like a universe of types.
Similarly, we consider \szero to be a pointed type, with center $\north$, but we will not write it explicitly throughout the text.

Consider the map $\encode : \prod_{(A : \universe_{\szero})} (\szero = A) \rightarrow A$ given by taking the center of \szero to the element that the chosen equality transports it to.
In other words, $\encode(A,p) = \idtoeqv(p)(\north)$, where \idtoeqv is the equivalence induced by the equality of types.

\begin{lemma}
\encode{} is an equivalence.
\end{lemma}

This \encode, like the others we have seen, tries to give a combinatorial interpretation of an equality type, in this case $\szero = A$.
To correctly interpret this function, we disregard the first argument ($A : \universe_{\szero}$), as it is only necessary in order to introduce the path $p$.
Then we see the actual meaning of the lemma: every element of a $2$-set $A$ corresponds uniquely with an equality between $A$ and the canonical pointed $2$-set \szero.
After all, there are only two ways to identify \szero{} with $A$.
This identification is uniquely determinated by the image of \north{} through the path.

The proof of the lemma is given in [@buchholtz_real_2017, Corollary II.6].
It is slightly technical and requires introducing results about pointed types that are out of scope, so we skip directly to building $\RP^n$ and $\cov^n$:

- For the base case ($n = -1$), we take $\RP^{-1} :\equiv \zero$, the empty type.
Then, there is only one candidate for $\cov^{-1}$, which is the only function of type $\zero \rightarrow \universe_{\szero}$.

- For the inductive case, assume $\RP^n$ and $\cov^n$ are defined. $\RP^{n+1}$ is defined as the pushout:

  \begin{center}
  \begin{tikzpicture}
  \node (X) at (0,0) {\(\sum_{(x : \RP^n)} \cov^n(x)\)};
  \node (Y) at (3,0) {\(\one\)};
  \node (Z) at (0,-2) {\(\RP^n\)};
  \node (P) at (3,-2) {\(\RP^{n+1}\)};
  \draw[->] (X) -- (Y);
  \draw[->] (X) -- (Z) node[midway,left] {$\pr_1$};
  \draw[->] (Y) -- (P);
  \draw[->] (Z) -- (P);
  \end{tikzpicture}
  \end{center}

  To define $\cov^{n+1} : \RP^{n+1} \rightarrow \universe_{\szero}$, consider the following diagram:

  \begin{center}
  \begin{tikzpicture}
  \node (X) at (0,0) {\(\sum_{(x : \RP^n)} \cov^n(x)\)};
  \node (Y) at (3,0) {\(\one\)};
  \node (Z) at (0,-2) {\(\RP^n\)};
  \node (P) at (3,-2) {\(\universe_{\szero}\)};
  \draw[->] (X) -- (Y);
  \draw[->] (X) -- (Z) node[midway,left] {$\pr_1$};
  \draw[->] (Y) -- (P) node[midway,right] {$\szero$};
  \draw[->] (Z) -- (P) node[midway,below] {$\cov^n$};
  \end{tikzpicture}
  \end{center}

  Where \szero represents the function taking $\star$ to \szero. If we can prove that the square commutes, then, by the universal property of the pushout, there has to exist an equivalence between $\RP^{n+1}$ and $\universe_{\szero}$, which we will take to be $\cov^{n+1}$.

  For every $x : \RP^n$, we have the equivalence $\encode(\cov^n(x)) : (\szero = \cov^n(x)) \simeq \cov^n(x)$ given by the lemma.
  Theorem 4.7.7 of @univalent_foundations_program_homotopy_2013 induces an equivalence

  $$\sum_{x : \RP^n} \cov^n(x) \simeq \sum_{x : \RP^n} (\szero = \cov^n(x))$$

  So we have the following diagram:

  TODO Finish the construction of RP^n

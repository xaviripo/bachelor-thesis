## Covering Spaces

We remind some topological definitions which will be relevant in this chapter.

\begin{definition}
A \textbf{covering space} of a topological space $X$ is a space $C$ (known as the \textbf{total space}) together with a continuous function $p : C \rightarrow X$ (the \textbf{projection}) satisfying the following condition: each point $x$ in $X$ has a neighborhood $U$ such that its preimage $p^{-1}(U)$ is the disjoint union of open sets, each homeomorphic to $U$.
\end{definition}

We say that $U$ is **evenly covered** by $p^{-1}(U)$. We call the preimage of each point in $X$ its **fiber**. We can visualize $C$ as "lying over" $X$, and the fiber of each point lying over it.

A very important property of covering spaces is that of path lifting.

```\begin{theorem}```{=latex}
Given a path $f : [0,1] \rightarrow X$ starting at $x \in X$, for each $\tilde{x} \in p^{-1}(x)$ there is a unique path $\tilde{f} : [0,1] \rightarrow C$ starting at $\tilde{x}$ and projecting onto $f$.
We call $\tilde{f}$ a **lift** of $f$.
```\end{theorem}```{=latex}

We can also uniquely lift homotopies.

```\begin{theorem}```{=latex}
Given a homotopy $h : [0,1] \times [0,1] \rightarrow X$ starting at $x \in X$, for each $\tilde{x} \in p^{-1}(x)$ there is a unique homotopy $\tilde{h} : [0,1] \times [0,1] \rightarrow C$ starting at $\tilde{x}$ and projecting onto $h$.
We call $\tilde{h}$ a **lift** of $h$.
```\end{theorem}```{=latex}

A proof of both theorems is given in @hatcher_algebraic_2000, Section 1.1.

In a covering space, the base $X$ parametrizes the total space: each point $x$ of $X$ "represents" its fiber.
Each fiber is discrete, but the elevation of the topological structure of $X$ bundles all the fibers, bringing a non-trivial topological structure to $C$.
In homotopy type theory, we take the idea of parametrizing the fibers via the base space to be the very definition.

```\begin{definition}```{=latex}
A **covering** of a type $X$ is a type family $P : X \rightarrow \universe$ such that $P(x)$ is a set for each $x : X$.
We call $P(x)$ the **fiber** of $x$, and $\sum_{(x : X)} P(x)$ the **total space**.
```\end{definition}```{=latex}

The fiber of each $x : X$ is now its image $P(x)$, which is a type.
This allows us to assign entire "subspaces" to every point in the base space, in the same way as $p^{-1}$ would do in the classical definition.
The sum type $\sum_{(x : X)} C(x)$ not only joins all the fibers, but also gives them the appropriate homotopical structure of the analogous classical construction.

Just as with the classical version, homotopy type theory coverings have a unique path lifting property.

```\begin{theorem}```{=latex}
Given a path $p : x = y$ of $X$, for each $\tilde{x} : P(x)$ there is a unique path $\lift(\tilde{x},p) : (x,\tilde{x}) = (y,p_*(\tilde{x}))$ in the type $\sum_{(x : A)} P(x)$.
```\end{theorem}```{=latex}

```\begin{proof}```{=latex}
We apply path induction.
It suffices to assume $y :\equiv x$ and $p :\equiv \refl_x$.
Hence, we want to build a witness $\lift(\tilde{x},\refl_x)$ of $(x,\tilde{x}) = (x,{(\refl_x)}_*(\tilde{x}))$.
By definition of the transport operation $(-)_*$, $(\refl_x)_*$ equals $\id_{P(x)}$.
So it is enough to take $\refl_{(x,\tilde{x})}$ as $\lift(\tilde{x},\refl_x)$.
```\end{proof}```{=latex}

In the following section we will gain a deeper understanding on how to deal with coverings in homotopy type theory.

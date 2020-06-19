## Truncation {#sec:circle_truncation}

Intuitively, a type $A : \universe$ is called an $n$-type (or just $n$-truncated) when all its identity spaces of order greater than $n$ are trivial.
A few key examples:

- $A : \mathcal{U}$ is a $(-2)$-type, or **contractible**, when there is a point all other points are equal to, i.e., $\sum_{(a : A)} \prod_{(x : A)}a = x$ ("there exists an $a$ such that for every $x$, $a = x$").

- $A : \mathcal{U}$ is a $(-1)$-type when all of its points are trivial, i.e., $\prod_{(x,y : A)}x = y$ ("for all $x$ and $y$ of type $A$, there is a proof that $x$ is equal to $y$").
This kind of types are also called **(mere) propositions**, because they contain no other information than "true" (they are inhabited) or "false" (they are not inhabited).

- $A : \mathcal{U}$ is a $0$-type when all of its identity types are trivial.
So, given any $x,y : A$ that are equal, then the type $x = y$ has a single element, i.e., it is a $(-1)$-type.
This can be read as saying that "there is only one way in which $x$ and $y$ are equal to each other".
A $0$-type is also called a **set**, because it is a type that has no further homotopical information about its elements other than whether they are equal or not.
This point of view agrees with looking at their identity types as mere propositions: two elements in a set are either equal or different, nothing else can be said about their equality status.

In view of this, we can define the notion of $n$-type inductively.

\begin{definition}
A type $A : \universe$ is called a \textbf{$-2$-type} if it is contractible, this is, if there exists a term $a : A$ such that $\prod_{(x : A)}a = x$.
A type $A : \universe$ is called a \textbf{$(n+1)$-type} if, for every $x$ and $y$ in $A$, $x = y$ is an $n$-type.
\end{definition}

Some remarks to help gain intuition on $n$-types.

To begin with, a type is contractible exactly when it is an inhabited proposition.
So, the only way for a type $A$ to be a proposition but not contractible, is to be an empty type.
The notion of contractibility exists in order to be able to make recursive definitions on $n$-types more easily.

Another useful fact is that truncatedness is cumulative:

<!-- HoTT Theorem 7.1.7. -->

\begin{theorem}
If $A : \universe$ is an $n$-type for any $n \geq -2$, then it is also an $(n+1)$-type as well.
\end{theorem}

\begin{proof}
By induction on $n$.
\begin{itemize}
  \item For the base case $n = -2$, it is enough to see that, for any $x$ and $y$, $x = y$ is contractible.
  As $A$ is contractible itself, there exist an element $a : A$ and a function $\contr : \prod_{(x : A)} a = x$.
  Then, there is a path $\contr(x)^{-1} \ct \contr(y) : x = y$.
  It is enough to show that, for any path $p : x = y$, $\contr(x)^{-1} \ct \contr(y) = p$.
  We will apply path induction: we just have to show this works for the case $x \equiv y$, $p \equiv \refl_x$, which is just proving that $\refl_x = \contr(x)^{-1} \ct \contr(x)$. This is true as any path composed with itself reversed is homotopic to the constant path.
  \item For the inductive case, we suppose that any $m$-type for $m \leq n$ is an $(m+1)$-type, and prove that the $(n+1)$-type $A$ is also an $(n+2)$-type.
  This amounts to showing that, for any $x$ and $y$ in $A$, $x = y$ is an $(n+1)$-type.
  But this follows form the inductive hypothesis.
\end{itemize}
\end{proof}

The idea of contractibility in homotopy type theory tries to represent the homonymous property in topology.
Nonetheless, one might look at the definition and wonder whether, for example, the circle \sone{} is contractible or not.
The answer, just as in classical topology, is no.
But why not?
After all, we only have to provide a center of contraction (for example, \sbase), and a function $\prod_{(x : \sone)} \sbase = x$.
Every point in \sone{} is path connected to \sbase{} by a piece of \sloop{}, so what is stopping us from building such a function?

The reason is continuity.
All functions in homotopy type theory are naturally continuous, as they have to respect paths.
This means that the function \contr{} not only assigns a path from \sbase{} to $x$ for every $x : \sone$, but does so in a *continuous* way.
Pick any valid path for the case $x \equiv \sbase$.
Then, as we travel along \sloop{}, the path to \sbase{} changes as well, until we reach \sbase{} again.
Now, the image of the function \contr{} at \sbase{} should be the same as before, with a \sloop{} appended, as we have made one turn around the circle.
But this amounts to saying that $\refl_{\sbase} = \sloop$, which would imply the existence of a two-dimensional cell in the circle that just does not exist.
In fact, the circle is not even a mere proposition, nor a set!
We will see a formal proof of this in @sec:circle_fundamental-group.

Given any type $A$, we can introduce its **$n$-truncation** $\norm{A}_n$ as the "$n$-type that best approximates $A$".

TODO Give definition for n-truncation via HITs

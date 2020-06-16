## Classical Construction {#sec:rp2_construction-classical}

For the final part of this thesis, we will take a closer look at an interesting family of types and how they are built in homotopy type theory: the real projective spaces.

In classical topology, the **real projective space of dimension $n$** ($\RP^n$) is the topological space $\sphere^n/R$, where $R$ is the relationship between each point and its antipode. We can also describe the real projective spaces as CW complexes by using the following facts:

- The sphere $\sphere^n$ has a CW complex structure with two $0$-cells, two $1$-cells, two $2$-cells, etc. up to two $n$-cells.
- The quotient space by the relationship $R$ glues each two $i$-cells through antipodal points ("flipping" one of the $i$-cells).

It can be shown that $\RP^n$ is then a CW complex with one cell for each dimension from $0$ up to $n$.
It is important to notice that there is more than one CW complex with these cells.
For example, if one were to try and build a CW complex with one $0$-cell, one $1$-cell, and one $2$-cell, it would most probably *not* end up being the real projective plane ${\mathbb R\mathrm P}^2$.
To get the projective plane, one has to mind using the $2$-cell to glue the $1$-cell to itself *reversed*.
Otherwise, we obtain the common sphere ${\mathbb S}^2$ with its two poles identified.

The projective spaces owe big part of their homotopic structure to the spheres they come from: $\RP^0$ is a single-pointed space, $\RP^1$ is homeomorphic to $\sone$.
For the rest, they all share their higher homotopy groups with the sphere: $\pi_k(\RP^n) \cong \pi_k(\sphere^n)$ for all $k > 1$.

But what about the fundamental group?
Calculating the fundamental group of projective spaces is very educational, because it helps us conceptualize the relationship between them and the spheres in a more visual way.

Take any projective space $RP^n$ as $\sphere^n/R$, with $R$ as above.
Consider then the covering space $p : \sphere^n \rightarrow \RP^n$ given by the projection of the equivalence relationship $R$.
Each fiber has exactly two elements: the two antipodal points that have been identified.
Covering spaces have a unique path lifting property, which states that, given a point $x \in \RP^n$ and an element $\tilde{x}$ of its fiber $p^{-1}(x)$, then any path starting at $x$ "lifts" to a unique path in the covering space starting at $\tilde{x}$.
In our case, if we take any loop $\gamma : [0,1] \rightarrow \RP^n$, $\gamma(0) = \gamma(1) = x$, we can lift it to a path in $\sphere^n$.
As the fibers have two elements, we say that the covering space has two "sheets".
So, depending on our choice of $\gamma$, it can be lifted in two different ways: taking both endpoints of the lifted path to be the same (e.g. $\tilde{x}$), or taking each endpoint to be the antipodal of the other (e.g. $\tilde{x}$ and $-\tilde{x}$).

For the first, we obtain a loop in the sphere.
As $\sphere^n$ has a trivial fundamental group for $n > 1$, that loop is homotopic to the constant path on $\tilde{x}$.
This homotopy on the covering space induces a homotopy on the base space taking $\gamma$ to the constant path on $x$.
So the loop is then trivial.

For the second, we see that the lifted path is not a loop, so it can not be contracted to a constant path without moving its endpoints, which we can not do as that would change the endpoints of the underlying loop $\gamma$.
So, we have a non-trivial loop $\gamma$ on $\RP^n$.
What can be said of such loop?
It seems to be the only generator of the fundamental group of $\RP^n$, so the only thing left to do is check what order it has.
Hence, we want to see what $\gamma \ct \gamma$ is.
As we have done before, we can lift the path to $\sphere^n$.
The first $\gamma$ is as before, a path from $\tilde{x}$ to $-\tilde{x}$.
In order for $\gamma \ct \gamma$ to be a valid loop, the second $\gamma$ has to be lifted to a path from $-\tilde{x}$ to $\tilde{x}$, otherwise the endpoints do not match.
But then, we obtain a loop on $\tilde{x}$, which makes $\gamma \ct \gamma$ homotopic to the constant path on $x$.

So, we have seen that the loops on $x$ are of two kinds: those homotopic to the constant path, and those which are not.
But those of the second kind, when repeated, are homotopic to the constant path.
Therefore, the fundamental group of $\RP^n$ is isomorphic to $\integers/2\integers$.

Why does this not work for $\RP^1$?
Because, for $n > 1$, $\sphere^n$ is simply connected, but $\sphere^1$ is not.

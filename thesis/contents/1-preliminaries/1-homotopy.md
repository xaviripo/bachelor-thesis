## Homotopy Theory

In a topological space $X$, a **path** from $x \in X$ to $y \in X$ is defined as a continuous map $f : [0,1] \rightarrow X$ such that $f(0) = x$ and $f(1) = y$.
Often, we want to consider the composition of paths $f$ (connecting $x$ to $y$) and $g$ (connecting $y$ to $z$).
This would be a path that walks over $f$ in $[0,\frac{1}{2}]$ and walks over $g$ in $[\frac{1}{2},1]$, denoted by $f \ct g$.
Then, we'd expect to be able to define extended compositions like $f \ct g \ct h \ct \cdots$.
Unfortunately, path composition is not associative due to parametrization issues.

A way to allow associativity is by weakening our notion of path equality.
For this we introduce the following notion.
Suppose two paths $f_0$ and $f_1$ with the same endpoints.
A **homotopy** between $f_0$ and $f_1$ is a function $H : [0,1] \times [0,1] \rightarrow X$ such that $H(0,t) = x$, $H(1,t) = y$, $H(t,0) = f_0(t)$, $H(t,1) = f_1(t)$ for any $t \in [0,1]$.
We say that $f_0$ and $f_1$ are **homotopic** (or equal up to a homotopy, or that they have the same homotopy class), if there exists a homotopy $H$ between them, and we write $H : f_0 \Rightarrow f_1$.
Now, it is true that, given composable paths $f$, $g$, and $h$, there exists a homotopy $(f \ct g) \ct h \Rightarrow f \ct (g \ct h)$.

A homotopy $H : f \Rightarrow g$ can be seen as a "path" between $f$ and $g$.
In fact, $H$ is nothing else than a path between $f$ and $g$ in the space of paths from $x$ to $y$ equipped with the compact-open topology.
This gives us an insight of what higher homotopies are: paths in higher path spaces.
Alternatively, an $n$-path can be regarded as a map $[0,1]^n \rightarrow X$ which agrees with the homotopies "below" itself in some manner.

A third way of visualizing higher path spaces is categorically.
We start by thinking of all points in $X$ as objects in a category, and all of the paths as morphisms.
This is not a category, as path composition is only associative up to homotopy.
If we instead take homotopy classes as morphisms, then composition is indeed associative.
Not only that, but all paths can be reversed, in such a way that they are invertible up to homotopy.
When all morphisms are invertible (such as in this case), the category is known as a groupoid.
But, if we take homotopy classes, we are losing important topological information.
To preserve the higher homotopical structure, we need higher morphisms.
We can build a new category from each pair of objects, consisting of all the paths between them, and whose morphisms are the homotopies between such paths.
If we repeat this at higher levels indefinitely, we obtain a "castle" of groupoids, which is called an $\infty$-groupoid.

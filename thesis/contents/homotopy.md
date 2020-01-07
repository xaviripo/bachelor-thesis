# Homotopies

In this chapter a very brief introduction to homotopy theory will be given. Basic definitions and results of topology are assumed.


## Points, paths, and homotopies

In a topological space $X$, we can define a path from $x \in X$ to $y \in X$ as a function $f : [0,1] \rightarrow X$ such that $f(0) = x$ and $f(1) = y$, if they are path-connected. Given two paths $f, g$ from $x$ to $y$, we say they are homotopically equivalent if there exists a function $H : [0,1] \times [0,1] \rightarrow X$ such that $H(0,t) = x$, $H(1,t) = y$, $H(t,0) = f(t)$, $H(t,1) = g(t)$ for any $t \in [0,1]$. We write $H : f \Rightarrow g$. Such a homotopy can be seen as a "higher path" between $f$ and $g$. In fact, a homotopy $H : f \Rightarrow g$ is nothing else than a path between $f$ and $g$ in the space of paths from $x$ to $y$ equipped with the compact-open topology. This gives us an insight of what higher homotopies are: paths in higher path spaces. Alternatively, an $n$-path can be regarded as a function $[0,1]^n \rightarrow X$ which agrees with the homotopies "below" itself in some manner.

A third way of visualizing higher path spaces is categorically. We can think of all points in $X$ as objects in a category, and all of the paths as morphisms. When all morphisms are invertible (such as in this case, given all paths are invertible), the category is known as a groupoid. To preserve the higher homotopical structure, we need higher morphisms. We can build a new category from each pair of objects, consisting of all the paths between them, and whose morphisms are the homotopies between such paths, and so on. This "castle" of groupoids is called an $\infty$-groupoid.
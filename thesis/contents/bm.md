# The Blakers-Massey Connectivity Theorem

In this chapter we finally present the Blakers-Massey theorem and unroll the proof from the paper.


## Connectivity and truncatedness

Two central notions to Blakers-Massey are those of truncatedness and connectivity of a type, which are dual to each other and related to the triviality of its identity types.

A type $A : \mathcal{U}$ is called an $n$-type (or said to be $n$-truncated) when all its higher identity types of order greater than $n$ are trivial. Let's illustrate this further with some cases for small $n$.

$A : \mathcal{U}$ is a $(-1)$-type when all of its points are trivial, i.e., $\prod_{(x,y : A)}x = y$ ("for all $x$ and $y$ of type $A$, there is a proof that $x$ is equal to $y$"). This kind of types are also called (mere) propositions, because they contain no other information than "true" (they are inhabited) or "false" (they are not inhabited).

$A : \mathcal{U}$ is a $0$-type when all of its identity types are trivial. So, given any $x,y : A$ that are equal, then the type $x = y$ has a single element, i.e., it's a $(-1)$-type. This can be read as saying that "there is only one way in which $x$ and $y$ are equal to each other". A $0$-type is also called a set, because it's a type that has no further homotopical information about its elements other than whether they are equal or not. This point of view agrees with looking at their identity types as mere propositions: two elements in a set are either equal or different, nothing else can be said about their equality status.

$A : \mathcal{U}$ is a $1$-type when all the second-level identity types are trivial. This means that, for any two $x,y : A$ which are equal, and any two $p,q : x = y$ which are also equal, then the type $p = q$ (the type of homotopies from $p$ to $q$) has a single element.

In view of this, we can define the notion of $n$-type inductively. For the base case we pick $n = -2$; $A$ is said to be a $(-2)$-type if it's contractible, this is, if there exists a term $a : A$ such that $\prod_{(x : A)}a = x$. In the general case, a type $A$ is an $(n+1)$-type if, for every $x$ and $y$ in $A$, $x = y$ is an $n$-type. It can be proved that an $n$-type is also an $(n+1)$-type, so every mere proposition is also a set, for example.


## Statement

TODO


## The encode-decode method

TODO
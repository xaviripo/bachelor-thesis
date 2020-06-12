## Concept

An inductive type, in its purest form, is given by introducing a series of *constructors*. The idea is that an inductive type is "freely generated" by its constructors. The simplest inductive type has no constructors:
$$\zero : \universe$$

This is known as the **empty type**.

The type with a single constructor is known as the **unit type**:
\begin{align*}
\one &: \universe\\
\star &: \one
\end{align*}

Finally, we define the **type of booleans**:
\begin{align*}
\two &: \universe\\
\zerotwo, \onetwo &: \two
\end{align*}

Inductive types accept other kinds of constructors, not just elements. For example, the **naturals** can be defined as such:
\begin{align*}
0 &: \naturals\\
\natsucc &: \naturals \rightarrow \naturals
\end{align*}

What this is telling us is that every element of the type $\naturals$ can be built as either $0$, or as $\natsucc$ applied to another element of $\naturals$. Thus, the possible naturals are $0$, $\natsucc(0)$, $\natsucc(\natsucc(0))$, etc.

Inductive types are an idea that already appears in older type theories. Homotopy type theory presents a whole new class of inductive types, known as **higher inductive types**. These allow constructors whose codomain is not only the type being described, but also path types on that.

The most iconic example is the **circle**, $\sone$, which is made up by a single point and a loop from the point to itself.
\begin{align*}
\sbase &: \sone\\
\sloop &: \sbase = \sbase
\end{align*}

Or, taking higher paths, we can build higher dimensional spheres:
\begin{align*}
\sbase &: \stwo\\
\ssurf &: \refl_{\sbase} = \refl_{\sbase}
\end{align*}

As seen, one of the key ideas of higher inductive types is that (higher) paths can (sometimes) take the role of cells in CW complexes.

TODO talk about the standard way of forming recursion/induction principles for HITs

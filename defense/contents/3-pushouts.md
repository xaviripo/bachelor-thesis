# *Pushouts*

## *Pushouts* categòrics

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(X\)};
\node (Y) at (2,0) {\(Y\)};
\node (Z) at (0,-2) {\(Z\)};
\node[white] (P) at (2,-2) {\(P\)};
\draw[->] (X) -- (Y) node[midway,above] {$f$};
\draw[->] (X) -- (Z) node[midway,left] {$g$};
\draw[->,white] (Y) -- (P) node[midway,right] {$i$};
\draw[->,white] (Z) -- (P) node[midway,below] {$j$};
\end{tikzpicture}
\end{center}


## *Pushouts* categòrics

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(X\)};
\node (Y) at (2,0) {\(Y\)};
\node (Z) at (0,-2) {\(Z\)};
\node[blue] (P) at (2,-2) {\(P\)};
\draw[->] (X) -- (Y) node[midway,above] {$f$};
\draw[->] (X) -- (Z) node[midway,left] {$g$};
\draw[->,blue] (Y) -- (P) node[midway,right] {$i$};
\draw[->,blue] (Z) -- (P) node[midway,below] {$j$};
\end{tikzpicture}
\end{center}


## *Pushouts* categòrics

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(X\)};
\node (Y) at (2,0) {\(Y\)};
\node (Z) at (0,-2) {\(Z\)};
\node (P) at (2,-2) {\(P\)};
\node[blue] (P') at (4,-4) {\(P'\)};
\draw[->] (X) -- (Y) node[midway,above] {$f$};
\draw[->] (X) -- (Z) node[midway,left] {$g$};
\draw[->] (Y) -- (P) node[midway,right] {$i$};
\draw[->] (Z) -- (P) node[midway,below] {$j$};
\path[->,blue] (Y) edge[bend left] node[above=5mm]{$i'$} (P');
\path[->,blue] (Z) edge[bend right] node[left=5mm]{$j'$} (P');
\draw[->,blue] (P) -- (P') node[midway,above] {$s$};
\end{tikzpicture}
\end{center}


## *Pushouts* topològics

$$(Y \sqcup Z)/\sim, \mathrm{\quad on\quad} \iota_Y(f(x)) \sim \iota_Z(g(x)) \,\forall x \in X$$

```\begin{center}```{=beamer}

![](out/images/disk-pushout.png){ width=180px }
![](out/images/point-pushout.png){ width=180px }

```\end{center}```{=beamer}


## *Pushouts* homotòpics

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(X\)};
\node (Y) at (2,0) {\(M_f\)};
\node (Z) at (0,-2) {\(M_g\)};
\node (P) at (2,-2) {\(P\)};
\draw[right hook->] (X) -- (Y) node[midway,above] {$\tilde{f}$};
\draw[right hook->] (X) -- (Z) node[midway,left] {$\tilde{g}$};
\draw[->] (Y) -- (P) node[midway,right] {$i$};
\draw[->] (Z) -- (P) node[midway,below] {$j$};
\end{tikzpicture}
\end{center}

```\begin{center}```{=beamer}

![](out/images/disk-pushout-homotopy.png){ width=180px }
![](out/images/point-pushout-homotopy.png){ width=180px }

```\end{center}```{=beamer}


## *Pushouts* homotòpics

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(X\)};
\node (Y) at (2,0) {\(M_f\)};
\node (Z) at (0,-2) {\(M_g\)};
\node (P) at (2,-2) {\(P\)};
\node (P') at (4,-4) {\(P'\)};
\draw[right hook->] (X) -- (Y) node[midway,above]{$\tilde{f}$};
\draw[right hook->] (X) -- (Z) node[midway,left]{$\tilde{g}$};
\draw[->] (Y) -- (P) node[midway,right]{$i$};
\draw[->] (Z) -- (P) node[midway,below]{$j$};
\path[->] (Y) edge[bend left] node[above=5mm]{$i'$} (P');
\path[->] (Z) edge[bend right] node[left=5mm]{$j'$} (P');
\draw[->] (P) -- (P') node[midway,above] {$s$};
\end{tikzpicture}
\end{center}


## El *pushout* com a tipus

\begin{prooftree}
\AxiomC{$f : X \rightarrow Y$}
\AxiomC{$g : X \rightarrow Z$}
\BinaryInfC{$Y +_X Z : \universe$}
\end{prooftree}


$$Y +_X Z\quad
\left\{\begin{aligned}
\inr &: Y \rightarrow Y +_X Z\\
\inl &: Z \rightarrow Y +_X Z\\
\glue &: \prod_{x : X} \inr(f(x)) = \inl(g(x))
\end{aligned}\right.
$$


## El *pushout* com a tipus

![](out/images/pushout-type.pdf)


## El *pushout* com a tipus

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(X\)};
\node (Y) at (2,0) {\(Y\)};
\node (Z) at (0,-2) {\(Z\)};
\node (P) at (2,-2) {\(Y +_X Z\)};
\node (P') at (4,-4) {\(P'\)};
\draw[->] (X) -- (Y) node[midway,above]{$f$};
\draw[->] (X) -- (Z) node[midway,left]{$g$};
\draw[->,double] (Y) -- (Z) node[midway,above=2mm]{$\glue$};
\draw[->] (Y) -- (P) node[midway,right]{$\inr$};
\draw[->] (Z) -- (P) node[midway,below]{$\inl$};
\path[->] (Y) edge[bend left] node[above=5mm]{$i'$} (P');
\path[->] (Z) edge[bend right] node[left=5mm]{$j'$} (P');
\draw[->] (P) -- (P') node[midway,above] {$s$};
\end{tikzpicture}
\end{center}


## Adjunció de cel·les

\begin{center}
\begin{tikzpicture}
\node (X) at (0,0) {\(\sphere^{n-1}\)};
\node (Y) at (2,0) {\(\one\)};
\node (Z) at (0,-2) {\(X\)};
\node (P) at (2,-2) {\(P\)};
\draw[->] (X) -- (Y);
\draw[->] (X) -- (Z) node[midway,left] {$f$};
\draw[->] (Y) -- (P) node[midway,right] {$\inr$};
\draw[->] (Z) -- (P) node[midway,below] {$\inl$};
\end{tikzpicture}
\end{center}


## Adjunció de cel·les

![](out/images/glue-before.pdf){ width=200px }
![](out/images/glue-after.pdf){ width=200px }

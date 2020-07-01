# Introducció

## Teoria d'homotopies

 <!-- # Math -->


<!-- ## General HoTT -->

<!-- Basic functions -->
\newcommand{\ap}{\ensuremath{\mathsf{ap}}}
\newcommand{\idtoeqv}{\ensuremath{\mathsf{idtoeqv}}}
\newcommand{\ua}{\ensuremath{\mathsf{ua}}}
\newcommand{\transport}{\ensuremath{\mathsf{transport}}}
\newcommand{\id}{\ensuremath{\mathsf{id}}}
\newcommand{\lift}{\ensuremath{\mathsf{lift}}}

<!-- Path concatenation, taken from HoTT -->
\newcommand{\ct}{%
  \mathchoice{\mathbin{\raisebox{0.5ex}{$\displaystyle\centerdot$}}}%
             {\mathbin{\raisebox{0.5ex}{$\centerdot$}}}%
             {\mathbin{\raisebox{0.25ex}{$\scriptstyle\,\centerdot\,$}}}%
             {\mathbin{\raisebox{0.1ex}{$\scriptscriptstyle\,\centerdot\,$}}}
}

<!-- The fiber function -->
\newcommand{\fib}{\ensuremath{\mathsf{fib}}}

<!-- cov -->
\newcommand{\cov}{\ensuremath{\mathsf{cov}}}

<!-- projection function -->
\newcommand{\pr}{\ensuremath{\mathsf{pr}}}

<!-- code, encode and decode -->
\newcommand{\code}{\ensuremath{\mathsf{code}}}
\newcommand{\encode}{\ensuremath{\mathsf{encode}}}
\newcommand{\decode}{\ensuremath{\mathsf{decode}}}


<!-- ## Types -->

<!-- Universe -->
\newcommand{\universe}{\ensuremath{\mathcal{U}}}

<!-- Empty type -->
\newcommand{\zero}{\ensuremath{\mathbf{0}}}

<!-- Unit type -->
\newcommand{\one}{\ensuremath{\mathbf{1}}}
<!-- Its element is \star -->

<!-- Bool type and its elements -->
\newcommand{\two}{\ensuremath{\mathbf{2}}}
\newcommand{\zerotwo}{\ensuremath{0\sb{\two}}}
\newcommand{\onetwo}{\ensuremath{1\sb{\two}}}

<!-- Naturals -->
\newcommand{\naturals}{\ensuremath{\mathbb{N}}}
\newcommand{\natsucc}{\ensuremath{\mathsf{succ}}}

<!-- S 0 -->
\newcommand{\szero}{\ensuremath{\mathbb{S}^{0}}}
\newcommand{\north}{\ensuremath{\mathsf{N}}}
\newcommand{\south}{\ensuremath{\mathsf{S}}}


<!-- Circle -->
\newcommand{\sone}{\ensuremath{\mathbb{S}^{1}}}
\newcommand{\sbase}{\ensuremath{\mathsf{base}}}
\newcommand{\sloop}{\ensuremath{\mathsf{loop}}}

<!-- Sphere -->
\newcommand{\stwo}{\ensuremath{\mathbb{S}^{2}}}
\newcommand{\ssurf}{\ensuremath{\mathsf{surf}}}

<!-- General sphere -->
\newcommand{\sphere}{\ensuremath{\mathbb{S}}}


<!-- ## Path types -->

<!-- refl -->
\newcommand{\refl}{\ensuremath{\mathsf{refl}}}


<!-- ## Algebra -->

<!-- Integers -->
\newcommand{\integers}{\ensuremath{\mathbb{Z}}}


<!-- ## Truncations -->

<!-- ||·|| -->
<!-- The hash character breaks beamer -- see: https://tex.stackexchange.com/questions/420448/error-illegal-parameter-number-in-definition-of-iterate ->
<!-- \newcommand{\norm}[1]{\left\lVert#1\right\rVert} -->

<!-- The function in the definition of contractible types -->
\newcommand{\contr}{\ensuremath{\mathsf{contr}}}


<!-- ## Pushouts -->

<!-- inl -->
\newcommand{\inl}{\ensuremath{\mathsf{inl}}}
\newcommand{\inr}{\ensuremath{\mathsf{inr}}}
\newcommand{\glue}{\ensuremath{\mathsf{glue}}}


<!-- ## Categories -->

<!-- Top -->
\newcommand{\Top}{\ensuremath{\mathsf{Top}}}

<!-- Pointed Top -->
\newcommand{\PTop}{\ensuremath{\mathsf{Top}_*}}

<!-- Ho(Top) -->
\newcommand{\HoTop}{\ensuremath{\mathsf{Ho}(\mathsf{Top})}}

<!-- Grp -->
\newcommand{\Grp}{\ensuremath{\mathsf{Grp}}}


<!-- ## Topology -->

<!-- Closed 2-dimensional disk -->
\newcommand{\dtwo}{\ensuremath{\mathbb{D}^{2}}}

<!-- Real projective space -->
\newcommand{\RP}{\ensuremath{{\mathbb{R}\mathsf{P}}}}

<!-- Real line -->
\newcommand{\reals}{\ensuremath{\mathbb{R}}}


**Teoria d'homotopies.** Estudi de propietats invariants per deformacions que preserven camins.

| Ordre | Nom | Exemple |
|---|---|---|
| 0-camins | Punts | $a, b \in X$ |
| 1-camins | Camins | $p, q : a \rightarrow b$ |
| 2-camins | Homotopies | $h : p \Rightarrow q$ |
| ... | ... | ... |



## Teoria homotòpica de tipus

![](out/images/type.png)


## Teoria homotòpica de tipus

![](out/images/type-annotated.png)


## Teoria homotòpica de tipus

\begin{center}
\begin{tikzpicture}
\tikzstyle{west}=[anchor=west]
\node[west] (lft) at (0,-1) {Com creem nous tipus?};
\node[west] (top) at (6,0) {\begin{tabular}{c} Constructors de tipus \\ \tiny Creem un tipus a partir d'altres \end{tabular}};
\node[west] (bot) at (6,-2) {\begin{tabular}{c} Tipus inductius \\ \tiny Creem un tipus donant-ne constructors \end{tabular}};
\draw[->] (lft.east) -- (top.west);
\draw[->] (lft.east) -- (bot.west);
\end{tikzpicture}
\end{center}


## Teoria homotòpica de tipus

\begin{center}
\begin{tikzpicture}
\tikzstyle{west}=[anchor=west]
\node[west] (lft) at (0,-1) {Com creem nous tipus?};
\node[west] (top) at (6,0) {\begin{tabular}{c} {\usebeamercolor[fg]{structure} Constructors de tipus} \\ \tiny Creem un tipus a partir d'altres \end{tabular}};
\node[west] (bot) at (6,-2) {\begin{tabular}{c} Tipus inductius \\ \tiny Creem un tipus donant-ne constructors \end{tabular}};
\draw[->] (lft.east) -- (top.west);
\draw[->] (lft.east) -- (bot.west);
\end{tikzpicture}
\end{center}


## Constructors de tipus

**Regla de formació**
: Com es construeix el tipus?

**Regla d'introducció**
: Com es construeixen elements del tipus?

**Regla d'eliminació**
: Què es pot fer amb elements del tipus?

**Regla de computació**
: Com es coordinen les regles d'introducció i d'eliminació?


## Constructors de tipus: funcions

**Formació**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : \universe$}
  \BinaryInfC{$A \rightarrow B : \universe$}
  \end{prooftree}

**Introducció**
: \begin{prooftree}
  \AxiomC{$\lambda (x:A).\Phi$}
  \UnaryInfC{$f : A \rightarrow B$}
  \end{prooftree}

**Eliminació**
: \begin{prooftree}
  \AxiomC{$f : A \rightarrow B$}
  \AxiomC{$a : A$}
  \BinaryInfC{$f(a) : B$}
  \end{prooftree}

**Computació**
: \begin{prooftree}
  \AxiomC{$\lambda (x:A).\Phi$}
  \AxiomC{$a : A$}
  \BinaryInfC{$f(a) \equiv \Phi[a/x]$}
  \end{prooftree}


## Constructors de tipus: funcions dependents (tipus $\Pi$)

**Formació**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : A \rightarrow \universe$}
  \BinaryInfC{$\prod_{(x : A)} B : \universe$}
  \end{prooftree}

**Introducció**
: \begin{prooftree}
  \AxiomC{$\lambda (x:A).\Phi$}
  \UnaryInfC{$f : \prod_{(x : A)} B$}
  \end{prooftree}

**Eliminació**
: \begin{prooftree}
  \AxiomC{$f : \prod_{(x : A)} B$}
  \AxiomC{$a : A$}
  \BinaryInfC{$f(a) : B(a)$}
  \end{prooftree}

**Computació**
: \begin{prooftree}
  \AxiomC{$\lambda (x:A).\Phi$}
  \AxiomC{$a : A$}
  \BinaryInfC{$f(a) \equiv \Phi[a/x]$}
  \end{prooftree}


## Constructors de tipus: parells

**Formació**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : \universe$}
  \BinaryInfC{$A \times B : \universe$}
  \end{prooftree}

**Introducció**
: \begin{prooftree}
  \AxiomC{$a : A$}
  \AxiomC{$b : B$}
  \BinaryInfC{$(a,b) : A \times B$}
  \end{prooftree}

**Eliminació**
: \begin{prooftree}
  \AxiomC{$f : A \rightarrow B \rightarrow C$}
  \UnaryInfC{$g : A \times B \rightarrow C$}
  \end{prooftree}

**Computació**
: \begin{prooftree}
  \AxiomC{$f : A \rightarrow B \rightarrow C$}
  \AxiomC{$a : A$}
  \AxiomC{$b : B$}
  \TrinaryInfC{$g((a,b)) \equiv f(a)(b)$}
  \end{prooftree}


## Constructors de tipus: parells dependents (tipus $\Sigma$)

**Formació**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : A \rightarrow \universe$}
  \BinaryInfC{$\sum_{(a : A)} B(a) : \universe$}
  \end{prooftree}

**Introducció**
: \begin{prooftree}
  \AxiomC{$a : A$}
  \AxiomC{$b : B(a)$}
  \BinaryInfC{$(a,b) : \sum_{(a : A)} B(a)$}
  \end{prooftree}

**Eliminació**
: \begin{prooftree}
  \AxiomC{$f : \prod_{(a : A)} B(a) \rightarrow C$}
  \UnaryInfC{$g : \sum_{(a : A)} B(a) \rightarrow C$}
  \end{prooftree}

**Computació**
: \begin{prooftree}
  \AxiomC{$f : \prod_{(a : A)} B(a) \rightarrow C$}
  \AxiomC{$a : A$}
  \AxiomC{$b : B(a)$}
  \TrinaryInfC{$g((a,b)) \equiv f(a)(b)$}
  \end{prooftree}


## Constructors de tipus: unió disjunta

**Formació**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : \universe$}
  \BinaryInfC{$A + B : \universe$}
  \end{prooftree}

**Introducció**
: \begin{prooftree}
  \AxiomC{$a : A$}
  \UnaryInfC{$\inl(a) : A + B$}
  \end{prooftree}
: \begin{prooftree}
  \AxiomC{$b : B$}
  \UnaryInfC{$\inr(b) : A + B$}
  \end{prooftree}

**Eliminació**
: \begin{prooftree}
  \AxiomC{$f_A : A \rightarrow C$}
  \AxiomC{$f_B : B \rightarrow C$}
  \BinaryInfC{$g : A + B \rightarrow C$}
  \end{prooftree}

**Computació**
: \begin{prooftree}
  \AxiomC{$f_A : A \rightarrow C$}
  \AxiomC{$f_B : B \rightarrow C$}
  \AxiomC{$a : A$}
  \TrinaryInfC{$g(\inl(a)) \equiv f_A(a)$}
  \end{prooftree}
: \begin{prooftree}
  \AxiomC{$f_A : A \rightarrow C$}
  \AxiomC{$f_B : B \rightarrow C$}
  \AxiomC{$b : B$}
  \TrinaryInfC{$g(\inr(b)) \equiv f_B(b)$}
  \end{prooftree}


## Constructors de tipus: identitat

**Formació**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$x : A$}
  \AxiomC{$y : A$}
  \TrinaryInfC{$x = y : \universe$}
  \end{prooftree}

**Introducció**
: \begin{prooftree}
  \AxiomC{$x : A$}
  \UnaryInfC{$\refl_x : x = x$}
  \end{prooftree}

**Eliminació**
: \begin{prooftree}
  \AxiomC{$B : \prod_{(x,y : A)} (x = y) \rightarrow \universe$}
  \AxiomC{$f : \prod_{(x : A)} B(x,x,\refl_x)$}
  \BinaryInfC{$g : \prod_{(x,y : A)} \prod_{(p:x=y)} B(x,y,p)$}
  \end{prooftree}

**Computació**
: &nbsp;

  \AxiomC{$B : \prod_{(x,y : A)} (x = y) \rightarrow \universe$}
  \AxiomC{$f : \prod_{(x : A)} B(x,x,\refl_x)$}
  \AxiomC{$x : A$}
  \TrinaryInfC{$g(x,x,\refl_x) \equiv f(x)$}
  \DisplayProof


## Teoria homotòpica de tipus

\begin{center}
\begin{tikzpicture}
\tikzstyle{west}=[anchor=west]
\node[west] (lft) at (0,-1) {Com creem nous tipus?};
\node[west] (top) at (6,0) {\begin{tabular}{c} Constructors de tipus \\ \tiny Creem un tipus a partir d'altres \end{tabular}};
\node[west] (bot) at (6,-2) {\begin{tabular}{c} {\usebeamercolor[fg]{structure} Tipus inductius} \\ \tiny Creem un tipus donant-ne constructors \end{tabular}};
\draw[->] (lft.east) -- (top.west);
\draw[->] (lft.east) -- (bot.west);
\end{tikzpicture}
\end{center}


## Tipus inductius

**Tipus buit**
: \begin{center}\textit{Cap constructor}\end{center}

**Tipus unitat**
: \begin{center}$\star : \one$\end{center}

**Tipus booleà**
: \begin{center}
  $\left\{\begin{aligned}
  \zerotwo &: \two \\
  \onetwo &: \two
  \end{aligned}\right.$
  \end{center}

**Naturals**
: \begin{center}
  $\left\{\begin{aligned}
  0 &: \naturals \\
  \natsucc &: \naturals \rightarrow \naturals
  \end{aligned}\right.$
  \end{center}


## Tipus inductius d'ordre superior

**Circumferència**
: \begin{center}
  $\left\{\begin{aligned}
  \sbase &: \sone \\
  \sloop &: \sbase = \sbase
  \end{aligned}\right.$
  \end{center}

**Esfera**
: \begin{center}
  $\left\{\begin{aligned}
  \sbase &: \stwo \\
  \ssurf &: \refl_{\sbase} = \refl_{\sbase}
  \end{aligned}\right.$
  \end{center}


## La correspondència Curry-Howard

| Lògica de primer ordre                 | Teoria de tipus                        |
|----------------------------------------|---------------------------------------:|
| Una declaració                         | Un tipus                               |
| Un teorema                             | Un tipus habitat                       |
| Una demostració                        | Un element d'un tipus                  |
| &nbsp;                                 | &nbsp;                                 |
| $A \wedge B$                           | $A \times B$                           |
| $A \vee B$                             | $A + B$                                |
| $A \Rightarrow B$                      | $A \rightarrow B$                      |
| $\neg A$                               | $A \rightarrow \zero$                  |
| &nbsp;                                 | &nbsp;                                 |
| Per algun $a$ d'$A$, $P(a)$.           | $\sum_{(a : A)} P(a)$                  |
| Per tot $a$ d'$A$, $P(a)$.             | $\prod_{(a : A)} P(a)$                 |
| &nbsp;                                 | &nbsp;                                 |
| $a = b$                                | $a = b$                                |

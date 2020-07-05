# Teoria homotòpica de tipus

## Teoria homotòpica de tipus

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


### Lògica

- No necessita **cap lògica externa**
- És **constructiva**
- Es pot interpretar **homotòpicament**

### Elements i tipus

- Cada **element** té assignat exactament un sol **tipus** ($x : A$)
- $\universe$ és el "tipus que conté tots els tipus" ($A : \universe$)

### Funcions

- $A \rightarrow B$ és el tipus de **funcions** de $A : \universe$ a $B : \universe$
- $B : A \rightarrow \universe$ és una **família de tipus** parametritzada per $A : \universe$


## Tipus identitat

- $x = y$ és un tipus
- Els seus elements es poden interpretar com **igualtats** o com **camins**
- Tot element $x$ és igual a si mateix: $\refl_x : x = x$


## Constructors de tipus

**Funcions dependents**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : A \rightarrow \universe$}
  \BinaryInfC{$\prod_{(x : A)} B(x) : \universe$}
  \end{prooftree}
: \begin{center}$f(x) : B(x)$\end{center}

**Parells**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : \universe$}
  \BinaryInfC{$A \times B : \universe$}
  \end{prooftree}
: \begin{center}$(x,y)$ amb $x : A$ i $y : B$\end{center}

**Parells dependents**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : A \rightarrow \universe$}
  \BinaryInfC{$\sum_{(x : A)} B(x) : \universe$}
  \end{prooftree}
: \begin{center}$(x,y)$ amb $x : A$ i $y : B(x)$\end{center}

**Unió disjunta**
: \begin{prooftree}
  \AxiomC{$A : \universe$}
  \AxiomC{$B : \universe$}
  \BinaryInfC{$A + B : \universe$}
  \end{prooftree}
: \begin{center}$\inl(x)$ amb $x : A$ o $\inr(y)$ amb $y : B$\end{center}


## La correspondència Curry-Howard

| Lògica de primer ordre                 | Teoria de tipus                        |
|----------------------------------------|---------------------------------------:|
| Declaració                             | Tipus                                  |
| Teorema                                | Tipus habitat                          |
| Demostració                            | Element d'un tipus                     |
| &nbsp;                                 | &nbsp;                                 |
| $A \wedge B$                           | $A \times B$                           |
| $A \vee B$                             | $A + B$                                |
| $A \Rightarrow B$                      | $A \rightarrow B$                      |
| $\neg A$                               | $A \rightarrow \zero$                  |
| &nbsp;                                 | &nbsp;                                 |
| Per algun $x$ d'$A$, $P(x)$.           | $\sum_{(x : A)} P(x)$                  |
| Per tot $x$ d'$A$, $P(x)$.             | $\prod_{(x : A)} P(x)$                 |
| &nbsp;                                 | &nbsp;                                 |
| $a = b$                                | $a = b$                                |


## Tipus inductius

Tipus **buit** ($\zero$)
: \begin{center}-\end{center}

<br/>

Tipus **unitat** ($\one$)
: \begin{center}$\star : \one$\end{center}

<br/>

Tipus **booleà** ($\two$)
: \begin{center}
  $\left\{\begin{aligned}
  \zerotwo &: \two \\
  \onetwo &: \two
  \end{aligned}\right.$
  \end{center}

<br/>
<br/>

**Naturals** ($\naturals$)
: \begin{center}
  $\left\{\begin{aligned}
  0 &: \naturals \\
  \natsucc &: \naturals \rightarrow \naturals
  \end{aligned}\right.$
  \end{center}


## Tipus inductius d'ordre superior

<br/>

**Circumferència** ($\sone$)
: \begin{center}
  $\left\{\begin{aligned}
  \sbase &: \sone \\
  \sloop &: \sbase = \sbase
  \end{aligned}\right.$
  \end{center}

<br/>

```\begin{center}```{=beamer}

![](out/images/circle.png){ width=200px }

```\end{center}```{=beamer}

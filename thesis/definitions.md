 <!-- # Math -->

<!-- ## Theorems -->

<!-- We use a "raw environment", otherwise pandoc mangles these defns -->
```{=latex}
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}

\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{axiom}[theorem]{Axiom}
\newtheorem{example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}
\newtheorem{question}[theorem]{Question}
```


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
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}

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

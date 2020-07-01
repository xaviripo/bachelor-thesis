# La circumferència

## Definició

$$
\left\{\begin{aligned}
\sbase &: \sone \\
\sloop &: \sbase = \sbase
\end{aligned}\right.
$$

![](out/images/circle.png)


## El grup fonamenal

$$
\pi_1(\sone,\sbase) :\equiv \left\lVert \sbase = \sbase \right\rVert_0
$$

Intentem descriure $\sbase = \sbase$.

Volem provar $(\sbase = \sbase) \simeq \integers$.
Com construïm una funció $(\sbase = \sbase) \rightarrow \integers$?


## \encode{} i \decode{}

El principi d'inducció del tipus identitat només permet construir funcions si almenys un dels dos termes no està fixat.

Difícil: $(\sbase = \sbase) \rightarrow \integers$

Possible: $\prod_{(x : \sone)} (\sbase = x) \rightarrow ?$


## \encode{} i \decode{}

Cal definir el codomini.

Per inducció sobre $\sone$:
\begin{align*}
\code : \sone &\rightarrow \universe\\
\code(\sbase) &= \integers\\
\ap_{\code}(\sloop) &= \ua(\natsucc)
\end{align*}
Aleshores, volem funcions:
\begin{align*}
\encode &: \prod_{x : \sone} (\sbase = x) \rightarrow \code(x)\\
\decode &: \prod_{x : \sone} \code(x) \rightarrow (\sbase = x)
\end{align*}


## \encode{} i \decode{}

\begin{align*}
\encode &: \prod_{x : \sone} (\sbase = x) \rightarrow \code(x)\\
\encode(x,p) &= \transport^{\code}(p,0)
\end{align*}

\begin{align*}
\decode &: \prod_{x : \sone} \code(x) \rightarrow (\sbase = x)\\
\decode(\sbase,n) &= \sloop^n\\
\ap_{\decode}(\sloop,-) &= L \mathrm{,\quad on\quad} L : \sloop_*(\sloop^-)=\sloop^-
\end{align*}


## \encode{} i \decode{}

\begin{align*}
\prod_{x:\sone} \prod_{p:\sbase=x} \decode_x(\encode_x(p)) &= p\\
\prod_{x:\sone} \prod_{p:\sbase=x} \encode_x(\decode_x(c)) &= c
\end{align*}
$$\Downarrow$$
$$\prod_{x:\sone} (\sbase = x) \simeq \code(x)$$
$$\Downarrow$$
$$(\sbase = \sbase) \simeq \integers$$

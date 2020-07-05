# El grup fonamental de la circumferència

$$
\pi_1(\sone,\sbase) = (\sbase = \sbase)
$$

\begin{align*}
(\sbase = \sbase) &\simeq \integers?\\
(\sbase = \sbase) &\rightarrow \integers?
\end{align*}


## \encode{} i \decode{}

```\begin{center}```{=beamer}
Difícil: $(\sbase = \sbase) \rightarrow \integers$

Possible: $\prod_{(x : \sone)} (\sbase = x) \rightarrow ?$
```\end{center}```{=beamer}


## \encode{} i \decode{}

\begin{align*}
\code : \sone &\rightarrow \universe\\
\code(\sbase) &= \integers\\
\code(\sloop) &= \natsucc
\end{align*}


## \encode{} i \decode{}

![](out/images/circle-covering.pdf)


## \encode{} i \decode{}

\begin{align*}
\encode &: \prod_{x : \sone} (\sbase = x) \rightarrow \code(x)\\
\decode &: \prod_{x : \sone} \code(x) \rightarrow (\sbase = x)
\end{align*}
\begin{align*}
\prod_{x:\sone} \prod_{p:\sbase=x} \decode_x(\encode_x(p)) &= p\\
\prod_{x:\sone} \prod_{p:\sbase=x} \encode_x(\decode_x(c)) &= c
\end{align*}
$$\Downarrow$$
$$\prod_{x:\sone} (\sbase = x) \simeq \code(x)$$
$$\Downarrow$$
$$(\sbase = \sbase) \simeq \integers$$

# Agda

## *Type checking*

\begin{center}
\begin{tikzpicture}
\node (codi) at (0,0) {Codi font};
\node (codileft) at (-1,0) {};
\node (p1) at (0,-2) {·};
\node (p2) at (0,-4) {·};
\node (exec) at (0,-6) {Executable};
\node (execleft) at (-1,-6) {};
\draw[->] (codi) -- (p1) node[midway,right] {...};
\draw[->] (p1) -- (p2) node[midway,right] {\textit{Type checking}};
\draw[->] (p2) -- (exec) node[midway,right] {...};
\draw[decorate,decoration={brace,amplitude=5pt,mirror}] (codileft) -- (execleft) node [midway,xshift=-1.5cm] {Compilació};
\end{tikzpicture}
\end{center}


## Demostració

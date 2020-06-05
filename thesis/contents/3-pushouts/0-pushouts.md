# Pushouts {#sec:pushouts}

As we have seen, higher inductive types allow mimicking CW complexes by using $n$-dimensional paths as $n$-cells. Unfortunately, this is not always possible. For starters, an $n$-path can only connect *two* $(n-1)$-paths, whereas cells can join an arbitrary number of lower dimensional cells.

So the question is raised: how does one build more complex spaces in homotopy type theory? In classical topology, there are tools like *gluing* (quotient spaces) that allow us to join or collapse spaces in different ways. In homotopy type theory we need more refined techniques, because we want these to preserve the homotopic invariants we are working with. As a solution, in this chapter we present the **homotopy pushout**.

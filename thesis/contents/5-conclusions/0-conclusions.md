# Conclusions

We have high hopes for the synthetic projective plane we are postulating.
All the clues have been pointing to this construction being correct, and perhaps more important, being "in the style" of homotopy type theory.

The equivalences between the pushout and synthetic versions take the "skeleton" (points and $1$-paths) to the corresponding items with little trouble.
Each of the two implementations has a "special" surface: in the case of the pushout, the path family \glue{}, and in the case of the higher inductive type, the constructor $X_2$.
The complexity and defining property of the equivalences is in describing correctly how these surfaces correspond to each other.
These surfaces are actually the generators of the second order homotopy group of each of the spaces, and in fact also spawn all the higher homotopy structure.
We also had postulated a possible implementation of higher projective spaces following this technique of attaching "reversing" paths, but this would add extra higher homotopical structure, which would not work.

Nonetheless, we will still eagerly try to prove the equivalence for $\RP^2$.
The conversion from pushout to higher inductive type in this manner is proposed by the book of the @univalent_foundations_program_homotopy_2013 itself, but we have not been able to find any complete proof of this style.
Hence, we believe that publishing the complete version of the proof would actually contribute value to the homotopy type theory community.

One of our objectives was to use Agda as an aid for learning homotopy type theory.
Using a machine turns out to be of big use: the compiler is blunt and does not forgive any mistake.
The learning path with a proof assistant can feel like pushing a boulder up a hill, but the error messages at every wrong step help correct misguided intuitions.
Although it did not help in producing complete results, Agda is useful for making "enquiries" about (homotopy) type theory.
It is particularly good for clearing up how higher paths should be built from lower ones, as it does not allow to abuse the language, hence avoiding conceptual or syntactical mistakes.

Some people may wonder what use does a proof checker have if the job of writing the proof relies on the mathematician.
After all, it might just seem like doing double work for nothing.

The immediate benefit is that verification helps catch mistakes that might be otherwise hard to notice by humans in very complex settings.
Some people might have philosophical reservations about computers proving things that people cannot.
We propose seeing the computer as a mathematical object: one first proves the computer to be correct (this entails everything from the processing unit up to the proof assistant), and then uses it to prove further things.
The computer is but a lemma in every proof it verifies.

The long-term answer is that formalization of proofs is an indispensable step for further improvements, like proof assistants (programs that help the mathematician by proposing ways of filling holes in proofs), which already exist, and eventually automated proof development, which would consist of the computer being capable of deducing valid theorems from a set of hypotheses (which already shows up in logic programming).

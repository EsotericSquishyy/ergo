#import "@local/superTheorems:0.1.0": *

#set page(
  width: 16.7cm,
  height: 13.405cm,
  margin: 1em
)
#show: thmS-init.with(

)

#defn[Group][
  A *group* is an ordered pair $(G, star)$, where $G$ is a set and $star$ is a binary operation on $G$ satisfying
  1. The operation is associative: $(a star b) star c = a star (b star c) forall a, b, c in G$
  2. $G$ has an identity: $exists e in G "such that" e star a = a star e = a forall a in G$
  3. Every element $a in G$ is invertible: $forall a in G exists a^(-1) in G "such that" a star a^(-1) = a^(-1) star a = e$
]

#thm[Orbit-Stabilizer Theorem][
  Let $G$ be a group acting on a set $X$, with $x in X$.
  Then the map
  $
    G \/ G_x &--> G dot x \
    a G_x &arrow.r.bar a dot x
  $
  is well-defined and bijective, and therefore $|G dot x| = [G : G_x]$.
][
  Let $a, b in G$.
  Then
  $
    a G_x = b G_x &<==> b^(-1) a in G_x \
    &<==> b^(-1) a dot x = x \
    &<==> a dot x = b dot x.
  $
  Observe the map is well-defined by $(==>)$ and injective by $(<==)$.

  For surjectivity, note for any $a in G$, $a dot x$ is the image of $a G_x$.
]

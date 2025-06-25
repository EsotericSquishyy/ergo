#import "@preview/physica:0.9.5": *
#import "@local/superTheorems:0.1.0": *

#show: thmS-init.with(colors: "gruvbox_dark", headers: "sidebar")
#set page(
  width: 18cm,
  height: 24cm,
  margin: 1em
)

= Lagrangian Mechanics

We want to now use the Euler-Lagrange equation to solve mechanics problems.
To do this, we want to find some function $L(t, x, dot(x))$ such that evaluating the Euler-Lagrange equation gives Newton's Second Law for a particle subject to conservative forces,
$
  dv(, t) (m dot(x)) = -dv(U, x).
$
Comparing with the form of Euler-Lagrange, we see we must have
$
  pdv(L, dot(x)) = m dot(x); quad pdv(L, x) = -dv(U, x).
$
Solving the first equation by separation of variables gives
$
  L = 1 / 2 m dot(x)^2 + g(t, x).
$
Now since $U$ is purely a function of $x$, our second PDE means we do not have to consider $t$ dependence in our solution, meaning without loss of generality let $g$ be a function of $x$ alone.
From here we deduce
$
  pdv(g, x) = -dv(U, x) => g(x) = -U(x),
$
implying that
$
  L = T - U
$
works.
This is called the *Lagrangian* of our system, and it gives us a powerful new formulation of mechanics.
Importantly, because we did not consider our PDE solution in full generality, it is not unique in its implication of Newton's Second Law.

#defn[Least Action Principle][
  Given a mechanical system described by $N$ dynamical generalized coordinates $q_k (t)$, with $k = 1, 2, dots, N$, define its *action* by
  #eqbox[
    $
      S[q_k (t)] = integral_(t_a)^(t_b) dd(t) L(t, q_1, q_2, dots, dot(q)_1, dot(q)_2, dots).
    $
  ]
  (We assume the particle begins at some position $(q_1, q_2, dots)_a$ at time $t_a$ and ends at position $(q_1, q_2, dots)_b$ at time $t_b$.)
  Also note that this is a generalized version of the function $J[f]$ shown previously.

  Now the *least action principle* states that, for trajectories $q_k (t)$ where $S$ is stationary, i.e.,
  $
    delta S = delta integral_(t_a)^(t_b) L(t, q_k dot(q)_k) dd(t) = 0,
  $
  then the $q_k (t)$'s satisfy the equations of motions for the system with the given boundary conditions.
  Note this is just the proof we did earlier a---if to first order $delta S = 0$, then $S$ is an extrema, and thus the Euler-Lagrange equations apply.
]


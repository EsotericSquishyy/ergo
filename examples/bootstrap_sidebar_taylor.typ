#import "@local/superTheorems:0.1.0": *
#show: thmS-init.with(
  colors: "bootstrap",
  headers: "sidebar",
  inline_qed: true,
)


#set page(
  width: 16.7cm,
  height: 27cm,
  margin: 1em
)


#defn[Multi-index][
  For $alpha_1, ..., alpha_n gt.eq 0$ we call $alpha = (alpha_1, ..., alpha_n)$ a multi-index. One then defines the following:
  1. $alpha! = alpha_1 ! dots.h.c alpha_n !$;
  2. for $x in RR^n$ one defines $x^alpha = x_1^(alpha_1) dots.h.c x_n^(alpha_n)$ if $x_i eq.not 0$ for all $i$, otherwise $x^alpha = 0$ if there exists a $j$ such that $x_j = 0$;
  3. let $abs(alpha) = alpha_1 + dots.h.c + alpha_n$ be the order of $alpha$;
  4. let $D^alpha f(x) = (partial^abs(alpha) f(x))/(partial x_1^(alpha_1) dots.h.c partial x_n^(alpha_n))$.
]

#thm[Taylor's Formula over $RR^n$][
  Let $E subset.eq RR^n$ be open and let $overline(B_r (a)) subset.eq E$. Assume $f in cal(C)^k (E)$ then $
    f(x)
      &= sum_(abs(alpha) lt.eq k) (D^alpha f(a))/(alpha!) (x - a)^alpha + sum_(abs(alpha) = k) h_alpha (x) (x - a)^alpha
  $ for any $x in B_r (a)$ where $alpha$ is a multi-index and $h_alpha:B_r (a) -> RR$ such that $h_alpha (x) -> 0$ when $x -> a$ for all $abs(alpha) = k$.
][
  #rem[
    Note $
      abs((x - a)^alpha)
        &= abs(product_(i = 1)^n (x_i - a_i)^alpha_i)
        &= product_(i = 1)^n abs(x_i - a_i)^alpha_i
        &lt.eq abs(x - a)^abs(alpha).
    $ Therefore we have that $
      abs(sum_(abs(alpha) = k) h_alpha (x) (x - a)^alpha)
        &lt.eq abs(x - a)^k sum_(abs(alpha) = k) abs(h_alpha (x))
    $ such that $sum_(abs(alpha) = k) h_alpha (x) (x - a)^alpha = o(abs(x - a)^k)$.
  ]

  Let $x in B_r (a)$ and define $[a, x] = {phi(t) bar.v t in [0, 1]}$ where $phi:[-1, 1] -> RR^n$ is defined by $phi(t) = a + t (x - a)$. Then let $g(t) = f(phi(t))$ such that $g(0) = f(a)$ and $g(1) = f(x)$. Then note $g in cal(C)^k ([-1, 1])$ such that $
    g(1)
      &= g(0) + 1/(1!) g'(0) + dots.h.c + 1/((k - 1)!) g^((k - 1)) (0) + 1/(k!) g^((k)) (c)
  $ for some $c in [0, 1]$. As shown previously we have $
    g^((m)) (t)
      &= sum_(abs(alpha) = m) D^alpha f(phi(t)) dot (x - a)^alpha
  $ for $m = 1, ..., k$ by mixed derivative theorem. Therefore $
    f(x)
      &= sum_(abs(alpha) lt.eq k - 1) (D^alpha f(a))/(alpha!) (x - a)^alpha + sum_(abs(alpha) = k) (D^alpha f(y))/(alpha!) (x - a)^alpha
  $ for some $y in [a, x]$. Now note that $D^alpha f(y) = D^alpha f(a) + (D^alpha (y) - D^alpha f(a))$ where $D^alpha f(y) - D^alpha f(a) -> 0$ as $y -> a$. Then define $h_alpha (x) = (D^alpha f(y) - D^alpha f(a))/(alpha!) -> 0$ as $x -> a$ where $y$ is a function of $x$.
]



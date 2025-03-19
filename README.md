# superTheorems

A [`Typst`](https://github.com/typst/typst) suite of environments/macros for ease of taking notes or doing problem sets in Mathematics, Computer Science, and Physics.

> [`Typst`](https://github.com/typst/typst) is required to use this package.
> You can get started by checking out the integrated language service [`Tinymist`](https://github.com/Myriad-Dreamin/tinymist) or by referring to Typst's [installation page](https://github.com/typst/typst?tab=readme-ov-file#installation).
> Note that [`Tinymist`](https://github.com/Myriad-Dreamin/tinymist) currently supports `VSCode`, `NeoVim`, `Emacs`, `Sublime Text`, `Helix`, and `Zed`.

## Installation

1. Clone this repository somewhere locally on your machine.

2. `cd` into the repository and use the setup script in `./scripts` matching your operating system to install.
(The Windows install script is currently still experimental.)
Refer to the [Typst Packages](https://github.com/typst/packages) repository for more information.

3. Test whether the installation worked by opening a new `.typ` file in any directory with the following code:
    ```typ
    #import "@local/superTheorems:0.1.0": *

    #thm(name: [ /* Name */ ])[
        /* Statement */
    ][
        /* Proof */
    ]
    ```
    If you're able to render the pdf, you're good to go.

4. Check out the examples in `./examples` to get started (TODO).


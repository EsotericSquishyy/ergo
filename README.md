# superTheorems

A [Typst](https://github.com/typst/typst) suite of environments/macros for ease of taking notes or doing problem sets in Mathematics, Computer Science, and Physics.

> [Typst](https://github.com/typst/typst) is required to use this package.
> You can get started by checking out the integrated language service [`Tinymist`](https://github.com/Myriad-Dreamin/tinymist) or by referring to Typst's [installation page](https://github.com/typst/typst?tab=readme-ov-file#installation).
> Note that [`Tinymist`](https://github.com/Myriad-Dreamin/tinymist) currently supports `VSCode`, `NeoVim`, `Emacs`, `Sublime Text`, `Helix`, and `Zed`.



## Installation

Clone this repository somewhere locally on your machine and move to the directory.
Run `scripts/setup.sh` from the **root of the project directory**.
Refer to the [Typst Packages](https://github.com/typst/packages) repository for more information.

> The installation process simply symlinks this project directory to the Typst local packages directory mentioned [here](https://github.com/Jollywatt/typst-fletcher).

```bash
git clone https://github.com/EsotericSquishyy/superTheorems
cd superTheorems
scripts/setup.sh
```

#### Updating package

If you want to use a different version of the package than the one currently installed you can do one of the following:
- **To keep previous version:** Clone this repository a second time (in a different directory) and run `scripts/setup.sh` in the new repository's root directory.
Note this will remove the any previous verion's symlink that has the same version number as the one you are installing.
- **To remove previous version:** Pull the changes from the target release/commit and rerun `scripts/setup.sh` from the root of the project directory.
Optionally, you can remove the dangling symlink from the Typst local package directory.

#### Testing

Test whether the installation/update worked by opening running the following commands in an empty directory:
```bash
cat <<EOF > test.typ
#import "@local/superTheorems:{Version Number}": *
#defn[
    #lorem(5)
][
    #lorem(50)
]
EOF

typst compile test.typ
```
The installation is working if the compile didn't fail and `test.pdf` looks like this:
<img src="gallery/test_output.png" width="50%">



## Usage

To get started simply add the following to your `.typ` file:
```typ
#import "@local/superTheorems:{Version Number}": *
```
This will give you access to all of the functions available in the `superTheorems` package.

#### Environments

`superTheorems` has three different types of enviornments: proofs, statements, and problems.
Their individual usages are listed in the subsections below but they all share a set of (optional) keyword arguments:
- `breakable` (default: `false`) - if the current environment is breakable across multiple pages.
- `width` (default: `100%`) - width of the current environment in its current scope.
- `height` (default: `auto`) - height of the current environment in its current scope.

The following is a table detailing the three different kinds of environments.
Note that the arguments are all positional but only one is required for valid syntax.
<table>
  <tr>
    <td><b>Type</b></td>
    <td><b>Args (Priority)</b></td>
    <td><b>Environments</b></td>
    <td><b>Notes</b></td>
  </tr>

  <tr>
    <td>Proof</td>
    <td>
        <ul>
            <li><code>name</code> (3)</li>
            <li><code>statement</code> (1)</li>
            <li><code>proof</code> (2)</li>
        </ul>
    </td>
    <td>
        <ul>
            <li><code>theorem</code> (<code>thm</code>)</li>
            <li><code>lemma</code> (<code>lem</code>)</li>
            <li><code>corollary</code> (<code>cor</code>)</li>
            <li><code>proposition</code> (<code>prop</code>)</li>
        </ul>
    </td>
    <td>
    </td>
  </tr>

  <tr>
    <td>Statement</td>
    <td>
        <ul>
            <li><code>name</code> (2)</li>
            <li><code>statement</code> (1)</li>
        </ul>
    </td>
    <td>
        <ul>
            <li><code>definition</code> (<code>defn</code>)</li>
            <li><code>remark</code> (<code>rem</code>, <code>rmk</code>)</li>
            <li><code>notation</code> (<code>notn</code>)</li>
            <li><code>example</code> (<code>ex</code>)</li>
            <li><code>concept</code> (<code>conc</code>)</li>
            <li><code>computational_problem</code> (<code>comp_prob</code>)</li>
            <li><code>algorithm</code> (<code>algo</code>)</li>
        </ul>
    </td>
    <td>
    </td>
  </tr>

  <tr>
    <td>Problem</td>
    <td>
        <ul>
            <li><code>name</code> (3)</li>
            <li><code>statement</code> (1)</li>
            <li><code>solution</code> (2)</li>
        </ul>
    </td>
    <td>
        <ul>
            <li><code>problem</code> (<code>prob</code>)</li>
            <li><code>exercise</code> (<code>excs</code>)</li>
        </ul>
    </td>
    <td>
        <ul>
            <li>Has built in counter</li>
        </ul>
    </td>
  </tr>
</table>

#### Themes/Colors

`superTheorems` offers several ways to customize the environments.
This is done through an initialization function, `thmS-init`, with the following keyword arguments:
- `colors` (default: `"bootstrap"`) - Changes colorscheme of environments and text color
    - `"classic"` - Original colorscheme
    - `"bw"` - Black and white colorscheme
    - `"bootstrap"` - Default colorscheme based on bootstrap colors
    - `"gruvbox_dark"` - Gruvbox Dark colorscheme, also modifies the background color
- `headers` (default: `"tab"`) - Changes environment box structure
    - `"tab"` - Default header style, rounded
    - `"classic"` - Original header style, rounded
    - `"sidebar"` - Less padding, not rounded

#### Extras

There are a few extra functions/macros that may be of interest:
- `correction(body)` - Add a correction to nearby content.
- `bookmark(title, info)` - Add additional information with small box.
- `equation_box(equation)` - Box an equation.
- `proof(body)` - Prepend body with "Proof:" and append `qed`.
- `qed` - A macro for `sym.square.big` with additional spacing.



## Examples

TODO



## Known Issues
- Incorrect colors for arrows in drawing packages such as [Fletcher](https://github.com/Jollywatt/typst-fletcher) when using `gruvbox_dark` color scheme.


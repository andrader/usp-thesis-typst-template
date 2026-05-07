# USP Thesis Typst Template

A comprehensive, extensible Typst template for theses and dissertations at the University of São Paulo (USP) and specifically the Institute of Mathematics and Statistics (IMEUSP), following the official guidelines (5th edition, 2024).

Example output PDF generated with this template: [usp-example.pdf](examples/usp-example.pdf)

## Features ✨
- **Official Layout**: Correct margins (3cm/2cm), A4 size, and 1.5 line spacing.
- **Automated Elements**: Generates Cover, Title Page, Approval Sheet, and Abstracts.
- **IMEUSP Support**: Specific branding and "Standard Statement" for the Institute of Mathematics and Statistics.
- **Extensible**: Easily adaptable to other USP institutes.
- **Pre-textual Elements**: Support for Dedication, Acknowledgments, and Epigraph.

## Table of Contents
- [USP Thesis Typst Template](#usp-thesis-typst-template)
  - [Features ✨](#features-)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites 📋](#prerequisites-)
  - [Install the Template Package](#install-the-template-package)
    - [MacOS 🍎](#macos-)
    - [Linux 🐧](#linux-)
    - [Windows ⊞](#windows-)
  - [Initialize a new project](#initialize-a-new-project)
  - [Example Usage](#example-usage)
  - [Configuration Options](#configuration-options)
  - [Future Extensions](#future-extensions)
  - [Development and Testing](#development-and-testing)
  - [License](#license)

## Prerequisites 📋

- [Typst Compiler](https://typst.app/): Typst is a modern, faster, and more intuitive typesetting alternative to LaTeX, featuring cleaner syntax and instant compilation, making it ideal for new projects. 

  <details>
    <summary><b>[Click to expand] How to install Typst ⚙️</b></summary>

    ### MacOS

    Open Terminal and run:

    ```bash
    brew install typst
    ```

    ### Linux

    Open Terminal and run:

    ```bash
    # For Debian/Ubuntu-based distributions
    sudo apt install typst
    # For Fedora-based distributions
    sudo dnf install typst
    # Snap
    sudo snap install typst
    ```

    ### Windows

    Open PowerShell and run:

    ```powershell
    winget install typst
    ```

  </details>




## Install the Template Package

### MacOS 🍎

```bash
# Clone the repository at the correct location for local Typst packages
git clone https://github.com/andrader/usp-thesis-typst-template ~/Library/Application\ Support/typst/packages/local/usp-thesis/0.1.0/
```

### Linux 🐧

```bash
# Clone the repository at the correct location for local Typst packages
git clone https://github.com/andrader/usp-thesis-typst-template ~/.local/share/typst/packages/local/usp-thesis/0.1.0/
```

### Windows ⊞

```powershell
# Clone the repository at the correct location for local Typst packages
git clone https://github.com/andrader/usp-thesis-typst-template $env:APPDATA\typst\packages\local\usp-thesis\0.1.0
```

## Initialize a new project

In your Typst project, on your terminal initialize the template with:

```bash
typst init @local/usp-thesis:0.1.0
```

Then, you can generate the PDF with:

```bash
cd usp-thesis
typst compile main.typ
```

To watch for changes and recompile automatically:

```bash
typst watch main.typ
```

## Example Usage

```typst
#import "@local/usp-thesis:0.1.0": usp-thesis

#show: usp-thesis.with(
  title: [Your Thesis Title],
  author: "Your Name",
  advisor: "Advisor's Name",
  institute: "Instituto de Matemática e Estatística",
  program: "Probability and Statistics",
  degree: "Mestre", // or "Doutor"
  abstract-pt: [ ... ],
  keywords-pt: ("Keyword1", "Keyword2"),
  abstract-en: [ ... ],
  keywords-en: ("Keyword1", "Keyword2"),
  banca: (
    (nome: "Examiner 1", instituicao: "USP"),
    (nome: "Examiner 2", instituicao: "Unicamp"),
  ),
)

= Introduction
Your content starts here...
```

## Configuration Options

The `usp-thesis` function accepts the following parameters:

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `title` | content | The main title of the work. |
| `subtitle` | content | Optional subtitle. |
| `author` | string | Full name of the author. |
| `advisor` | string | Full name of the supervisor. |
| `institute` | string | Full name of the USP institute. |
| `degree` | string | "Mestre" or "Doutor". |
| `program` | string | Name of the graduate program. |
| `version` | string | "Original" or "Corrigida" (Default: "Original"). |
| `banca` | array | List of dictionaries `(nome: "", instituicao: "")` for the jury. |
| `abstract-pt` | content | Abstract in Portuguese. |
| `abstract-en` | content | Abstract in English. |

## Future Extensions

To add support for a new institute with a specific "Nature Text", modify the logic in `src/lib.typ`:

```typst
let nature-text = if institute.contains("Your Institute") {
  "Specific Statement for your Institute"
} else {
  // default ABNT/USP statement
}
```

## Development and Testing

To install this Typst package locally for development or testing, create symlinks as follows (macOS example):

```sh
mkdir -p ~/Library/Application\ Support/typst/packages/local/usp-thesis/0.1.0
ln -s "$PWD/src" "~/Library/Application Support/typst/packages/local/usp-thesis/0.1.0/src"
ln -s "$PWD/typst.toml" "~/Library/Application Support/typst/packages/local/usp-thesis/0.1.0/typst.toml"
```

Then, in your Typst files, import the package with:

```typst
#import "@local/usp-thesis:0.1.0": *
```

---

You can store packages in {data-dir}/typst/packages/{namespace}/{name}/{version} to make them available locally on your system. Here, {data-dir} is

- $XDG_DATA_HOME or ~/.local/share on Linux
- ~/Library/Application Support on macOS
- %APPDATA% on Windows

You may also run typst info and check Package path for the actual path. 
This would be helpful if you have installed the Typst compiler from Snap or are using special environment variables.




## License
MIT

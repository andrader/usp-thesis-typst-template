# USP Thesis Typst Template

A comprehensive, extensible Typst template for theses and dissertations at the University of São Paulo (USP), following the official guidelines (5th edition, 2024).

## Features
- **Official Layout**: Correct margins (3cm/2cm), A4 size, and 1.5 line spacing.
- **Automated Elements**: Generates Cover, Title Page, Approval Sheet, and Abstracts.
- **IMEUSP Support**: Specific branding and "Standard Statement" for the Institute of Mathematics and Statistics.
- **Extensible**: Easily adaptable to other USP institutes.
- **Pre-textual Elements**: Support for Dedication, Acknowledgments, and Epigraph.

## How to Use

### 1. Initialize a new project
If this package is installed in your Typst local packages or the Universe, you can use:
```bash
typst init @preview/usp-thesis:0.1.0
```

### 2. Manual Setup
Copy the `src/` directory to your project and import it:

```typst
#import "src/lib.typ": usp-thesis

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

## How to install this package locally

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

$XDG_DATA_HOME or ~/.local/share on Linux
~/Library/Application Support on macOS
%APPDATA% on Windows
You may also run typst info and check Package path for the actual path. This would be helpful if you have installed the Typst compiler from Snap or are using special environment variables.




## License
MIT

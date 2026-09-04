# Generic LaTeX Thesis Template

This project is a reusable, multi-file dissertation template. It demonstrates how to organize a thesis in LaTeX while keeping front matter, chapters, figures, references, appendices, and the vita in separate files. All names, committee information, publication entries, examples, figures, and numerical results are placeholders or fictional demonstrations.

> Important: The included `mstogs.cls` and `mstogs.bst` files originated from an institution-specific formatting system. Before submitting a dissertation, compare the compiled PDF with the latest requirements from your graduate school. Replace or revise the class and bibliography style if your institution uses different rules.

## Credits

This LaTeX dissertation template and accompanying user guide were developed by **Keiwan Soltani**, Ph.D. Candidate in Computer Science and Graduate Assistant at the Writing and Communication Center, under the supervision of **Dr. Jossalyn Gale**.

## Quick Start

1. Upload the complete project folder or ZIP file to Overleaf.
2. Open **Menu → Main document** and select `thesis_main.tex`.
3. Use pdfLaTeX as the compiler unless your institution or fonts require another engine.
4. Compile the project.
5. Replace placeholder metadata and sample text one file at a time.
6. Compile frequently and resolve warnings before final submission.

For local compilation, a TeX distribution with `latexmk`, `pdflatex`, BibTeX, and the packages used by `thesis_main.tex` is required. Run:

```bash
make
```

or:

```bash
latexmk -pdf thesis_main.tex
```

The `Makefile` also provides `make clean` to remove generated build files.

## Project Tree

```text
Generic_LaTeX_Thesis_Template/
├── thesis_main.tex                 # Main compilation file and document structure
├── mstogs.cls                      # Institution-specific document class
├── mstogs.bst                      # Optional institution-specific bibliography style
├── ThesisRef.bib                   # BibTeX reference database
├── abstract.tex                    # Abstract text
├── acknowledgement.tex             # Acknowledgment text
├── publications.tex                # Publications/scholarly products appendix
├── vita.tex                        # Short third-person biography
├── Introduction/
│   └── main.tex                    # Introduction chapter
├── Literature_Review/
│   └── main.tex                    # Literature review chapter
├── paper1/
│   ├── main.tex                    # Example study: model, equation, table, figure
│   └── figs/
│       ├── Graph.tex               # Standalone TikZ source
│       └── Makefile                # Optional local figure build command
├── paper2/
│   ├── main.tex                    # Example study: algorithm, theorem, proof
│   └── figs/                       # Place chapter-specific figures here
├── paper3/
│   ├── main.tex                    # Example study: experiment and PGFPlots chart
│   └── figs/                       # Place chapter-specific figures here
├── Conclusion/
│   └── main.tex                    # Conclusion and future work
├── Makefile                        # Local build commands
├── .gitignore                      # Excludes generated LaTeX files from Git
└── README.md                       # This user manual
```

## 1. The Main File: `thesis_main.tex`

`thesis_main.tex` is the entry point for the entire project. Compile this file to generate the complete dissertation. It performs four main jobs:

1. selects the document class and global formatting;
2. loads packages and defines reusable environments;
3. provides title-page and front-matter information; and
4. calls every chapter, appendix, bibliography, and vita file in order.

### Document class and global spacing

The document begins with:

```latex
\documentclass[12pt]{mstogs}
\doublespacing
```

The class controls institution-specific page design, title-page commands, front matter, chapter formatting, and other requirements. The option requests 12-point text, while the class's `ThesisTitlePage` environment creates the title page. Global double spacing is enabled by `\doublespacing`. The class also supports a `times` option, but that option requires the `newtxtext` and `newtxmath` packages; enable it only when those packages are installed and the selected institutional style requires them.

Do not assume that this class meets another university's current requirements. If your graduate school provides an official class or Overleaf template, use that class and adapt the chapter organization described here.

### Package management

Packages should normally be loaded in the preamble of `thesis_main.tex`, before `\begin{document}`. Keeping package calls in one place avoids repeated loading and conflicting options.

Examples from this project include:

```latex
\usepackage{amsmath,amsfonts,amssymb} % equations and mathematical symbols
\usepackage{amsthm}                  % theorem and proof environments
\usepackage{graphicx}                % external graphics
\usepackage{booktabs}                % improved table rules
\usepackage{listings}                % source-code listings
\usepackage{tikz}                    % diagrams created in LaTeX
\usepackage{pgfplots}                % data plots created in LaTeX
\usepackage[numbers,sort]{natbib}    % citations and bibliography
```

Only add a package when the project needs it. If a package requires options, pass the options in the same `\usepackage` call. When a command is undefined, consult that command's package documentation before adding unrelated packages.

### Theorem-family environments

The preamble defines reusable theorem environments:

```latex
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
```

The bracketed `[theorem]` means that lemmas and corollaries share the theorem counter. If a discipline requires numbering by chapter or section, adjust these definitions according to the `amsthm` documentation and institutional rules.

## 2. Title Page and Author Metadata

The title page is defined in `thesis_main.tex`:

```latex
\begin{ThesisTitlePage}{PhD}
\author{\MakeUppercase{Student Name}}
\thesistitle{\MakeUppercase{A General Demonstration of Thesis Writing with LaTeX}}
\department{Department Name}
\ThesisAdvisor{Advisor Name, Advisor}
\ThesisCommittee{%
Committee Member One\\%
Committee Member Two\\%
Committee Member Three}
\graddate{20XX}
\end{ThesisTitlePage}
```

Replace every placeholder. The argument `{PhD}` identifies the degree type used by the class; use the value required by the class documentation. Enter the graduation year rather than the manuscript submission date if that is what the graduate school requires.

The copyright page is controlled by:

```latex
\copyrightyear{20XX}
\ThesisCopyrightPage{true}
```

Change `true` to `false` only if the class and graduate-school instructions allow the copyright page to be omitted.

## 3. Front Matter

### Abstract

The abstract text is stored in `abstract.tex` and inserted with:

```latex
\begin{ThesisAbstract}
\input{abstract}
\end{ThesisAbstract}
```

Edit `abstract.tex`, not the wrapper in `thesis_main.tex`, unless the class structure must change. A dissertation abstract generally states the problem, purpose, methods, central findings, and contribution within the institution's word limit.

### Acknowledgments

The acknowledgments are stored in `acknowledgement.tex` and inserted with:

```latex
\begin{ThesisAcknowledgment}
\input{acknowledgement}
\end{ThesisAcknowledgment}
```

Check whether your institution uses “Acknowledgment” or “Acknowledgments” and whether funding statements must follow specific wording.

### Contents, figures, tables, and symbols

The remaining front matter is generated automatically:

```latex
\begin{ThesisFrontMatter}
\tableofcontents
\listoffigures
\listoftables
\listofsymbols{false}
\end{ThesisFrontMatter}
```

LaTeX builds the table of contents from chapter and section commands, the list of figures from figure captions, and the list of tables from table captions. These lists often require more than one compilation to update correctly.

Symbols are introduced in chapter files with entries such as:

```latex
\nomenclature{$n$}{Number of observations}
```

Nomenclature generation may require an additional indexing command, depending on the class and Overleaf configuration. If the symbol list remains empty, consult the `nomencl` package instructions and the class documentation.

## 4. Dissertation Body and Chapter Files

All main chapters appear between:

```latex
\begin{ThesisBody}
...
\end{ThesisBody}
```

A chapter is called with three lines:

```latex
\ThesisBodyChapter{Introduction}
\label{ch:introduction}
\input{Introduction/main}
```

These lines have distinct jobs:

- `\ThesisBodyChapter{Introduction}` creates the chapter and determines its displayed title.
- `\label{ch:introduction}` creates a stable cross-reference key.
- `\input{Introduction/main}` inserts `Introduction/main.tex` at that location.

Later text can refer to the chapter with:

```latex
Chapter~\ref{ch:introduction}
```

The nonbreaking space `~` keeps the word “Chapter” and its number on the same line. Never type a chapter number manually; references update automatically when chapters move.

### Adding a new chapter

1. Create a descriptive folder, such as `Methodology`.
2. Create `Methodology/main.tex`.
3. Add the following block at the desired position inside `ThesisBody`:

```latex
\ThesisBodyChapter{Methodology}
\label{ch:methodology}
\input{Methodology/main}
```

4. Compile twice and verify the chapter title, table of contents, page numbering, and references.

### Removing a chapter

Remove or comment out the three-line chapter block in `thesis_main.tex`. The chapter file may remain in the project as an archive, but deleting unused files and figures makes a public repository easier to understand. Never delete material you may need without keeping a version-control history or backup.

## 5. Sections and Subsections

Inside a chapter's `main.tex`, organize content with semantic commands:

```latex
\section{Research Design}
\subsection{Data Collection}
\subsubsection{Sampling Procedure}
```

Avoid manually bolding a line to imitate a heading. Semantic section commands ensure consistent styling and allow the heading to appear in navigation and the table of contents according to class settings.

Use short, descriptive headings that reveal the chapter's argument. Very deep heading levels can make a dissertation difficult to navigate, so use `\subsubsection` only when the additional level genuinely improves structure.

## 6. Labels and Cross-References

Labels let LaTeX manage numbering. Use unique, descriptive prefixes:

| Element | Recommended prefix | Example |
|---|---|---|
| Chapter | `ch:` | `\label{ch:conclusion}` |
| Section | `sec:` | `\label{sec:data-collection}` |
| Figure | `fig:` | `\label{fig:research-process}` |
| Table | `tab:` | `\label{tab:sample-results}` |
| Equation | `eq:` | `\label{eq:weighted-score}` |
| Algorithm | `alg:` | `\label{alg:select-best}` |
| Theorem | `thm:` | `\label{thm:maximum}` |

Reference numbered elements with `\ref{...}`. Use `\eqref{...}` for equations because it includes parentheses:

```latex
Figure~\ref{fig:research-process}
Table~\ref{tab:sample-results}
Equation~\eqref{eq:weighted-score}
```

Place a figure or table label immediately after its caption. Duplicate labels and undefined references appear as warnings in the compilation log and should be corrected.

## 7. Equations and Mathematical Notation

A numbered equation can be written as:

```latex
\begin{equation}
\label{eq:sample-model}
Z = \alpha A + \beta B + C.
\end{equation}
```

Refer to it with:

```latex
Equation~\eqref{eq:sample-model}
```

Use inline math for short expressions such as `\(n=10\)`. Use displayed environments for important equations. The `align` environment is useful for multiple aligned lines:

```latex
\begin{align}
x &= a+b, \\
y &= c+d.
\end{align}
```

Define every symbol near its first use, use notation consistently, and punctuate displayed equations as part of the surrounding sentence.

## 8. Figures

### External image files

Store each chapter's figures in that chapter's figure folder. For example, a figure for the first study belongs in `paper1/figs/`. Use portable formats:

- PDF for vector plots and diagrams;
- PNG for screenshots or raster graphics with transparency;
- JPG for photographs when appropriate.

Include an external figure with:

```latex
\begin{figure}[ht]
    \centering
    \includegraphics[width=0.9\textwidth]{paper1/figs/example-figure.pdf}
    \caption{A descriptive caption that explains the figure.}
    \label{fig:example-figure}
\end{figure}
```

The path is relative to `thesis_main.tex`, not to the chapter file that contains the command. Avoid spaces and unusual characters in filenames. Use lowercase, descriptive names such as `system-architecture.pdf`.

The placement specifier `[ht]` asks LaTeX to place the figure approximately “here” or at the top of a page. LaTeX may move floats to preserve good page layout. Use `[H]` from the `float` package sparingly because forced placement can create large blank areas.

### TikZ diagrams inside a chapter

TikZ creates diagrams as LaTeX code. `Introduction/main.tex` contains an inline workflow example. This method keeps fonts and vector rendering consistent with the dissertation.

### Standalone TikZ figures

For a complex diagram, create a standalone source such as `paper1/figs/Graph.tex`:

```latex
\documentclass[tikz,border=6pt]{standalone}
\usepackage{tikz}
\begin{document}
% TikZ diagram
\end{document}
```

Compile it independently to inspect the result. The dissertation includes it with:

```latex
\begin{figure}[ht]
    \centering
    \includestandalone[width=0.95\textwidth]{paper1/figs/Graph}
    \caption{A generic research process created in TikZ.}
    \label{fig:research-process}
\end{figure}
```

The provided figure-level `Makefile` can build `Graph.pdf` locally. Overleaf usually handles the standalone source when the relevant package and settings are available. If it does not, compile `Graph.tex` and include the resulting PDF with `\includegraphics`.

For TikZ learning resources, see the official package documentation or Overleaf's [TikZ package guide](https://www.overleaf.com/learn/latex/TikZ_package).

### PGFPlots charts

`paper3/main.tex` demonstrates a line chart created with PGFPlots. This is suitable for small, maintainable datasets. When analysis involves many values, transformations, confidence intervals, or specialized statistical graphics, generate the plot from the analysis code and export a vector PDF whenever possible.

Every plot must have readable axis labels, units, legend entries, and a caption. Do not use the fictional values included in this template as evidence.

## 9. Tables

A simple table can be written as:

```latex
\begin{table}[ht]
\centering
\caption{Sample performance results.}
\label{tab:sample-results}
\footnotesize
\resizebox{\columnwidth}{!}{%
\begin{tabular}{l|cc}
\hline
\textbf{Method} & \textbf{Accuracy (\%)} & \textbf{Runtime (s)} \\
\hline
Baseline & 82.5 & 15.3 \\
Method A & 87.9 & 12.8 \\
Method B & 90.4 & 10.6 \\
Proposed & 93.1 & 9.4 \\
\hline
\end{tabular}}
\end{table}
```

In the column definition `{l|cc}`, `l` creates a left-aligned column and each `c` creates a centered column. Other common choices are `r` for right alignment and `p{width}` for a paragraph column with a fixed width.

Use `\resizebox` only when necessary. A table that must be dramatically reduced may contain too many columns; consider splitting or redesigning it. Explain the most important result in the body text and do not repeat every value from the table.

## 10. Algorithms

The project creates a numbered algorithm float with the `float` package and formats its steps with ordinary LaTeX lists. The preamble contains:

```latex
\newfloat{algorithm}{htbp}{loa}
\floatname{algorithm}{Algorithm}
```

A basic algorithm has the following form:

```latex
\begin{algorithm}[ht]
\caption{Descriptive algorithm name}
\label{alg:example}
\begin{minipage}{0.94\textwidth}
\textbf{Input:} Required input\\
\textbf{Output:} Produced output
\begin{enumerate}
    \item First step.
    \item Second step.
\end{enumerate}
\end{minipage}
\end{algorithm}
```

`paper2/main.tex` provides a complete loop and conditional example. For more advanced pseudocode, a project may instead use `algorithm2e`, `algorithmic`, or `algpseudocode` when the selected TeX installation provides it. Do not load two packages that define conflicting `algorithm` environments without understanding the conflict. Standardize the dissertation on one algorithm system whenever possible.

## 11. Theorems, Lemmas, Corollaries, and Proofs

After the environments are defined in the preamble, use them in a chapter:

```latex
\begin{theorem}
\label{thm:example}
State the claim and its assumptions precisely.
\end{theorem}

\begin{proof}
Provide a logical argument that establishes the claim.
\end{proof}
```

The same pattern applies to `lemma` and `corollary`. Refer to a result with `Theorem~\ref{thm:example}`. Formal claims should be integrated into the chapter's argument: explain why each result is needed and what it implies.

## 12. References and `ThesisRef.bib`

`ThesisRef.bib` contains every bibliographic record cited in the dissertation. A book entry looks like:

```bibtex
@book{lamport1994latex,
  author    = {Leslie Lamport},
  title     = {LaTeX: A Document Preparation System},
  edition   = {2},
  publisher = {Addison-Wesley},
  year      = {1994}
}
```

The key `lamport1994latex` is used in chapter text:

```latex
\cite{lamport1994latex}
```

The bibliography is created near the end of `thesis_main.tex`:

```latex
\begin{ThesisBibliography}{REFERENCES}
\bibliographystyle{unsrtnat}
\singlespacing
\bibliography{ThesisRef}
\end{ThesisBibliography}
```

`unsrtnat` produces a numerical list in citation order. The template also includes `mstogs.bst`, but it is not active. Select a bibliography style only after checking institutional and disciplinary requirements.

Recommended reference-management practices:

- obtain metadata from a reliable source and verify it against the publication;
- include DOI information when appropriate;
- protect capitalization in technical terms with braces, such as `{LaTeX}`;
- use one unique key per source;
- remove duplicate entries; and
- never cite a source that has not been read and checked.

## 13. Publications Appendix

The template creates one appendix:

```latex
\begin{ThesisAppendix}{one}{false}{false}
\ThesisAppendixChapter{Publications}
\input{publications}
\end{ThesisAppendix}
```

Edit `publications.tex` to list only the scholarly products allowed by the graduate school. If the dissertation has no publication list or the list belongs elsewhere, remove or revise this appendix block. If you add multiple appendices, consult the class documentation because the first argument and boolean options are class-specific.

## 14. Vita

The final biographical section is inserted with:

```latex
\begin{Vita}
\input{vita}
\end{Vita}
```

Write the vita in `vita.tex`. The sample uses a brief third-person paragraph. Follow institutional guidance about length and acceptable personal information. Do not include private contact details or information that should not appear in a public dissertation.

## 15. Adapting Published Papers as Chapters

A paper-based dissertation still needs to read as one coherent work. When converting a paper into a chapter:

1. place the chapter text in its own folder and `main.tex` file;
2. move its figures to that chapter's figure folder;
3. remove the paper's independent `\documentclass`, `\begin{document}`, and `\end{document}` commands;
4. remove duplicate package calls and move required packages to `thesis_main.tex`;
5. change the paper title into the chapter title in `thesis_main.tex`;
6. make every label unique across the dissertation;
7. merge bibliography entries into `ThesisRef.bib` and remove duplicates;
8. revise terminology, notation, introductions, and conclusions for consistency; and
9. add transitions that explain how the chapter advances the dissertation's overall argument.

If copyright or publisher permissions apply, follow the graduate school's and publisher's requirements for attribution and reuse.

## 16. Compilation Process

LaTeX often needs several passes:

1. LaTeX reads the structure and writes auxiliary information.
2. BibTeX creates the bibliography from cited entries.
3. LaTeX inserts citations and references.
4. A final LaTeX pass stabilizes page numbers and the table of contents.

`latexmk` automates these passes:

```bash
latexmk -pdf thesis_main.tex
```

In Overleaf, click **Recompile** and inspect both the PDF and log. If references remain unresolved after a successful compile, use **Recompile from scratch** after checking labels and BibTeX keys.

## 17. Common Problems and Troubleshooting

### Overleaf compiles the wrong file

Set `thesis_main.tex` as the Main document in the Overleaf menu.

### “File not found”

Check spelling, capitalization, folder names, and the extension. Overleaf paths are case-sensitive. Paths in this project are written relative to `thesis_main.tex`.

### Undefined control sequence

The command may be misspelled, the required package may be missing, or a command may belong to a paper's original document class. Read the first relevant error in the log; later errors may be consequences of the first one.

### Undefined citations

Confirm that the citation key in `\cite{...}` exactly matches an entry in `ThesisRef.bib`. Check that the `.bib` entry has balanced braces and valid syntax.

### Undefined references or `??` in the PDF

Confirm that the label exists, is unique, and is spelled exactly the same in `\ref{...}`. Compile again after fixing it.

### Figure appears in an unexpected location

Figures and tables are floats. Try a reasonable placement option such as `[htbp]`, shorten the figure, or move the source command near the paragraph that first discusses it. Avoid forcing every float with `[H]`.

### Figure is too large or blurry

Adjust the width, for example `width=0.8\textwidth`. Prefer vector PDF for plots and diagrams. Export raster images at sufficient resolution and avoid enlarging a small screenshot.

### Package option clash

Search the preamble and class file to determine whether the package is loaded more than once with different options. Load it once with the needed options whenever the class permits.

### Bibliography or contents are stale

Use `latexmk`, compile multiple times, or recompile from scratch. Generated auxiliary files can preserve stale information after major structural changes.

## 18. GitHub and Version-Control Practices

The included `.gitignore` excludes common LaTeX build products while keeping source files, bibliography records, and figures under version control.

Recommended practices:

- commit small, meaningful changes;
- use descriptive messages such as `Revise literature review synthesis`;
- create branches for major restructuring;
- avoid committing temporary or private data;
- keep figures and analysis code linked by clear filenames;
- tag major milestones, such as proposal, committee draft, and final submission; and
- use repository access controls appropriate to unpublished research.

Do not store credentials, private participant data, copyrighted source files, or confidential reviewer material in a public repository.

## 19. File-by-File Editing Guide

| File | Edit when you need to... | Avoid placing here... |
|---|---|---|
| `thesis_main.tex` | change global packages, metadata, chapter order, bibliography style | long chapter prose |
| `abstract.tex` | revise the dissertation abstract | title-page metadata |
| `acknowledgement.tex` | revise acknowledgments and funding recognition | chapter content |
| `Introduction/main.tex` | write the problem, questions, contributions, and roadmap | unrelated literature detail |
| `Literature_Review/main.tex` | synthesize prior scholarship and establish the gap | raw reference records |
| `paper1/main.tex` | write the first study or substantive chapter | other chapters' figures |
| `paper2/main.tex` | write the second study or substantive chapter | package calls |
| `paper3/main.tex` | write the third study or substantive chapter | generated build files |
| `Conclusion/main.tex` | synthesize findings, limitations, implications, and future work | entirely new unexamined results |
| `ThesisRef.bib` | add and correct BibTeX records | prose or citation commands |
| `publications.tex` | list approved scholarly products | full bibliography entries |
| `vita.tex` | provide the required short biography | sensitive personal information |
| chapter `figs/` folders | store figures used by that chapter | unrelated source documents |

## 20. Pre-Submission Checklist

### Content

- [ ] All placeholder names, dates, titles, and sample values have been replaced.
- [ ] Research questions align with methods, results, and conclusions.
- [ ] Each chapter supports the dissertation's overall contribution.
- [ ] Reused publication material is revised for coherence and properly attributed.
- [ ] Limitations are specific and accurately constrain the claims.

### References and navigation

- [ ] Every citation resolves and every bibliography entry is accurate.
- [ ] No duplicate labels or undefined references remain.
- [ ] Chapter, figure, table, equation, algorithm, and theorem numbers update correctly.
- [ ] The table of contents and lists of figures/tables match the document.

### Figures and tables

- [ ] Every figure and table is mentioned in the text.
- [ ] Captions are descriptive and consistent.
- [ ] Text, legends, and axis labels remain readable at normal page size.
- [ ] Units, sample sizes, uncertainty, and data sources are reported where needed.
- [ ] Permissions and attribution requirements have been satisfied.

### Formatting and delivery

- [ ] The current graduate-school formatting guide has been checked.
- [ ] Title page, abstract, acknowledgments, bibliography, appendix, and vita follow policy.
- [ ] Page numbers, margins, spacing, and heading levels are correct.
- [ ] The project compiles from `thesis_main.tex` without errors.
- [ ] The final PDF has been inspected page by page.
- [ ] The submitted ZIP includes all source files and figures required to reproduce the PDF.

## License and Reuse

Add an explicit license before publishing this template on GitHub. The document class and bibliography style may have their own license or distribution terms; review those files and their source before redistributing them. A repository license for the surrounding example content does not automatically override third-party terms.

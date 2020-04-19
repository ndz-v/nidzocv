% !TEX program = lualatex
% !TEX root = ../main.tex
% !TEX options = -synctex=1 -interaction=nonstopmode -file-line-error "%DOC%"

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{scrbook}%
}
\ProcessOptions\relax

\LoadClass{article}

\input{preamble/packages.tex}
\input{preamble/commands.tex}
\input{preamble/margins.tex}
\input{preamble/pgfkeys.tex}
\input{preamble/styles.tex}
\input{preamble/coverletterenv.tex}
\input{preamble/sidebarenv.tex}
\input{preamble/bodyenv.tex}

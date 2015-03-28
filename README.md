#Paper Collection Template for PhD Thesis
In this folder you will find the `uisthesis.cls` paper collection thesis
template for the University of Stavanger. The template is based on
`book.cls`, and it was adapted for UiS by Morten Mossige and Hein Meling,
2015, based on a template for University of Oslo.


#Contributing
LaTeX templates are never finished. If you make a change to the template
or structure, or add some new feature. And of course, if you remove an
obsolete feature: submit the change as a Pull request. 

If you have a request for a feature or have found a bug/issue, then you
can report this as an Issue on Github.


#Documentation
Construct a thesis.tex file that uses this class along with the following
directory structure. All files in [] are optional; instead you can define
a global bibliography file, see below. The number of included papers is
flexible; we use 3 here.

##Directory Structure
```
src/
  thesis.tex
  preface.tex
  introduction/
    body.tex
   [bibliography.bib]
   [graphics/]
      [pictures.pdf]
  paperI/
    body.tex
   [bibliography.bib]
  paperII/
    body.tex
   [bibliography.bib]
  paperIII/
    body.tex
   [bibliography.bib]
```


##Compiling

To compile your thesis (on a proper operating system):

```sh
  latexmk -pdf thesis
```

To clean up (deletes generated files, except `.pdf`):

```sh
  latexmk -c
  rm -rf `biber --cache`
```

Or you can also do:

```sh
  pdflatex thesis
  biber thesis
  pdflatex thesis
  pdflatex thesis
```

**Note:** The template uses the `biblatex` package along with the `biber`
tool to compile multiple *Reference* sections. Note also that the template
is design to generate pdf only, and hence the `-pdf` option to `latexmk`
is required.

Or on Windows:

```bat
  "C:\Program Files (x86)\MiKTeX 2.9\miktex\bin\texify.exe"
     --pdf --tex-option=-synctex=-1 --tex-option=-shell-escape
     --run-viewer "thesis.tex"
  biber thesis
```


##Class Options:

```
alternative (choose only one):
   done         final thing
   layout       final, but black boxes for overwide lines
   date         final, but with date
   proof        wide margins, line skips, date

independent: 
   showtags     show \label's, \rem's and \think's
   showcomments show only \rem's and \think's
   showhead     display some info in the header
   nofigures    turn off figures 
   hyperref     activate hyperref
```


##Specific Thesis Commands:

```latex
\thesisbibliography   Defines a global bibliography file. By default local 
                      bibliography files are used.

\defaultbibliographystyle 
                      Defines a global bibliography style.
                      If \bibliographystyle is called inside a body.tex this
                      will be used locally. The class is using biblatex with
                      the biber as the backend.

\titlepage            Insert a title page, with UiS specific information.

\copyrightpage        Insert a copyright page, with UiS specific information.
                      ISBN, ISSN, and thesis no. will be given to you in the
                      final stages before you submit your thesis.

\inputpreface         Call this to import the content of preface.tex.
                      A special preface chapter will be created.

\tableofcontents      Insert table of contents and clear a double page.

\listofpapers         Insert the list of papers, added through the paper
                      environment.

\inputintroduction    Import the introduction. Reads body.tex from the 
                      introduction folder. Includes in this files is
                      relative to the introduction folder (using import).
```


The paper environment consist of the following options:

```latex
\begin{paper}{Paper title}
  \paperauthor{Author One}{1}
  \paperauthor{Author Two}{1,2}
  \published{Where the paper is (going to be) published}
  \institute{The name of institute 1}{The address to institute 1}
  \institute{The name of institute 2}{The address to institute 2}
\end{paper}
```

```latex
\paperauthor          Add author to the paper. The authors are added in the
                      order they should appear. The second argument points
                      to the institution of the author.

\published            Where is the paper (going to be) published.

\institute            The department of the authors. The order of these
                      definitions must correspond to the numbers specified
                      in \paperauthor command.

\suppressinput        Placed before \inputintroduction, or a paper 
                      environment to suppress the import of the relevant 
                      body.tex file.

\nobibliography       Issue this command before a paper environment
                      to suppress errors due to missing bibliography.
```


##Miscellaneous Commands:

```latex
\nextfloatevenpage    Place next float on an even page (hope so ...)

\continuecaption[]{}  If caption is too long for one page, remainder can be
                      placed at bottom of following page like a footnote;
                      Must be placed IMMEDIATELY after \end{figure}.
                      Optional arguments see \rightcaption.

\rightcaption[]{}     Create a figure caption without creating an entry in
                      the list of figures or advancing the figure counter.
                      Figure number will be that of preceeding figure.
                      If optional entry is missing, caption begins with 
                          Figure X.XX(continued):
                      otherwise with
                          Figure X.XX#1:

\rem{}                put remark on margin, with showtags only

\think{}              put longer, boxed remark in middle of text,
                      with showtags only

\longpage             lengthen/shorten page by
\shortpage             +-\baselineskip

\forcehyperanchor     hyperref does not notice References, this
                      command forces recognition
```

##License

 Copyright (C) 2015 Morten Mossige, Hein Meling.
 Copyright (C) 2009 Johan Hake, Hans Eckhard Plesser, Martin Alnæs.

 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

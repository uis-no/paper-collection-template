%
%  uisthesis.cls
% 
%  Class for writing a UiS PhD thesis, based on book.cls
%  Adapted for UiS by Morten Mossige and Hein Meling, 2015.
%  Original version by Johan Hake, Oslo, 2009 
%  Based on previuos work by Hans E. Plesser and Martin Alnæs.
%
%  Construct a thesis.tex file that uses this class along with the following
%  directory structure. All files in [] are optional; instead you can define
%  a global bibliography file, see below. The number of included papers is
%  flexible; we use 3 here.
%
%  src/
%    thesis.tex
%    preface.tex
%    introduction/
%      body.tex
%     [bibliography.bib]
%     [graphics/]
%        [pictures.pdf]
%    paperI/
%      body.tex
%     [bibliography.bib]
%    paperII/
%      body.tex
%     [bibliography.bib]
%    paperIII/
%      body.tex
%     [bibliography.bib]
%
%
%  CLASS OPTIONS:
%
%  alternative (choose only one):
%     done         final thing
%     layout       final, but black boxes for overwide lines
%     date         final, but with date
%     proof        wide margins, line skips, date
%
%  independent: 
%     showtags     show \label's, \rem's and \think's
%     showcomments show only \rem's and \think's
%     showhead     display some info in the header
%     nofigures    turn off figures 
%     hyperref     activate hyperref
%
%
%  SPECIFIC THESIS COMMANDS:
% 
%  \thesisbibliography   Defines a global bibliography file. By default local 
%                        bibliography files are used.
%
%  \defaultbibliographystyle 
%                        Defines a global bibliography style.
%                        If \bibliographystyle is called inside a body.tex this
%                        will be used locally. The class is using biblatex with
%                        the biber as the backend.
%
%  \titlepage            Insert a titlepage, with UiS specific information.
%
%  \inputpreface         Call this to import the content of preface.tex.
%                        A special preface chapter will be created.
%
%  \tableofcontents      Insert table of contents and clear a double page.
%
%  \listofpapers         Insert the list of papers, added through the paper
%                        environment.
%                      
%  \inputintroduction    Import the introduction. Reads body.tex from the 
%                        introduction folder. Includes in this files is
%                        relative to the introduction folder (using import).
%
%  The paper environment consist of the following options:
%
%  \begin{paper}{Paper title}
%    \paperauthor{Author One}{1}
%    \paperauthor{Author Two}{1,2}
%    \published{Where the paper is (going to be) published}
%    \institute{The name of institute 1}{The address to institute 1}
%    \institute{The name of institute 2}{The address to institute 2}
%  \end{paper}
%
%  \paperauthor          Add author to the paper. The authors are added in the
%                        order they should appear. The second argument points
%                        to the insitution of the author.
%
%  \published            Where is the paper (going to be) published.
%
%  \institute            The department of the authors. The order of these
%                        definitions must correspond to the numbers specified
%                        in \paperauthor command.
%
%  \suppressinput        Placed before \inputintroduction, or a paper 
%                        environment to suppress the import of the relevant 
%                        body.tex file.
% 
%  \nobibliography       Issue this command before a paper environment
%                        to suppress errors due to missing bibliography.
%
%
%  COMPILING
%
%  To compile your thesis (on a proper operating system):
%
%  > biber thesis
%  > pdflatex thesis
%
%  Or on Windows:
%
%  > biber thesis
%  > "C:\Program Files (x86)\MiKTeX 2.9\miktex\bin\texify.exe"
%       --pdf --tex-option=-synctex=-1 --tex-option=-shell-escape
%       --run-viewer "thesis.tex"
%
%
%  MISCELLANEOUS COMMANDS:
% 
%  \nextfloatevenpage    Place next float on an even page (hope so ...)
%
%  \continuecaption[]{}  If caption is too long for one page, remainder can be
%                        placed at bottom of following page like a footnote;
%                        Must be placed IMMEDIATELY after \end{figure}.
%                        Optional arguments see \rightcaption.
%  
%  \rightcaption[]{}     Create a figure caption without creating an entry in
%                        the list of figures or advancing the figure counter.
%                        Figure number will be that of preceeding figure.
%                        If optional entry is missing, caption begins with 
%                            Figure X.XX(continued):
%                        otherwise with
%                            Figure X.XX#1:
%
%  \rem{}                put remark on margin, with showtags only
%
%  \think{}              put longer, boxed remark in middle of text,
%                        with showtags only
%
%  \longpage             lengthen/shorten page by
%  \shortpage             +-\baselineskip
%
%  \forcehyperanchor     hyperref does not notice References, this
%                        command forces recognition
%
%
%   Copyright (C) 2015 Morten Mossige, Hein Meling
%   Copyright (C) 2009 Johan Hake, Hans Eckhard Plesser
%
%   This program is free software; you can redistribute it and/or
%   modify it under the terms of the GNU General Public License
%   as published by the Free Software Foundation; either version 2
%   of the License, or (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with this program; if not, write to the Free Software
%   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

%%%%%%%%%%%%%%%%%% IDENTIFICATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make sure we require a Latex not older than the one used in development
\NeedsTeXFormat{LaTeX2e}[1996/06/01]
\ProvidesClass{uisthesis}[2015/03/27 UiS thesis class by Morten Mossige and Hein Meling]

%%%%%%%%%%%%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load packages that will be needed in uisthesis.cls
\RequirePackage{calc}[1995/04/10]
\RequirePackage{ifthen}
\RequirePackage{xspace}

%%%%%%%%%%%%%%%%%% DECLARE OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% de-activate standard draft and final options, as they cause confusion
\DeclareOption{draft}{\OptionNotUsed}
\DeclareOption{final}{\OptionNotUsed}

% done: final layout, no date, no keys etc
\DeclareOption{done}{\def\thesis@layout{FINAL}%
                       \def\thesis@date{HIDE}%
                       \def\thesis@labels{HIDE}
                       \def\thesis@comments{HIDE}}

% Layout control, like dfinal, but black boxes for overwide lines
\DeclareOption{layout}{\def\thesis@layout{FINAL}%
                        \def\thesis@date{HIDE}%
                        \def\thesis@labels{HIDE}%
                        \def\thesis@comments{HIDE}
                        \PassOptionsToClass{draft}{book}}

% Final layout, dated
\DeclareOption{date}{\def\thesis@layout{FINAL}%
                      \def\thesis@date{SHOW}%
                      \def\thesis@labels{HIDE}
                      \def\thesis@comments{HIDE}}

% Proof layout for others, wide margins and spacing, data
\DeclareOption{proof}{\def\thesis@layout{PROOF}%
                       \def\thesis@date{SHOW}%
                       \def\thesis@labels{HIDE}
                       \def\thesis@comments{HIDE}}

% \labels, \thinks, \rems are switched independent of layout option
\DeclareOption{showtags}{\def\thesis@labels{SHOW}
                         \def\thesis@comments{SHOW}}

\DeclareOption{showcomments}{\def\thesis@comments{SHOW}}

% EPS figures are switched independently of layout option
\DeclareOption{nofigures}{\PassOptionsToPackage{draft}{graphicx}}

% PDF generation requires some attention
\newboolean{thesis@hyperref}
\DeclareOption{hyperref}{\setboolean{thesis@hyperref}{true}}

% pass unused options to book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}


%%%%%%%%%%%%%%%%%% EXECUTE OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default is date
\ExecuteOptions{date}
\ProcessOptions\relax


%%%%%%%%%%%%%%%%%% LOAD BASE CLASS & PACKAGES %%%%%%%%%%%%%%%%%%

\LoadClass[a4paper]{book}
\RequirePackage[T1]{fontenc}
\RequirePackage{ae,aecompl}
\RequirePackage[protrusion=true,expansion=true]{microtype} % Improve spacing
\RequirePackage{ifpdf}
\RequirePackage[backend=biber, refsection=chapter, natbib=true]{biblatex}
\RequirePackage[american]{babel}         % need some Swedish or not...
\RequirePackage{fancyhdr}                % flexible headings
\RequirePackage{fancyvrb}                % flexible listings
\RequirePackage{amsmath}                 % powerful math with AMS LaTeX 
\RequirePackage{amssymb}               
\RequirePackage{amsbsy}
\RequirePackage{amsthm}
\RequirePackage{amsfonts}
\RequirePackage{graphicx}
\RequirePackage{float}                   % added flexibility for floats
\RequirePackage{array}                   % better arrays, tabulars
\RequirePackage[figuresright]{rotating}  % landscape figures
\RequirePackage{longtable}               % multi-page tables
\RequirePackage{dcolumn}                 % fancy math table formatting
\RequirePackage{bm}
\RequirePackage{siunitx}                 % commands for number/unit formating
\RequirePackage{algorithm}
\RequirePackage{subfigure}
%\RequirePackage{subcaption} %%TODO: Should use subcaption
\RequirePackage{afterpage}
\RequirePackage[subfigure]{tocloft}
\RequirePackage{url}                     % nice formating of urls using \url
\RequirePackage{import}
\RequirePackage[footnotesize,bf]{caption}  % bold figure/table numbers
\RequirePackage{vmargin}
\ifthenelse{\equal{\thesis@labels}{SHOW}}% % show labels
   {\RequirePackage[notref,notcite]{showkeys}}%
   {\relax}
\ifthenelse{\boolean{thesis@hyperref}}%
{%
  \ifthenelse{\boolean{pdf}}
  {\RequirePackage[hypertexnames=false,pdftex]{hyperref}}%
  {\RequirePackage[hypertexnames=false,dvips]{hyperref}}%
}% hyperrefs for PDF
{\relax}
      

%%%%%%%%%%%%%%%%%% MAIN PART %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% some status information to be given before starting on document
\AtEndOfClass{%
  \typeout{*********** Layout   : \thesis@layout   ***********}
  \typeout{*********** Date     : \thesis@date     ***********}
  \typeout{*********** Comments : \thesis@comments ***********}
  \typeout{*********** Labels   : \thesis@labels   ***********}
  \ifthenelse{\boolean{pdf}}
  {\typeout{*********** PDF generation  ***********}}%
  {\relax}%
}

% make sure we start in English
\selectlanguage{american}

%--- Environments ---
%\DefineVerbatimEnvironment{code}{Verbatim}{commandchars=\\\{\}}

% Set page layout
\setpapersize{A4}
\setlength{\parskip}{0pt}
\setlength{\parindent}{12pt}

\ifthenelse{\equal{\thesis@layout}{FINAL}}
  {
    %% \setmarginsrb{leftmargin}{topmargin}{rightmargin}{bottommargin}%
    %% {headheight}{headsep}{footheight}{footskip}
    \setmarginsrb{3.0cm}{2.5cm}{2.5cm}{2.5cm}{15pt}{15pt}{15pt}{25pt}
    \setlength{\marginparwidth}{20mm}
  }
  {
    \setmarginsrb{3.0cm}{2.5cm}{4.5cm}{2.5cm}{15pt}{15pt}{12pt}{16pt}
    \setlength{\marginparwidth}{40mm}
    \renewcommand{\baselinestretch}{1.5}
  }


% minor changes to tables
\setlength{\extrarowheight}{2pt}
\setlength{\arrayrulewidth}{0.4pt}
\setlength{\doublerulesep}{0pt}
\setlength{\tabcolsep}{6pt}
\renewcommand{\arraystretch}{1.05}

% Command used to print tables
\newcommand{\tabfontsize}{\small}
\newcommand{\tabbaselinestretch}{2.0}
\newcommand{\normalbaselinestretch}{1}

% Defining some author and title information
\def\thesis@title{NOTSET}%
\def\thesis@shorttitle{NOTSET}%
\def\thesis@author{NOTSET}%
\def\thesis@shortauthor{NOTSET}%
\def\thesis@date{NOTSET}%

\renewcommand{\title}[2][NOTSET]{\gdef\@title{#2}\def\thesis@title{#2}%
                                  \ifthenelse{\equal{#1}{NOTSET}}%
                                   {\relax}{\def\thesis@shorttitle{#1}}}%
\renewcommand{\author}[2][NOTSET]{\gdef\@author{#2}\def\thesis@author{#2}%
                                  \ifthenelse{\equal{#1}{NOTSET}}%
                                   {\relax}{\def\thesis@shortauthor{#1}}}%
\renewcommand{\date}[1]{\gdef\@date{#1}\def\thesis@date{#1}}

%%% Commands to aquire author and title information
\newcommand{\thetitle}{\thesis@title}
\newcommand{\thedate}{\thesis@date}
\newcommand{\thethesisauthor}{\thesis@author}
\newcommand{\theshorttitle}{\thesis@shorttitle}
\newcommand{\thethesisshortauthor}{\thesis@shortauthor}

%%% Reset the counters
\newcommand\resetcounters{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \setcounter{equation}{0}%
  \setcounter{table}{0}%
  \setcounter{figure}{0}%
}

% Insert a hook to the thebibitemlist environment, \extrareflistcode
% Redefine this to get direct access to the bibitemenvironment. E.g.
% one can use 
%
%\renewcommand{\extrareflistcode}{
%  \setlength{\itemsep}{0pt}%
%  \setlength{\parsep}{0pt}%
%}
%
% to reduce any spacing between the bibitems in the reference list.
   
\newcommand{\extrareflistcode}{\relax}
\newcommand{\vtune}{\vspace{0em}}

%%% Define a boolean for local bibliographies defaults to true
\newboolean{thesis@uselocalbibliography} 
\setboolean{thesis@uselocalbibliography}{true}

\newcommand{\thesisbibliography}[1]{%
  \defaultbibliography{#1}
  \setboolean{thesis@uselocalbibliography}{false}
}

% Parameters for floats must be set at beginning of document
% to override defaults!
\AtBeginDocument{%
   \setcounter{bottomnumber}{1}            % for continued captions
   \setcounter{topnumber}{1}               % do not stack floats
   \setcounter{totalnumber}{2}             % do not stack floats
   \renewcommand{\textfraction}{0.1}       % allow large floats with text
   \renewcommand{\topfraction}{0.9}        % allow a lot at top
   \renewcommand{\bottomfraction}{0.4}     % allow continued captions
   \renewcommand{\floatpagefraction}{0.7}  % avoid empty pages
   \floatplacement{figure}{tp}             % no floats at bottom unless
   \floatplacement{table}{tp}              %   explicitly requested
   \pagestyle{empty}                       % start with no pagestyle
   %TODO Remove this when sure it works with biblatex
   %\let\stdthebibliography\thebibliography
   %\renewcommand{\thebibliography}{%
   %  \let\chapter\subsection
   %  \stdthebibliography}
   %\bibliographyunit[\chapter]
   %\bibliography*{bibliography}
   %\bibliographystyle*{siam}
   %\bibliographyunit
   %\defaultbibliographystyle{siam}

   %%% Add clear double page after tableofcontents and listofpapers
   \expandafter\def\expandafter
   \tableofcontents\expandafter{\tableofcontents\clearplaindoublepage}

   %%% Begin with roman page style
   \pagenumbering{roman}
}

\pagestyle{fancy}

% commands to enlarge/shrink current page
\newcommand{\longpage}{\enlargethispage{\baselineskip}}
\newcommand{\shortpage}{\enlargethispage{-\baselineskip}}

% place next float on even page
\newcommand{\nextfloatevenpage}{%
  \afterpage{%
     \clearpage%           get rid of pending floats after current page
     \ifthenelse{\isodd{\value{page}}}%  
        {\suppressfloats}%     no float on new, odd page
        {\relax}%
     }%
}

% right part of figure should have caption, but no LOF entry
\newcommand{\rightcaption}[2][(continued)]{%
 {\@makecaption{\figurename~\thefigure{}#1}{#2}}}

% continue caption on bottom of following page
\newcommand{\continuecaption}[2][(continued)]{%
  \begin{figure}[!b]
     \footnoterule
     \rightcaption[#1]{#2}    % no entry to figure list, no advanced counter
  \end{figure}}

% Activate fancy headings, define headers; footer follow below
%\cfoot{\bfseries \thepage}
%\lfoot{\relax}
%\rfoot{\relax}

% enumerate down to subsections
\setcounter{secnumdepth}{2}

% enumerate (i), (ii) ...
\renewcommand{\labelenumi}{(\roman{enumi})}

% auxiliary command for hyperref, creates anchors if not done automatically
%   only needed in PDF-mode, when hyperref is active
\ifthenelse{\boolean{thesis@hyperref}}%
  {\newcounter{hyperref@anchor@counter}%
   \newcommand{\forcehyperanchor}{\refstepcounter{hyperref@anchor@counter}}}%
  {\newcommand{\forcehyperanchor}{\relax}}

% If wanted, put date into box and set footers appropriately,
%   otherwise footers are empty
%   Counters defined outside to avoid spurious errors
\newcounter{hour} \newcounter{minute}
\ifthenelse{\equal{\thesis@date}{SHOW}}
  {
    % Box containing date and time of day, see LaTeX Begleiter, p. 490
    %  Make it a box, as \today and \time are fixed at start.
    \DeclareRobustCommand{\dateandtime}{%
      \setcounter{hour}{\time/60}%
      \setcounter{minute}{\time - \value{hour}*60}%
      % type out Date HH:MMh, adding leading zeros where needed 
      \today,~%
      \ifthenelse{\value{hour} < 10}{0\thehour:}{\thehour:}%
      \ifthenelse{\value{minute} < 10}{0\theminute{}}{\theminute{}}%
      }   % end dateandtime

      \rfoot{\footnotesize \dateandtime}
  }
  {
    \relax
  }
  

% If rems and thinks are to be shown, define appropriate
%   commands, otherwise set commads to \relax
%   Note: showkeys for showing labels is loaded above

\ifthenelse{\equal{\thesis@comments}{SHOW}}
{\DeclareRobustCommand{\rem}[1]{$^{\mathbf{*}}$\marginpar{\fbox{\parbox{0.9\marginparwidth}
                        {\raggedright$^{\mathbf{*}}$\scriptsize #1}}}}
   \DeclareRobustCommand{\think}[2][NOTSET]{\noindent\par\vspace{2ex}\par
                \centerline{ \fbox{\parbox{0.8\linewidth}{
                               \ifthenelse{\equal{#1}{NOTSET}}
                               {\ifthenelse{\equal{\thesis@shortauthor}{NOTSET}}
                               {\relax}{{\bfseries \footnotesize \thesis@shortauthor:}\\}}
                             {{\bfseries \footnotesize #1:}\\}
                             \footnotesize #2}}}\par\vspace{2ex}\par}
  }
  {
   \DeclareRobustCommand{\rem}[1]{\relax}
   \DeclareRobustCommand{\think}[1]{\relax}
  }

%%% Hard code the graphic path
\graphicspath{{graphics/}{figures/}}

%%% Use this to avoid page numbers on empty pages
\newcommand{\clearemptydoublepage}{\newpage{\pagestyle{empty}\cleardoublepage}}
\newcommand{\clearplaindoublepage}{\newpage{\pagestyle{plain}\cleardoublepage}}

%%% Returns the month and year
\newcommand{\shortdate}{%
  \ifcase\month \or%
  January\or February\or March\or April\or May\or June\or July\or%
  August\or September\or October\or November\or December\fi%
  \space\number\year}%

%%% Command to suppress input
\newboolean{thesis@suppressinput}
\newcommand{\suppressinput}{%
  \setboolean{thesis@suppressinput}{true}
}%

%%% Command to suppress bibliography
\newboolean{thesis@suppressbibliography} 
\setboolean{thesis@suppressbibliography}{false}
\newcommand{\nobibliography}{%
  \setboolean{thesis@suppressbibliography}{true}
}%


%%% Macros for setting the the numbering depth for the toc
\newcommand{\nonumX}{\setcounter{secnumdepth}{-2}}
\newcommand{\numX}{\setcounter{secnumdepth}{2}}

\setlength{\baselineskip}{13pt}
\setcounter{tocdepth}{1}

%%% Input a file containing the preface
\newcommand{\inputpreface}{
\pagestyle{plain}
%\nonumX \chapter{Preface}
\ifthenelse{\boolean{thesis@suppressinput}}%
  {\relax}%
  {\input{preface}}%
\numX
\setboolean{thesis@suppressinput}{false}
\clearplaindoublepage
}

%%% Make title page 
\renewcommand{\titlepage}{
\thispagestyle{empty}
\vspace*{2.5cm}
\begin{center}
\Large{\textbf{\thetitle}}
\end{center}
\vspace{0.5cm}
\centerline{by}
\vspace{0.5cm}
\centerline{\large{\textbf{\thethesisauthor}}}
\vspace{2cm}
{
\centerline{\small A dissertation submitted in partial satisfaction of}
\centerline{\small the requirements for the degree}
\centerline{\small PHILOSOPHIAE DOCTOR}
}
\vspace{3.5cm}
\begin{figure}[h!]
\centering
\includegraphics[scale=0.7]{uis-logo-en}
\end{figure}
\vspace{1.0cm}
\centerline{Faculty of Science and Technology} 
\centerline{Department of Electrical Engineering and Computer Science} 
\centerline{\shortdate} 
\clearpage
}

%%%TODO(hein): continue editing from here

%%% Define a macro that sets arabic pagenumbering if not allready set
\newboolean{thesis@usearabicpagenumbering}
\setboolean{thesis@usearabicpagenumbering}{false}
\newcommand{\thesis@arabicpagenumbering}{%
  \ifthenelse{\boolean{thesis@usearabicpagenumbering}}%
  {%
    \relax%
  }%
  {
    \pagenumbering{arabic}%
    \setboolean{thesis@usearabicpagenumbering}{true}%
  }%
}%

%%% Produce the introduction from input file in the local dir introduction
%\newcommand{\inputintroduction}{
%  \clearemptydoublepage
%  \pagestyle{fancy}
%  \thesis@arabicpagenumbering
%  \begin{bibunit}%
%    \nonumX \chapter{Summary} \numX
%    \afterpage{\chapterhead{Summary}}
%    \ifthenelse{\boolean{thesis@suppressinput}}%
%    {\relax}%
%    {\subimport{introduction/}{body}
%      \ifthenelse{\boolean{thesis@suppressbibliography}}
%      {\relax}%
%      {\bibhead{\thepaper}%
%        \clearemptydoublepage%
%        \ifthenelse{\boolean{thesis@uselocalbibliography}}%
%        {\putbib[paper\arabic{paper}/bibliography]}%
%        {\putbib}}}%
%  \end{bibunit}%
%  \setboolean{thesis@suppressinput}{false}
%  \setboolean{thesis@suppressbibliography}{false}
%  \clearemptydoublepage
%}


\newcommand{\inputintroduction}{
  \clearemptydoublepage
  \pagestyle{fancy}
  \thesis@arabicpagenumbering
  \nonumX \chapter{Summary} \numX 
  \subimport{introduction/}{body}
  \printbibliography[segment=\therefsegment,heading=subbibliography]
  \clearemptydoublepage
}


%%% Set the section counter to arabic
\renewcommand{\thesection}{\arabic{section}}

%%% Abstract environment
\newenvironment{abstract}%
{\begin{center}%
\begin{minipage}[t]{0.9\linewidth}
\textbf{Abstract: }\\}%
{\end{minipage}%
\end{center}
\pagebreak}%

%%% Header styles
%\newcommand{\nohead}{}
%\newcommand{\paperstarthead}{\fancyhead{}}%

\newcommand{\bibhead}[1]{%
\fancyhead{}
\fancyhead[LO,RE]{\scshape #1}%
}%
\newcommand{\chapterhead}[1]{%
\fancyhead[LE,RO]{\nouppercase{\scshape \rightmark}}%
\fancyhead[LO,RE]{\scshape #1}%
}%

%%% Initalize a paper counter together with a list of paper environment
\newlistof{paper}{lop}
{
	\nonumX
	\vspace{-3em}
	\section[List of Papers]{\huge List of Papers}
	\vspace{-1em}
	{
		\vspace{1em}
		\noindent 
		\normalsize 
		\textnormal{The following papers are included in this thesis:}
	} \numX
}
\setcounter{paper}{0}%

%%%FIXME: This seems to be broked for paper number < 3
\newcommand{\listofpapers}{%
\listofpaper%
\vfill
}%

%%% The short paper name
%\renewcommand{\thepaper}{Paper \label{p:paper}\arabic{paper}}
\renewcommand{\thepaper}{Paper \arabic{paper}}

%%% Paper start
\newcommand{\papertitle}[1]{%
}%
%

%%% Chapter input
\newcommand{\inputpaper}{%
}%

\newcounter{thesis@paperauthors}
\newcounter{thesis@paperinstitutes}
\newcommand{\thesis@howpublished}{\relax}

\newenvironment{paper}[1]%
{%%% Start of paper environment
\thesis@arabicpagenumbering%
\renewcommand{\thesis@howpublished}{\relax}%
\stepcounter{paper}%
\setcounter{thesis@paperauthors}{1}%
\setcounter{thesis@paperinstitutes}{1}%
\clearemptydoublepage\resetcounters\nonumX%
\chapter[\thepaper: #1]{\thepaper: \\#1}%
\numX\clearplaindoublepage\fancyhead{}%
\rule{0pt}{18pt}\\{\fontsize{17pt}{17pt}\textbf{#1}}\\\rule{0pt}{18pt}%
\afterpage{\chapterhead{\thepaper}}%
\addtocontents{lop}{\protect\begin{itemize}}%
\addtocontents{lop}{\protect\item \textbf{\thepaper}\\}
\addtocontents{lop}{\protect\rule[0.5em]{\protect\linewidth}{0.5mm}\\}
\addtocontents{lop}{\textbf{#1}\\}%
}%
{%%% End of paper environment
{\\\textbf{\noindent\thesis@listofpaperauthors}}\\%
\rule{0pt}{12pt}\\%
\thesis@listofinstitutes%
\ifthenelse{\boolean{thesis@suppressinput}}%
  {\relax}%
  {
		\subimport{paper\Roman{paper}/}{body}%
		\printbibliography[segment=\therefsegment,heading=subbibliography]%
	}%
\addtocontents{lop}{\protect\end{itemize}}%
\addtocontents{lop}{\protect\vspace{1em}}%
\setboolean{thesis@suppressinput}{false}
\setboolean{thesis@suppressbibliography}{false}
\clearemptydoublepage%
}%

%%% Command to add paper authors (for paper environment)
\newcommand{\paperauthor}[2]{%
\expandafter\def\csname thesis@author\Alph{thesis@paperauthors}\Alph{paper}\endcsname{\textbf{#1}$^{#2}$}%
\ifthenelse{\value{thesis@paperauthors}=1}%
{\addtocontents{lop}{#1}}%
{\addtocontents{lop}{\hspace{-1ex}, #1}}%
\stepcounter{thesis@paperauthors}}%

%%% Command for adding how paper is published (for paper environment)
\newcommand{\published}[1]{
\addtocontents{lop}{\\#1}%
}

%%% Command for adding institution (for paper environment)
\newcommand{\institute}[2]{%
\expandafter\def\csname thesis@institutename\Alph{thesis@paperinstitutes}\Alph{paper}\endcsname{\selectfont#1}%
\expandafter\def\csname thesis@instituteaddr\Alph{thesis@paperinstitutes}\Alph{paper}\endcsname{\selectfont#2}%
\stepcounter{thesis@paperinstitutes}%
}%

%%% Define a help counter
\newcounter{thesis@tmpcount}

%%% Internal command to print list of authors and institutes
\newcommand{\thesis@listofpaperauthors}{%
\setcounter{thesis@tmpcount}{1}%
\whiledo{\value{thesis@tmpcount}<\value{thesis@paperauthors}}{%
\ifthenelse{\value{thesis@tmpcount}=1}%
{\csname thesis@author\Alph{thesis@tmpcount}\Alph{paper}\endcsname}%
{, \csname thesis@author\Alph{thesis@tmpcount}\Alph{paper}\endcsname}%
\stepcounter{thesis@tmpcount}}}%

\newcommand{\thesis@listofinstitutes}{%
\setcounter{thesis@tmpcount}{1}%
{\fontsize{10}{10}%
  \whiledo{\value{thesis@tmpcount}<\value{thesis@paperinstitutes}}{%
    \rule{0pt}{12pt}\makebox[0.8em][l]{$^{\arabic{thesis@tmpcount}}$}\selectfont \csname thesis@institutename\Alph{thesis@tmpcount}\Alph{paper}\endcsname\\
    \rule{0pt}{12pt}\makebox[0.8em][l]{}\csname thesis@instituteaddr\Alph{thesis@tmpcount}\Alph{paper}\endcsname\\[0.5em]
\stepcounter{thesis@tmpcount}}}%
}%

% Sideblob:
%\setlength{\unitlength}{18mm}
%\newcommand\rblob{
%  \begin{picture}(0,0)
%    \put(1,-\value{chapter}){\rule[-.2\unitlength]{2\unitlength}{.5\unitlength}}
%  \end{picture}}
%...
%\fancyhead[RO]{\rblob}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndDocument{%
}

%% End of file `uisthesis.cls'.

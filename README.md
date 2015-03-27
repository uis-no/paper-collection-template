#Templates for thesis

In this folder you will find thesis templates for the University of Stavanger.

TODO: Upload the different templates.


# LaTex Resources


## Editors

Almost all editors out there provide some support for LaTeX. 


### Mac OS X
On Mac, [TextMate 2](https://macromates.com) is a good one that will also allow
you to compile and directly view the compiled PDF, and even sync to current
cursor location to the corresponding page/line in the PDF when view with the
[Skim](http://skim-app.sourceforge.net) PDF viewer.

There are also WYSIWYG editors that allow exporting to LaTeX format, and
[LyX](http://www.lyx.org) is one such tool. You use LyX without exporting to
LaTeX, but if you find yourself trying to make a complex table, try doing it
with LyX, and export that to LaTeX and include that in your own regular LaTeX
setup.

## Collaboration Tools
If you are collaborating with co-authors on a paper or a thesis, we recommend
that you use a source control management (SCM) tool. We recommend
[git](http://git-scm.com). Git comes preinstalled on Mac OS X and is available
on all major Linux distros and there is a Windows installer. Git is a
sophisticated tool and can be quite daunting at first. However, luckily you
quite rarely need all the sophistication and can get away with learning only a
small fraction of its capabilities. We recommend the book [Pro
Git](http://git-scm.com/book/en/v2), which is freely available. If you are
collaborating on a paper, you will want to use an online service to keep the
git commit history. These are to recommended ones:

- [Github](https://github.com/)
- [Bitbucket](https://bitbucket.org/)

Bitbucket allows unlimited private repositories, while github requires payment
for private repositories. However, you can have as many open repositories as
you want on github.

## Collaboration with Online Editors
Recently, online LaTeX editors have started to pop up. These allow you to keep
your LaTeX projects in the cloud and easily collaborate with your co-authors.
In Overleaf you can also export your LaTeX code to a git account.

We have some experience in the department using Overleaf, and some of it works
quite well, while other things are a bit rough still.

- [Overleaf](https://www.overleaf.com/)
- [ShareLaTeX](https://www.sharelatex.com/)
- [Authorea](https://www.authorea.com/)

## Bibliography 
To manage your bibliography there are tools for this as well. In LaTeX, we rely on `.bib` files and the `bibtex` tool to produce the reference list from `\cite` commands within LaTeX documents. These bib files can be managed by

- [Mendeley](http://www.mendeley.com/) 
  parses already resources you have and put them into
  your document collection. They also have a browser plugin to easily add resources online. 
- [jabref](http://jabref.sourceforge.net/)

###Mac OS X
Mendeley has a desktop version for Mac OS X, but if you want to manage your bib
files locally only, there is a tool called
[BibDesk](http://bibdesk.sourceforge.net) that is easy to use.

## Graphics

[graphbox](http://www.ctan.org/pkg/graphbox) – Extend graphicx to improve placement of graphics.

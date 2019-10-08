% !TEX program = pdflatex
% !TEX encoding = UTF-8 Unicode
% !TEX root = main.tex
% !TEX options = -synctex=1 -interaction=nonstopmode -file-line-error "%DOC%"

\LoadClass{article}

\RequirePackage[german]{babel}
\RequirePackage{lipsum}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{calc}
\RequirePackage{xcolor}
\RequirePackage{xparse}
\RequirePackage{pdfpages}
\RequirePackage{enumitem}

% Options in brackets are needed for centering in sidebar showframe=true
\RequirePackage[margin=1cm,noheadfoot]{geometry}
\RequirePackage{graphicx}

% Remove paragraph indentation
\RequirePackage{parskip}
\RequirePackage{xstring}

% For drawing header, footer and blocks
\RequirePackage{tikz}

% |\@IfNoValueOrEmptyTF{argument}{if empty}{if not empty}|
% checks if an argument is empty.
\ExplSyntaxOn
\DeclareExpandableDocumentCommand{\IfNoValueOrEmpty}%
{mmm}{\IfNoValueTF{#1}{#2}{
    \tl_if_empty:nTF {#1} {#2} {#3}%
  }
}
\ExplSyntaxOff
\long\def\ifnodedefined#1#2#3{%
  \@ifundefined{pgf@sh@ns@#1}{#3}{#2}%
}

\usetikzlibrary{%
  arrows.meta,
  backgrounds,
	calc,
	fit,
  matrix,
	positioning,
  shapes.geometric,
  shapes.misc
}
\RequirePackage[hidelinks]{hyperref}
\hypersetup{
  colorlinks=true,
  % linkcolor=white,
  % filecolor=magenta,
  urlcolor=blue,
}

\NewDocumentCommand{\loadFonts}{}{
  \RequirePackage{fontspec}
  \RequirePackage{fontawesome}

  \ProvideDocumentCommand{\faAddressCard}{}{{\cv@FA%
        \symbol{"F2B9}}}
  \ProvideDocumentCommand{\faVcard}{}{{\cv@FA%
        \symbol{"F2BB}}}
  \ProvideDocumentCommand{\faMicrochip}{}{{\cv@FA%
        \symbol{"F2DB}}}
}
%
\ifxetex
  \loadFonts
\else
  \ifluatex
    \loadFonts
  \else
    \RequirePackage{fontawesome}
    \RenewDocumentCommand{\familydefault}{}{\sfdefault}
  \fi
\fi
\ifxetex
  \NewDocumentCommand{\kright}{m}{\leavevmode #1%
    \kern-\XeTeXglyphbounds3 \the\XeTeXcharglyph`#1 }
  \NewDocumentCommand{\kleft}{m}{\leavevmode %
    \kern-\XeTeXglyphbounds1 \the\XeTeXcharglyph`#1 #1}
\else
  \NewDocumentCommand{\kright}{m}{#1}
  \NewDocumentCommand{\kleft}{m}{#1}
\fi
\ExplSyntaxOn
\cs_generate_variant:Nn\tl_item:nn {f}
\DeclareExpandableDocumentCommand{\extract}{mm}{%
  \tl_item:fn{#1}{#2}%
}
\ExplSyntaxOff

%----------------------------------------------------------------------------------------
%	Colors
%----------------------------------------------------------------------------------------

% Lines under experience points
\definecolor{lineColors}{HTML}{4A6B8A}
% Background color sidebar and coverletter heading
\definecolor{backgroundColor}{HTML}{ECECEC}
% Font color in coverletter and sidebar
\definecolor{fontColor}{HTML}{041D37}
% Accent color i.e. loading bars
% \definecolor{accentColor}{HTML}{133253}
\definecolor{accentColor}{HTML}{4A6B8A}
% Color for Background rectangles
\definecolor{white}{HTML}{FFFFFF}

%----------------------------------------------------------------------------------------
%	Config
%----------------------------------------------------------------------------------------

% No page numbering
\pagestyle{empty}

\tikzset{
	@contactIcon/.style={minimum height=\baselineskip,contactIcon,},
	@contactText/.style={minimum height=\baselineskip,text depth=0pt,contactText,},
	@eventdottext/.style = {text width=\mainWidth-\timeDotSep,fontColor,anchor=north west,eventdottext,},
	@headerIcon/.style={minimum width=\headerIconWidth,anchor=center,headerIcon,},
	@interesticon/.style = {minimum width=\headerIconWidth,interesticon},
	@interesttext/.style = {interesttext,},
	@invisibletimedot/.style = {circle,minimum width=\timeDotDiameter,anchor=center,invisibletimedot,},
	@languageText/.style={languageText,},
	@progressArea/.style={minimum width=\progressAreaWidth,minimum height=\progressAreaHeight,rectangle,draw,accentColor,progressArea},
	@progressBar/.style={minimum height=\progressAreaHeight,rectangle,draw,fill,accentColor,anchor=west,progressBar},
	@sectionEduText/.style={@eventdottext,anchor=north west,sectionEduText,},
	@sectionTitle/.style={anchor=north west,align=left,sectionTitle,},
	@skillLevel/.style={skillLevel,},
	@skillText/.style={skillText,},
	@timedot/.style = {@invisibletimedot,draw,fill,accentColor,timedot,},
  contactIcon/.style={},
  contactText/.style={},
	eventdottext/.style = {},
  headerIcon/.style={},
	interesticon/.style = {},
	interesttext/.style = {},
	invisibletimedot/.style = {},
  languageText/.style={},
  progressArea/.style={},
  progressBar/.style={},
	sectionEduText/.style={},
  sectionTitle/.style={},
	skillLevel/.style={},
	skillText/.style={},
	timedot/.style = {},
}

\pgfkeys{/variables/.is family,
         /variables/.unknown/.style = %
         {\pgfkeyscurrentpath/\pgfkeyscurrentname/%
         .initial = #1}}
% Set all title names to English (default):
\NewDocumentCommand{\cv@setEnglish}{}{
    \pgfkeys{/variables/profile = PROFILE}%
    \pgfkeys{/variables/contact = CONTACT}%
    \pgfkeys{/variables/languages = LANGUAGES}%
    \pgfkeys{/variables/interests = Interests}%
    \pgfkeys{/variables/professional = Professional}%
    \pgfkeys{/variables/personal = Personal}%
    \pgfkeys{/variables/projects = Projects}%
    \pgfkeys{/variables/education = Education}%
    \pgfkeys{/variables/experience = Experience}%
    \pgfkeys{/variables/references = References}%
    \pgfkeys{/variables/scholarship = Scholarship}%
    \pgfkeys{/variables/skills = Skills}%
}
%
% Set all title names to German:
\NewDocumentCommand{\cv@setGerman}{}{
    \pgfkeys{/variables/profile = PROFIL}%
    \pgfkeys{/variables/contact = KONTAKT}%
    \pgfkeys{/variables/languages = SPRACHEN}%
    \pgfkeys{/variables/interests = Interessen}%
    \pgfkeys{/variables/professional = Professionel}%
    \pgfkeys{/variables/personal = Persönlich}%
    \pgfkeys{/variables/projects = Projekte}%
    \pgfkeys{/variables/education = Bildung}%
    \pgfkeys{/variables/experience = Erfahrung}%
    \pgfkeys{/variables/references = Referenzen}%
    \pgfkeys{/variables/scholarship = Stipendien}%
    \pgfkeys{/variables/skills = Fertigkeiten}%
}

% Set the actual language to English. This can be overwritten by the user in the
% preamble
%
% Define the command to change the language
\ExplSyntaxOn
\NewDocumentCommand{\cvSetLanguage}{m}{
    \str_case:nnF {#1}
    {
      {german} {\cv@setGerman}
      {english} {\cv@setEnglish}
    }
	{\ClassError{error}{Unknown option `#1' for cvLanguage %
     macro.}{Only `english', `chinese`, `french` and `dutch' are valid options %
     for this macro.}}
}
\ExplSyntaxOff
\cvSetLanguage{german}

%----------------------------------------------------------------------------------------
%	Margins
%----------------------------------------------------------------------------------------

% Diameter of points in experience timeline
\newlength\dotDiameter
\setlength\dotDiameter{3pt}

\newlength\margin
\setlength\margin{1cm}

\newlength\sideWidth
\setlength\sideWidth{0.3\paperwidth-\margin}
\newlength\mainWidth
\setlength\mainWidth{\paperwidth-3.5\margin-\sideWidth}

\newlength\coverletterWidth
\setlength\coverletterWidth{\mainWidth+3\margin}
\newlength\headerHeight
\setlength\headerHeight{5cm}

\newlength\nameblockHeight
\setlength\nameblockHeight{1.3cm}

\newlength\footerHeight
\setlength\footerHeight{3cm}

\newlength\addressblockHeight
\setlength\addressblockHeight{2cm}
\newlength\addressblockWidth
\setlength\addressblockWidth{\sideWidth+2.4\margin}

\newlength\sectionSBSep
\setlength\sectionSBSep{4pt}

\newlength\sBSectionLineWidth
\setlength\sBSectionLineWidth{1pt}

\newlength\skillSep
\setlength\skillSep{1ex}

\newlength\headerIconWidth
\setlength\headerIconWidth{0pt}

\newlength\colSep
\setlength\colSep{0.1cm} % 2 times column separation!

\newlength\timeDotDiameter
\setlength\timeDotDiameter{3pt}

\newlength\timeDotSep
\setlength\timeDotSep{0.4cm}

\newlength\startEndSep
\setlength\startEndSep{0.3cm}

\newlength\itemSep
\setlength\itemSep{0.4cm}

\newlength\tableSepWidth
\setlength\tableSepWidth{0.3cm}

\newlength\progressAreaWidth
\setlength\progressAreaWidth{5em}

\newlength\progressAreaHeight
\setlength\progressAreaHeight{0.75em}

\newlength\sectionSep
\setlength\sectionSep{0.6cm}

\newlength\titleLineWidth
\setlength\titleLineWidth{2pt}

\newlength\titleLineSpacing
\setlength\titleLineSpacing{0.1cm}

\newlength\projectDetailsSep
\setlength\projectDetailsSep{0.2cm}

\newlength\contactItemSep
\setlength\contactItemSep{5pt}

\newlength\idNameSep
\setlength\idNameSep{0.1cm}

\newlength\positionSep
\setlength\positionSep{0.5cm}

%----------------------------------------------------------------------------------------
%   Commands for profile info
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\setfirstName}{m}{
  \pgfkeyssetvalue{firstName}{#1}
}
\NewDocumentCommand{\setlastName}{m}{
  \pgfkeyssetvalue{lastName}{#1}
}
\xdef\profilepicture{\empty}
\NewDocumentCommand{\setPicture}{m}{
	\IfNoValueOrEmpty{#1}{}{\xdef\profilepicture{#1}}
}
\xdef\signature{\empty}
\NewDocumentCommand{\setSignaturePicture}{m}{
  \IfNoValueOrEmpty{#1}{}{\xdef\signature{#1}}
}

\NewDocumentCommand{\displaysignature}{}{
	\begin{figure}[htbp]
		\includegraphics[width=5cm]{\signature}
	\end{figure}
}

\NewDocumentCommand{\setAddress}{m}{
  \pgfkeyssetvalue{address}{#1}
}
\NewDocumentCommand{\setjobofferlocation}{m}{
	\pgfkeyssetvalue{jobofferlocation}{#1}
}
\NewDocumentCommand{\setZipcode}{m}{
  \pgfkeyssetvalue{zipcode}{#1}
}
\NewDocumentCommand{\setCity}{m}{
  \pgfkeyssetvalue{city}{#1}
}
\NewDocumentCommand{\setEmail}{m}{
  \pgfkeyssetvalue{email}{#1}
}
\NewDocumentCommand{\setPhone}{m}{
  \pgfkeyssetvalue{phoneNumber}{#1}
}
\NewDocumentCommand{\setPosition}{m}{
  \pgfkeyssetvalue{position}{#1}
}
\NewDocumentCommand{\setPositionId}{m}{
  \pgfkeyssetvalue{positionid}{#1}
}
\NewDocumentCommand{\setCompanyName}{m}{
  \pgfkeyssetvalue{companyName}{#1}
}
\NewDocumentCommand{\setCompanyAddress}{m}{
  \pgfkeyssetvalue{companyAddress}{#1}
}
\NewDocumentCommand{\setCompanyZip}{m}{
  \pgfkeyssetvalue{companyZip}{#1}
}
\NewDocumentCommand{\setCompanyCity}{m}{
  \pgfkeyssetvalue{companyCity}{#1}
}

%----------------------------------------------------------------------------------------
%   Cover Letter Environment
%----------------------------------------------------------------------------------------

\NewDocumentEnvironment{coverletter}{}{
  \newgeometry{textwidth=\coverletterWidth,textheight=23cm,noheadfoot}
  \begin{tikzpicture}[remember picture, overlay, every node/.style={inner sep=0cm, outer sep=0cm}]
    \begin{scope}[on background layer]
      % Header
      \fill[backgroundColor]%
      (current page.north west)%
      rectangle%
      ++(\paperwidth, -0.8\headerHeight);

      \fontsize{14}{12}\selectfont
      \newlength\fullnameWidth
      \setlength\fullnameWidth{\widthof{\pgfkeysvalueof{firstName} \pgfkeysvalueof{lastName}}}
      \fontsize{10}{12}\selectfont

      % Blue name block
      \fill[accentColor,draw=white,line width=1mm]%
      ($(current page.north west)+(-2pt,-0.8\headerHeight+0.5\nameblockHeight)$)%
      rectangle%
      ++(0.5\paperwidth-0.5\coverletterWidth+\fullnameWidth+0.3cm,-\nameblockHeight);

      % First and Second Name
      \draw (current page.north west) ++(0.5\paperwidth-0.5\coverletterWidth, -0.8\headerHeight) node (name) {};
      \node[anchor=west] at (name) (coverletter name)
      {\fontsize{14}{12}\selectfont\color{white}\pgfkeysvalueof{firstName} \pgfkeysvalueof{lastName}};

      % Footer
      \fill[backgroundColor]%
      (current page.south east) rectangle%
      ++(-\paperwidth, \footerHeight);

      \fontsize{10}{12}\selectfont\color{white}
      \newlength\extraWidth
      \setlength\extraWidth{
        \maxof{
          \widthof{\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}}}{\widthof{\pgfkeysvalueof{email}}
        }
      }
      \setlength\addressblockWidth{0.5\paperwidth-0.5\coverletterWidth+\extraWidth}

      \newlength\addressHeight
      \setlength\addressHeight{
        \heightof{
          \pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}
        }
      }

      \setlength\addressblockHeight{6\addressHeight}
      % Blue address block upper right
      % \fill[accentColor,draw=white,line width=1mm]%
      % ($(current page.north east)+(0,-0.8\headerHeight-0.5\addressblockHeight)$) %
      % rectangle %
      % ++(-\addressblockWidth-0.3cm,\addressblockHeight);

      % \draw (current page.north east) ++(-\addressblockWidth, -0.8\headerHeight) node (emailnode) {};

      % \node[anchor=west] at (emailnode) (email)
      % {\href{mailto:\pgfkeysvalueof{email}}{\color{white}{\pgfkeysvalueof{email}}}};

      % \node[
      %   align=left,
      %   below=-5pt-\addressHeight of email.north west,
      %   anchor=north west](address)
      % {\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}};

      % \node[
      %   align=left,
      %   below=5pt+\addressHeight of email.south west,
      %   anchor=south west](phone)
      % {\pgfkeysvalueof{phoneNumber}};

      % Blue address block down right
      % \fill[accentColor,draw=white,line width=1mm]%
      % ($(current page.south east)+(0,\footerHeight-0.5\addressblockHeight)$)%
      % rectangle%
      % ++(-\addressblockWidth-0.3cm,\addressblockHeight);

      % \draw (current page.south east) ++(-\addressblockWidth, \footerHeight) node (emailnode) {};

      % \node[anchor=west] at (emailnode) (email)
      % {\href{mailto:\pgfkeysvalueof{email}}{\color{white}{\pgfkeysvalueof{email}}}};

      % \node[
      %   align=left,
      %   below=-5pt-\addressHeight of email.north west,
      %   anchor=north west](address)
      % {\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}};

      % \node[
      %   align=left,
      %   below=5pt+\addressHeight of email.south west,
      %   anchor=south west](phone)
      % {\pgfkeysvalueof{phoneNumber}};

      % Blue address block down left
      \fill[accentColor,draw=white,line width=1mm]%
      ($(current page.south west)+(-2pt,\footerHeight-0.5\addressblockHeight)$)%
      rectangle%
      ++(\addressblockWidth+0.3cm,\addressblockHeight);

      \draw (current page.south west) ++(\addressblockWidth, \footerHeight) node (emailnode) {};

      \node[anchor=east] at (emailnode) (email)
      {\href{mailto:\pgfkeysvalueof{email}}{\color{white}{\pgfkeysvalueof{email}}}};

      \node[
        align=left,
        below=-5pt-\addressHeight of email.north east,
        anchor=north east](address)
      {\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}};

      \node[
        align=left,
        below=5pt+\addressHeight of email.south east,
        anchor=south east](phone)
      {\pgfkeysvalueof{phoneNumber}};

    \end{scope}
  \end{tikzpicture}

  \vspace{\dimexpr\headerHeight-1in-\topmargin\relax}
  % \vspace{5pt}

  % \vspace{\baselineskip}

  \textbf{\pgfkeysvalueof{companyName}}\\
  \pgfkeysvalueof{companyAddress}\\
  \pgfkeysvalueof{companyZip} \pgfkeysvalueof{companyCity}

  \vspace{15pt}

  \textbf{Bewerbung für die Stelle \pgfkeysvalueof{position}}  \null\hfill \today\\
	\textbf{\pgfkeysvalueof{jobofferlocation}}
	\textbf{\pgfkeysvalueof{positionid}}
}{
  % \vspace{5pt}

  \restoregeometry
  \cleardoublepage
}

%----------------------------------------------------------------------------------------
%   Sidebar Environment
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\cvhrulefill}{}{{\color{accentColor}%
      \leavevmode\leaders\hrule height \sBSectionLineWidth\hfill\kern\z@}}
\NewDocumentCommand{\ruleline}{m}{\par\noindent\raisebox{.6ex}{%
    \makebox[\linewidth]{\cvhrulefill\hspace{1ex}%
      \raisebox{-.6ex}{#1}\hspace{1ex}\cvhrulefill}}}

% Left Sidebar
\NewDocumentEnvironment{sidebar}{}{
  \begin{tikzpicture}[remember picture,overlay]
    \fill[backgroundColor]%
    (current page.north west)%
    rectangle%
    ++(\sideWidth+2\margin,-\paperheight);
  \end{tikzpicture}
  \begin{minipage}{\sideWidth}
    \begin{center}
			\IfFileExists{\profilepicture}{
        \begin{tikzpicture}[remember picture, overlay]
          \node[
            anchor=center,
            xshift=.5*(\sideWidth+2\margin),
            yshift=-0.4*(\sideWidth+2\margin)+0.21cm,
            regular polygon,
            regular polygon sides=4,
            text=black,
            % draw=black,line width=.5mm,
            minimum size=10.2cm,
            path picture={
                \node[
                  xshift=-0.2cm,
                  anchor=center,
                  % draw,line width=.5mm,
                ] at (path picture bounding box.center){
									\includegraphics[width=8cm]{\profilepicture}
                };
              }] at (current page.north west)
          {};
        \end{tikzpicture}
        \vspace{130pt}
      }{}
      \color{fontColor}
      {
        \begin{center}
          \LARGE
          \vspace{3\idNameSep}
          \pgfkeysvalueof{firstName}
          \vspace{3\idNameSep}
          \pgfkeysvalueof{lastName}
          \vspace{\positionSep}

        \end{center}
        \begin{center}
          \pgfkeysvalueof{position}\\
          \pgfkeysvalueof{positionid}
        \end{center}
        \vspace{\positionSep}
      }
      }{
    \end{center}
  \end{minipage}
  \vspace*{\fill}
}

\NewDocumentEnvironment{sidear*}{}{%
  \vspace*{\fill}
  \vspace*{-0.5\margin}
  \begin{tikzpicture}[remember picture,overlay]
    \fill[backgroundColor] (current page.north east) rectangle %
    ++(-\sideWidth-2\margin,-\paperheight);
  \end{tikzpicture}%
  \begin{minipage}{\sideWidth}
    \begin{center}
      }{%
    \end{center}
  \end{minipage}
  \vspace*{\fill}
}

\NewDocumentEnvironment{profile}{}{%
  \vspace{\sectionSBSep}
  \ruleline{\pgfkeysvalueof{/variables/profile}}
  \vspace{\sectionSBSep}

}{%
}

\NewDocumentCommand{\@ContactTemplate}{mm}{
  \NewDocumentCommand{#1}{m}{
    \if@contactfirst \\ \else %
      \global\@contactfirsttrue \fi\node[@contactIcon]{#2};
    \pgfmatrixnextcell \node[@contactText]{##1};
  }
}

\NewDocumentCommand{\@ContactTemplateLink}{mm}{
  \NewDocumentCommand{#1}{mm}{
    \if@contactfirst \\ \else %
      \global\@contactfirsttrue \fi\node[@contactIcon]{#2};
    \pgfmatrixnextcell \node[@contactText]{%
      \IfNoValueOrEmpty{##1}{##2}{\href{##1}{##2}}};
  }
}

\NewDocumentCommand{\cvContactTemplate}{O{} mm}{
  \if@contactfirst%
    \\%
  \else %
    \global\@contactfirsttrue %
  \fi %
  \node[@contactIcon]{#2};
  \pgfmatrixnextcell \node[@contactText]{%
    \IfNoValueOrEmpty{#1}{#3}{\href{#1}{#3}}%
  };
}

\newif\if@contactfirst
\NewDocumentEnvironment{contact}{}{%
  \vspace{\sectionSBSep}
  \ruleline{\pgfkeysvalueof{/variables/contact}}%
  % \begin{flushleft}
  %   KONTAKT
  % \end{flushleft}
  % \vspace{\sectionSBSep}
  \vspace{15pt}

  \global\@contactfirstfalse
  \@ContactTemplate{\address}{\faMapMarker}
  \@ContactTemplate{\phone}{\faPhone}

  \@ContactTemplateLink{\email}{\faEnvelope}
  \@ContactTemplateLink{\website}{\faGlobe}
  \@ContactTemplateLink{\github}{\faGithub}
  \@ContactTemplateLink{\linkedin}{\faLinkedinSquare}
  \@ContactTemplateLink{\twitter}{\faTwitter}
  \@ContactTemplateLink{\keybase}{\faKey}
  \begin{tikzpicture}[%
      every node/.style={inner sep=0pt, outer sep=0pt}]
    \matrix [
      column 1/.style={anchor=west},
      column 2/.style={anchor=east,align=right},
      column sep=\contactItemSep,
      row sep=\contactItemSep+3pt,
      inner sep=0pt,
      outer sep=0pt] (contact) \bgroup
    \address{\pgfkeysvalueof{address}\\\pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}}
    \email{mailto:\pgfkeysvalueof{email}}{\pgfkeysvalueof{email}}
    \phone{\pgfkeysvalueof{phoneNumber}}
    }{%
    \\\egroup; % \\ required, does not compile otherwise
  \end{tikzpicture}%
}

\newcounter{@languages}
\setcounter{@languages}{1}
\pgfkeys{/languages/.is family,
  /languages/.unknown/.style = {%
      \pgfkeyscurrentpath/\pgfkeyscurrentname/.initial = #1}}
\NewDocumentEnvironment{languages}{}{%
  \NewDocumentCommand{\languageRating}{mm}{%
    {\globaldefs=1\relax\pgfkeys{%
          /languages/lang\the\value{@languages} = ##2}}
    \node[@languageText]{##1}; \pgfmatrixnextcell %
    \node[@progressArea] (@language \the\value{@languages}) {}; \\
    \stepcounter{@languages}
  }%
  \vspace{\sectionSBSep}
  \ruleline{\pgfkeysvalueof{/variables/languages}}%
  % \vspace{\sectionSBSep}
  \vspace{15pt}
  \begin{tikzpicture}[%
      every node/.style={text depth=0pt,inner sep=0pt,outer sep=0pt}]
    \matrix [
      column 1/.style={anchor=west},
      column sep=1.5\sectionSBSep,
      row sep=1.5\sectionSBSep+5pt,
      column 2/.style={anchor=east,align=right}
    ] (contact) \bgroup
    }{%
    \\\egroup;
    \newcounter{@languagelevel}
    \setcounter{@languagelevel}{1}
    \loop\ifnum\value{@languagelevel}<\value{@languages}
    \draw (@language \the\value{@languagelevel}.west) %
    node[%
      @progressBar,
      minimum width=\pgfkeysvalueof{%
        /languages/lang\the\value{@languagelevel}}em]%
    {};
    \stepcounter{@languagelevel}
    \repeat
  \end{tikzpicture}
}

%----------------------------------------------------------------------------------------
%   Main Environment
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\cvSection}{m}{\large\textbf{#1}}

\newcounter{titlePrev}
\setcounter{titlePrev}{0}
\newcounter{titleNext}
\setcounter{titleNext}{1}

\NewDocumentCommand{\@Title}{mm}{%
  \color{fontColor}
  \ifnodedefined{last item \the\value{lastItem}}{%
    \setlength\headerIconWidth{%
      \maxof{\headerIconWidth}{\widthof{\Large #2}}}%
    \protected@write\@auxout{}{\global\headerIconWidth=\the\headerIconWidth}

    \node[below=\sectionSep of last item \the\value{lastItem}.south west,@sectionTitle]
    (@title \the\value{titleNext})
    {\begingroup\edef\y{\endgroup%
        \cvSection\bgroup\noexpand\kleft{\extract{#1}{1}}}\y\StrGobbleLeft{#1}{1}
      \egroup
    };

    \node[left=\timeDotSep of @title \the\value{titleNext},@headerIcon]
    {#2};

    \node[below=\sectionSep of last item \the\value{lastItem}.south west,@sectionTitle]
    (@title \the\value{titleNext} dummy)
    {
      \phantom{\cvSection{Education}}
    };

    \begin{scope}[on background layer]
      \draw[line width=\titleLineWidth,accentColor]
      let \p1=(@title \the\value{titleNext} %
      dummy.south west),
      \p2=(current page.east) in
      (\x1,\y1-\titleLineSpacing) to (\x2,\y1-\titleLineSpacing);
    \end{scope}
  }{%
    \node[@sectionTitle] at (0,0) (@title \the\value{titleNext})
    {\begingroup\edef\y{\endgroup
        \cvSection\bgroup\noexpand\kleft{\extract{#1}{1}}}%
      \y\StrGobbleLeft{#1}{1}\egroup};

    \node[left=\timeDotSep of @title \the\value{titleNext},@headerIcon]
    {#2};

    \node[@sectionTitle] at (0,0)(@title \the\value{titleNext} dummy) {%
      \phantom{\cvSection{Education}}};

    \begin{scope}[on background layer]
      \draw[line width=\titleLineWidth,accentColor]
      let \p1=(@title \the\value{titleNext} %
      dummy.south west),
      \p2=(current page.east) in
      (\x1,\y1-\titleLineSpacing) to (\x2,\y1-\titleLineSpacing);
    \end{scope}
  }%
  \stepcounter{titlePrev}%
  \stepcounter{titleNext}
}
\NewDocumentCommand{\@EndSectionDraw}{}{
  \color{fontColor}
  \draw (start) to (end.center);}
\newcounter{itemPrev}
\setcounter{itemPrev}{0}
\newcounter{itemNext}
\setcounter{itemNext}{1}
\newcounter{lastItem}
\setcounter{lastItem}{1}

\NewDocumentCommand{\@definecvItem}{}{
\NewDocumentCommand{\cvItem}{O{}O{}O{}O{}O{}}{%
\ifnodedefined{item \the\value{itemPrev}}{%
  \node[below=\itemSep of item \the\value{itemPrev}.south west,@eventdottext]
  (item \the\value{itemNext} header){\phantom{Evening}};

  \node[below=\itemSep of item \the\value{itemPrev}.south west,@sectionEduText]
  (item \the\value{itemNext})
  {
    \IfNoValueOrEmpty{##1}{}{##1 \IfNoValueOrEmpty{##2}{}{\hfill {\color{accentColor}##2}}\\}\IfNoValueOrEmpty{##3}{\IfNoValueOrEmpty{##4}{}{##4\\}}{\textsc{\selectfont##3}\IfNoValueOrEmpty{##4}{}{, ##4\\}}

    \IfNoValueOrEmpty{##5}{}{##5}
  };

  \node[left=\timeDotSep of item \the\value{itemNext} header,@timedot]
  {};
}{
  \node[below=\itemSep of @title \the\value{titlePrev}.south west,@eventdottext]
  (item \the\value{itemNext} header){\phantom{Evening}};

  \node[below=\itemSep of @title \the\value{titlePrev}.south west,@sectionEduText]
  (item \the\value{itemNext})
  {
    \IfNoValueOrEmpty{##1}{}{##1 \IfNoValueOrEmpty{##2}{}{\hfill {\color{accentColor}##2}}\\}\IfNoValueOrEmpty{##3}{\IfNoValueOrEmpty{##4}{}{##4\\}}{\textsc{\selectfont##3}\IfNoValueOrEmpty{##4}{\\}{, ##4\\}}

    \IfNoValueOrEmpty{##5}{}{##5}
  };

  \node[left=\timeDotSep of item \the\value{itemNext} header,@timedot]
  (start)
  {};
}
\node[left=\timeDotSep of item \the\value{itemNext}.south west,@invisibletimedot]
(end)
{};
\stepcounter{itemPrev}
\stepcounter{itemNext}
}
}

\NewDocumentEnvironment{mainContent}{}{%
  \begin{tikzpicture}
    [every node/.style={inner sep=0pt,outer sep=0pt},remember picture,overlay,
			shift={($(current page.north west)+(\sideWidth+2.5\margin+\timeDotSep,-0.5\margin)$)}]
    \begin{scope}[on background layer]
    }{%
    \end{scope}
  \end{tikzpicture}
}

\NewDocumentEnvironment{mainContent*}{}{%
  \stepcounter{titlePrev}
  \stepcounter{titleNext}
  \begin{tikzpicture}[%
      every node/.style={%
          inner sep=0pt,
          outer sep=0pt},
      remember picture,
      overlay,
      shift={($(current page.north west)+%
            (\margin+\timeDotSep,-\margin)$)}]
    }{%
  \end{tikzpicture}%
}
\NewDocumentEnvironment{education}{O{}}{%
  \@Title{#1}{\faGraduationCap}
  \stepcounter{itemPrev}
  \stepcounter{itemNext}
  \@definecvItem
}{%
  \@EndSectionDraw
  \stepcounter{lastItem}
  \draw (item \the\value{itemPrev}.south west)
  node (last item \the\value{lastItem}) {};
}

\NewDocumentEnvironment{experience}{O{}}{%
  \@Title{#1}{\faBriefcase}
  \stepcounter{itemPrev}
  \stepcounter{itemNext}
  \@definecvItem
}{%
  \@EndSectionDraw
  \stepcounter{lastItem}
  \draw (item \the\value{itemPrev}.south west)
  node (last item \the\value{lastItem}) {};
}

\NewDocumentEnvironment{scholarship}{O{}}{%
  \@Title{#1}{\faEuro}
  % insures uniqueness
  \stepcounter{itemPrev}
  \stepcounter{itemNext}
  \@definecvItem
}{%
  \@EndSectionDraw
  \stepcounter{lastItem}
  \draw (item \the\value{itemPrev}.south west)
  node (last item \the\value{lastItem}) {};
}

\newcount\my@repeat@count
\NewDocumentCommand{\skill}{m}{%
  \color{fontColor}
  \begingroup
  \my@repeat@count=\z@
  \@whilenum\my@repeat@count<#1\do{\faCircle\advance%
    \my@repeat@count\@ne}%
  \my@repeat@count=\numexpr5-\z@\relax
  \@whilenum\my@repeat@count>#1\do{\faCircleO\advance%
    \my@repeat@count\m@ne}%
  \endgroup
}

\newif\if@firstskill
\NewDocumentCommand{\@skillsTwoTable}{}{}
\NewDocumentCommand{\@skillsTable}{}{}
\NewDocumentCommand{\skillTwo}{mmmm}{%
  \if@firstskill
    \g@addto@macro\@skillsTwoTable{\skill{#1} %
      & #2 & \skill{#3} & #4}
    \@firstskillfalse
  \else
    \g@addto@macro\@skillsTwoTable{\\[\skillSep] \skill{#1} %
      & #2 & \skill{#3} & #4}
  \fi
}
\NewDocumentCommand{\skillOne}{mm}{%
  \if@firstskill
    \g@addto@macro\@skillsTable{\skill{#1} & #2}
    \@firstskillfalse
  \else
    \g@addto@macro\@skillsTable{\\[\skillSep] \skill{#1} & #2}
  \fi
}

\NewDocumentEnvironment{skills}{O{}}{%
  \@Title{#1}{\faStar}
  \global\@firstskilltrue
}{%
  \node[
    below=\sectionSep of @title \the\value{titlePrev}.south west,
    anchor=north west] (skills)
  {
    \begin{tabular}{@{}ll@{\hskip\colSep}ll@{}}%
      \@skillsTwoTable
      \@skillsTable
    \end{tabular}
  };
  \stepcounter{lastItem}
  \draw (skills.south west) node %
  (last item \the\value{lastItem}) {};
}

\NewDocumentEnvironment{interests}{O{}}{%
  \@Title{#1}{\faUser}
  % insures uniqueness
  \stepcounter{itemPrev}
  \stepcounter{itemNext}
  \@definecvItem
}{%
  \@EndSectionDraw
  \stepcounter{lastItem}
  \draw (item \the\value{itemPrev}.south west)
  node (last item \the\value{lastItem}) {};
}

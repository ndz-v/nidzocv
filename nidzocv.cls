% !TEX program = pdflatex
% !TEX encoding = UTF-8 Unicode
% !TEX root = main.tex
% !TEX options = -synctex=1 -interaction=nonstopmode -file-line-error "%DOC%"

\ProvidesClass{nidzocv}
\LoadClass{article}

\RequirePackage[german]{babel}
\RequirePackage{lipsum}
\RequirePackage[hidelinks,pdfusetitle]{hyperref}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{calc}
\RequirePackage{xcolor}
\RequirePackage{xparse}
\RequirePackage{pdfpages}
\RequirePackage{enumitem}

% For drawing header, footer and blocks
\RequirePackage{tikz}

% Options in brackets are needed for centering in sidebar showframe=true
\RequirePackage[margin=1cm,noheadfoot]{geometry}
\RequirePackage{graphicx}

% Remove paragraph indentation
\RequirePackage{parskip}
\RequirePackage{xstring}

\RequirePackage{fontawesome5}

% Global options for pdfpages
\includepdfset{linkname=attachment, pagecommand={\refstepcounter{attachment}\label{attachment.\theattachment}}}

% |\@IfNoValueOrEmptyTF{argument}{if empty}{if not empty}|
% checks if an argument is empty.
\ExplSyntaxOn
\DeclareExpandableDocumentCommand{\@IfNoValueOrEmpty}%
{mmm}{\IfNoValueTF{#1}{#2}{
		\tl_if_empty:nTF {#1} {#2} {#3}%
	}
}
\ExplSyntaxOff
\long\def\ifnodedefined#1#2#3{%
	\@ifundefined{pgf@sh@ns@#1}{#3}{#2}%
}

\usetikzlibrary{%
	backgrounds,
	calc,
	positioning,
	shapes.geometric,
	shapes.misc,
	shadings,
   	shadows,
}

\ExplSyntaxOn
\cs_generate_variant:Nn\tl_item:nn {f}
\DeclareExpandableDocumentCommand{\extract}{mm}{%
	\tl_item:fn{#1}{#2}%
}
\ExplSyntaxOff

%----------------------------------------------------------------------------------------
%	Colors
%----------------------------------------------------------------------------------------

% Lines under title points
\definecolor{lineColors}{HTML}{4A6B8A}
% Background color sidebar and coverletter heading
\definecolor{backgroundColor}{HTML}{ECECEC}
% Font color in coverletter and sidebar
\definecolor{fontColor}{HTML}{041D37}
% Accent color i.e. loading bars
% \definecolor{accentColor}{HTML}{133253}
\definecolor{accentColor}{HTML}{4A6B8A}
% Name and address block color
\definecolor{blockColor}{HTML}{4A6B8A}

%----------------------------------------------------------------------------------------
%	Margins
%----------------------------------------------------------------------------------------

% Diameter of points in experience timeline
\newlength\@margin
\setlength\@margin{1cm}
\newlength\@sideWidth
\setlength\@sideWidth{0.3\paperwidth-\@margin}
\newlength\@mainWidth
\setlength\@mainWidth{\paperwidth-3.5\@margin-\@sideWidth}
\newlength\@coverletterWidth
\setlength\@coverletterWidth{\@mainWidth+3\@margin}
\newlength\@headerHeight
\setlength\@headerHeight{4cm}
\newlength\@minipageLength
\setlength\@minipageLength{\textheight-1cm}
\newlength\@nameBlockHeight
\setlength\@nameBlockHeight{1.3cm}
\newlength\@footerHeight
\setlength\@footerHeight{3cm}
\newlength\@addressBlockHeight
\setlength\@addressBlockHeight{2cm}
\newlength\@addressBlockWidth
\setlength\@addressBlockWidth{\@sideWidth+2.4\@margin}
\newlength\@sectionSBSep
\setlength\@sectionSBSep{4pt}
\newlength\@sBSectionLineWidth
\setlength\@sBSectionLineWidth{1pt}
\newlength\@skillSep
\setlength\@skillSep{1ex}
\newlength\@headerIconWidth
\setlength\@headerIconWidth{0pt}
\newlength\@colSep
\setlength\@colSep{0.5cm} % 2 times column separation!
\newlength\@timeDotDiameter
\setlength\@timeDotDiameter{3pt}
\newlength\@timeDotSep
\setlength\@timeDotSep{0.4cm}
\newlength\@itemSep
\setlength\@itemSep{0.4cm}
\newlength\@progressAreaWidth
\setlength\@progressAreaWidth{5em}
\newlength\@progressAreaHeight
\setlength\@progressAreaHeight{0.75em}
\newlength\@sectionSep
\setlength\@sectionSep{0.6cm}
\newlength\@titleLineWidth
\setlength\@titleLineWidth{2pt}
\newlength\@titleLineSpacing
\setlength\@titleLineSpacing{0.1cm}
\newlength\@contactItemSep
\setlength\@contactItemSep{5pt}
\newlength\@idNameSep
\setlength\@idNameSep{0.1cm}
\newlength\@positionSep
\setlength\@positionSep{0.5cm}

%----------------------------------------------------------------------------------------
%	Config
%----------------------------------------------------------------------------------------

\RenewDocumentCommand{\familydefault}{}{\sfdefault}

% No page numbering
\pagestyle{empty}

% PDF meta data
\title{Bewerbung als \pgfkeysvalueof{position}}
\author{\pgfkeysvalueof{firstName} \pgfkeysvalueof{lastName}}

\hypersetup{
	colorlinks=true,
	linkcolor=blue,
	urlcolor=blue
}

\tikzset{
	@contactIcon/.style={minimum height=\baselineskip},
	@contactText/.style={minimum height=\baselineskip,text depth=0pt},
	@eventdotText/.style = {text width=\@mainWidth-\@timeDotSep,fontColor,anchor=north west},
	@headerIcon/.style={minimum width=\@headerIconWidth,anchor=center},
	@invisibleTimeDot/.style = {circle,minimum width=\@timeDotDiameter,anchor=center},
	@progressArea/.style={minimum width=\@progressAreaWidth,minimum height=\@progressAreaHeight,rectangle,draw,accentColor},
	@progressBar/.style={minimum height=\@progressAreaHeight,rectangle,draw,fill,accentColor,anchor=west},
	@sectionEduText/.style={@eventdotText,anchor=north west,align=justify},
	@sectionTitle/.style={anchor=north west,align=left},
	@timedot/.style = {@invisibleTimeDot,draw,fill,accentColor},
	@sidebarPicturePosition/.style = {anchor=north east},
	@column1/.style={anchor=west},
	@column2/.style={anchor=east,align=right}
}

\pgfkeys{/variables/.is family,
	/variables/.unknown/.style = %
		{\pgfkeyscurrentpath/\pgfkeyscurrentname/%
			.initial = #1}}
% Set all title names to English (default):
\NewDocumentCommand{\cv@setEnglish}{}{
	\pgfkeys{/variables/contact = CONTACT}%
	\pgfkeys{/variables/education = Education}%
	\pgfkeys{/variables/experience = Experience}%
	\pgfkeys{/variables/interests = Interests}%
	\pgfkeys{/variables/languages = LANGUAGES}%
	\pgfkeys{/variables/personal = Personal}%
	\pgfkeys{/variables/professional = Professional}%
	\pgfkeys{/variables/profile = PROFILE}%
	\pgfkeys{/variables/projects = Projects}%
	\pgfkeys{/variables/scholarship = Scholarship}%
	\pgfkeys{/variables/skills = Skills}%
}
%
% Set all title names to German:
\NewDocumentCommand{\cv@setGerman}{}{
	\pgfkeys{/variables/contact = KONTAKT}%
	\pgfkeys{/variables/education = Bildung}%
	\pgfkeys{/variables/experience = Erfahrung}%
	\pgfkeys{/variables/interests = Interessen}%
	\pgfkeys{/variables/languages = SPRACHEN}%
	\pgfkeys{/variables/personal = Persönlich}%
	\pgfkeys{/variables/professional = Professionel}%
	\pgfkeys{/variables/profile = PROFIL}%
	\pgfkeys{/variables/projects = Projekte}%
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
			macro.}{Only `english' and `german' are valid options %
			for this macro.}}
}
\ExplSyntaxOff
\cvSetLanguage{german}

% Create counters so pages can be referenced in the document
\newcounter{cvPage}
\newcounter{attachment}

%----------------------------------------------------------------------------------------
%   Commands for profile info
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\setFirstName}{m}{\pgfkeyssetvalue{firstName}{#1}}
\NewDocumentCommand{\setLastName}{m}{\pgfkeyssetvalue{lastName}{#1}}

\xdef\profilePicture{\empty}
\NewDocumentCommand{\setPicture}{m}{
	\@IfNoValueOrEmpty{#1}{}{\xdef\profilePicture{#1}}
}

\NewDocumentCommand{\displayCompanyAdress}{}{
	\textbf{\pgfkeysvalueof{companyName}}\\
	\pgfkeysvalueof{contactPerson}
	\pgfkeysvalueof{companyAddress}\\
	\pgfkeysvalueof{companyZip} \pgfkeysvalueof{companyCity}
}

\NewDocumentCommand{\displaySubject}{O{Bewerbung als}O{\today}}{
	\textbf{#1 \pgfkeysvalueof{position}}  \null\hfill #2\\
	{\pgfkeysvalueof{jobofferlocation}
	\pgfkeysvalueof{positionid}}
}

\xdef\signature{\empty}
\NewDocumentCommand{\setSignaturePicture}{m}{\@IfNoValueOrEmpty{#1}{}{\xdef\signature{#1}}}

\NewDocumentCommand{\displaysignature}{O{5cm}}{
	\begin{figure}[htbp]
		\includegraphics[width=#1]{\signature}
	\end{figure}
}
\NewDocumentCommand{\setAddress}{m}{\pgfkeyssetvalue{address}{#1}}
\NewDocumentCommand{\setJobofferURL}{m}{\pgfkeyssetvalue{jobofferlocation}{#1}}
\NewDocumentCommand{\setZipcode}{m}{\pgfkeyssetvalue{zipcode}{#1}}
\NewDocumentCommand{\setCity}{m}{\pgfkeyssetvalue{city}{#1}}
\NewDocumentCommand{\setEmail}{m}{\pgfkeyssetvalue{email}{#1}}
\NewDocumentCommand{\setPhone}{m}{\pgfkeyssetvalue{phoneNumber}{#1}}
\NewDocumentCommand{\setPosition}{m}{\pgfkeyssetvalue{position}{#1}}
\NewDocumentCommand{\setPositionId}{m}{\pgfkeyssetvalue{positionid}{#1}}
\NewDocumentCommand{\setCompanyName}{m}{\pgfkeyssetvalue{companyName}{#1}}
\NewDocumentCommand{\setContactPerson}{m}{\pgfkeyssetvalue{contactPerson}{#1}}
\NewDocumentCommand{\setCompanyAddress}{m}{\pgfkeyssetvalue{companyAddress}{#1}}
\NewDocumentCommand{\setCompanyZip}{m}{\pgfkeyssetvalue{companyZip}{#1}}
\NewDocumentCommand{\setCompanyCity}{m}{\pgfkeyssetvalue{companyCity}{#1}}

%----------------------------------------------------------------------------------------
%   Cover Letter Environment
%----------------------------------------------------------------------------------------
\newlength\@fullNameWidth
\newlength\@addressWidth
\newlength\@addressHeight

% Calculates width and height of text, is needed for block sizes adjustments
\NewDocumentCommand{\@calculateDimensions}{}{
	\fontsize{14}{12}\selectfont
	\setlength\@fullNameWidth{\widthof{\pgfkeysvalueof{firstName} \pgfkeysvalueof{lastName}}}

	\fontsize{10}{12}\selectfont

	\setlength\@addressWidth{\maxof{\widthof{\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}}}{\widthof{\pgfkeysvalueof{email}}}}

	\setlength\@addressBlockWidth{0.5\paperwidth-0.5\@coverletterWidth+\@addressWidth}
	\setlength\@addressHeight{\heightof{\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}}}
	\setlength\@addressBlockHeight{6\@addressHeight+.3cm}
}

\NewDocumentEnvironment{coverletter}{O{\@headerHeight} O{\@footerHeight}}{
	\setlength\@headerHeight{#1}
	\setlength\@footerHeight{#2}
	\color{fontColor}
	\refstepcounter{cvPage}\label{cvPage.\thecvPage}
	\newgeometry{textwidth=\@coverletterWidth,textheight=\paperheight,noheadfoot}
	\begin{tikzpicture}[remember picture, overlay, every node/.style={inner sep=0cm, outer sep=0cm}]
		\begin{scope}[on background layer]
			% Header
			\fill[backgroundColor] (current page.north west) rectangle ++(\paperwidth, -0.8\@headerHeight);

			\@calculateDimensions

			\coordinate (nameBlockPos) at ($(current page.north west)+(0pt,-0.8\@headerHeight+0.5\@nameBlockHeight)$);
			\coordinate (addressBlockPos) at ($(current page.south west)+(0pt,\@footerHeight-0.5\@addressBlockHeight)$);

			\fill[blockColor, drop shadow] (nameBlockPos) rectangle%
			++(0.5\paperwidth-0.5\@coverletterWidth+\@fullNameWidth+0.3cm,-\@nameBlockHeight)%
			node [anchor=west, xshift=-\@fullNameWidth-0.3cm,yshift=0.5\@nameBlockHeight] (coverletter name)
			{\fontsize{14}{12}\selectfont\color{white}\pgfkeysvalueof{firstName} \pgfkeysvalueof{lastName}};

			% Footer
			\fill[backgroundColor] (current page.south east) rectangle ++(-\paperwidth, \@footerHeight);

			% Blue address block
			\fill[blockColor,drop shadow] (addressBlockPos) rectangle%
			++(\@addressBlockWidth+0.3cm,\@addressBlockHeight)
			node[anchor=west, text=white,xshift=-\@addressWidth-0.3cm, yshift=-0.5\@addressBlockHeight] (email)
			{\href{mailto:\pgfkeysvalueof{email}}{\color{white}{\pgfkeysvalueof{email}}}};

			\node[align=right,text=white,below=-8pt-\@addressHeight of email.north west,anchor=north west]
			(address)
			{\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}};

			\node[align=right,text=white,below=8pt+\@addressHeight of email.south west, anchor=south west]
			(phone)
			{\pgfkeysvalueof{phoneNumber}};

		\end{scope}
	\end{tikzpicture}
	% Ensures the space below header
	\vspace{\dimexpr\@headerHeight-1in-\topmargin\relax}
}{
	% Ensures the space above footer
	\vspace{\dimexpr\@footerHeight+1.2cm\relax}
	\restoregeometry
	\cleardoublepage
}

%----------------------------------------------------------------------------------------
%   Sidebar Environment
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\@hRulefill}{}{
	{\color{accentColor}%
	\leavevmode\leaders\hrule height \@sBSectionLineWidth\hfill\kern\z@}
}

\NewDocumentCommand{\@ruleline}{m}{
	\par\noindent\raisebox{.6ex}{%
		\makebox[\linewidth]{\@hRulefill\hspace{1ex}%
			\raisebox{-.6ex}{#1}\hspace{1ex}\@hRulefill}}%
}

\NewDocumentCommand{\displaySidebarSignature}{}{
	\vfill
	\includegraphics[width=4cm]{\signature}\\
	\pgfkeysvalueof{city}, \today
}

\newif\if@isPictureDefined
\global\@isPictureDefinedfalse

% Optional arguments: xshift, yshift, picture size
\NewDocumentCommand{\displaySidebarPicture}{O{0cm}O{0cm}O{0cm}}{
	\IfFileExists{\profilePicture}{
		\global\@isPictureDefinedtrue
		\begin{tikzpicture}[remember picture, overlay]
			\node[@sidebarPicturePosition,
				yshift=\textheight+2\@margin,
				xshift=-3.5pt,
				minimum width=\@sideWidth+2\@margin-2pt,
				draw, line width = 2pt,color=backgroundColor,
				minimum height= 150pt,
				path picture={
					\node[xshift=#1,yshift=#2,anchor=center] at (path picture bounding box.center){\includegraphics[height=150pt+#3]{\profilePicture}};
				}
			] at (sidebar.north east) (picture)
			{};

		\end{tikzpicture}
	}{\global\@isPictureDefinedfalse}
	\vspace{150pt}
}

\NewDocumentCommand{\displaySidebarName}{}{
	\if@isPictureDefined
		\begin{tikzpicture}[remember picture, overlay]
			\node[anchor=north, yshift=-10pt] at (picture.south) {
				{\LARGE
				\vspace{3\@idNameSep}
				\pgfkeysvalueof{firstName}
				\vspace{3\@idNameSep}
				\pgfkeysvalueof{lastName}
				\vspace{\@positionSep}}
			};
		\end{tikzpicture}
	\else
		\begin{center}
			\LARGE
			\vspace{3\@idNameSep}
			\pgfkeysvalueof{firstName}
			\vspace{3\@idNameSep}
			\pgfkeysvalueof{lastName}
			\vspace{\@positionSep}
		\end{center}
	\fi
}

\NewDocumentCommand{\displayJobDetails}{}{
	\begin{center}
		\pgfkeysvalueof{position}\\
		\pgfkeysvalueof{positionid}
	\end{center}
	\vspace{\@positionSep}
	\vspace{10pt}
}

% Left Sidebar
\NewDocumentEnvironment{sidebar}{}{
	\tikzset{@sidebarPicturePosition/.style = {anchor=north east},}
	\refstepcounter{cvPage}\label{cvPage.\thecvPage}
	\begin{tikzpicture}[remember picture,overlay]
		\fill[backgroundColor](current page.north west)rectangle%
		++(\@sideWidth+2\@margin,-\paperheight) node [anchor=north] (sidebar){};
	\end{tikzpicture}
	\color{fontColor}
	\begin{flushleft}
		\begin{minipage}[c][\@minipageLength]{\@sideWidth}
			\begin{center}
}{
			\end{center}
		\end{minipage}
	\end{flushleft}
}

\NewDocumentEnvironment{sidebar*}{}{
	\tikzset{@sidebarPicturePosition/.style = {anchor=north west},}
	\refstepcounter{cvPage}\label{cvPage.\thecvPage}
	\begin{tikzpicture}[remember picture,overlay]
		\fill[backgroundColor](current page.north east)rectangle%
		++(-\@sideWidth-2\@margin,-\paperheight) node [anchor=north] (sidebar){};
	\end{tikzpicture}
	\color{fontColor}
	\begin{flushright}
		\begin{minipage}[c][\@minipageLength]{\@sideWidth}
		\begin{center}
}{
		\end{center}
	\end{minipage}
	\end{flushright}
}

\NewDocumentEnvironment{profile}{}{%
	\vspace{\@sectionSBSep}
	\@ruleline{\pgfkeysvalueof{/variables/profile}}
	\vspace{\@sectionSBSep}\\
}{%
\vspace{.5cm}
}

\NewDocumentEnvironment{miscellaneous}{}{}{\vspace{.5cm}}

\NewDocumentCommand{\@contactTemplate}{mm}{
	\NewDocumentCommand{#1}{m}{
		\if@contactfirst \\ \else %
			\global\@contactfirsttrue \fi\node[@contactIcon]{#2};
		\pgfmatrixnextcell \node[@contactText]{##1};
	}
}

\NewDocumentCommand{\@contactTemplateLink}{mm}{
	\NewDocumentCommand{#1}{mm}{
		\if@contactfirst \\ \else %
			\global\@contactfirsttrue \fi\node[@contactIcon]{#2};
		\pgfmatrixnextcell \node[@contactText]{%
			\@IfNoValueOrEmpty{##1}{##2}{\href{##1}{##2}}};
	}
}

\NewDocumentCommand{\contactTemplate}{O{} mm}{
	\if@contactfirst%
		\\%
	\else %
		\global\@contactfirsttrue %
	\fi %
	\node[@contactIcon]{#2};
	\pgfmatrixnextcell \node[@contactText]{%
		\@IfNoValueOrEmpty{#1}{#3}{\href{#1}{#3}}%
	};
}

\newif\if@contactfirst
\NewDocumentEnvironment{contact}{}{%
	\vspace{\@sectionSBSep}
	\@ruleline{\pgfkeysvalueof{/variables/contact}}%
	\vspace{15pt}

	\global\@contactfirstfalse
	\@contactTemplate{\address}{\faMapMarker*}
	\@contactTemplate{\phone}{\faPhone}

	\@contactTemplateLink{\email}{\faEnvelope}
	\@contactTemplateLink{\website}{\faGlobe}
	\@contactTemplateLink{\github}{\faGithub}
	\@contactTemplateLink{\linkedin}{\faLinkedinSquare}
	\@contactTemplateLink{\twitter}{\faTwitter}
	\@contactTemplateLink{\keybase}{\faKey}
	\begin{tikzpicture}[every node/.style={inner sep=0pt, outer sep=0pt}]
		\matrix [
			column 1/.style={anchor=east},
			column 2/.style={anchor=west,align=left},
			column sep=\@contactItemSep,
			row sep=\@contactItemSep,
			inner sep=0pt,
			outer sep=0pt] (contact)
		\bgroup
			\address{\pgfkeysvalueof{address}\\\pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}}
			\email{mailto:\pgfkeysvalueof{email}}{\pgfkeysvalueof{email}}
			\phone{\pgfkeysvalueof{phoneNumber}}
}{%
		\\\egroup;
	\end{tikzpicture}%
	\vspace{.5cm}
}

\newcounter{@languages}
\setcounter{@languages}{1}
\pgfkeys{
	/languages/.is family,
	/languages/.unknown/.style = {%
		\pgfkeyscurrentpath/\pgfkeyscurrentname/.initial = #1
	}
}

\NewDocumentEnvironment{languages}{}{%
	\NewDocumentCommand{\languageRating}{mm}{%
		{\globaldefs=1\relax\pgfkeys{%
					/languages/lang\the\value{@languages} = ##2}}
		\node[]{##1}; \pgfmatrixnextcell %
		\node[@progressArea] (@language \the\value{@languages}) {}; \\
		\stepcounter{@languages}
	}%
	\vspace{\@sectionSBSep}
	\@ruleline{\pgfkeysvalueof{/variables/languages}}%
	% \vspace{\@sectionSBSep}
	\vspace{15pt}
	\begin{tikzpicture}[every node/.style={text depth=0pt,inner sep=0pt,outer sep=0pt}]
		\matrix [column 1/.style=@column1,column 2/.style=@column2,%
		column sep=1.5\@sectionSBSep,row sep=1.5\@sectionSBSep] (contact)
		\bgroup
}{%
		\\\egroup;
		\newcounter{@languagelevel}
		\setcounter{@languagelevel}{1}
		\loop\ifnum\value{@languagelevel}<\value{@languages}
		\draw (@language \the\value{@languagelevel}.west) %
		node[@progressBar,minimum width=\pgfkeysvalueof{/languages/lang\the\value{@languagelevel}}em]%
		{};
		\stepcounter{@languagelevel}
		\repeat
	\end{tikzpicture}
	\vspace{.5cm}
}

%----------------------------------------------------------------------------------------
%   Body Environment
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\titleText}{m}{\large\textbf{#1}}

\newcounter{@titlePrev}
\setcounter{@titlePrev}{0}
\newcounter{@titleNext}
\setcounter{@titleNext}{1}

\NewDocumentCommand{\@createTitle}{mm}{%
	\color{fontColor}

	\ifnodedefined{last item \the\value{@lastItem}}{%
		\tikzset{@titlenode/.style = {below=\@sectionSep of last item \the\value{@lastItem}.south west}}
	}{
		\tikzset{@titlenode/.style = {}}
	}

	\node[@titlenode,@sectionTitle](@title \the\value{@titleNext})
	{
		\begingroup\edef\y
		{\endgroup\titleText\bgroup\noexpand\extract{#1}{1}}\y\StrGobbleLeft{#1}{1}\egroup
	};

	\node[left=\@timeDotSep of @title \the\value{@titleNext},@headerIcon]
	{#2};

	\node[@titlenode,@sectionTitle](@title \the\value{@titleNext} dummy)
	{\phantom{\titleText{Education}}};

	\begin{scope}[on background layer]
		\draw[line width=\@titleLineWidth,accentColor]
		let
			\p1=(@title \the\value{@titleNext} dummy.south west),
			\p2=(current page.east) in (\x1,\y1-\@titleLineSpacing) to (\@mainWidth-\@timeDotSep,\y1-\@titleLineSpacing);
	\end{scope}
	\stepcounter{@titlePrev}%
	\stepcounter{@titleNext}
}

\NewDocumentCommand{\@endSectionDraw}{}{
	\color{accentColor}
	\draw (start) to (end.center);
}

\newcounter{@itemPrev}
\setcounter{@itemPrev}{0}
\newcounter{@itemNext}
\setcounter{@itemNext}{1}
\newcounter{@lastItem}
\setcounter{@lastItem}{1}

\NewDocumentCommand{\@definecvItem}{}{
	\NewDocumentEnvironment{cvItem}{}{%
		\ifnodedefined{item \the\value{@itemPrev}}{%
			\tikzset{@skillnode/.style= {below=\@itemSep of item \the\value{@itemPrev}.south west}}
		}{
			\tikzset{@skillnode/.style= {below=\@itemSep of @title \the\value{@titlePrev}.south west}}
		}

		\node[@skillnode,@eventdotText]
		(item \the\value{@itemNext} header){\phantom{Evening}};

		\node[@skillnode,@sectionEduText]
		(item \the\value{@itemNext})
		\bgroup
	}{
		\egroup;

		\ifnodedefined{item \the\value{@itemPrev}}{%
			\node[left=\@timeDotSep of item \the\value{@itemNext} header,@timedot]
			{};
		}{
			\node[left=\@timeDotSep of item \the\value{@itemNext} header,@timedot]
			(start)
			{};
		}
		\node[left=\@timeDotSep of item \the\value{@itemNext}.south west,@invisibleTimeDot]
		(end)
		{};
		\stepcounter{@itemPrev}
		\stepcounter{@itemNext}
	}
}

\NewDocumentEnvironment{body}{}{%
	\begin{tikzpicture}
		[every node/.style={inner sep=0pt,outer sep=0pt},remember picture,overlay,
			shift={($(current page.north west)+(\@sideWidth+2.5\@margin+\@timeDotSep,-\@margin)$)}]
		\begin{scope}[on background layer]
}{%
		\end{scope}
	\end{tikzpicture}
	\restoregeometry
	\setcounter{@itemPrev}{0}
	\setcounter{@itemNext}{1}
	\setcounter{@lastItem}{1}
}

\NewDocumentEnvironment{body*}{}{%
	\stepcounter{@titlePrev}
	\stepcounter{@titleNext}
	\begin{tikzpicture}[%
			every node/.style={inner sep=0pt,outer sep=0pt},remember picture,overlay,
			shift={($(current page.north west)+(\@margin+\@timeDotSep,-\@margin)$)}]
		}{%
	\end{tikzpicture}%
	\restoregeometry
	\setcounter{@itemPrev}{0}
	\setcounter{@itemNext}{1}
	\setcounter{@lastItem}{1}
}

% Environment template
\NewDocumentCommand{\@createEnvironment}{mmm}{
	\NewDocumentEnvironment{#1}{O{#2}}{
		\@createTitle{#2}{#3}
		\stepcounter{@itemPrev}
		\stepcounter{@itemNext}
		\@definecvItem
	}{
		\@endSectionDraw
		\stepcounter{@lastItem}
		\draw (item \the\value{@itemPrev}.south west)
		node (last item \the\value{@lastItem}) {};
	}
}

% Create needed environments
\@createEnvironment{experience}{\pgfkeysvalueof{/variables/experience}}{\faBriefcase}
\@createEnvironment{education}{\pgfkeysvalueof{/variables/education}}{\faGraduationCap}
\@createEnvironment{scholarship}{\pgfkeysvalueof{/variables/scholarship}}{\faDollarSign}
\@createEnvironment{interests}{\pgfkeysvalueof{/variables/interests}}{\faGraduationCap}

\newcount\my@repeat@count
\NewDocumentCommand{\@markGrade}{m}{%
	\begingroup
	\my@repeat@count=\z@
	\@whilenum\my@repeat@count<#1\do{\faStar\advance%
		\my@repeat@count\@ne}%
	\my@repeat@count=\numexpr5-\z@\relax
	\@whilenum\my@repeat@count>#1\do{\faStar[regular]\advance%
		\my@repeat@count\m@ne}%
	\endgroup
}

\newif\if@isFirstSkill
\newif\if@isOneSkill
\newif\if@isGradelessSkill
\NewDocumentCommand{\@twoSkillsTable}{}{}
\NewDocumentCommand{\@oneSkillTable}{}{}
\NewDocumentCommand{\@gradelessSkillTable}{}{}

\NewDocumentCommand{\skillTwo}{mmmm}{%
	\if@isFirstSkill
		\g@addto@macro\@twoSkillsTable{\@markGrade{#1} & #2 & \@markGrade{#3} & #4}
		\@isFirstSkillfalse
	\else
		\g@addto@macro\@twoSkillsTable{\\[\@skillSep] \@markGrade{#1} & #2 & \@markGrade{#3} & #4}
	\fi
}
\NewDocumentCommand{\skillOne}{mm}{%
	\@isOneSkilltrue

	\if@isFirstSkill
		\g@addto@macro\@oneSkillTable{\@markGrade{#1} & #2}
		\@isFirstSkillfalse
	\else
		\g@addto@macro\@oneSkillTable{\\[\@skillSep] \@markGrade{#1} & #2}
	\fi
}
\NewDocumentCommand{\skill}{m}{%
	\@isGradelessSkilltrue

	\if@isFirstSkill
		\g@addto@macro\@gradelessSkillTable{\parbox{\@mainWidth-\@timeDotSep}{#1}}
		\@isFirstSkillfalse
	\else
		\g@addto@macro\@gradelessSkillTable{\\[\@skillSep] \parbox{\@mainWidth-\@timeDotSep}{#1}}
	\fi
}

\NewDocumentEnvironment{skills}{O{\pgfkeysvalueof{/variables/skills}}}{%
	\@createTitle{#1}{\faStar}
	\global\@isFirstSkilltrue
	\global\@isOneSkillfalse
	\global\@isGradelessSkillfalse
}{%
	\node[below=\@sectionSep of @title \the\value{@titlePrev}.south west,anchor=north west]
	(skills)
	{
		\begin{tabular}{@{}l@{\hskip 5pt}l@{\hskip \@colSep}l@{\hskip 5pt}l@{}}%
			\@twoSkillsTable
		\end{tabular}
	};
	\if@isOneSkill
		\node[below=-0.65\@sectionSep of skills.south west,anchor=north west,]
		 (skills)
		{
			\begin{tabular}{@{}l@{\hskip 5pt}l@{}}%
				\@oneSkillTable
			\end{tabular}
		};
	\fi

	\if@isGradelessSkill
		\node[below=-0.65\@sectionSep of skills.south west,anchor=north west]
		(skills)
		{
			\begin{tabular}{@{}l}%
				\@gradelessSkillTable
			\end{tabular}
		};
	\fi

	\stepcounter{@lastItem}
	\draw (skills.south west) node %
	(last item \the\value{@lastItem}) {};
}

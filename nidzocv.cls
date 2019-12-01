% !TEX program = pdflatex
% !TEX encoding = UTF-8 Unicode
% !TEX root = main.tex
% !TEX options = -synctex=1 -interaction=nonstopmode -file-line-error "%DOC%"

\ProvidesClass{nidzocv}
\LoadClass{article}

\RequirePackage[german]{babel}
\RequirePackage{lipsum}
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

% Create counters so pages can be referenced in the document
\newcounter{cvpage}
\newcounter{attachment}
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
	shapes.misc
}

\hypersetup{
	colorlinks=true,
	linkcolor=blue,
	% filecolor=magenta,
	urlcolor=blue,
}

\RenewDocumentCommand{\familydefault}{}{\sfdefault}

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
	@contactIcon/.style={minimum height=\baselineskip},
	@contactText/.style={minimum height=\baselineskip,text depth=0pt},
	@eventdottext/.style = {text width=\@mainWidth-\@timeDotSep,fontColor,anchor=north west},
	@headerIcon/.style={minimum width=\@headerIconWidth,anchor=center},
	@invisibletimedot/.style = {circle,minimum width=\@timeDotDiameter,anchor=center},
	@progressArea/.style={minimum width=\@progressAreaWidth,minimum height=\@progressAreaHeight,rectangle,draw,accentColor},
	@progressBar/.style={minimum height=\@progressAreaHeight,rectangle,draw,fill,accentColor,anchor=west},
	@sectionEduText/.style={@eventdottext,anchor=north west,align=justify},
	@sectionTitle/.style={anchor=north west,align=left},
	@timedot/.style = {@invisibletimedot,draw,fill,accentColor},
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
\newlength\@nameblockHeight
\setlength\@nameblockHeight{1.3cm}
\newlength\@footerHeight
\setlength\@footerHeight{3cm}
\newlength\@addressblockHeight
\setlength\@addressblockHeight{2cm}
\newlength\@addressblockWidth
\setlength\@addressblockWidth{\@sideWidth+2.4\@margin}
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
	\@IfNoValueOrEmpty{#1}{}{\xdef\profilepicture{#1}}
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
\NewDocumentCommand{\setSignaturePicture}{m}{
	\@IfNoValueOrEmpty{#1}{}{\xdef\signature{#1}}
}
\NewDocumentCommand{\displaysignature}{O{5cm}}{
	\begin{figure}[htbp]
		\includegraphics[width=#1]{\signature}
	\end{figure}
}
\NewDocumentCommand{\setAddress}{m}{
	\pgfkeyssetvalue{address}{#1}
}
\NewDocumentCommand{\setJobofferlocation}{m}{
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
\NewDocumentCommand{\setContactPerson}{m}{
	\pgfkeyssetvalue{contactPerson}{#1}
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
\newlength\@fullnameWidth
\newlength\@addressWidth
\newlength\@addressHeight

\NewDocumentCommand{\@calculateLengths}{}{
	\fontsize{14}{12}\selectfont
	\setlength\@fullnameWidth{\widthof{\pgfkeysvalueof{firstName} \pgfkeysvalueof{lastName}}}

	\fontsize{10}{12}\selectfont

	\setlength\@addressWidth{\maxof{\widthof{\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}}}{\widthof{\pgfkeysvalueof{email}}}}

	\setlength\@addressblockWidth{0.5\paperwidth-0.5\@coverletterWidth+\@addressWidth}
	\setlength\@addressHeight{\heightof{\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}}}
	\setlength\@addressblockHeight{6\@addressHeight+.3cm}
}

\NewDocumentEnvironment{coverletter}{O{\@headerHeight} O{\@footerHeight}}{
	\setlength\@headerHeight{#1}
	\setlength\@footerHeight{#2}
	\color{fontColor}
	\refstepcounter{cvpage}\label{cvpage.\thecvpage}
	\newgeometry{textwidth=\@coverletterWidth,textheight=\paperheight,noheadfoot}
	\begin{tikzpicture}[remember picture, overlay, every node/.style={inner sep=0cm, outer sep=0cm}]
		\begin{scope}[on background layer]
			% Header
			\fill[backgroundColor] (current page.north west) rectangle ++(\paperwidth, -0.8\@headerHeight);

			\@calculateLengths

			\coordinate (nameblockpos) at ($(current page.north west)+(-2pt,-0.8\@headerHeight+0.5\@nameblockHeight)$);
			\coordinate (addressblockpos) at ($(current page.south west)+(-2pt,\@footerHeight-0.5\@addressblockHeight)$);

			\fill[accentColor,draw=white,line width=1mm] (nameblockpos) rectangle%
			++(0.5\paperwidth-0.5\@coverletterWidth+\@fullnameWidth+0.3cm,-\@nameblockHeight)%
			node [anchor=west, xshift=-\@fullnameWidth-0.3cm+2pt, yshift=0.5\@nameblockHeight] (coverletter name)
			{\fontsize{14}{12}\selectfont\color{white}\pgfkeysvalueof{firstName} \pgfkeysvalueof{lastName}};

			% Footer
			\fill[backgroundColor] (current page.south east) rectangle ++(-\paperwidth, \@footerHeight);

			% Blue address block
			\fill[accentColor,draw=white,line width=1mm] (addressblockpos) rectangle%
			++(\@addressblockWidth+0.3cm,\@addressblockHeight)
			node[anchor=west, text=white,xshift=-\@addressWidth-0.3cm+2pt, yshift=-0.5\@addressblockHeight] (email)
			{\href{mailto:\pgfkeysvalueof{email}}{\color{white}{\pgfkeysvalueof{email}}}};

			\node[align=right,text=white,below=-8pt-\@addressHeight of email.north west,anchor=north west]
			(address)
			{\pgfkeysvalueof{address}, \pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}};

			\node[align=right,text=white,below=8pt+\@addressHeight of email.south west, anchor=south west]
			(phone)
			{\pgfkeysvalueof{phoneNumber}};

		\end{scope}
	\end{tikzpicture}

	\vspace{\dimexpr\@headerHeight-1in-\topmargin\relax}
	}{
	\vspace{\dimexpr\@footerHeight+1.2cm\relax}
	\restoregeometry
	\cleardoublepage
}

%----------------------------------------------------------------------------------------
%   Sidebar Environment
%----------------------------------------------------------------------------------------
\NewDocumentCommand{\@cvhrulefill}{}{
	{\color{accentColor}%
	\leavevmode\leaders\hrule height \@sBSectionLineWidth\hfill\kern\z@}
}

\NewDocumentCommand{\@ruleline}{m}{
	\par\noindent\raisebox{.6ex}{%
		\makebox[\linewidth]{\@cvhrulefill\hspace{1ex}%
			\raisebox{-.6ex}{#1}\hspace{1ex}\@cvhrulefill}}%
}

\NewDocumentCommand{\displaysidebarpicture}{O{0cm}O{0cm}}{
	\IfFileExists{\profilepicture}{
		\begin{tikzpicture}[remember picture, overlay]
			\node[anchor=center,xshift=.5*(\@sideWidth+2\@margin),
				yshift=-0.4*(\@sideWidth+2\@margin)+0.21cm,
				minimum size=7.2cm,
				path picture={
						\node[xshift=#1,yshift=#2,anchor=center,
							% draw,line width=.5mm,
						] at (path picture bounding box.center){
							\includegraphics[width=8cm]{\profilepicture}
						};
					}] at (current page.north west)
			{};
		\end{tikzpicture}
		\vspace{130pt}
	}{}
	\begin{center}
		\LARGE
		\vspace{3\@idNameSep}
		\pgfkeysvalueof{firstName}
		\vspace{3\@idNameSep}
		\pgfkeysvalueof{lastName}
		\vspace{\@positionSep}
	\end{center}
}

\NewDocumentCommand{\displayjobdetails}{}{
	\begin{center}
		\pgfkeysvalueof{position}\\
		\pgfkeysvalueof{positionid}
	\end{center}
	\vspace{\@positionSep}
}

% Left Sidebar
\NewDocumentEnvironment{sidebar}{}{
	\refstepcounter{cvpage}\label{cvpage.\thecvpage}
	\begin{tikzpicture}[remember picture,overlay]
		\fill[backgroundColor]%
		(current page.north west)%
		rectangle%
		++(\@sideWidth+2\@margin,-\paperheight);
	\end{tikzpicture}
	\color{fontColor}
	\begin{minipage}{\@sideWidth}
		\begin{center}
			}{
		\end{center}
	\end{minipage}
	\vspace*{\fill}
}

\NewDocumentEnvironment{profile}{}{%
	\vspace{\@sectionSBSep}
	\@ruleline{\pgfkeysvalueof{/variables/profile}}
	\vspace{\@sectionSBSep}

}{%
}

\NewDocumentEnvironment{miscellaneous}{}{%
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
	\@ContactTemplate{\address}{\faMapMarker*}
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
			column 1/.style={anchor=east},
			column 2/.style={anchor=west,align=left},
			column sep=\@contactItemSep,
			row sep=\@contactItemSep,
			inner sep=0pt,
			outer sep=0pt] (contact) \bgroup
		\address{\pgfkeysvalueof{address}\\\pgfkeysvalueof{zipcode} \pgfkeysvalueof{city}}
		\email{mailto:\pgfkeysvalueof{email}}{\pgfkeysvalueof{email}}
		\phone{\pgfkeysvalueof{phoneNumber}}
		}{%
		\\\egroup;
	\end{tikzpicture}%
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
	\begin{tikzpicture}[%
			every node/.style={text depth=0pt,inner sep=0pt,outer sep=0pt}]
		\matrix [
			column 1/.style={anchor=west},
			column sep=1.5\@sectionSBSep,
			row sep=1.5\@sectionSBSep,
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
\NewDocumentCommand{\titleText}{m}{\large\textbf{#1}}

\newcounter{@titlePrev}
\setcounter{@titlePrev}{0}
\newcounter{@titleNext}
\setcounter{@titleNext}{1}

\NewDocumentCommand{\@Title}{mm}{%
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
		let \p1=(@title \the\value{@titleNext}
		dummy.south west),
		\p2=(current page.east) in
		(\x1,\y1-\@titleLineSpacing) to (\x2,\y1-\@titleLineSpacing);
	\end{scope}
	\stepcounter{@titlePrev}%
	\stepcounter{@titleNext}
}

\NewDocumentCommand{\@EndSectionDraw}{}{
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

		\node[@skillnode,@eventdottext]
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
		\node[left=\@timeDotSep of item \the\value{@itemNext}.south west,@invisibletimedot]
		(end)
		{};
		\stepcounter{@itemPrev}
		\stepcounter{@itemNext}
	}
}

\NewDocumentEnvironment{mainContent}{}{%
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

\NewDocumentEnvironment{education}{O{\pgfkeysvalueof{/variables/education}}}{%
	\@Title{#1}{\faGraduationCap}
	\stepcounter{@itemPrev}
	\stepcounter{@itemNext}
	\@definecvItem
}{%
	\@EndSectionDraw
	\stepcounter{@lastItem}
	\draw (item \the\value{@itemPrev}.south west)
	node (last item \the\value{@lastItem}) {};
}

\NewDocumentEnvironment{experience}{O{\pgfkeysvalueof{/variables/experience}}}{%
	\@Title{#1}{\faBriefcase}
	\stepcounter{@itemPrev}
	\stepcounter{@itemNext}
	\@definecvItem
}{%
	\@EndSectionDraw
	\stepcounter{@lastItem}
	\draw (item \the\value{@itemPrev}.south west)
	node (last item \the\value{@lastItem}) {};
}

\NewDocumentEnvironment{scholarship}{O{\pgfkeysvalueof{/variables/scholarship}}}{%
	\@Title{#1}{\faEuroSign}
	\stepcounter{@itemPrev}
	\stepcounter{@itemNext}
	\@definecvItem
}{%
	\@EndSectionDraw
	\stepcounter{@lastItem}
	\draw (item \the\value{@itemPrev}.south west)
	node (last item \the\value{@lastItem}) {};
}

\newcount\my@repeat@count
\NewDocumentCommand{\@skillgrade}{m}{%
	\begingroup
	\my@repeat@count=\z@
	\@whilenum\my@repeat@count<#1\do{\faStar\advance%
		\my@repeat@count\@ne}%
	\my@repeat@count=\numexpr5-\z@\relax
	\@whilenum\my@repeat@count>#1\do{\faStar[regular]\advance%
		\my@repeat@count\m@ne}%
	\endgroup
}

\newif\if@firstskill
\newif\if@skillone
\newif\if@skillgradeless
\NewDocumentCommand{\@skillsTwoTable}{}{}
\NewDocumentCommand{\@skillsOneTable}{}{}
\NewDocumentCommand{\@skillsTable}{}{}
\NewDocumentCommand{\skillTwo}{mmmm}{%
	\if@firstskill
		\g@addto@macro\@skillsTwoTable{\@skillgrade{#1} & #2 & \@skillgrade{#3} & #4}
		\@firstskillfalse
	\else
		\g@addto@macro\@skillsTwoTable{\\[\@skillSep] \@skillgrade{#1} & #2 & \@skillgrade{#3} & #4}
	\fi
}
\NewDocumentCommand{\skillOne}{mm}{%
	\@skillonetrue

	\if@firstskill
		\g@addto@macro\@skillsOneTable{\@skillgrade{#1} & #2}
		\@firstskillfalse
	\else
		\g@addto@macro\@skillsOneTable{\\[\@skillSep] \@skillgrade{#1} & #2}
	\fi
}
\NewDocumentCommand{\skill}{m}{%
	\@skillgradelesstrue

	\if@firstskill
		\g@addto@macro\@skillsTable{\parbox{\@mainWidth-\@timeDotSep}{#1}}
		\@firstskillfalse
	\else
		\g@addto@macro\@skillsTable{\\[\@skillSep] \parbox{\@mainWidth-\@timeDotSep}{#1}}
	\fi
}

\NewDocumentEnvironment{skills}{O{\pgfkeysvalueof{/variables/skills}}}{%
	\@Title{#1}{\faStar}
	\global\@firstskilltrue
	\global\@skillonefalse
	\global\@skillgradelessfalse
}{%
	\node[below=\@sectionSep of @title \the\value{@titlePrev}.south west,anchor=north west]
	(skills)
	{
		\begin{tabular}{@{}l@{\hskip 5pt}l@{\hskip \@colSep}l@{\hskip 5pt}l@{}}%
			\@skillsTwoTable
		\end{tabular}
	};

	\if@skillone
		\node[below=-0.65\@sectionSep of skills.south west,anchor=north west,]
		 (skills)
		{
			\begin{tabular}{@{}l@{\hskip 5pt}l@{}}%
				\@skillsOneTable
			\end{tabular}
		};
	\fi

	\if@skillgradeless
		\node[below=-0.65\@sectionSep of skills.south west,anchor=north west]
		(skills)
		{
			\begin{tabular}{@{}l}%
				\@skillsTable
			\end{tabular}
		};
	\fi

	\stepcounter{@lastItem}
	\draw (skills.south west) node %
	(last item \the\value{@lastItem}) {};
}

\NewDocumentEnvironment{interests}{O{\pgfkeysvalueof{/variables/interests}}}{%
	\@Title{#1}{\faUser}
	\stepcounter{@itemPrev}
	\stepcounter{@itemNext}
	\@definecvItem
}{%
	\@EndSectionDraw
	\stepcounter{@lastItem}
	\draw (item \the\value{@itemPrev}.south west)
	node (last item \the\value{@lastItem}) {};
}

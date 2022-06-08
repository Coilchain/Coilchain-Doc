% coilchain.cls
%
% A LaTeX2e document class for coilchain documents.
%

%----Define file version and date------%
\newcommand{\fileversion}{1.0}
\newcommand{\filedate}{2022/03/22}

%-------Declarations------%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{coilchain}[\filedate\space v\fileversion\space]
\PassOptionsToClass{oneside}{article}
\LoadClassWithOptions{article}

%------Required packages------%
\PassOptionsToPackage{a4paper,margin=1in,marginparwidth=5cm}{geometry}
\PassOptionsToPackage{absolute}{textpos}
\PassOptionsToPackage{T1}{fontenc}
\usepackage[utf8]{inputenc}
\PassOptionsToPackage{default}{sourcesanspro}
\PassOptionsToPackage{french,english}{datetime2}
\PassOptionsToPackage{scale=1.0}{ccicons}

\RequirePackage{booktabs,calc,datetime,datetime2,draftwatermark,etoolbox,enumitem,fancyhdr,graphicx,ifthen,keyval,multicol,parskip,tikz,titlesec,xparse,xstring}
\RequirePackage{geometry}
\RequirePackage{textpos}
\RequirePackage{sourcesanspro}
\RequirePackage{fontenc}
\RequirePackage{float}
\RequirePackage{subfig}
\RequirePackage{ccicons}
\RequirePackage{hyperref}
\SetWatermarkText{}
\setlength{\TPHorizModule}{\paperwidth}\setlength{\TPVertModule}{\paperheight}

%--------Process options-----------%
\makeatletter
\DeclareOption{technicalreport}{\newcommand{\doctitle@type}{%
		\doctitle{Technical Report}}}
\DeclareOption{technicalpolicy}{\newcommand{\doctitle@type}{%
		\doctitle{Technical Policy}}}
\DeclareOption{generalannouncement}{\newcommand{\doctitle@type}{%
		\doctitle{General Announcement}}}
\DeclareOption{datasheet}{\newcommand{\doctitle@type}{%
		\doctitle{Datasheet}}}
		
%--------Option toggle-----------%
\newtoggle{invoice}\DeclareOption{invoice}{\toggletrue{invoice}}
\newtoggle{letter}\DeclareOption{letter}{\toggletrue{letter}}
\newtoggle{offer}\DeclareOption{offer}{\toggletrue{offer}}
\newtoggle{short}\DeclareOption{short}{\toggletrue{short}}
\ProcessOptions\relax

%---------Toggles fo specific usage----%
\newtoggle{nodisclaimer}
\newtoggle{sublogo}
\newtoggle{draft}
\newtoggle{confidential}

%--------Watermarks------%
\newcommand{\wdraft}{\SetWatermarkText{DRAFT}}
\newcommand{\wconfidential}{\SetWatermarkScale{0.6}\SetWatermarkText{CONFIDENTIAL}}

%--------doctitle------%
\newcommand{\doctitle}[1]{\providecommand{\doctitle@type}{#1}}

%----------\notforpublication------%
\newcommand{\@notforpublication@footer}{}
\newcommand{\@notforpublication@titlep}{}
\newcommand{\notforpublication}{%
	\renewcommand{\@notforpublication@footer}{%
		\textbf{\textup{Not For Publication}}
	}
	\renewcommand{\@notforpublication@titlep}{%
		\begin{center}
				\textbf{\large Important notice:\\ this document is for 
				internal use only and is not intended for distribution to the 
				public.}
		\end{center}		
	}
	}

%--------header and footer------%
\pagestyle{fancy}
\fancyhf{}
\rhead{\thedocid}
\lhead{\rightmark}
\rfoot{\thepage/\pageref{LastPage}}
\lfoot{\iftoggle{nodisclaimer}{\@date}{\raisebox{0.1\height}{\ccbyncsa} \the\year{}  coilchain}
	}
\cfoot{\@notforpublication@footer}

%--------\docid key definitions------%
\newtoggle{hasdocid}
\providecommand{\docid@code}{coilchain}
\providecommand{\docid@sequence}{}
\providecommand{\docid@subcode}{}
\providecommand{\docid@type}{technicalreport}
\providecommand{\docid@year}{}
\providecommand{\docid@revision}{}
\define@key{docid}{code}{\renewcommand{\docid@code}{#1}}
\define@key{docid}{sequence}{\renewcommand{\docid@sequence}{#1}}
\define@key{docid}{subcode}{\renewcommand{\docid@subcode}{#1}}
\define@key{docid}{type}{\renewcommand{\docid@type}{#1}}
\define@key{docid}{year}{\renewcommand{\docid@year}{#1}}
\define@key{docid}{revision}{\renewcommand{\docid@revision}{#1}}
\newcommand{\docid}[1]{%
	\toggletrue{hasdocid}
	\setkeys{docid}{#1}
	}

%-------Looks up the shorttype version of docid@type------%
\newcommand{\DefineDocTypeSuffix}[2]{\@namedef{type@docid@type@#1}{#2}}
\DefineDocTypeSuffix{generalannouncement}{GA}
\DefineDocTypeSuffix{technicalreport}{TR}
\DefineDocTypeSuffix{engineeringpolicy}{EP}
\DefineDocTypeSuffix{documentation}{DOC}
\DefineDocTypeSuffix{proposal}{PR}
\DefineDocTypeSuffix{procesverbal}{PV}
\DefineDocTypeSuffix{ordredujour}{OJ}
\DefineDocTypeSuffix{weeklyreport}{WR}
\DefineDocTypeSuffix{datasheet}{DS}

%-------Create thedocid alphanumerical sequence------%
\newcommand{\thedocid}{\iftoggle{hasdocid}{%
	\docid@code% coilchain
	\docid@subcode-% not used
	\StrRight{\docid@year}{2}% last two digit of the year
	\StrLen{\docid@sequence}[\len@docid@sequence]% measure len of sequence number
	\StrGobbleLeft{0000}{\len@docid@sequence}% prepare 4 zeros and remove sequence len
	\StrRight{\docid@sequence}{4}% place remaining sequence number 
	\@nameuse{type@docid@type@\docid@type}% use the shorttype version of docid@type
	\ifdefempty{\docid@revision}{}{\space Rev.\docid@revision}% declare revision
	}{}}
\newcommand{\thedocidAboveTitle}{\thedocid}

%------\title command------%
\newtoggle{hastitle}
\let\title@old\title
\renewcommand{\title}[1]{\title@old{#1}\toggletrue{hastitle}}

%-------define current revision doc date------%
\renewcommand{\@date}{}
\renewcommand{\date}[3]{\newdate{docdate}{#1}{#2}{#3}}

%-------------\maketitle command------%
\renewcommand{\@author}{}
\renewcommand{\author}[1]{\renewcommand{\@author}{#1}}
\newcommand{\byAuthorHeader}[1]{by #1}
\newcommand{\thelogo}{\includegraphics[height=3em]{coilchainlogo}}
\newcommand{\defsublogo}[1]{\def\@sublogo{#1}}
\newcommand{\thesublogo}{\includegraphics[height=3em]{\@sublogo}}
\newcommand{\titledate}{\displaydate{docdate}\\}
\renewcommand{\maketitle}{%	
	\newpage
	
	\iftoggle{short}{}{\thispagestyle{empty}}
	\null
	\vskip 2em
	\begin{flushright}
		\hrule
		\vskip 1em
		\iftoggle{hasdocid}{\thedocidAboveTitle}{\vskip 1em}
		\vskip 1em
		{\LARGE \doctitle@type}
		\vskip 1em
		\hrule
		\vskip 1em
		\iftoggle{hastitle}{{\LARGE \@title}
		\vskip 1em
		\hrule
		\vskip 1em}{}
		\titledate
		\ifdefempty{\@author}{}{\byAuthorHeader{\@author}\vskip 1em}
		\renewcommand{\do}[1]{##1\newline}
		\dolistloop{\@warnings}
		\vskip 1em
	\end{flushright}
	\par
	\vskip 1.5em
	\begin{textblock}{3}(0.13,0.122)
		{\thelogo}
	\end{textblock}
	
	\iftoggle{sublogo}{
		\begin{textblock}{3}(0.35,0.122)
			{\thesublogo}
		\end{textblock}
		}{}
	
	\iftoggle{short}{}{
		\begin{textblock}{0.5}[0.5,1](0.5,0.8)
			\@notforpublication@titlep
		\end{textblock}
		}
	}
	
%-------\docwarning, \deprecated, \superseded------%
\providecommand{\@warnings}{}
\newcommand{\@docwarning}[1]{\listadd{\@warnings}{#1}}
\NewDocumentCommand{\deprecated}{o}{%
	\@docwarning{\textcolor{red}{\textbf{THIS DOCUMENT IS DEPRECATED%
				\IfValueT{#1}{ SINCE #1}. FOR 
				REFERENCE ONLY.}}}}
\NewDocumentCommand{\superseded}{o}{%
	\@docwarning{\textcolor{red}{\textbf{THIS DOCUMENT IS SUPERSEDED%
				\IfValueT{#1}{ BY #1}. FOR 
				REFERENCE ONLY.}}}}

%----------\assignedto, \personincharge------%
\newcommand{\@relwho}[2]{{\textbf{#1}:~#2}}
\newcommand{\personincharge}[1]{\@relwho{Person in charge}{#1.}}

%---------\introduction environment (not used)------%
\newenvironment{introduction}[1][			
Introduction]{\section*{#1}}{\iftoggle{short}{}{%
		%\vfill\par{\small Please consider the environment before printing.}	
		\newpage}}

%---------\datasheetcover environment------%
\newenvironment{datasheetcover}%
	{%
		\begingroup%
		\setlist[itemize]{noitemsep,topsep=0pt,partopsep=0pt,parsep=0pt}
		\renewcommand\labelitemi{$\vcenter{\hbox{\tiny$\bullet$}}$}%
		\titleformat{\section}{\large\bf}{}{0pt}{}%
		\titlespacing*{\section}{0pt}{16pt}{-\parskip}%

	}%
	{%
		\endgroup%
		\iftoggle{short}{}{\newpage}%
		\setcounter{section}{0}
	}

%----------legal notice------%
\providecommand{\coilchaindisclaimer}{
	\iftoggle{short}{}{\newpage}
	\null
	\vfill
	\begin{samepage}
	{\small
		\begin{center}\textbf{DISCLAIMER}\end{center}
		This document is the property of the author.
		
		The author takes great care when presenting information in its documents but cannot guarantee that published content is accurate, up-to-date, reliable, or complete.
		
		The author reserves the right to modify or erase content in this  document without prior notice and at any time.
		
		No license, express or implied, to any intellectual property right is granted by this document.
		
		The  information  contained  in  these  documents  is  confidential,  privileged  and  only  for  the  information of the intended recipient and may not be used, published or redistributed without the prior written consent of the author.
		
		The author cannot  be  held  liable  for  the  use  of  and  reliance  of  the  opinions,  estimates,  forecasts  and findings in these documents. 
		\begin{center} 
			\raisebox{0.1\height}{\ccbyncsa} \the\year{} coilchain -- Some rights reserved
		\end{center}
	}
	\end{samepage}
}
\newcommand{\nodisclaimer}{\renewcommand{\coilchaindisclaimer}{}\toggletrue{nodisclaimer}}
\newcommand{\notitledate}{\renewcommand{\titledate}{}}
\AtEndDocument{\coilchaindisclaimer\label{LastPage}}

%---- Figure at the exact place ----%
%---- Exemple : \figi{nom_fichier.extension}{label}{Largeur (par ex: 0.6\linewidth)}{Légende de la figure}
\newcommand{\figi}[4]{
   \begin{figure}[h]
   \begin{center}
   \includegraphics[width=#3]{img/#1}
   \caption{\label{#2}#4}
   \end{center}
   \end{figure}   
} 

%---- Figure at the top of the page ----%
%---- Exemple : \figh{nom_fichier.extension}{label}{Largeur (par ex: 0.6\linewidth)}{Légende de la figure}
\newcommand{\figh}[4]{
   \begin{figure}[H]
   \begin{center}
   \includegraphics[width=#3]{img/#1}
   \caption{\label{#2}#4}
   \end{center}
   \end{figure}   
}

%---- Figure simple ----%
\newcommand{\figs}[4]{
   \begin{figure}[H]
   \begin{center}
   \includegraphics[width=#3]{img/#1}
   \end{center}
   \end{figure}   
}

%---- Include a double figure ----%
%---- Exemple : \figdouble{fich1}{fich2}{labelfig}{largeur}{caption_gauche}{caption_droite}{légende}
\newcommand\figdouble[7]{
\begin{figure}[!ht]
    \centering
    \subfloat[#5]{{\includegraphics[width=#4]{img/#1}}}
    \quad
    \subfloat[#6]{{\includegraphics[width=#4]{img/#2}}}
    \caption{#7}
    \label{#3}
\end{figure}
}

%---- Include a double figure ----%
%---- Exemple : \figdouble{fich1}{fich2}{labelfig}{largeur}{caption_gauche}{caption_droite}{légende}
\newcommand\figdoublh[7]{
\begin{figure}[H]
    \centering
    \subfloat[#5]{{\includegraphics[width=#4]{img/#1}}}
    \quad
    \subfloat[#6]{{\includegraphics[width=#4]{img/#2}}}
    \caption{#7}
    \label{#3}
\end{figure}
}

%---- Include a double figure ----%
%---- Exemple : \figdouble{fich1}{fich2}{labelfig}{largeur}{caption_gauche}{caption_droite}{légende}
\newcommand\figdoubla[8]{
\begin{figure}[ht!]
    \centering
    \subfloat[#6]{{\includegraphics[width=#4]{img/#1}}}
    \quad
    \subfloat[#7]{{\includegraphics[width=#5]{img/#2}}}
    \caption{#8}
    \label{#3}
\end{figure}
}


%---- Include a triple figure ----%
%---- Exemple : \figtriple{fich1}{fich2}{fich3}{labelfig}{largeur}{caption_gauche}{caption_centre}{caption_droite}{légende}
\newcommand\figtriple[9]{
\begin{figure}[!ht]
    \centering
    \subfloat[#6]{{\includegraphics[width=#5]{img/#1}}}
    \qquad
    \subfloat[#7]{{\includegraphics[width=#5]{img/#2}}}
    \qquad
    \subfloat[#8]{{\includegraphics[width=#5]{img/#3}}}
    \caption{#9}
    \label{#4}
\end{figure}
}

%---- Include an inline logo ----%

\newlength\myheight
\newlength\mydepth
\settototalheight\myheight{Xygp}
\settodepth\mydepth{Xygp}
\setlength\fboxsep{0pt}
\newcommand*\inlinegraphics[1]{%
  \settototalheight\myheight{Xygp}%
  \settodepth\mydepth{Xygp}%
  \raisebox{-\mydepth}{\hspace{1pt}\includegraphics[height=\myheight]{#1}\hspace{1pt}}%
}

%---- Write a note of something that should be done ----%
\newcommand{\todo}[1]{{\color{red}\textbf{TODO:} #1}}



%------Redefinitions for unconventionnal document types------%
\iftoggle{letter}{\RequirePackage{coilchain-letter}}{}
\iftoggle{offer}{\RequirePackage{coilchain-offer}}{}
\iftoggle{invoice}{\RequirePackage{coilchain-invoice}}{}

%--------tableofcontents------%
\iftoggle{short}
	{\appto{\tableofcontents}{\vskip5em}}
	{\appto{\tableofcontents}{\clearpage}}

\makeatother
\endinput
}
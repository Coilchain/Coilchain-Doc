% coilchainpres.cls
%
% A LaTeX2e document class for coilchain presentations.
%

%----Define file version and date------%
\newcommand{\fileversion}{1.0}
\newcommand{\filedate}{2022/03/22}

%-------Declarations------%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{coilchainpres}[\filedate\space v\fileversion\space]
\PassOptionsToClass{xetex,serif,xcolor=x11names,compress}{beamer}
\LoadClassWithOptions{beamer}

\PassOptionsToPackage{default, semibold}{sourcesanspro}
\RequirePackage{sourcesanspro}

\setbeamerfont{title}{series=\bfseries,parent=structure}
\setbeamerfont{frametitle}{series=\mdseries,parent=structure}

\RequirePackage{tikz}

\PassOptionsToPackage{absolute,overlay}{textpos}
\RequirePackage{textpos}

%--------Process options-----------%
\makeatletter
\newtoggle{simple}\DeclareOption{simple}{\toggletrue{simple}}
\ProcessOptions\relax


%------Include option style------%
\iftoggle{simple}{\RequirePackage{coilchain-simple}}{}

% Place a picture over the slide
\newcommand{\fullsizegraphic}[1]{%
\usebackgroundtemplate{\includegraphics[width=\paperwidth]{#1}}
}
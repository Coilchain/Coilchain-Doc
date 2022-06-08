:: Called from Notepad++ Run  
:: [path_to_bat_file] "$(CURRENT_DIRECTORY)" "$(NAME_PART)"  

:: Change Drive and  to File Directory  
%~d1  
cd %1

:: Run Cleanup  
call:cleanup  

:: Run pdflatex -&gt; bibtex -&gt; pdflatex -&gt; pdflatex  
pdflatex %2  
bibtex  %2  
:: If you are using multibib the following will run bibtex on all aux files  
:: FOR /R . %%G IN (*.aux) DO bibtex %%G  
pdflatex "\includeonly{chap01}\input{%2}"
rename %3 "chap01_%3"
pdflatex "\includeonly{chap02}\input{%2}" 
rename %3 "chap02_%3"
pdflatex "\includeonly{chap03}\input{%2}"
rename %3 "chap03_%3"
pdflatex %2 

:: Run Cleanup  
call:cleanup  

:: Open PDF  
START "" "C:\Users\bonnal\AppData\Local\SumatraPDF\SumatraPDF.exe" "chap01_%3" -reuse-instance  
START "" "C:\Users\bonnal\AppData\Local\SumatraPDF\SumatraPDF.exe" "chap02_%3" -reuse-instance  
:: Cleanup Function  
:cleanup  
del *.dvi
del *.out
del *.log 
del *.aux  
del *.bbl    
del *.blg  
del *.brf  

goto:eof  
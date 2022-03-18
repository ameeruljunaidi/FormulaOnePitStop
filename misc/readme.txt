==========================================================
                   How this project works
==========================================================

- The main tex file is tasktwo.tex
- The main python script will be in /misc/pythoncodes.tex
- The python code will be imbedded into the tex file
- This is possible using pythontex
- Overleaf can not compile pythontex
- User need to download whole project into local pc
- Copy all the contents from /pythontex/
- Paste all the file into main project file 
  i.e., same folder as main tex file
- Make sure texlive and python is installed on system

For Windows users
----------------------------------------------------------
- Must have installed Anaconda
- Double click on compile.bat
- Select the tex file to compile i.e., tasktwo
- Select pythontex rerun option e.g.:
  - Always mean run all python codes always
  - Modified means run all python codes only if codes are
    modified
- See pdflatex_log, pythontex_log, and bibtex.log for log

For Unix users
-----------------------------------------------------------
It's a three step process:
1. Run pdflatex and generate pdf from texfile first
 'pdflatex tasktwo.tex'    
2. Run pythontex on tex file
 'python pythontex.py --rerun="option" tasktwo
 Note: Replace "option" with desired option
3. Run pdflatex on again (and bibtex if applicable)

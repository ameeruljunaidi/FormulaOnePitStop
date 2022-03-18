#!/usr/bin/sh

file="$1"

if [ -f "$file" ]; then
    echo ""
    cd .
    mv ./pytex/* .
    mv ./temp/* .
    pdflatex-quiet -interaction=nonstopmode "$file"
    bibtex "${file%.*}" > /dev/null 2>&1
    echo ""
    python3 pythontex.py --rerun=always "$file"
    pdflatex-quiet -interaction=nonstopmode "$file" > /dev/null 2>&1
    cd .
    mv pythontex* ./pytex
    mv depythontex* ./pytex
    mv syncpdb* ./pytex
    mv ./pytex/pythontex.sh .
    mv ${file%.*}* ./temp
    mv ./temp/$file .
    mv ./temp/${file%.*}.pdf .
    ipynb-py-convert ./pythoncodes.py ./pythoncodes.ipynb
    echo "Done!"
else 
    echo "Invalid or no target. Try ./pyhontex.sh (or sh pythontex.sh) valid-file.tex"
fi

###############################################################################
#                                   README                                    #
###############################################################################

################
# Dependencies #
################

# Need texlive, I just have texlive-full, not sure if it'll work with the
# smaller versions of texlive

# Pdflatex quiet, found someone on github who had the script, install with
# curl -s https://gitlab.com/jirislav/pdftex-quiet/raw/latest/pdftex-quiet | \
#     sudo tee /usr/local/bin/pdftex-quiet >/dev/null \
#     && sudo chmod +x /usr/local/bin/pdftex-quiet \
#     && sudo ln -sf /usr/local/bin/pdftex-quiet /usr/local/bin/pdflatex-quiet

# ipynb-py-convert: https://pypi.org/project/ipynb-py-convert/

# I think you also need python 3.8, not too sure though

#####################
# Pythontex options #
#####################

# usage: pythontex.py [-h] [--version] [--encoding ENCODING]
#                     [--error-exit-code {true,false}] [--runall [{true,false}]
#                     | --rerun {never,modified,errors,warnings,always}]
#                     [--hashdependencies [{true,false}]] [-j N] [-v]
#                     [--interpreter INTERPRETER]
#                     [--debug [<family>:<session>:<restart>] | --interactive
#                     [<family>:<session>:<restart>]]
#                     TEXNAME

# positional arguments:
#   TEXNAME               LaTeX file, with or without .tex extension

# optional arguments:
#   -h, --help            show this help message and exit
#   --version             show program's version number and exit
#   --encoding ENCODING   encoding for all text files (see codecs module for
#                         encodings)
#   --error-exit-code {true,false}
#                         return exit code of 1 if there are errors (not
#                         desirable with some TeX editors and workflows)
#   --runall [{true,false}]
#                         run ALL code; equivalent to package option
#   --rerun {never,modified,errors,warnings,always}
#                         set conditions for rerunning code; equivalent to
#                         package option
#   --hashdependencies [{true,false}]
#                         hash dependencies (such as external data) to check for
#                         modification, rather than using mtime; equivalent to
#                         package option
#   -j N, --jobs N        Allow N jobs at once; defaults to cpu_count().
#   -v, --verbose         verbose output
#   --interpreter INTERPRETER
#                         set a custom interpreter; argument should be in the
#                         form "<interpreter>:<command>, <interp>:<cmd>, ..."
#                         where <interpreter> is "python", "ruby", etc., and
#                         <command> is the command for invoking the interpreter;
#                         argument may also be in the form of a Python
#                         dictionary
#   --debug [<family>:<session>:<restart>]
#                         Run the specified session (or default session) with
#                         the default debugger, if available. If there is only
#                         one session, it need not be specified. If the session
#                         name is unambiguous, it is sufficient. The full
#                         <family>:<session>:<restart> (for example,
#                         py:default:default) is only needed when the session
#                         name alone would be ambiguous.
#   --interactive [<family>:<session>:<restart>]
#                         Run the specified session (or default session) in
#                         interactive mode. If there is only one session, it
#                         need not be specified. If the session name is
#                         unambiguous, it is sufficient. The full
#                         <family>:<session>:<restart> (for example,
#                         py:default:default) is only needed when the session
#                         name alone would be ambiguous.

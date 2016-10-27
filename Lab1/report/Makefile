TEX = xelatex -shell-escape -interaction=nonstopmode -file-line-error
INPUT_FOLDER = sections

COURSE = 1DT072
SID = silo4625
ASSIGNMENT_DIR = $(shell pwd | rev | cut -d / -f 2 | rev)
YEAR = $(shell date "+%Y")

.PHONY: all, report,  inputs, clean, latex, bibtex

all: report

report: inputs
	@echo "Attempting to compile to PDF..."
	@$(MAKE) latex
	@$(MAKE) bibtex
	@$(MAKE) latex
	@$(MAKE) latex
	@echo 'OK'
	mv $@.pdf $(SID)_$(ASSIGNMENT_DIR)_$(COURSE)_$(YEAR).pdf
	@echo 'Done'

latex:
	latexmk -pdf -pdflatex="$(TEX)" report.tex
	$(TEX) report.tex

bibtex:
	@bibtex report

inputs: $(wildcard $(INPUT_FOLDER)/*.tex)
	@ls $(INPUT_FOLDER)/*.tex | awk '{printf "\\input{%s}\n", $$1}' > inputs.tex

clean:
	latexmk -CA
	@rm -f *.bbl

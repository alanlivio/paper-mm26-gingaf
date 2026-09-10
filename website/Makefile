MAKEFLAGS += -s --no-print-directory

MAIN = main
LATEX = latexmk -pdf -synctex=1 -interaction=nonstopmode

.PHONY: clean build help latex slides serve deps

help:
	@echo "latex        Build PDF from latex"
	@echo "slides       Build slides"
	@echo "clean        Clean build artifacts and cache files"
	@echo "build        Build website"
	@echo "serve        Build website and run dev server"
	@echo "deps         Install dependencies"

latex:
	cd ../latex && $(LATEX) $(MAIN)
	cp ../latex/main.pdf docs/main.pdf

slides:
	make -C ../slides build
	rm -rf docs/slides
	cp -r ../slides/site docs/slides

clean:
	cd ../latex && $(LATEX) -C
	rm -rf site
	rm -rf .cache
	rm -rf docs/slides

build:
	zensical build

serve:
	zensical serve

deps:
	pip install -r requirements.txt
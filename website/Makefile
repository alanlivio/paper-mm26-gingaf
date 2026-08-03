MAIN = main
LATEX = latexmk -pdf -synctex=1 -interaction=nonstopmode

.PHONY: clean build help latex serve deps

help:
	@echo "latex        Build PDF from latex"
	@echo "clean        Clean build artifacts and cache files"
	@echo "build        Build website"
	@echo "serve        Build website and run dev server"
	@echo "deps         Install dependencies"

latex:
	cd ../latex && $(LATEX) $(MAIN)
	cp ../latex/main.pdf docs/main.pdf

clean:
	cd ../latex && $(LATEX) -C
	rm -rf site
	rm -rf .cache

build:
	zensical build

serve:
	zensical serve

deps:
	pip install -r requirements.txt
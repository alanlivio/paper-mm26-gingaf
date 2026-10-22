MAKEFLAGS += -s --no-print-directory
.DEFAULT_GOAL := help
$(if $(filter Windows_NT,$(OS)),$(if $(shell where printf 2>nul),,$(error coreutils is not installed. Please run: winget install coreutils)))

LATEX_CMD = latexmk -pdf -synctex=1 -interaction=nonstopmode -cd
URL = https://alanlivio.github.io/paper-mm26-gingaf/

.PHONY: help deps latex site serve clean slides qrcode format

help:
	@printf "%s\n" \
		"Usage: make [target]" \
		"" \
		"Targets:" \
		"  site          Build website and slides (compiles LaTeX PDFs first)" \
		"  latex         Compile LaTeX documents and copy PDFs" \
		"  serve         Build and serve website locally" \
		"  format        Format LaTeX and Python code" \
		"  clean         Remove build artifacts" \
		"  deps          Install website dependencies" \
		"  slides        Build slides and copy to website/docs" \
		"  qrcode        Regenerate slide QR code"

deps:
	pip install -r website/requirements.txt

latex:
	$(LATEX_CMD) src/main.tex
	cp src/*.pdf website/docs/assets/pdfs/

website/docs/assets/pdfs/main.pdf: src/main.tex $(wildcard src/references.bib) $(wildcard src/assets/*)
	$(MAKE) latex

site: website/docs/assets/pdfs/main.pdf slides
	zensical build

serve: site
	zensical serve

website/docs/slides/index.html: slides/slides.md
	npx -y @marp-team/marp-cli --html slides/slides.md -o slides/site/index.html --no-stdin
	cp -r slides/assets slides/site/
	rm -rf website/docs/slides
	cp -r slides/site website/docs/slides

slides: website/docs/slides/index.html

qrcode:
	npx -y qrcode -t svg -o slides/assets/qrcode.svg $(URL)

clean:
	latexmk -C -cd src/main.tex
	rm -rf src/.build
	rm -f website/docs/assets/pdfs/*.pdf
	rm -rf website/site
	rm -rf website/.cache
	rm -rf slides/site website/docs/slides

format:
	latexindent -w -s -m -c=/tmp/ -y="defaultIndent: '  '" src/main.tex
	python -m black -q .

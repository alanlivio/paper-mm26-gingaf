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
		"  slides        Build slides and copy to docs" \
		"  qrcode        Regenerate slide QR code"

deps:
	pip install zensical

latex:
	$(LATEX_CMD) src/main.tex
	cp src/*.pdf docs/assets/pdfs/

docs/assets/pdfs/main.pdf: src/main.tex $(wildcard src/references.bib) $(wildcard src/assets/*)
	$(MAKE) latex

site: docs/assets/pdfs/main.pdf slides
	zensical build

serve: site
	zensical serve

docs/slides/index.html: src/slides.md $(wildcard src/assets/*)
	rm -rf docs/slides
	npx -y @marp-team/marp-cli --html src/slides.md -o docs/slides/index.html --no-stdin
	cp -r src/assets docs/slides/

slides: docs/slides/index.html

qrcode:
	npx -y qrcode -t svg -o src/assets/qrcode.svg $(URL)

clean:
	latexmk -C -cd src/main.tex
	rm -rf src/.build
	rm -f docs/assets/pdfs/*.pdf
	rm -rf site
	rm -rf .cache
	rm -rf docs/slides

format:
	latexindent -w -s -m -c=/tmp/ -y="defaultIndent: '  '" src/main.tex
	python -m black -q .

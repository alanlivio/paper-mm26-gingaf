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
	$(LATEX_CMD) paper/main.tex
	cp paper/*.pdf docs/assets/pdfs/

docs/assets/pdfs/main.pdf: paper/main.tex
	$(MAKE) latex

site: docs/assets/pdfs/main.pdf slides
	zensical build

serve: site
	zensical serve

docs/slides/index.html: slides/slides.md
	rm -rf docs/slides
	npx -y @marp-team/marp-cli --html slides/slides.md -o docs/slides/index.html --no-stdin
	cp -r slides/assets docs/slides/

slides: docs/slides/index.html

qrcode:
	npx -y qrcode -t svg -o slides/assets/qrcode.svg $(URL)

clean:
	latexmk -C -cd paper/main.tex
	rm -rf paper/.build
	rm -f docs/assets/pdfs/*.pdf
	rm -rf site
	rm -rf .cache
	rm -rf docs/slides

format:
	latexindent -w -s -m -c=/tmp/ -y="defaultIndent: '  '" paper/main.tex
	python -m black -q .

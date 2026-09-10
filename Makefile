MAKEFLAGS += -s --no-print-directory

LATEX_DIR = latex
LATEX_CMD = latexmk -pdf -synctex=1 -interaction=nonstopmode
URL = https://alanlivio.github.io/paper-mm26-gingaf/

.PHONY: all help deps latex slides website build serve serve-slides slides-qrcode clean

all: build

help:
	@printf "%s\n" \
		"deps          Install website dependencies" \
		"build         Build paper, slides, and website" \
		"clean         Clean all build artifacts" \
		"serve         Build and serve website locally" \
		"serve-slides  Build and serve slides locally" \
		"latex         Build paper PDF and copy to website/docs" \
		"slides        Build slides and copy to website/docs" \
		"website       Build website using Zensical" \
		"slides-qrcode Regenerate slide QR code"

deps:
	pip install -r website/requirements.txt

website/docs/main.pdf: $(LATEX_DIR)/main.tex
	cd $(LATEX_DIR) && $(LATEX_CMD) main
	cp $(LATEX_DIR)/main.pdf website/docs/main.pdf

latex: website/docs/main.pdf

website/docs/slides/index.html: slides/slides.md
	npx -y @marp-team/marp-cli --html slides/slides.md -o slides/site/index.html --no-stdin
	cp -r slides/assets slides/site/
	rm -rf website/docs/slides
	cp -r slides/site website/docs/slides

slides: website/docs/slides/index.html

slides-qrcode:
	npx -y qrcode -t svg -o slides/assets/qrcode.svg $(URL)

website: website/docs/main.pdf website/docs/slides/index.html
	cd website && zensical build

build: website

serve: website/docs/main.pdf website/docs/slides/index.html
	cd website && zensical serve

serve-slides: website/docs/slides/index.html
	npx -y serve -L slides/site

clean:
	cd $(LATEX_DIR) && $(LATEX_CMD) -C
	rm -f website/docs/main.pdf
	rm -rf slides/site slides/slides slides/slides.html
	rm -rf website/site website/.cache website/docs/slides

.PHONY: build clean zip

build:
	latexmk -pdf -synctex=1 -interaction=nonstopmode main.tex

clean:
	latexmk -C
	rm -f main.zip

zip: clean
	zip -r main.zip . -x "*.git*"

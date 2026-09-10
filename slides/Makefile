MAKEFLAGS += -s --no-print-directory

.PHONY: all deps build serve clean qrcode

all: build

deps:

build:
	npx -y @marp-team/marp-cli --html slides.md -o site/index.html --no-stdin
	cp -r assets site/

serve: build
	npx serve site

qrcode:
	npx -y qrcode -t svg -o assets/qrcode.svg "https://alanlivio.github.io/paper-mm26-gingaf/"

clean:
	rm -rf site slides slides.html

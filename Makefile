.PHONY: all doc build list-targets render clean test

CONFIGURATION := nodejs-6
CONFIGURATION_IMAGE_NAME := $(shell dfe expanded-value $(CONFIGURATION) "image_name")

all: render doc build test

list-targets:
	dfe list-configs

render:
	dfe render $(CONFIGURATION)

build:
	docker build --tag=$(CONFIGURATION_IMAGE_NAME) -f Dockerfile.${CONFIGURATION} .

doc:
	go-md2man -in=files/help.md.${CONFIGURATION} -out=./root/help.1

clean:
	rm -f Dockerfile.*
	rm -f files/help.md.*
	rm -rf root

test:
	IMAGE_NAME=$(CONFIGURATION_IMAGE_NAME) cd test && ./run

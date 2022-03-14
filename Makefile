REGISTRY := docker.io/networkop
IMAGE := cx
TAG ?= 5.0.2
HOST_IMAGE := host:ifreload
HOST_SUFFIX ?= $(shell git rev-parse --short HEAD)

all: help 

.PHONY: build
## Build the latest stable Cumulus image
build:
	docker build -t $(REGISTRY)/$(IMAGE):$(TAG) -f Dockerfile-$(TAG) .

.PHONY: host
## Build the host image
host:
	cd host && docker build -t $(REGISTRY)/$(HOST_IMAGE)-$(HOST_SUFFIX) .
	docker tag $(REGISTRY)/$(HOST_IMAGE)-$(HOST_SUFFIX)  $(REGISTRY)/$(HOST_IMAGE)


.PHONY: run
## Run the Cumulus VX image
run:
	docker run -d --name cumulus --privileged -p 8765:8765 $(REGISTRY)/$(IMAGE):$(TAG)


# From: https://gist.github.com/klmr/575726c7e05d8780505a
help:
	@echo "$$(tput sgr0)";sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|awk -F --- -v n=$$(tput cols) -v i=15 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'

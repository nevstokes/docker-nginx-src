IMAGE_NAME = nevstokes/nginx-src

export

.DEFAULT_GOAL := help
.PHONY: build help mainline stable

build: TAG=$(MAKECMDGOALS)
build: Dockerfile hooks/build
	@./hooks/build

mainline: build ## Build the nginx mainline Docker image

stable: NGINX_VERSION=$(shell wget -q https://github.com/nginx/nginx/releases.atom -O - | xsltproc github-releases.xsl - | awk -F/ '{ print $$NF; }' | sed -E 's/release-//' | sort -r -k1,1 -k2,2 -k3,3 > versions.$$$$ && grep -v `head -1 versions.$$$$ | sed -E 's/([0-9]+\.[0-9]+\.).+/\1/'` versions.$$$$ | head -1 && rm versions.$$$$)
stable: build ## Build the nginx stable Docker image

help: ## Display list and descriptions of available targets
	@awk -F ':|\#\#' '/^[^\t].+:.*\#\#/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$NF }' $(MAKEFILE_LIST) | sort


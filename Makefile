NAME := aws-cli-oidc
PREFIX?=/usr/local
VERSION := v0.6.0
REVISION := $(shell git rev-parse --short HEAD)

SRCS    := $(shell find . -type f -name '*.go')
LDFLAGS := -ldflags="-s -w -X \"github.com/openstandia/aws-cli-oidc/version.Version=$(VERSION)\" -X \"github.com/openstandia/aws-cli-oidc/version.Revision=$(REVISION)\" -extldflags -static"

DIST_DIRS := find * -type d -exec

go-binary: $(SRCS)
	go build $(LDFLAGS) -o bin/$(NAME) cmd/aws-cli-oidc/*.go

clean:
	rm -rf bin/*
	rm -rf dist/*
	rm -rf vendor/*
	rm -rf ~/.aws-cli-oidc/*

install: go-binary
	mkdir -p ~/.aws-cli-oidc
	cp ./assets/config.yaml ~/.aws-cli-oidc/config.yaml
	mv bin/$(NAME) $(PREFIX)/bin/$(NAME)
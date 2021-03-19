BIN := go-cli-template
VERSION := $$(make -s show-version)
VERSION_PATH := .
CURRENT_REVISION := $(shell git rev-parse --short HEAD)
BUILD_LDFLAGS := "-s -w -X github.com/skanehira/go-cli-template/cmd.Revision=$(CURRENT_REVISION)"
GOBIN ?= $(shell go env GOPATH)/bin
export GO111MODULE=on

.PHONY: init
init:
ifeq ($(shell uname -s),Darwin)
	@grep -r -l go-cli-template * | xargs sed -i "" "s/go-cli-template/$$(basename `git rev-parse --show-toplevel`)/"
else
	@grep -r -l go-cli-template * | xargs sed -i "s/go-cli-template/$$(basename `git rev-parse --show-toplevel`)/"
endif

.PHONY: all
all: clean build

.PHONY: build
build:
	go build -ldflags=$(BUILD_LDFLAGS) -o $(BIN) .

.PHONY: install
install:
	go install -ldflags=$(BUILD_LDFLAGS) ./...

.PHONY: show-version
show-version:
	@git describe --tags --abbrev=0

.PHONY: cross
cross: $(GOBIN)/goxz
	goxz -n $(BIN) -pv=$(VERSION) -build-ldflags=$(BUILD_LDFLAGS) .

$(GOBIN)/goxz:
	cd && go get github.com/Songmu/goxz/cmd/goxz

.PHONY: test
test: build
	go test -v ./...

.PHONY: clean
clean:
	rm -rf $(BIN) goxz
	go clean

.PHONY: upload
upload: $(GOBIN)/ghr
	ghr "$(VERSION)" goxz

$(GOBIN)/ghr:
	cd && go get github.com/tcnksm/ghr


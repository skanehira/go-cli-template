BIN := go-cli-template
CURRENT_REVISION := $(shell git rev-parse --short HEAD)
BUILD_LDFLAGS := "-s -w -X github.com/skanehira/go-cli-template/cmd.Revision=$(CURRENT_REVISION)"
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

.PHONY: test
test: build
	go test -v ./...

.PHONY: clean
clean:
	rm -rf $(BIN)
	go clean

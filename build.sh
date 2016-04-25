#!/bin/bash

GOPATH=$(pwd) go install -buildmode=c-archive foo

$(go env CC) $(go env GOGCCFLAGS) -Wl,-no_pie -I pkg/darwin_amd64 -o test bar.c pkg/darwin_amd64/foo.a

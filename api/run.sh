#!/bin/bash

go get -d -v ./...
go install -v ./...

test-social-network-api
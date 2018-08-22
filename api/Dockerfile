FROM golang:1.10.3

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
RUN go get github.com/vanekt/test-social-network-api
WORKDIR /go/src/github.com/vanekt/test-social-network-api
RUN dep ensure
RUN go install -v ./...

CMD ["test-social-network-api"]
FROM golang:1.17

RUN mkdir /build

ADD app/go.mod app/hello.go /build/

WORKDIR /build

RUN go build hello.go

CMD ["go", "build", "./hello.go"]
CMD ["./hello"]
### FIRST STEP - BUILD
FROM golang:1.17 AS build

WORKDIR /build

ADD app/go.mod app/hello.go /build/

RUN CGO_ENABLED=0 go build -o myapp .

RUN cat /etc/passwd | grep nobody > passwd.nobody

### SECOND STEP - RUN
FROM scratch

COPY --from=build /build/passwd.nobody /etc/passwd

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY --from=build /build/myapp .

USER nobody
CMD ["./myapp"]
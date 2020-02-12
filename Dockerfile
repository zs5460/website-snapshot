#build
FROM golang AS build

WORKDIR /go/src/github.com/zs5460/website-snapshot

ADD . .

RUN CGO_ENABLED=0 GOOS=linux go build .

#production
FROM scratch AS prod

COPY --from=build /go/src/github.com/zs5460/website-snapshot/p .
COPY --from=build /go/src/github.com/zs5460/website-snapshot/p.js .
COPY --from=build /go/src/github.com/zs5460/website-snapshot/website-snapshot .

CMD ["./website-snapshot"]
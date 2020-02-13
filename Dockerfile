#build
FROM golang AS build

RUN go env -w GOPROXY=https://goproxy.cn,direct 

WORKDIR /app

ADD . .

RUN CGO_ENABLED=0 GOOS=linux go build . 

#production
FROM leanix/phantomjs2 AS prod
WORKDIR /app
COPY --from=build /app/p.js . 
COPY --from=build /app/website-snapshot .

CMD ["./website-snapshot"]

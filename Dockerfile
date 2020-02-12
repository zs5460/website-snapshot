#build
FROM golang AS build

RUN go env -w GOPROXY=https://goproxy.cn,direct 

WORKDIR /app

ADD . .

RUN CGO_ENABLED=0 GOOS=linux go build . 

#production
FROM wernight/phantomjs AS prod

COPY --from=build /app/p.js /app/ 
COPY --from=build /app/website-snapshot /app/

CMD ["/app/website-snapshot"]

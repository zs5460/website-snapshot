#build
FROM golang AS build

WORKDIR /app

ADD . .

RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor . 

#production
FROM leanix/phantomjs2 AS prod
WORKDIR /app
COPY --from=build /app/fonts/* /usr/share/fonts/
COPY --from=build /app/snapshot.js . 
COPY --from=build /app/website-snapshot .

CMD ["./website-snapshot"]

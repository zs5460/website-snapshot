#build
FROM golang AS build

WORKDIR /app

ADD . .

RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor . 

#production
FROM wernight/phantomjs AS prod
USER phantomjs
WORKDIR /home/phantomjs/app
COPY --from=build /app/fonts/* /usr/share/fonts/
COPY --from=build /app/snapshot.js . 
COPY --from=build /app/website-snapshot .
USER root
RUN chown phantomjs:phantomjs -R /home/phantomjs/app
USER phantomjs

CMD ["./website-snapshot"]

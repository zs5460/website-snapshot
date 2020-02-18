#build
FROM golang AS build

WORKDIR /app

ADD . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -mod=vendor . 

#production
FROM wernight/phantomjs AS prod

WORKDIR /home/phantomjs/app

USER root
RUN chown phantomjs:phantomjs -R /home/phantomjs/app && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' >/etc/timezone
USER phantomjs

COPY --from=build /app/fonts/* /usr/share/fonts/
COPY --from=build /app/snapshot.js . 
COPY --from=build /app/website-snapshot .

ENTRYPOINT ["./website-snapshot"]

FROM golang as builder

ENV BUILD_DIR=/build CGO_ENABLED=0 GOPROXY=https://goproxy.cn

RUN mkdir ${BUILD_DIR}

ADD . ${BUILD_DIR}

WORKDIR ${BUILD_DIR}

RUN go build -ldflags "-s -w" .

FROM alpine

RUN apk --no-cache add ca-certificates curl

RUN curl -L https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 -o /usr/bin/dumb-init && \
    chmod +x /usr/bin/dumb-init && \
    mkdir -p /falcon-plus/falcon-message/bin/

COPY --from=builder /build/falcon-message /falcon-plus/falcon-message/bin/
COPY --from=builder /build/message-template.md /falcon-plus/falcon-message/bin/
COPY --from=builder /build/cfg.example.json /falcon-plus/falcon-message/bin/cfg.json
WORKDIR /falcon-plus/falcon-message/bin/

ENV PATH=/falcon-plus/falcon-message/bin/:$PATH

EXPOSE 23329

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["falcon-message"]
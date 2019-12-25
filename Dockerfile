FROM golang:latest
MAINTAINER lixiangyun linimbus@126.com

WORKDIR /gopath/
ENV GOPATH=/gopath/
ENV GOOS=linux
ENV CGO_ENABLED=0

RUN go get -u -v github.com/lixiangyun/tcpproxy
WORKDIR /gopath/src/github.com/lixiangyun/tcpproxy
RUN go build .

FROM ubuntu:xenial

WORKDIR /bin/
COPY --from=0 /gopath/src/github.com/lixiangyun/tcpproxy/tcpproxy ./tcpproxy
COPY ./proxy.sh ./proxy.sh
COPY ./config.yaml ./config.yaml

RUN chmod +x ./tcpproxy

RUN apt-get update 
RUN apt-get install -y iproute2 iptables 

RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./proxy.sh"]

#!/bin/bash
export ACT_PORT=$1

sed  's/_PORT/${ACT_PORT}/g' config.yaml.temp > config.yaml
iptables -t nat -A PREROUTING -p tcp -m tcp --dport ${ACT_PORT} -j REDIRECT --to-ports 15001
./tcpproxy -config config.yaml

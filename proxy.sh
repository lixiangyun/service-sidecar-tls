#!/bin/bash

sed  's/_PORT/$1/g' config.yaml.temp > config.yaml
iptables -t nat -A PREROUTING -p tcp -m tcp --dport $1 -j REDIRECT --to-ports 15001
tcpproxy -config config.yaml

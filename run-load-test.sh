#!/bin/bash
FILE=${1?Error: no file name given, ex: /scripts/ewoks.js}

docker-compose up -d influxdb grafana
get_public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")
echo "--------------------------------------------------------------------------------------"
echo "Load testing with Grafana dashboard http://$get_public_ip:3000/d/k6/k6-load-testing-results"
echo "--------------------------------------------------------------------------------------"
docker-compose run --rm k6 run $FILE

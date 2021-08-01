FROM debian:latest

ARG bin=/usr/local/bin
ARG conf=/etc/prometheus
ARG data=/data/prometheus

RUN apt-get update && apt-get -y install curl

RUN LOCATION=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/prometheus/prometheus/archive/" substr($2, 2, length($2)-3) "linux-amd64.tar.gz"}') \
; curl -s -L -o prometheus.tar.gz $LOCATION \
&& tar xf prometheus.tar.gz \
&& mv prometheus-* prometheus

WORKDIR prometheus

# Executables
COPY promtool $bin/promtool
COPY prometheus $bin/prometheus
# Config files
COPY consoles/ $conf/consoles/
COPY console_libraries/ $conf/console_libraries/
COPY prometheus.yml $conf/prometheus.yml
# Data
RUN mkdir -p /data/prometheus

# Remove garbage
WORKDIR /
RUN prometheus.tar.gz
RUN apt-get remove curl

# Run Prometheus service
CMD $bin/prometheus \
    --config.file=$conf/prometheus.yml \
    --storage.tsdb.path=$data/ \
    --web.console.templates=$conf/consoles/ \
    --web.console.libraries=$conf/console_libraries/ \
    --web.listen-address=0.0.0.0:9090 \
    --web.enable-admin-api \
    --web.external-url=https://localhost:1001

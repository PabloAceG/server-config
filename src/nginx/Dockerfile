FROM nginx

ARG src=/sources
ARG conf=/etc/nginx
ARG daem=$conf/conf.d

# Config files
COPY $src/grafana.conf $daem/grafana.conf
COPY $src/prometheus.conf $daem/grafana.conf

FROM nginx

USER nginx:nginx

ARG conf=/etc/nginx
ARG daem=$conf/conf.d
ARG cert=/etc/ssl
ARG cProm=$cert/prometheus
ARG cGraf=$cert/grafana

# Config files
COPY --chown=nginx:nginx $conf/nginx.conf
COPY --chown=nginx:nginx $daem/grafana.conf $daem/grafana.conf
COPY --chown=nginx:nginx $daem/prometheus.conf $daem/grafana.conf
# Certificates
COPY $cProm/* $cProm/
COPY $cGraf/* $cGraf/

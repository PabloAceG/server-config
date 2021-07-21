FROM nginx

USER nginx:nginx

ARG src=/sources
ARG conf=/etc/nginx
ARG daem=$conf/conf.d

# Config files
COPY --chown=nginx:nginx $src/nginx.conf $conf/nginx.conf
COPY --chown=nginx:nginx $src/grafana.conf $daem/grafana.conf
COPY --chown=nginx:nginx $src/prometheus.conf $daem/grafana.conf

CMD [ "nginx", "-c /etc/nginx/nginx.conf", "-g daemon-off" ]

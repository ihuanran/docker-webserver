FROM nginx:1.13

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME /usr/share/nginx/html /etc/nginx/conf.d /var/log/nginx
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

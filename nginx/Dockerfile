FROM nginx:1.13

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /usr/share/nginx/html
VOLUME /usr/share/nginx/html /etc/nginx/conf.d /var/log/nginx
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

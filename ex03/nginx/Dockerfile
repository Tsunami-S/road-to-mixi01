FROM openresty/openresty:alpine

ENV TZ=Asia/Tokyo

RUN apk add --no-cache bash curl

WORKDIR /usr/local/openresty/nginx/

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]

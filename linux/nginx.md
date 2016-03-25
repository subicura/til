# nginx

자주 사용하는 셋팅

## build

- 환경변수
  - NGINX\_VERSION=1.9.12
  - NGX\_PAGESPEED\_VERSION=1.10.33.6

```sh
$ apt-get -y install build-essential wget git libssl-dev libpcre3-dev
$ mkdir /tmp/nginx && cd /tmp/nginx && \
  wget -q -O - http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xfz - && \
  wget -q -O - https://github.com/pagespeed/ngx_pagespeed/archive/v${NGX_PAGESPEED_VERSION}-beta.tar.gz | tar xfz - && \
  cd /tmp/nginx/ngx_pagespeed-${NGX_PAGESPEED_VERSION}-beta && \
  wget -q -O - https://dl.google.com/dl/page-speed/psol/${NGX_PAGESPEED_VERSION}.tar.gz | tar xfz - && \
  cd /tmp/nginx/nginx-${NGINX_VERSION} && \
  ./configure --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin --with-http_realip_module --with-http_ssl_module \
    --with-stream --with-stream_ssl_module --with-http_stub_status_module --with-http_gzip_static_module --with-http_v2_module \
    --add-dynamic-module=/tmp/nginx/ngx_pagespeed-${NGX_PAGESPEED_VERSION}-beta && \
  make --silent && make install --silent && \
  cd && rm -rf /tmp/nginx
```

## configure

module loading

```
load_module "modules/ngx_pagespeed.so";
```

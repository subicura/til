# https 셋팅

- openssl 최신버전유지

```
$ apt-get update
$ apt-get upgrade
$ reboot
```

추가로 nginx도 최신버전이면 좋음

- nginx 보안

nginx.conf

```
server_tokens off;
```

- 인증서는 `SHA256 and a 2048 bit RSA key` 방식 사용

```
$ openssl x509 -in /etc/nginx/cert/nginx.crt -text -noout | grep "Signature\|Public-Key"

Signature Algorithm: sha256WithRSAEncryption
            Public-Key: (2048 bit)
            Digital Signature, Key Encipherment
Signature Algorithm: sha256WithRSAEncryption
```

sha1이나 1024 bit면 다시 생성함

- dh parameter 설정 (오래걸림)

```
$ openssl dhparam -out /etc/nginx/cert/dhparam.pem 4096
```

- ssl 설정

```
add_header Strict-Transport-Security "max-age=31536000; includeSubdomains";

ssl_dhparam /etc/nginx/cert/dhparam.pem;
ssl_certificate /etc/nginx/cert/nginx.crt;
ssl_certificate_key /etc/nginx/cert/nginx.key;

ssl_session_cache   shared:SSL:20m;
ssl_session_timeout 60m;

ssl_prefer_server_ciphers on;
ssl_ciphers "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4";

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
```

- links
  - https://www.ssllabs.com/ssltest/index.html
  - https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-on-ubuntu-14-04

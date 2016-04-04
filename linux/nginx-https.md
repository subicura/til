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

- ssl 설정

```
ssl_certificate /etc/nginx/cert/nginx.crt;
ssl_certificate_key /etc/nginx/cert/nginx.key;

ssl_session_cache   shared:SSL:20m;
ssl_session_timeout 60m;

ssl_prefer_server_ciphers on;
ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5;

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
```

- links
  - https://www.ssllabs.com/ssltest/index.html
  - https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-on-ubuntu-14-04

# 실습용 서버 설정

[Light Sail](https://lightsail.aws.amazon.com/ls/webapp/home)

## 프로비저닝 스크립트

```sh
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "ubuntu:1q2w3e4r" | chpasswd
service sshd reload
apt-get -y update
apt-get -y install shellinabox
```

## 웹 접속

https://xxxx:4200

# 실습용 서버 설정

[Light Sail](https://lightsail.aws.amazon.com/ls/webapp/home)

## 프로비저닝 스크립트

shellinabox

```sh
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "ubuntu:1q2w3e4r" | chpasswd
service sshd reload
apt-get -y update
apt-get -y install shellinabox
```

wetty
```
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "ubuntu:1q2w3e4r" | chpasswd
service sshd reload
apt-get -y update
apt-get -y install nodejs npm
npm install -g wetty
nohup wetty -p 4200 > /dev/null
```

## 웹 접속

https://xxxx:4200

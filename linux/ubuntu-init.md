# ubuntu 초기 셋팅

- public key 등록

```
$ mkdir ~/.ssh
$ curl -sSL https://github.com/subicura.keys -o ~/.ssh/authorized_keys
```

- 최신 업데이트

```
$ sudo apt-get update && sudo apt-get -y dist-upgrade && sudo reboot
```

- 기본 프로그램 설치

```
$ sudo apt-get install -y git vim zsh unzip openssh-server tmux bind9
$ chsh -s /usr/bin/zsh
[패스워드 입력]
$ wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
$ sed -i "s#robbyrussell#ys#" ~/.zshrc
[재로그인]
```

- docker 설치

```
$ curl -sSL https://get.docker.com/ | sh
$ sudo usermod -a -G docker $USER
$ sudo curl -sSL https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

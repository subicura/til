# Alpine linux

alpine linux는 [musl libc](http://www.musl-libc.org/)와 [busybox](https://busybox.net/)를 이용한 5MB 남짓한 초소형 리눅스 배포판이다. 다른 리눅스 배포판처럼 package repository를 제공하여 손쉽게 라이브러리나 프로그램 설치가 가능하다.

mysql client를 docker image로 만들경우 alpine기반은 16MB, ubuntu기반은 232MB로 용량면으로 10배 이상 효율적!

ubuntu를 이용해서 docker image를 만들었다면 이제 alpine을 고려해보자.

## package

**기본 명령어**

```
$ apk update # update package repository
$ apk add mysql-client # install mysql client binary
$ apk --update add mysql-client # one line
```

**dev library**

뒤에 `-dev`를 붙이면 됨

```
$ apk --update add openssl-dev zlib-dev
```

**sample**

```
$ apk --update add openssl-dev pcre-dev zlib-dev wget build-base
```

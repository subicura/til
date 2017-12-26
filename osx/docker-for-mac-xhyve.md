# xhyve 접속하기

```
docker run --rm -it --privileged --pid=host walkerlee/nsenter -t 1 -m -u -i -n sh
```

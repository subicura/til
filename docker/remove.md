# Remove

필요없는 파일 삭제하여 용량확보를 하자.

## Container

사용하지 않는 컨테이너 제거

```
docker rm $(docker ps -a -q)
```

## Image

사용하지 않는 이미지 제거

```
docker rmi $(docker images -fq dangling=true)
```

## Volumes

사용하지 않는 볼륨 제거

```
docker volume rm $(docker volume ls -qf dangling=true)
```

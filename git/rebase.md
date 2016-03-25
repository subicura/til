# rebase

rebase 명령어 사용팀

## git pull --rebase

`merge`대신 `rebase` 명령어를 이용해서 소스를 병합한다. merge관련 로그가 남지 않아 로그가 깔끔하게 유지되는 장점이 있음.

기본설정하기

```
$ git config pull.rebase true
```

## git rebase -i HEAD~2

2개 로그 합치기. 반드시 push 하기전에만 수행해야함
지우고 싶은 로그를 pick => s로 변경하고 저장
변경하고 싶은 로그는 pick => r로 변경하고 저장

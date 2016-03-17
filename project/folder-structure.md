# Folder Structure

이번에 맥을 새로 셋팅하면서 기존에 사용하던 개발환경 폴더구조를 변경했는데 괜찮은 것 같아서 공유한다.

## 기본 Home

`~/Documents`를 쓰는 경우도 있는데 개발용 폴더를 새로 하나 만든다. `~/Workspace`

## Workspace 폴더

```
Workspace
ㄴ frameworks
  ㄴ gradle
  ㄴ vertx
ㄴ go
  ㄴ bin
  ㄴ pkg
  ㄴ src
ㄴ project
  ㄴ github.com
    ㄴ subicura
      ㄴ til
    ㄴ remotty
      ㄴ angular-ladda
  ㄴ bitbucket.org
```

핵심은 `project` 폴더 밑에 실제 소스관리 경로를 그대로 사용하는건데 기존에는 여러가지 의미와 기준으로 분리했었는데 그냥 소스관리 경로 그대로가 가장 나은듯 하다.
일단 한동안은 이렇게 사용할 듯

# tmux

자세한 내용은 구글링을 합시다. 개인적으로 꼭 써야 하는 이유를 이야기해보면 터미널을 종료해도 세션이 유지되기 때문에 서버관리에서는 필수라고 생각함.
그외에 장점은 직접 쓰다보면 알게됨.

## 설치

**osx**

```
$ brew install tmux
```

**ubuntu**

```
$ apt-get install tmux
```

## 개념

session은 window를 포함하고 window는 pane을 포함함

- session
  - tmux 실행단위
  - 여러 터미널의 그룹이라고 생각하면 됨
- window
  - 탭개념
  - 브라우져 탭처럼 한 세션에 여러개의 윈도우를 만들고 지울수 있음
- pane
  - 한 화면을 가로/세로로 나눌수 있음
  - 나눈 화면을 또 나눌수도 있음

## 필수 명령어

`tmux`를 실행하면 tmux session이 실행되며 `ctrl` + `b` 를 누르고 손을 다 뗀다음 다음 명령어를 입력하면 됨

여러개의 session을 관리하는건 나중에 보고 기본적으로 `tmux`를 치면 `session`을 생성하게 되고 `tmux attach`를 치면 만들어 놨던 `session`에 접속함

**session 나오기(종료가 아님 살아있음)**

`ctrl` + `b`, `d`

**window 생성**

`ctrl` + `b`, `c`

**window 종료**

`exit` 또는 `ctrl` + `d`

**window 이동**

`ctrl` + `d`, `0`~`9`

**copy 모드**

tmux의 최대단점은 마우스 휠 스크롤이 안됨.. 스크롤 되는것처럼 할수 있긴하지만 부드럽지 않고 이왕 하는거 마우스 안쓰고 하는것으로..

`ctrl` + `[` 를 누르면 copy mode로 들어가서 스크롤을 할 수 있음

`copy mode`에서 `esc` 또는 `q`를 누르면 빠져나옴
`copy mode`에서 화살표를 움직이거나 page up/down을 하면 스크롤 할 수 있음

## 중급 명령어

다음시간에..

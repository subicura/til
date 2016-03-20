# VI editor

syntax color와 line number만 활성화해도 쓸만함

## color 설치

[spacegray](https://github.com/ajh17/Spacegray.vim) 설치

다른 colorscheme를 찾고 싶다면 [여기](https://www.google.co.kr/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=vim%20colorscheme)로

```
$ mkdir -p ~/.vim/colors
$ curl -sSL https://raw.githubusercontent.com/ajh17/Spacegray.vim/master/colors/spacegray.vim -o ~/.vim/colors/spacegray.vim
```

## .vimrc 수정

`~/.vimrc` 파일을 수정(작성)함

```
syntax enable
colorscheme spacegray
set nu
set term=screen-256color
```

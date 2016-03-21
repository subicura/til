# PECO

Peco는 증분검색툴이다. 툴이란게 잘 쓰면 엄청나게 활용도가 좋지만 여기선 명령어 히스토리 검색만 다룸

## 설치

```
$ brew install peco
```

## zsh용 히스토리 스크립트 추가

~/.zsh/peco-history.zsh

```
# from http://qiita.com/uchiko/items/f6b1528d7362c9310da0 by uchiko

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
```

파일 저장 후 ``~/.zshrc` 파일 마지막에 `source ~/.zsh/peco-history.zsh`을 추가

## 테스트

쉘에서 `ctrl` + `r`을 누르고 이전에 쳤던 명령어를 쳐보면 검색됨!

## 추가적으로

히스토리는 길면 좋으니 ``~/.zshrc`에 다음을 추가

```
HISTSIZE=100000000
SAVEHIST=100000000
```

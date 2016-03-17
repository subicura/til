# Terminal Tip

`atom editor`나 `sublime text`를 사용할 경우 터미널에서 현재 디렉토리를 기준으로 바로 오픈하고 싶을 때가 있다.
이럴때는 명령어를 실행할 수 있도록 `/usr/local/bin`디렉토리에 실행파일을 링크 하면 된다.

## sublime text 3

```sh
$ # link
$ ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
$ # run
$ atom .
```

## atom

```sh
$ # link
$ ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom
$ # run
$ atom .
```

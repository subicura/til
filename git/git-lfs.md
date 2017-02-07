# git-lfs

대용량 파일 관리 플러그인

## 설치

**macOS**

```
brew install git-lfs
git lfs install
```

**linux**

https://github.com/git-lfs/git-lfs/wiki/Installation

## 사용하기

**단건**

```
git lfs track "design-resources/design.psd"
```

**여러건**

```
git lfs track "*.indd"
```

**확인**

```
git lfs ls-files
```

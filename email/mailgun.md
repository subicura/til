# Mailgun

[mailgun](https://mailgun.com)은 서비스가 아직 작을때 무료로 쉽게 이메일을 주고 받을수 있다.

기본적으로 메일발송을 하기 위해 사용하지만 route를 셋팅하여 다른 메일로 포워딩하는 기능을 제공한다.

## Forwarding

- 도메인설정에서 `MX`값을 정확하게 설정해준다.
  - Name: domain.com (도메인에 따라 수정)
  - Value: mxa.mailgun.org / mxb.mailgun.org
  - Priority: 10
- Mailgun > Routes 메뉴설정
  - Priority: 0
  - Filter Expression: match_recipient(".*@domain.com")
  - Actions: forward("my@email.com")
  - Description: forward email

## DNS nslookup

```
$ nslookup domain.com
$ nslookup -query=mx domain.com
$ nslookup -query=txt domain.com
```

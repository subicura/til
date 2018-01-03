# vpc

https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_Scenario2.html

public에 bastion host 하나 두고 나머지는 모두 private으로 구성후 웹서버는 ELB로 노출하는 방식

## 구성

1. VPC 만들기 - 10.0.0.0/16
2. 서브넷 - public(10.0.1.0/24, public ip 자동생성), private(10.0.10.0/24)
3. 인터넷 게이트웨이 - VPC에 연결
4. NAT 게이트웨이 - public subnet 생성
5. 라우팅 테이블 - public subnet(10.0.0.0/16, 0.0.0.0/0-igw), private subnet(10.0.0.0/16, 0.0.0.0/0-nat)
6. EC2 - public(bastion), private(web server)
7. 보안그룹 - private web server open
8. 로드밸런서 - public subnet에 만들고 private web 서버 등록

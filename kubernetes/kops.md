# kops

[kops](https://github.com/kubernetes/kops) 구성 테스트

kops는 aws, kops 클라이언트로 명령어를 전달하고 AWS S3 특정 bucket에 설정을 관리

## 프로그램

```
brew update
brew install aws
aws --version
aws configure # or aws configure --profile subicura
brew install kops
kops version
```

`~/.aws/config`에 profile 저장
`aws > 내 보안 자격 증명` 에서 생성

## AWS 설정

기본 profile 설정

```
export AWS_DEFAULT_PROFILE=subicura
export AWS_PROFILE=subicura
aws s3 ls
```

## 기본 권한 설정

한번만 설정하면 됨

**group**

```
aws iam create-group \
    --group-name kops

aws iam attach-group-policy \
    --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess \
    --group-name kops

aws iam attach-group-policy \
    --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess \
    --group-name kops

aws iam attach-group-policy \
    --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess \
    --group-name kops

aws iam attach-group-policy \
    --policy-arn arn:aws:iam::aws:policy/IAMFullAccess \
    --group-name kops
```

**user**

```
aws iam create-user \
    --user-name kops

aws iam add-user-to-group \
    --user-name kops \
    --group-name kops

aws iam create-access-key \
    --user-name kops > kops-creds

cat kops-creds

aws configure --profile kops
export AWS_DEFAULT_PROFILE=kops

aws iam get-user
```

**ssh key**

```
mkdir -p cluster
cd cluster

aws ec2 create-key-pair \
    --key-name kops-subicura \
    | jq -r '.KeyMaterial' \
    > kops-subicura.pem

chmod 400 kops-subicura.pem

ssh-keygen -y -f kops-subicura.pem \
  > kops-subicura.pub
```

pem키는 ~/.ssh에 복사하고 pub만 남겨두자

----

## kubernetes 클러스터 만들기

### 설정 관리용 s3 만들기

```
# set aws profile
export AWS_DEFAULT_PROFILE=subicura
export AWS_PROFILE=subicura

# gossip-based cluster
export NAME=kops-subicura.k8s.local
# configuration
export BUCKET_NAME=kops-subicura-$(date +%s)
export KOPS_STATE_STORE=s3://$BUCKET_NAME
# zones
export ZONES=$(aws ec2 \
    describe-availability-zones \
    --region ap-northeast-2 \
    | jq -r \
    '.AvailabilityZones[].ZoneName' \
    | tr '\n' ',' | tr -d ' ')

ZONES=${ZONES%?}

echo $ZONES

aws s3api create-bucket \
    --bucket $BUCKET_NAME \
    --create-bucket-configuration \
    LocationConstraint=ap-northeast-2

aws s3 ls
```

### public VPC에 만들기

```
kops create cluster \
    --name $NAME \
    --master-count 1 \
    --node-count 2 \
    --node-size t2.small \
    --master-size t2.small \
    --zones $ZONES \
    --master-zones $ZONES \
    --ssh-public-key kops/kops-subicura.pub \
    --networking kubenet \
    --kubernetes-version v1.8.10 \
    --yes
```

### private VPC에 만들기

```
# private vpc https://github.com/kubernetes/kops/blob/master/docs/topology.md
kops create cluster \
    --name $NAME \
    --master-count 1 \
    --node-count 2 \
    --node-size t2.small \
    --master-size t2.small \
    --zones $ZONES \
    --master-zones $ZONES \
    --ssh-public-key kops/kops-subicura.pub \
    --kubernetes-version v1.8.10 \
    --topology private \
    --networking kube-router \
    --yes
```

### 존재하는 VPC에 만들기

VPC 만들고 kops에 붙이기 추천

```
# exist VPC
export VPC_ID=vpc-c998caa1
# export ZONES=ap-northeast-2a
kops create cluster \
    --name $NAME \
    --master-count 1 \
    --node-count 2 \
    --node-size t2.small \
    --master-size t2.small \
    --zones $ZONES \
    --master-zones $ZONES \
    --ssh-public-key kops/kops-subicura.pub \
    --kubernetes-version v1.8.10 \
    --topology private \
    --networking kube-router \
    --vpc=${VPC_ID}
```

subnet을 수정하자

```
kops edit cluster $NAME
```

```
# exist subnet
  subnets:
  - cidr: ${SUBNET_CIDR}
    id: ${SUBNET_ID}
    name: us-east-1b
    type: Public
    zone: us-east-1b

# exist egress
  subnets:
  - cidr: 10.20.64.0/21
    name: us-east-1a
    egress: nat-987654321
    type: Private
    zone: us-east-1a

# etcd3
etcdClusters:
- etcdMembers:
  name: main
  enableEtcdTLS: true
  version: 3.0.17

```

```
kops update cluster $NAME --yes
```

### kops 클러스터 테스트

```
kops get cluster
kubectl cluster-info
kops validate cluster
```

### 워커 노드 추가

```
kops edit ig --name $NAME nodes
kops update cluster --name $NAME --yes
kops rolling-update cluster $NAME --yes

kops validate cluster
```

## Add ingress(elb)

https://github.com/kubernetes/kops/tree/master/addon

```
kubectl create \
-f https://raw.githubusercontent.com/kubernetes/kops/master/addons/ingress-nginx/v1.6.0.yaml

kubectl --namespace kube-ingress get all
aws elb describe-load-balancers
```

## High-Availability And Fault-Tolerance

```
aws ec2 \
    describe-instances | jq -r \
    ".Reservations[].Instances[] \
    | select(.SecurityGroups[]\
    .GroupName==\"nodes.$NAME\")\
    .InstanceId"

aws ec2 terminate-instances \
--instance-ids $INSTANCE_ID

aws ec2 \
    describe-instances | jq -r \
    ".Reservations[].Instances[] \
    | select(.SecurityGroups[]\
    .GroupName==\"nodes.$NAME\")\
    .InstanceId"
```

## destroy

```
kops delete cluster \
    --name $NAME \
    --yes
aws s3api delete-bucket \
    --bucket $BUCKET_NAME
```

---

## 수정

* list clusters with: kops get cluster
* edit this cluster with: kops edit cluster kops-subicura.k8s.local
* edit your node instance group: kops edit ig --name=kops-subicura.k8s.local nodes
* edit your master instance group: kops edit ig --name=kops-subicura.k8s.local master-ap-northeast-2a-1

## 접근제어

https://github.com/kubernetes/kops/blob/master/docs/cluster_spec.md

```
spec:
  sshAccess:
    - 12.34.56.78/32
  kubernetesApiAccess:
    - 12.34.56.78/32
```

```
kops edit cluster $NAME
kops update cluster $NAME --yes
```

---

## sample

### dashboard

```
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl -n kube-system get secret

kubectl -n kube-system describe secret kubernetes-dashboard-token-

kubectl proxy

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

### web

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: whoami-ingress
  annotations:
    ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths: 
      - path: /
        backend:
          serviceName: whoami
          servicePort: 4567
---

apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: whoami
spec:
  replicas: 1
  selector:
    matchLabels:
      type: frontend
      service: whoami
  template:
    metadata:
      labels:
        type: frontend
        service: whoami
    spec:
      containers:
      - name: k8s-frontend
        image: subicura/whoami:1

---

apiVersion: v1
kind: Service
metadata:
  name: whoami
spec:
  ports:
  - port: 4567
  selector:
    type: frontend
    service: whoami
```

```
k get ing
k describe ing/whoami-ingress
```

```
while true
do
  curl af407b8d833da11e8b30002b42a4da15-1257421023.ap-northeast-2.elb.amazonaws.com/whoami
  echo ""
	sleep 1
done
```

```
while true
do
  kubectl get pods
	sleep 1
done
```


```
k rollout history deploy/whoami
k rollout undo deployment/whoami
k rollout undo deployment/whoami --to-revision=2
```

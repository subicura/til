# Helm

https://helm.sh/

## install

```
brew install kubernetes-helm
```

```
helm init
helm version
kubectl -n kube-system get pods # check tiller
```

https://docs.helm.sh/using_helm/#tiller-and-role-based-access-control

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
```

```
$ kubectl create -f rbac-config.yaml
serviceaccount "tiller" created
clusterrolebinding "tiller" created
$ helm init --service-account tiller
```

## create chart

```
helm create sample
```

## install

```
helm install sample -n nginx-sample
```

## list

```
helm ls
```

## status


```
helm status $NAME
```

## uninstall

```
helm delete $NAME
```

---

## Chart 수정

- values.yaml 파일은 개발/운영 공통 설정
- values.dev.yaml 파일은 개발, values.prd.yaml 파일은 운영

개발 배포

```
helm install sample -n sample -f ./sample/values.dev.yaml
```

---

## Template 기초

### function & value

- include: _helpers.tpl에 정의된 값을 사용함
- .Release: 배포한 차트 정보
- .Values: values.yaml 또는 --set 옵션으로 지정한 값

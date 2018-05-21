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

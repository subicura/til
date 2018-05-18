# Istio

An open platform to connect, manage, and secure microservices

docker-for-mac sample

## Install

```
curl -L https://git.io/getLatestIstio | sh -
```

- install: install k8s spec file
- samples: sample
- bin: client file

## Run istio

```
cd istio-0.7.1
export PATH=$PWD/bin:$PATH
kubectl apply -f install/kubernetes/istio.yaml

kubectl get svc -n istio-system
kubectl get pods -n istio-system
```

## Run sample

```
istioctl kube-inject --debug -f samples/bookinfo/kube/bookinfo.yaml | kubectl apply -f -

kubectl get pods

open http://localhost/productpage
```

## Zipkin

```
kubectl apply -f install/kubernetes/addons/zipkin.yaml
kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=zipkin -o jsonpath='{.items[0].metadata.name}') 9411:9411 &
open http://localhost:9411

kubectl get svc -n istio-system
kubectl get pods -n istio-system
```

## Promethues

```
kubectl apply -f install/kubernetes/addons/prometheus.yaml
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') 9090:9090 &
open http://localhost:9090

kubectl get svc -n istio-system
kubectl get pods -n istio-system
```

## Grafana

```
kubectl apply -f install/kubernetes/addons/grafana.yaml
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
open http://localhost:3000
```

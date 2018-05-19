# Istio

Istio provides an easy way to create a network of deployed services with load balancing, service-to-service authentication, monitoring, and more.

- [docker-for-mac](https://docs.docker.com/docker-for-mac/) 18.05.0-ce(edge + kubernetes 1.9.6 enable) 
- [istio](https://istio.io/docs/) (0.7.1) (manual injection)
- [kong](https://konghq.com/plugins/) (0.13) + kong ingress (0.0.?)

## Prerequire

```
curl -L https://git.io/getLatestIstio | sh -
cd istio-0.7.1
export PATH=$PWD/bin:$PATH
```

- directory
  - install: install k8s spec file
  - samples: sample
  - bin: client file

## Run Istio & Sample

### Run Istio

- istio
  - control plane
    - pilot
    - mixer
    - istio-auth
    - ingress controller
  - data plane
    - [envoy](https://www.envoyproxy.io/) by sidecar pattern

```
# run
kubectl apply -f install/kubernetes/istio.yaml # retry when config.istio.io error occurs
# check
kubectl get svc -n istio-system
kubectl get pods -n istio-system
```

### Run sample

- productpage(v1)
- details(v1)
- reviews(v1, v2, v3)
  - v1: no rating
  - v2: black star
  - v3: red star
- ratings(v1)

```
# run
istioctl kube-inject --debug -f samples/bookinfo/kube/bookinfo.yaml | kubectl apply -f -
# check
kubectl get pods
# test
open http://localhost/productpage
```

## Addons

### Zipkin

Tracking service

```
# run
kubectl apply -f install/kubernetes/addons/zipkin.yaml
# check
kubectl get svc -n istio-system
kubectl get pods -n istio-system
# port forwarding
kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=zipkin -o jsonpath='{.items[0].metadata.name}') 9411:9411 &
# test
open http://localhost:9411
```

### Promethues

Collecting metrics

```
# run
kubectl apply -f install/kubernetes/addons/prometheus.yaml
# check
kubectl get svc -n istio-system
kubectl get pods -n istio-system
# port forwarding
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') 9090:9090 &
# test
open http://localhost:9090
```

### Grafana

```
# run
kubectl apply -f install/kubernetes/addons/grafana.yaml
# port forwarding
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
# test
open http://localhost:3000
```

### Service Graph

Service visualizer

```
# run
kubectl apply -f install/kubernetes/addons/servicegraph.yaml
# port forwarding
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=servicegraph -o jsonpath='{.items[0].metadata.name}') 8088:8088 &
# test
open http://localhost:8088/dotviz
```

### All addon

```
kubectl apply -f install/kubernetes/addons/zipkin.yaml
kubectl apply -f install/kubernetes/addons/prometheus.yaml
kubectl apply -f install/kubernetes/addons/grafana.yaml
kubectl apply -f install/kubernetes/addons/servicegraph.yaml
```

## Traffic Management

`istioctl` 명령어를 사용

### Request Routing

원하는 곳으로 라우팅하기

```
# run (all use v1)
istioctl create -f samples/bookinfo/kube/route-rule-all-v1.yaml
# run (jason use v2)
istioctl create -f samples/bookinfo/kube/route-rule-reviews-test-v2.yaml
# check
istioctl get routerule
# detail view
istioctl get routerule productpage-default -o yaml
```

### Fault injection

에러 발생 / metric 수집은 되지 않음 (https://github.com/istio/istio/issues/4323)

```
# run (delay when jason)
istioctl create -f samples/bookinfo/kube/route-rule-ratings-test-delay.yaml
# remove
istioctl delete -f samples/bookinfo/kube/route-rule-ratings-test-delay.yaml
# run (abort when jason)
istioctl create -f samples/bookinfo/kube/route-rule-ratings-test-abort.yaml
```


## With kong

### remove ingress

```
# check istio-ingress
kubectl -n istio-system get all -l 'istio=ingress'
# remove istio-ingress
kubectl -n istio-system delete deploy/istio-ingress svc/istio-ingress
# remove sample ingress
kubectl delete ing/gateway
```

### Run kong with ingress

```
# run
kubectl apply -f kong/all-in-one-postgres.yaml
# check
kubectl -n kong get all
```

### Run sample (with kong ingress)

```
# run
istioctl kube-inject --debug -f kong/bookinfo-kong.yaml | kubectl apply -f -
# check
kubectl get all
# test
watch -n 1 curl -I -s http://localhost/productpage
```

service port name을 http로 지정해야 정상적으로 metrics 수집함

```
# run
istioctl kube-inject --debug -f kong/restapi-sample.yaml | kubectl apply -f -
# check
kubectl get all
# test
watch -n 1 curl -I -s http://localhost/sample
```

## Trouble Shooting

### Verify Mixer

```
# run
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l istio=mixer -o jsonpath='{.items[0].metadata.name}') 9093:9093
# test
open http://localhost:9093/metrics
```

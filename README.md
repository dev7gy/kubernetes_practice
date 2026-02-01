# kubernetes
## environment
- mac mini4
- Docker Desktop 4.55.0
- k8s vresion v1.34.3
## pod
컨테이너들의 집합
```sh
kubectl run nginx --image=nginx
kubectl get pod -o wide

kubectl port-forward pod/nginx 8888:80
curl localhost:8888
```
### 외부에서 해당 pod에 접속되게 하기
```sh
kubectl expose pod nginx --type=LoadBalancer --port=80
kubectl get service

curl localhost:80
```
## deployment
pod를 모아놓은 것
```sh
kubectl create deployment deploy-nginx --image=nginx
kubectl scale deployment deploy-nginx --replicas=3
kubectl expose deployment deploy-nginx --type=LoadBalancer --port=80
```
## service
동적으로 변하는 파드(Pod) 집합에 접근하기 위한 '고정된 엔드포인트'를 제공하는 추상화 레이어

## namespace

## Concept

# Object
쿠버네티스 API 서버로 생성하는 영속성을 가지는 모든 실체

# Pod
쿠버네티스 환경에서 컨테이너 애플리케이션을 실행하는 기본 단위
- 각 파드는 고유의 IP주소 가지고, 고유의 볼륨을 사용
```bash
kubectl run nginx --image=nginx
kubectl get pod -o wide
kubectl exec -it nginx -- bash
```

# Deployment
파드가 배포되는 방법을 정의하는 오브젝트
- 파드 갯수
- 이미지 종류
- 배포 방법
- 등등
```bash
kubectl create deployment httpd --image=httpd
kubectl scale deployment httpd --replicas 10
kubectl get pod -w
# pod 삭제 테스트, pod 자동 복구
kubectl delete pod httpd-7699944dc8-7cxf4
```

# Namespace
네임스페이스는 클러스터를 구분하는 가상 클러스터 단위
같은 네임스페이스 내에서는 같은 이름의 오브젝트를 만들지 못하지만, 네임스페이스가 다르면 같은 이름의 오브젝트를 생성 가능

현업에서는 네임스페이스를 주로 애플리케이션을 구분하는 단위로 사용

네임스페이스는 클러스터를 가상으로 구분하는 단위라서 물리적으로 완전하게 분리하지는 못함.
기본 설정으로 임의의 네임스페이스에서 다른 네임스페이스로 네트워크 연결이 가능, 2개의 네임스페이스에서 실행 중인 파드는 각 파드 간 통신 가능
```bash
kubectl create ns practice01
kubectl run nginx --image=nginx
## pod/nginx created
kubectl run nginx --image=nginx
## Error from server (AlreadyExists): pods "nginx" already exists
```

- chapter3_finish_p75


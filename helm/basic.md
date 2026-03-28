# Helm 을 이용해서 tomcat 배포하기
1. Helm hub(artifact hub)에서 설치하고 싶은 패키지의 chart repository와 설치 방법 찾아봄
    - Artifact Hub: https://artifacthub.io/
2. Helm Chart 레파지토리 등록
3. Helm Chart 검색
4. Helm Chart 설치
5. Helm Chart 삭제

## 차트 레포지토리 등록
```zsh
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo list

helm search repo bitnami/tomcat --versions

helm repo update

helm repo remove bitnami
```
### tomcat 배포
```zsh
helm install my-tomcat bitnami/tomcat --version 13.4.8 --set persistence.enabled=false

kubectl get svc --namespace default -w my-tomcat
# kind 환경에서 LoadBalancer 타입 서비스는 실제로 외부로 노출되지 않기 때문에, NodePort로 접근이 안될 때가 있음 -> Port Forwarding으로 접근
kubectl port-forward svc/my-tomcat 8080:80
# 웹 브라우저에서 http://localhost:8080 접속해서 tomcat 페이지 뜨는지 확인
```
### tomcat 삭제
```zsh
helm repo list
helm status my-tomcat
helm uninstall my-tomcat
```

### 관리자 페이지에 접속이 되도록 다시 재설치
```zsh
helm install my-tomcat bitnami/tomcat --version 13.4.8 --set persistence.enabled=false,tomcatAllowRemoteManagement=1
# 관리자 페이지 접근 http://localhost:8081/manager/html
```

### chart 다운로드
```zsh
helm pull bitnami/tomcat --version 13.4.8
# tar.gz 파일이 다운로드됨 -> 압축 해제
tar -xvf tomcat-13.4.8.tgz

# vi values.yaml 파일에서 persistence.enabled: false, tomcatAllowRemoteManagement: 1 설정 추가
# 압축 해제된 디렉토리로 이동
cd tomcat
helm install my-tomcat . -f values.yaml
```

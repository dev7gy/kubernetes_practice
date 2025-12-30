# podinfo 차트 리포지토리 추가
helm repo add podinfo https://stefanprodan.github.io/podinfo
helm repo update

# demo-app 네임스페이스에 설치
helm install my-shell podinfo/podinfo \
  --namespace demo-app \
  --create-namespace

kubectl port-forward svc/my-shell-podinfo 9898:9898 -n demo-app

# 네임스페이스 생성
kubectl create namespace monitoring

# Helm 설치 실행
helm install prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  -f monitoring-values.yaml
  
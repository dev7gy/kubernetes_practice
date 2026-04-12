# kubernetes cluster setup using multipass
## create 3 nodes (1 master and 2 workers)
```bash
multipass launch --name control-plane  --cpus 1 --memory 2G --disk 20G
multipass launch --name worker1 --cpus 1 --memory 2G --disk 20G
multipass launch --name worker2 --cpus 1 --memory 2G --disk 20G
```

# k3s setup using multipass
## create node
```bash
multipass launch --name k3s-node1 --cpus 2 --memory 4G --disk 30G
```
## install k3s
node 1개 구성
```bash
# install k3s on node1
multipass exec k3s-node1 -- sh -c "curl -sfL https://get.k3s.io | sh -"
# get k3s token
multipass exec k3s-node1 -- sudo cat /etc/rancher/k3s/k3s.yaml > ./k3s.yaml

mkdir -p ~/.kube
cp ./k3s.yaml ~/.kube/config
# change server address in k3s.yaml to node1's IP address
# multipass list 명령어로 node1의 IP 주소 확인
```
# kube-promethus-stack setup
```
helm install prometheus-stack oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack -n monitoring --create-namespace

kubectl port-forward svc/prometheus-stack-grafana 9080:80 -n monitoring --address 0.0.0.0
kubectl port-forward svc/prometheus-stack-kube-prom-prometheus 9090:9090 -n monitoring --address 0.0.0.0
kubectl port-forward svc/prometheus-stack-kube-prom-alertmanager 9093:9093 -n monitoring --address 0.0.0.0
```

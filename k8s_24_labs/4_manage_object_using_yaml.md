# kube-neat Plugin
```bash
kubectl krew install neat

kubectl run busybox --image=busybox
## busybox   0/1     Completed   2 (15s ago)   16s

kubectl get pod busybox -o yaml|kubectl neat > busybox-pod.yaml

```

reference: https://kubernetes.io/docs/concepts/services-networking/service/


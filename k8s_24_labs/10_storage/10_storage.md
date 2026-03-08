# storage
## OpenEBS 로컬 호스트패스 설치
```bash
./openebs-hostpath/install_ebs.sh
kubectl get sc
```
**output**
openebs-hostpath: 호스트 노드의 특정 디렉토리에 데이터를 할당하는 방식
```text
NAME                     PROVISIONER               RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
hostpath                 rancher.io/local-path     Delete          WaitForFirstConsumer   false                  60d
mayastor-etcd-localpv    openebs.io/local          Delete          WaitForFirstConsumer   false                  3h36m
openebs-hostpath         openebs.io/local          Delete          WaitForFirstConsumer   false                  3h36m
openebs-loki-localpv     openebs.io/local          Delete          WaitForFirstConsumer   false                  3h36m
openebs-minio-localpv    openebs.io/local          Delete          WaitForFirstConsumer   false                  3h36m
openebs-single-replica   io.openebs.csi-mayastor   Delete          Immediate              true                   3h36m
standard (default)       rancher.io/local-path     Delete          WaitForFirstConsumer   false                  60d
```

## 스토리지 클래스를 이용한 pvc 및 영구볼륨 사용
**openebs-hostname/openebs-hostpath-date-pvc.yaml**
- kind: PersistentVolumeClaim 
        쿠버네티스는 영구볼륨을 요청하는 PersistentVolumeClaim을 별도의 리소스로 지정
- namespace: default
    
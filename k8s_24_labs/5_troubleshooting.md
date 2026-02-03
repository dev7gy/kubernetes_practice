# 일반적인 쿠버네티스 작업 순서
apply -> get -> describe -> logs -> get event
- describe는 상세 정보 확인
- logs는 애플리케이션 로그 확인 
- get event는 클러스터 이벤트 확인
```bash
kubectl get events -n kube-system
kubectl get events -A
```
# 장애 처리 사례: 호스트 노드의 파일 시스템 용량 초과
노드의 사용 가능한 디스크 용량 부족 상황 유발


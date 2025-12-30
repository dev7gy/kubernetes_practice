#!/opt/homebrew/bin/bash

# 목적: Grafana 대시보드 시각화를 위한 실시간 트래픽 생성

TARGET_URL="http://localhost:9898/api/echo"
INTERVAL=0.1  # 100ms 간격 (초당 10번 요청)

echo "Starting traffic generation to $TARGET_URL..."
echo "Press [CTRL+C] to stop."

# 무한 루프 시작
while true; do
  # -s: silent, -o: output to /dev/null, -w: write-out (HTTP 상태코드 확인)
  RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL")
  
  if [ "$RESPONSE" -eq 200 ]; then
    echo -n "."  # 성공 시 점 하나 찍기
  else
    echo -e "\n[ERROR] Received HTTP $RESPONSE"
  fi
  
  sleep $INTERVAL
done

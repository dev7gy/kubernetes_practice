# Helm chart Directory
- Chart.yaml 차트에 대한 정보가 담긴 YAML 파일
- LICENSE 차트의 라이선스 정보가 담긴 텍스트 파일
- README.md 해당 차트에 대한 설명을 포함한 README 파일
- values.yaml 차트의 기본 템플릿 변수 파일
- charts/ 차트에 종속된 차트들을 포함하는 디렉토리
- crds/ 커스텀 자원 정의
- templates/ values 파일과 같이 유효한 쿠버네티스 매니패스트 파일을 생성하는 템플릿 디렉토리
- templates/NOTES.txt 차트 사용법을 설명하는 텍스트 파일

# Helm command
```bash
helm repo add

helm pull

HELM_NAME=test
cp values.yaml my-values.yaml
helm install ${HELM_NAME} -f my-values.yaml

helm ls

helm get manifest

helm upgrade

helm delete
```

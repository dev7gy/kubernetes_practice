# 내 helm 차트 만들기
## Helm 명령어
### Chart 템플릿 생성
```zsh
helm create mychart
```

### show 명령으로 차트 정보 확인
```zsh
helm show values .
helm show chart .

vi README.md
# # Title
# ## introduction
# This is README.md

helm show readme .
helm show all .
```

### template 명령
아래 명령으로 보면, `mychart` 디렉토리에 있는 템플릿이 렌더링된 결과를 볼 수 있습니다.
```zsh
helm template mychart .
```

### Chart 배포
```zsh
helm install mychart .
```
### Get 명령
```zsh
helm get manifest mychart
helm get notes mychart
helm get values mychart
helm get all mychart
```
#### helm get values 비교
```zsh
helm uninstall mychart
helm install mychart . -f values.yaml
# values.yaml 파일 내용이 확인됨
helm get values mychart

helm uninstall mychart
helm install mychart . --set replicaCount=3
helm get values mychart
```

## 내장 객체
### 실습용 Configmap 추가
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: built-in-object
data:
  .Release: ______________________________________
  .Release.Name: {{ .Release.Name }}
  .Release.Namespace: {{ .Release.Namespace }}
  .Release.IsUpgrade: "{{ .Release.IsUpgrade }}"
  .Release.IsInstall: "{{ .Release.IsInstall }}"
  .Release.Revision: "{{ .Release.Revision }}"
  .Release.Service: {{ .Release.Service }}
  .Values: ______________________________________
  .Values.replicaCount: "{{ .Values.replicaCount }}"
  .Values.image.repository: {{ .Values.image.repository }}
  .Values.image.pullPolicy: {{ .Values.image.pullPolicy }}
  .Values.service.type: {{ .Values.service.type }}
  .Values.service.port: "{{ .Values.service.port }}"
  .Chart: ______________________________________
  .Chart.Name: {{ .Chart.Name }}
  .Chart.Description: {{ .Chart.Description }}
  .Chart.Type: {{ .Chart.Type }}
  .Chart.Version: {{ .Chart.Version }}
  .Chart.AppVersion: {{ .Chart.AppVersion }}
  .Template: ______________________________________
  .Template.BasePath: {{ .Template.BasePath }}
  .Template.Name: {{ .Template.Name }}
```
실습용 Configmap 준비 후 install
```zsh
vi templates/configmap-object.yaml
# 위 yaml 내용 입력

# 실습에 불필요한 내용 삭제
cd templates
rm -rf deployment.yaml hpa.yaml ingress.yaml serviceaccount.yaml tests

# install 배포
cd ..
helm install mychart . -n default
helm get manifest mychart
# configmap 객체가 렌더링된 것을 확인할 수 있음

# values.yaml 파일의 replicaCount 값 변경 후 수정 사항 반영
helm upgrade mychart . -n default
helm get manifest mychart
```

## 변수 주입 우선 순위
### ConfigMap 추가
vi templates/configmap-values.yaml
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: values-yaml
data:
  env: {{ .Values.configMapData.env }}
  log: {{ .Values.configMapData.log }}
  path: "{{ .Values.configMapData.path }}"
```
### values.yaml에 해당 속성 추가
```yaml
configMapData:
  env: dev
  log: debug
  path: "/data"
```
### template명령으로 렌더링 결과만 확인
```zsh
helm template mychart .
```
### prod용 values_prod.yaml 파일 추가
vi values_prod.yaml
```yaml
configMapData:
  env: prod
  log: info
```
- path 속성은 values.yaml 파일에 정의된 값을 그대로 확인됨
#### -f 옵션으로 prod용 values 파일을 적용하여 렌더링 결과 확인
```zsh
helm template mychart . -f ./values_prod.yaml
```
#### --set 옵션으로 prod용 values 파일을 적용하여 렌더링 결과 확인
```zsh
helm template mychart . -f ./values_prod.yaml --set configMapData.log=debug
```
- log 속성은 --set 옵션으로 debug로 재정의 되었지만, path 속성은 values_prod.yaml 파일에 정의된 값이 없으므로 values.yaml 파일에 정의된 값을 그대로 확인할 수 있음
## 사용자 정의 변수
templates/_helpers.tpl 파일에 사용자 정의 변수를 정의할 수 있습니다.

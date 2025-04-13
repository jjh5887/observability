  #!/bin/bash

# 종료 시 에러 핸들링
set -e


print_section() {
  local message=$1
  echo  "\n--------------------------------------------------"
  echo  "\t$message\t"
  echo  "--------------------------------------------------\n"
}

# Kubernetes 클러스터 생성
CLUSTER_NAME=${1:-"my-cluster"}

# 현재 존재하는 클러스터 목록에서 해당 클러스터가 있는지 확인
if kind get clusters | grep -wq "${CLUSTER_NAME}"; then
    print_section "클러스터 '${CLUSTER_NAME}'가 이미 존재합니다. 삭제를 시작합니다..."
    kind delete cluster --name "${CLUSTER_NAME}"
    print_section "클러스터 '${CLUSTER_NAME}' 삭제 완료."
fi

print_section "Kubernetes 클러스터 생성 중..."
kind create cluster --name "${CLUSTER_NAME}" --config cluster-config.yaml
print_section "Kubernetes 클러스터 생성 완료"

# zsh 설정 업데이트
if [ -f "$HOME/.zshrc" ]; then
  if ! grep -q 'export PATH=.*istio-' "$HOME/.zshrc"; then
    echo 'export PATH=$PATH:'"$PWD"'/bin' >> "$HOME/.zshrc"
    echo "zsh 설정 파일(.zshrc)이 업데이트되었습니다."
  else
    echo "zsh 설정 파일(.zshrc)은 이미 업데이트되어 있습니다."
  fi
fi

# bash 설정 업데이트
if [ -f "$HOME/.bashrc" ]; then
  if ! grep -q 'export PATH=.*istio-' "$HOME/.bashrc"; then
    echo 'export PATH=$PATH:'"$PWD"'/bin' >> "$HOME/.bashrc"
    echo "bash 설정 파일(.bashrc)이 업데이트되었습니다."
  else
    echo "bash 설정 파일(.bashrc)은 이미 업데이트되어 있습니다."
  fi
fi

# fish 설정 업데이트
if [ -d "$HOME/.config/fish" ]; then
  if ! grep -q 'set -gx PATH .*istio-' "$HOME/.config/fish/config.fish"; then
    echo 'set -gx PATH '"$PWD"'/bin $PATH' >> "$HOME/.config/fish/config.fish"
    echo "fish 설정 파일(config.fish)이 업데이트되었습니다."
  else
    echo "fish 설정 파일(config.fish)은 이미 업데이트되어 있습니다."
  fi
fi


print_section "환경 설정 파일 로드"
# 환경 설정 파일 로드 안내
echo "환경 설정 파일을 다시 로드하려면 터미널을 재시작하거나 아래 명령어를 실행하십시오:"
echo "bash: source ~/.bashrc"
echo "zsh: source ~/.zshrc"
echo "fish: . ~/.config/fish/config.fish"

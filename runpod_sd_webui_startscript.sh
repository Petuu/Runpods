#!/bin/bash

# 패키지 목록 받아오기
apt update
# 필수패키지 설치
apt install libgl1 -yq
# Ngrok 설치
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && apt update && apt install ngrok
# Ngrok 토큰 설정
ngrok config add-authtoken 2MIUvycxfHLydrCI7iCIZJPqHxy_22wfUdoyhJxTcoajYCpwz
echo "authtoken: 2MIUvycxfHLydrCI7iCIZJPqHxy_22wfUdoyhJxTcoajYCpwz" > /workspace/ngrok.yml
# 자동좌 레포 클론
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /workspace/stable-diffusion-webui/
# 모델 쓸거 다운받기
wget https://huggingface.co/Petu/setup/resolve/main/model/camelliamix25D_v10.safetensors -O /workspace/stable-diffusion-webui/models/Stable-diffusion/camelliamix25D_v10.safetensors
# VAE 쓸거 다운받기
wget https://huggingface.co/hakurei/waifu-diffusion-v1-4/resolve/main/vae/kl-f8-anime2.ckpt -O /workspace/stable-diffusion-webui/models/VAE/kl-f8-anime2.ckpt
# EasyNegative 다운받기
wget https://huggingface.co/datasets/gsdf/EasyNegative/resolve/main/EasyNegative.safetensors -O /workspace/stable-diffusion-webui/embeddings/EasyNegative.safetensors
# 알아서 쓸 익스텐션 클론 (익스텐션 탭에서 다운받아도 무방)

# venv 가상환경 만들기
python -m venv /workspace/stable-diffusion-webui/venv --without-pip
# venv activate
source /workspace/stable-diffusion-webui/venv/bin/activate
curl https://bootstrap.pypa.io/get-pip.py | python
# 필수 의존성 패키지 다운로드
python -m pip install -r /workspace/stable-diffusion-webui/requirements_versions.txt
# start.sh 다운로드
wget https://gist.github.com/panta5/b0cbddee37d6839561ad1b6a2d353a5b/raw/start.sh -O /workspace/stable-diffusion-webui/start.sh
wget https://gist.githubusercontent.com/panta5/6239382f45a773d75a9788efd1c940a9/raw/continue.sh -O /workspace/stable-diffusion-webui/continue.sh
chmod +x /workspace/stable-diffusion-webui/start.sh
chmod +x /workspace/stable-diffusion-webui/continue.sh
# 완료
echo -e "환경 구성이 완료됐습니다. \n이후부터는 시작할 때 /workspace/stable-diffusion-webui/start.sh 파일을 실행해주세요"
echo -e "팟을 켤 때 자동실행을 원하신다면, 설정에서 7860포트를 열어주시고\n\e[42;1;31mbash -c \"cd /workspace/stable-diffusion-webui \&\& ./continue.sh\"\e[0m 명령을 이용해주세요."
exit 0

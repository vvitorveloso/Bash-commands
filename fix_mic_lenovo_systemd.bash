#!/bin/bash

# Verificar se o script é executado como superusuário
if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa ser executado como superusuário (root)." 
  exit 1
fi

# Passo 1: Copiar o script "fix_mic_lenovo.py" para /opt/
cp fix_mic_lenovo.py /opt/

# Passo 2: Criar a unidade systemd
cat << EOF > /etc/systemd/system/fix-mic.service
[Unit]
Description=Fix Lenovo Mic
After=pipewire.service
Wants=pipewire.service

[Service]
Type=simple
ExecStart=/usr/bin/python3 /opt/fix_mic_lenovo.py
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Passo 3: Atualizar e habilitar o serviço
systemctl daemon-reload
systemctl enable fix-mic.service

# Passo 4: Iniciar o serviço
systemctl start fix-mic.service

echo "O serviço para corrigir o microfone do Lenovo foi configurado e iniciado automaticamente após o início do Pipewire."

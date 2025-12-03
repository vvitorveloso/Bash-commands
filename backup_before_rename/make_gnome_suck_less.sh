#!/bin/bash

# Define o caminho do schema para facilitar leitura/manutenção
SCHEMA="org.gnome.desktop.wm.keybindings"

# 1. Limpa os atalhos de "Alternar Aplicativos" (Agrupado)
# Isso é obrigatório para liberar as teclas <Alt>Tab e <Shift><Alt>Tab
gsettings set $SCHEMA switch-applications "[]"
gsettings set $SCHEMA switch-applications-backward "[]"

# 2. Define os atalhos para "Alternar Janelas" (Linear/Individual)
gsettings set $SCHEMA switch-windows "['<Alt>Tab']"
gsettings set $SCHEMA switch-windows-backward "['<Shift><Alt>Tab']"

echo "GNOME configurado para alternar janelas individuais (estilo clássico)."

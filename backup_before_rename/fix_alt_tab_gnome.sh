#!/bin/bash

# Script para alterar o comportamento do Alt+Tab no GNOME
# Por padrão: muda para alternar entre JANELAS (estilo Windows/KDE)
# Com --reset: restaura o padrão do GNOME (agrupar APLICATIVOS)

# Caminho dos schemas do gsettings
SCHEMA="org.gnome.desktop.wm.keybindings"

# Função para aplicar o modo "Janelas"
aplicar_modo_janelas() {
    echo "Aplicando atalhos para alternar entre JANELAS (individual)..."
    
    # Define 'switch-applications' (agrupado) para Super+Tab
    gsettings set $SCHEMA switch-applications "['<Super>Tab']"
    gsettings set $SCHEMA switch-applications-backward "['<Shift><Super>Tab']"
    
    # Define 'switch-windows' (individual) para Alt+Tab
    gsettings set $SCHEMA switch-windows "['<Alt>Tab']"
    gsettings set $SCHEMA switch-windows-backward "['<Shift><Alt>Tab']"
    
    echo "Feito! Alt+Tab agora alterna entre janelas individuais."
}

# Função para reverter ao padrão GNOME
reverter_padrao_gnome() {
    echo "Restaurando atalhos do GNOME para o padrão (agrupado)..."
    
    # Reseta os dois pares de atalhos
    gsettings reset $SCHEMA switch-applications
    gsettings reset $SCHEMA switch-applications-backward
    gsettings reset $SCHEMA switch-windows
    gsettings reset $SCHEMA switch-windows-backward
    
    echo "Feito! Alt+Tab agora agrupa aplicativos (padrão GNOME)."
}

# Verifica o argumento passado
if [ "$1" == "--reset" ]; then
    reverter_padrao_gnome
else
    aplicar_modo_janelas
fi
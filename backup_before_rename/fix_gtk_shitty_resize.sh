#!/bin/bash

# Função para criar diretórios se não existirem
create_dir_if_not_exists() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# Configuração para GTK 2
cat > ~/.gtkrc-2.0 << EOL
style "smaller-titlebar" {
    GtkWindow::titlebar-height = 16
}
widget "*.gtk-titlebar" style "smaller-titlebar"
EOL

# Configuração para GTK 3
create_dir_if_not_exists ~/.config/gtk-3.0
cat > ~/.config/gtk-3.0/gtk.css << EOL
headerbar {
    min-height: 0px;
    padding-left: 2px;
    padding-right: 2px;
}
headerbar entry,
headerbar spinbutton,
headerbar button,
headerbar separator {
    margin-top: 0px;
    margin-bottom: 0px;
}
headerbar button {
    min-height: 15px;
    min-width: 15px;
    padding: 2px;
}
.titlebar {
    min-height: 0px;
}
window.ssd headerbar.titlebar {
    padding-top: 0px;
    padding-bottom: 0px;
    min-height: 0;
}
window.ssd headerbar.titlebar button.titlebutton {
    padding: 0px;
    min-height: 0;
    min-width: 0;
}
EOL

# Configuração para GTK 4 (incluindo libadwaita)
create_dir_if_not_exists ~/.config/gtk-4.0
cat > ~/.config/gtk-4.0/gtk.css << EOL
@define-color accent_color @blue_3;
headerbar {
    min-height: 0px;
    padding-left: 2px;
    padding-right: 2px;
}
headerbar entry,
headerbar spinbutton,
headerbar button,
headerbar separator {
    margin-top: 0px;
    margin-bottom: 0px;
}
headerbar button {
    min-height: 15px;
    min-width: 15px;
    padding: 2px;
}
window.csd {
    border-radius: 0;
    box-shadow: none;
}
.default-decoration {
    min-height: 0;
    padding: 2px;
}
.default-decoration .titlebutton {
    min-height: 15px;
    min-width: 15px;
}
window.ssd headerbar.titlebar {
    padding-top: 0px;
    padding-bottom: 0px;
    min-height: 0;
}
window.ssd headerbar.titlebar button.titlebutton {
    padding: 0px;
    min-height: 0;
    min-width: 0;
}
EOL

echo "Configurações aplicadas para reduzir o tamanho da barra de título para GTK 2, 3 e 4 (incluindo libadwaita)."
echo "Por favor, reinicie seus aplicativos ou faça logout e login novamente para ver as mudanças."
echo "Nota: Nem todos os aplicativos podem respeitar todas essas configurações."

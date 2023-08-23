#!/bin/bash
wget "https://github.com/cvsuser-chromium/third_party_hunspell_dictionaries/raw/master/pt-BR-3-0.bdic" -O pt_BR.bdic
sudo mv 'pt_BR.bdic' /usr/share/qt6/qtwebengine_dictionaries/
sudo chown root:root /usr/share/qt6/qtwebengine_dictionaries/pt_BR.bdic
#sudo rm -rf /usr/share/qt/qtwebengine_dictionaries/pt_BR.bdic
sudo ln -s "../../qt6/qtwebengine_dictionaries/pt_BR.bdic" "/usr/share/qt/qtwebengine_dictionaries/pt_BR.bdic"
#ls -lars  /usr/share/qt/qtwebengine_dictionaries/



ps aux | grep -Ei 'wineserver|\.exe$' | grep -v grep | awk '{print $2}' | xargs kill -9

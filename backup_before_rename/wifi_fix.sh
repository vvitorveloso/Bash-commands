sudo systemctl stop NetworkManager

for i in $(echo ath10k_pci ath10k_core ath mac80211 cfg80211 ath9k); do
    sudo rmmod $i
done

for i in $(echo ath10k_pci ath10k_core ath mac80211 cfg80211 ath9k); do
    sudo modprobe $i
done

sudo systemctl start NetworkManager

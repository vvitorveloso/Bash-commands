sudo firewall-cmd --add-masquerade --permanent --zone=home
sudo firewall-cmd --zone=home --permanent --add-port=1714-1764/tcp
sudo firewall-cmd --zone=home --permanent --add-port=1714-1764/udp
sudo systemctl restart firewalld.service 
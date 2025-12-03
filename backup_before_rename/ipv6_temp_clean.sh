#!/bin/bash

# Lista de todas as interfaces de rede ativas
interfaces=$(ip -6 addr | grep -oP '^[0-9]+: \K\w+')

# Loop através de cada interface
for iface in $interfaces; do
    echo "Verificando interface: $iface"

    # Lista de todos os endereços IPv6 deprecated nessa interface
    deprecated_ips=$(ip -6 addr show dev $iface | grep deprecated | awk '{print $2}')

    # Remover cada endereço IPv6 deprecated
    for ip in $deprecated_ips; do
        echo "Removendo endereço deprecated: $ip da interface: $iface"
        sudo ip -6 addr del $ip dev $iface
    done

    # Remover endereços temporários (opcional, dependendo do seu caso)
    sudo sysctl -w net.ipv6.conf.$iface.use_tempaddr=0
done

echo "Todos os endereços IPv6 deprecated foram removidos."

#O Anbox usa a ponte anbox0 semelhante à rede NAT da brctl show você pode ver:
#
# bridge name  bridge id               STP enabled     interfaces
#anbox0               8000.1 edb3f6031c8       no              vethQ6F8VV
#
#Para o sistema que possui o firewalld ativado, você precisa adicionar anbox0 à zona internal e configurar o disfarce de IP da zona public para se comunicar com a rede externa.
#
#    Zona de verificação:
########

firewall-cmd --get-active-zones

#######
#A interface anbox0 ainda não está visível.
#
#    Adicione a interface anbox0 à zona interna:
#######

firewall-cmd --zone=internal --change-interface=anbox0

#######
#Depois verifique:
#######

firewall-cmd --get-active-zones

#######
#A saída mostra:
#
# internal
#  interfaces : anbox0
#...
#
#    Verifique a interface pública, você encontrará esse mascarado masquerade: no
###########

firewall-cmd --zone=public --list-all

##########
#    Adicione mascarada na área pública:

firewall-cmd --zone=public --add-masquerade


#!/bin/bash

# Script melhorado para gravar imagens .img.xz ou .img.gz em dispositivos USB
# Checagens adicionadas:
#   - Verifica se o segundo parâmetro (arquivo de imagem) foi fornecido e existe.
#   - Verifica se o dispositivo especificado no primeiro parâmetro existe e é um dispositivo de bloco.
#   - Adiciona uma confirmação do usuário antes de iniciar a gravação.
#   - Suporte para arquivos .img.xz e .img.gz.

# Função para exibir mensagem de uso
usage() {
  echo "Uso: $0 <dispositivo_alvo> <arquivo_imagem.img.xz ou arquivo_imagem.img.gz>"
  echo "  Exemplo para .img.xz: $0 sdc ~/Downloads/minha_imagem.img.xz"
  echo "  Exemplo para .img.gz: $0 sdc ~/Downloads/minha_imagem.img.gz"
  echo ""
  echo "Certifique-se de que:"
  echo "  - <dispositivo_alvo> seja o identificador correto do seu dispositivo USB (ex: sdc, sdb, etc)."
  echo "  - <arquivo_imagem.img.xz ou arquivo_imagem.img.gz> seja o caminho completo para o seu arquivo de imagem."
  exit 1
}

# Verifica se o número correto de argumentos foi fornecido
if [[ $# -ne 2 ]]; then
  echo "Erro: Número incorreto de argumentos."
  usage
fi

# Define as variáveis para dispositivo e arquivo de imagem
DISPOSITIVO=$1
IMAGEM_COMPRIMIDA=$2

# Verifica se o arquivo de imagem existe
if [[ ! -f "$IMAGEM_COMPRIMIDA" ]]; then
  echo "Erro: Arquivo de imagem '$IMAGEM_COMPRIMIDA' não encontrado."
  usage
fi

# Verifica se o dispositivo existe e é um dispositivo de bloco
if [[ ! -b "/dev/$DISPOSITIVO" ]]; then
  echo "Erro: Dispositivo '/dev/$DISPOSITIVO' não encontrado ou não é um dispositivo de bloco válido."
  echo "Verifique se o dispositivo está corretamente conectado e identificado pelo sistema."
  exit 1
fi

# Obtém o caminho absoluto do arquivo de imagem para exibir na confirmação
CAMINHO_ABSOLUTO_IMAGEM=$(realpath "$IMAGEM_COMPRIMIDA")

# Determina o comando de descompressão com base na extensão do arquivo
case "$IMAGEM_COMPRIMIDA" in
  *.img.xz)
    DECOMPRESS_CMD="xzcat"
    ;;
  *.img.gz)
    DECOMPRESS_CMD="gzip -dc" # ou poderia ser "zcat"
    ;;
  *)
    echo "Erro: Formato de arquivo de imagem não suportado. Apenas .img.xz e .img.gz são suportados."
    usage
    ;;
esac

# Mensagem de confirmação para o usuário
echo ""
echo "######################################################################"
echo "  VOCÊ ESTÁ PRESTES A GRAVAR A SEGUINTE IMAGEM:"
echo "    Arquivo de imagem: $CAMINHO_ABSOLUTO_IMAGEM"
echo "  NO SEGUINTE DISPOSITIVO:"
echo "    Dispositivo alvo: /dev/$DISPOSITIVO"
echo "######################################################################"
echo ""
read -p "Tem certeza que deseja prosseguir? (Sim/Não) [Não]: " -n 1 -r
echo    # Move para a próxima linha após a entrada do usuário
if [[ ! "$REPLY" =~ ^[YySs]$ ]]; then
    echo "Operação cancelada pelo usuário."
    exit 0
fi

echo ""
echo "######################################################################"
echo "  INICIANDO A GRAVAÇÃO DA IMAGEM..."
echo "  Por favor, aguarde. Este processo pode levar algum tempo."
echo "######################################################################"
echo ""

# Desmonta o dispositivo alvo (ignora erros se não estiver montado)
sudo umount /dev/$DISPOSITIVO 2>/dev/null

# Inicia a gravação da imagem usando o comando de descompressão correto e dd
echo "Executando: $DECOMPRESS_CMD \"$IMAGEM_COMPRIMIDA\" | sudo dd of=/dev/$DISPOSITIVO oflag=nocache bs=4096 conv=fdatasync status=progress"
$DECOMPRESS_CMD "$IMAGEM_COMPRIMIDA" | sudo dd of=/dev/$DISPOSITIVO oflag=nocache bs=4096 conv=fdatasync status=progress

echo ""
echo "######################################################################"
echo "  GRAVAÇÃO DA IMAGEM CONCLUÍDA COM SUCESSO!"
echo "  Dispositivo: /dev/$DISPOSITIVO"
echo "  Imagem: $CAMINHO_ABSOLUTO_IMAGEM"
echo "######################################################################"
echo ""
echo "Remova o dispositivo USB com segurança."

exit 0

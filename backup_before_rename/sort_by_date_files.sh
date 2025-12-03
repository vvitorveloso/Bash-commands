#!/bin/bash

# Set Internal Field Separator to handle spaces in file names
IFS=$'\n'

# Find all files
FILES=$(find . -type f)

# Loop through each file found
for FILE in $FILES; do
    # Extract modification date from file metadata using stat command
    MODIFICATION_DATE=$(stat -c %y "$FILE" | cut -d ' ' -f 1)

    # Extract year, month, and day from the modification date
    YEAR=$(echo "$MODIFICATION_DATE" | cut -d '-' -f 1)
    MONTH=$(echo "$MODIFICATION_DATE" | cut -d '-' -f 2)
    DAY=$(echo "$MODIFICATION_DATE" | cut -d '-' -f 3)

    # Check if a parameter is provided
    if [ ! -z "$1" ]; then
        case "$1" in
            -d)
                DIR="archive/$YEAR/$MONTH/$DAY"
                ;;
            -m)
                DIR="archive/$YEAR/$MONTH"
                ;;
            -y)
                DIR="archive/$YEAR"
                ;;
            *)
                echo "Parâmetro inválido. Uso: nome_script [-d | -m | -y]"
                exit 1
                ;;
        esac
    else
        # Explicando as opções em português
        echo "Opções disponíveis:"
        echo "-d: Organiza os arquivos por ano/mês/dia"
        echo "-m: Organiza os arquivos por ano/mês"
        echo "-y: Organiza os arquivos por ano"
        DIR="archive/$YEAR/$MONTH/$DAY" # Usando a estrutura padrão
    fi

    # Create the directory if it doesn't exist
    mkdir -p "$DIR"

    # Get the filename without the path
    FILENAME=$(basename "$FILE")

    # Move the file to the correct location including the filename
    mv -n "${FILE}" "$DIR/$FILENAME"

    echo "Arquivo movido: ${FILE} -> $DIR/$FILENAME"
done

# Remove empty directories inside the "archive" directory
find . -type d -empty -delete

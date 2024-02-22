#!/bin/bash

# Extrair a versão do arquivo package.json
version=$(jq -r '.version' package.json)

# Nome do arquivo de changelog
changelog_file="CHANGELOG.md"

# Nome do arquivo de release
release_file="RELEASE.md"

# Verifique se a versão existe no changelog
if ! grep -q "## \[$version\]" "$changelog_file"; then
  echo "A versão $version não foi encontrada no changelog."
  exit 1
fi

# Use o comando sed para extrair o conteúdo da versão desejada
sed -n "/^## \[$version\]/,/^## /p" "$changelog_file" | sed '$d' >> "$release_file"

echo "Arquivo de release criado com sucesso para a versão $version em $release_file."

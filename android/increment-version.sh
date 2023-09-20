#!/bin/bash

# Caminho para o arquivo build.gradle
build_gradle_path="android/app/build.gradle"

# Ler o valor de versionCode do arquivo build.gradle
current_version_code=$(cat "$build_gradle_path" | grep versionCode | awk '{print $2}')

# Ler o valor de versionName do arquivo build.gradle
current_version_name=$(cat "$build_gradle_path" | grep versionName | awk '{print $2}' | tr -d '"')

# Incrementando versionCode
update_version_code=$((current_version_code + 1))

# Incrementar versionName
# Obter o último número de versionName
last_version_number=$(echo "$current_version_name" | awk -F'.' '{print $NF}')
# Incrementar o último número e construir o novo versionName
new_version_number=$((last_version_number + 1))
base_version_name=$(echo "$current_version_name" | rev | cut -d'.' -f2- | rev)
update_version_name="$base_version_name.$new_version_number"

# Atualizar o arquivo build.gradle com os novos valores
sed -i".bak" -e "s/versionCode $current_version_code/versionCode $update_version_code/g" $build_gradle_path
sed -i".bak" -e "s/versionName \"$current_version_name\"/versionName \"$update_version_name\"/g" $build_gradle_path

echo "versionCode incrementado para $update_version_code"
echo "versionName atualizado para $update_version_name"

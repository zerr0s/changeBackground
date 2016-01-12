#!/bin/bash

# language
declare -A Ltab=(
  ["fr_toolNotSet"]="Veuillez configurer un outil pour appliquer le fichier background."
  ["fr_langApply"]="Utilisation du français."
  ["fr_langError"]="Impossible de déterminer la langue à utiliser. Application de l'anglais par défaut."
  ["fr_fExists"]="Le fichier de liste existe déjà."
  ["fr_fApply"]="Application du fichier"
  ["fr_fCreated"]="Le fichier de liste a été créé."
  ["fr_dirError"]="Un des dossiers d'images n'existe pas."
  ["en_toolNotSet"]="Please configure a tool to apply the background file."
  ["en_langApply"]="Utilisation de l'anglais."
  ["en_langError"]="Can not get the language to use. Setting to english by default."
  ["en_fExists"]="List file already exists."
  ["en_fApply"]="Setting file"
  ["en_fCreated"]="Lis file created."
  ["en_dirError"]="One of images directories does not exists."
)

language=""
if [[ -z ${LANG} ]]
then
  language="en"
  echo ${Ltab["${language}_langError"]}
else
  [[ ${LANG} =~ .*fr.* ]] && language="fr" && echo ${Ltab["${language}_langApply"]}
  [[ ${LANG} =~ .*en.* ]] && language="en" && echo ${Ltab["${language}_langApply"]}
  [[ -z ${language} ]] && language="en" && echo ${Ltab["${language}_langError"]}
fi

# Configuration
setTool=$(which nitrogen)
optTool="--set-centered"
declare -a DISPLAYS=(
  ":0.0"
)
declare -a IMG_DIR=(
  "${HOME}/Documents/backgrounds"
)
TMP_DIR="${HOME}/Documents/changeBackground"
LIST_FILE="list.txt"

# functions
function getFiles {
  OLDIFS=${IFS}
  IFS="||"
  for i in ${IMG_DIR[*]}
  do
    if [[ ! -d "$i" ]]
    then
      echo ${Ltab["${language}_dirError"]}
    else
      for file in $(find "$i" -maxdepth 1 -type f -regex ".*\.\(png\|jpg\|jpeg\|\bmp\)")
      do
        echo "${file}" >> "${TMP_DIR}/${LIST_FILE}"
      done
    fi
  done
  IFS=${OLDIFS}
  echo ${Ltab["${language}_fCreated"]}
}

function setBckgd {
  if [[ -z ${setTool} ]]
  then
    echo ${Ltab["${language}_toolNotSet"]}
  else
    OLDIFS=${IFS}
    IFS="||"
    bckgd=$(sort --random-sort "${TMP_DIR}/${LIST_FILE}" | head -n 1)
    newList=$(cat "${TMP_DIR}/${LIST_FILE}" | grep -v "${bckgd}")
    echo ${newList} > "${TMP_DIR}/${LIST_FILE}"
    echo ${Ltab["${language}_fApply"]} $(basename ${bckgd}).
    $(DISPLAY=$1 ${setTool} ${optTool} ${bckgd})
    IFS=${OLDIFS}
  fi
}

# main
[[ ! -s "${TMP_DIR}/${LIST_FILE}" ]] && getFiles || echo ${Ltab["${language}_fExists"]}
for i in ${DISPLAYS[*]}
do
  setBckgd "$i"
done

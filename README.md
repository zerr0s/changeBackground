# changeBackground

# Récupération
==============

git clone https://github.com/zerr0s/changeBackground.git

# Description
=============

This tool provide a simple way to change the background on multiple display screen.
Just configure the shell script and add a crontab line to change periodically your background.

Cet outil fourni un moyen simple de changer son fond d'écran sur tous les display configurés.
Il vous suffit de configurer le script et de l'ordonnancer dans la crontab.

# Tool / Outils
===============
Personally i use nitrogen to set the background images.
Personnellement j'utilise nitrogen pour changer les images.

debian /ubuntu  : apt-get install nitrogen
gentoo          : emerge x11-misc/nitrogen

# Configuration
===============

setTool=$(which nitrogen) <-- configure the bin tool to set the background images // binaire qui permet de changer l'image
optTool="--set-centered" <-- configure the options for te tool // options du binaire

declare -a DISPLAYS=( <-- list of displays. The background will be different on each display // liste des display
  ":0.0"
  ":0.1"
  ":0.2"
)

declare -a IMG_DIR=( <-- list of directories that containing images // liste des répertoires
  "${HOME}/Documents/backgrounds"
  "${HOME}/Documents/backgrounds1"
  "${HOME}/Documents/backgrounds2"
)

TMP_DIR="${HOME}/Documents/ChangeBackgd" <-- temp directory where to place the list file // répertoire temporaire où placer le fichier liste
LIST_FILE="list.txt" <-- name of the list file // nom du fichier liste

# CRON
======
This is just an example. The script is executed at boot and running every 2 minutes.
Cet exemple exécute le script au démarrage et toutes les 2 minutes.
@reboot ~/Documents/changeBackground/changebackgd.sh > /dev/null
*/2 * * * * ~/Documents/changeBackground/changebackgd.sh > /dev/null

# New files / Nouveaux fichiers
===============================
All new files placed in the directories won't be supplied to script while the list is not empty.
If you want to go faster, you can delete the list file.

Tous les nouveaux fichiers déposés dans les répertoires configurés ne seront pas pris en compte tant que le fichier liste
n'est pas vide. Si vous voulez aller plus vite, vous pouvez supprimer le fichier list existant.

# Evolution
===========
Feel free to fork this tool or request for new functions.
Please report me if you are experiencing some bugs.

Soyez libre de créer un fork de cet outil ou de demander de nouvelles fonctions.
Merci de me remonter les bugs si vous en rencontrer.

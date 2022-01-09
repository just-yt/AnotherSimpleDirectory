#!/bin/bash

function ini()
{

#commenter la ligne ci dessous pour test ou developpement
#trap '' 2 3
clear

}

function logon()
{
ini
source /opt/mylogon/logon.conf
nom=""
mdp=""

exec 3>&1

dialog --title "Authentification" --backtitle "Authentification" --insecure \
                --mixedform "" 15 50 0 \
                "Utilisateur: " 1 1 "$nom" 1 20 20 0 0 \
                "Mot de passe :"      3 1    "$mdp"  3 20  20 0 1 2>&1 1>&3 | {
				
				read -r nom	
				read -r mdp	

request=$(mysql -u $login -p$pwd -h directory-logon -D mylogon   -e "select mdp from directory where user='$nom'")
request=${request##*mdp}
request=$(echo $request)
if [[ "$mdp" == "$request" ]]
then
active=$(mysql -u $login -p$pwd -h directory-logon -D mylogon   -e "select active from directory where user='$nom'")
active=${active##*active}
active=$(echo $active)
    if [[ "$active" == "1" ]]
    then
    for i in $(seq 0 50 100) ; do sleep 1; echo $i | dialog --gauge "connexion ....." 10 70 0; done
    else
    dialog --title "" --msgbox 'Erreur ou Compte désactivé' 6 20
    logon
    fi
else
logon
fi
				}

exec 3>&-

}
logon
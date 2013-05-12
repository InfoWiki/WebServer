#!/bin/bash
# INSTALLATION AUTOMATISER DE OCS/GLPI - DEBIAN
# Script dev. par Mickael Stanislas pour Infowiki
# http://mickael-stanislas.com/
# https://github.com/InfoWiki
# http://infowiki.fr
#
# Version = 1.0
# Synthaxe: bash ./install-web-server.sh
# Synthaxe: sudo bash ./install-web-server.sh
# Configuration
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
ADDRIP=$(ifconfig eth0 | grep "inet addr" | cut -d " " -f 12 | cut -d : -f 2)


clear
echo ""
echo " Auto installation Serveur Web"
echo " --------------------"
echo -e "\n"
read -p "[Enter] pour commencer ...."

clear
apt-get update 									# Recherche de mises à jour
apt-get upgrade -y 								# Installation des mises à jour

# Installation de Apache2 et Mysql
clear
echo -e "$NORMAL"
if [ -n "$( pidof apache2 )" ]					# On test si Apache2 est deja présent
	then echo -e "Apache2 est déjà présent sur votre système"
	else echo -e ""
		apt-get install -y apache2 php5 libapache2-mod-php5 php5-gd # Installation de Apache et des librairies
		/etc/init.d/apache2 restart 					# On redémarre Apache
fi
if [ -n "$( pidof mysql )" ]					# On test si Mysql est deja présent
	then echo -e "Mysql-server est déjà présent sur votre système"
	else echo -e ""
		apt-get install -y mysql-server php5-mysql		# Installation de Mysql
		/etc/init.d/apache2 restart 					# On redémarre Apache
fi
clear

echo -e " **-------------------------------**\n"
echo -e "\tTest des installations \n"
if [ -n "$( pidof apache2 )" ]
	then echo -e "$NORMAL""APACHE2 :""$VERT""\t[OK]\n"
	else echo -e "$NORMAL""APACHE2 :""$ROUGE""\t[ERREURS]\n"
fi
if [ -n "$( pidof mysqld )" ]
	then echo -e "$NORMAL""MYSQL-SERVER :""$VERT""\t[OK]\n"
	else echo -e "$NORMAL""MYSQL-SERVER :""$ROUGE""\t[ERREURS]\n"
fi
echo -e "$NORMAL"""
echo -e " **-------------------------------** \n"
echo -e "Si vous rencontrez des erreurs a cette étape"
echo -e "Merc de bien ouloir annulé l'istallation"
read -p "Appuyer sur une touche pour continuer ..."
clear

echo -n "Souhaitez vous installer PHPMYADMIN : [y / n] "
read repphpmyadmin
if [ $repphpmyadmin = "y" ]
	then apt-get install -y phpmyadmin			# Installation de PHPMYADMIN
	else echo -e ""
fi
clear
# In redémarre les services avant la fin de l'installation
/etc/init.d/apache2 restart
/etc/init.d/mysqld restart
clear
echo -e " **-------------------------------------------------** \n"
echo -e "\tFINALISATION DE LINSTALLATION DU SERVEUR WEB \n"
echo -e "Rendez-vous sur http://VOTREADRESSEIP/ \n"
echo -e ""
echo -e " **-------------------------------------------------** \n"
read -p "Appuyer sur une touche quand vous avez termine"
exit
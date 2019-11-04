#!/bin/sh
add_exo () {
clear
read -p "Niveau de l'exercice : " level
mkdir ressources/exercices/$level 2>> /dev/null
read -p "Nom de l'exercice : " name
mkdir ressources/exercices/$level/$name
echo ""

}
menu () {
	echo "menu"
}


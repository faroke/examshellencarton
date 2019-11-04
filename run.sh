#!/bin/sh
level=0
menu () {
echo "		Usage : start ==> lancer l'entrainement niveau 1"
read -p ">> " choice
if [ choice="start" ]; then
	play
else
	exit
fi
}
play () {
	clear
	level=$(($level + 1))
	NB_EXO="$(ls ressources/exercices/$level | wc -l)"
	NB_EXO="$(shuf -i 1-$NB_EXO -n 1)"
	echo "-------------------------------------------------------------------------------------------------"
	echo "Exercice niveau $level"
	echo "Nom de l'exercice : $(cat ressources/exercices/$level/$NB_EXO/exo | grep name | awk '{print $2}')"
	#echo "Prototypage de la fonction : $(cat ressources/exercices/$level/$NB_EXO/exo | grep  prototypage | awk '{print $2}')"	
	echo "-------------------------------------------------------------------------------------------------"
	cat ressources/exercices/$level/$NB_EXO/doc
	echo ""
	echo "Une fois fini, veuillez entrer le chemin d'accès absolue"
	read -p ">> " chemin
	cat $chemin ressources/exercices/$level/$NB_EXO/test > .tmp/exotmp
	racket .tmp/exotmp > .tmp/restmp
	if  diff .tmp/restmp ressources/exercices/$level/$NB_EXO/compare; then
		echo "reussi"
	else
		echo "failed"
	fi
}
menu

#!/bin/sh
menu () {
echo "		Usage : start ==> lancer l'entrainement niveau 1"
read -p ">> " choice
if [ choice="start" ]; then
	play 1
else
	exit
fi
}
play () {
	clear
	NB_EXO="$(ls ressources/exercices/$1 | wc -l)"
	NB_EXO="$(shuf -i 1-$NB_EXO -n 1)"
	echo "-------------------------------------------------------------------------------------------------"
	echo "Exercice niveau $1"
	echo "Nom de l'exercice : $(cat ressources/exercices/$1/$NB_EXO/exo | grep name | awk '{print $2}')"
	#echo "Prototypage de la fonction : $(cat ressources/exercices/$1/$NB_EXO/exo | grep  prototypage | awk '{print $2}')"	
	echo "-------------------------------------------------------------------------------------------------"
	cat ressources/exercices/$1/$NB_EXO/doc
	echo ""
	echo "Une fois fini, veuillez entrer le chemin d'accès absolue"
	read -p ">> " chemin
	cat $chemin ressources/exercices/$1/$NB_EXO/test > tmp/exotmp
	racket tmp/exotmp > tmp/restmp
	if  diff tmp/restmp ressources/exercices/$1/$NB_EXO/compare; then
		echo "reussi, lancement du prochaine exercice..."
		sleep 2
		play $(($1 + 1))
	else
		clear
		echo "failed, lancement du prochaine exercice..."
		sleep 2
		play $(($1 - 1))
	fi
}
menu
rm tmp/*

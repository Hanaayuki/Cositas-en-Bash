#!/bin/bash

echo "Hola Bienvenido LesbMetro.sh para Empezar me podrias pasar la pagina web de los metros " url
read  metros 


#Bucle que hace que pregunte la url 
#para Hana  del futuro esta parte es para mirar si nos ha pasado bien la url 

while true ; do
    read -p  "Hola Bienvenido LesbMetro.sh para Empezar me podrias pasar la pagina web de los metros "

    if [[ "$url" =~ "metro" ]]; then
        echo "Gracias por la pagina web amigo"
        break 
    else
        echo "mmmm algo me dice a mi que eso no es una estacion de metro amigo "
    fi
done


#Traer informacion de una paguna web

echo "Por favor me podrias decir La estacion de origen y de destino que quieras ir?"
 
read -p "origen"
read -p "destino"

contenido-web=$(curl -s "$url")


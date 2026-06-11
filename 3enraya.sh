#!/bin/bash

#Registro de jugadores
#Aqui lo que haremos es qye cada jugador se idebentifique y se les pone la x o

echo "Hola jugador, vamos a jugar 3 en raya"
echo "Por favor, que los 2 jugadores se registren"
read -p "Nombre del Jugador 1 (será X): " j1
read -p "Nombre del Jugador 2 (será O): " j2

tablero=(1 2 3 4 5 6 7 8 9)
jugador=$j1
marca="X"

#creamos el tablero
dibujar_tablero() {
    clear
    echo " ---> 3 EN RAYA <--- "
    echo " ${tablero[0]} | ${tablero[1]} | ${tablero[2]} "
    echo "---+---+---"
    echo " ${tablero[3]} | ${tablero[4]} | ${tablero[5]} "
    echo "---+---+---"
    echo " ${tablero[6]} | ${tablero[7]} | ${tablero[8]} "
}

#lo que vamos a hacer ahora es para hacer un ganador del 3 en raya uwu
verificar_ganador() {
#Combinaciones ganadoras (filas, columnas, diagonales) que dolor de cabeza fue esto
    if [[ ${tablero[0]} == ${tablero[1]} && ${tablero[1]} == ${tablero[2]} ]] || \
       [[ ${tablero[3]} == ${tablero[4]} && ${tablero[4]} == ${tablero[5]} ]] || \
       [[ ${tablero[6]} == ${tablero[7]} && ${tablero[7]} == ${tablero[8]} ]] || \
       [[ ${tablero[0]} == ${tablero[3]} && ${tablero[3]} == ${tablero[6]} ]] || \
       [[ ${tablero[1]} == ${tablero[4]} && ${tablero[4]} == ${tablero[7]} ]] || \
       [[ ${tablero[2]} == ${tablero[5]} && ${tablero[5]} == ${tablero[8]} ]] || \
       [[ ${tablero[0]} == ${tablero[4]} && ${tablero[4]} == ${tablero[8]} ]] || \
       [[ ${tablero[2]} == ${tablero[4]} && ${tablero[4]} == ${tablero[6]} ]]; then
        return 0 # Ganó alguien
    else
        return 1 # Nadie ha ganado todavía
    fi
}

#Bucle  del 3 en raya
#para que el 3 en raya funcione tenemos que hacer un bucle que es lo siguiente que cree
for i in {1..9}; do
    dibujar_tablero
    echo "Turno de: $jugador ($marca)"
    read -p "Elige una posicion (1-9): " p
    
    indice=$((p-1))
    tablero[$indice]=$marca
    
    if verificar_ganador; then
        dibujar_tablero
        echo "¡FELICIDADES $jugador, HAS GANADO!"
	echo "=================================================================="
	echo " El juego termino mis estimados caballeros $jugador1 y $jugador2"
	echo "=================================================================="

        exit
    fi
    
#Cambiar de jugador esto es importante para que no se buge y quede 1 perfil
    if [ "$jugador" == "$j1" ]; then
        jugador=$j2
        marca="O"
    else
        jugador=$j1
        marca="X"
    fi
done

dibujar_tablero
echo "¡Es un EMPATE"
echo "=================================================================="
echo " El juego termino mis estimados caballeros $jugador1 y $jugador2"
echo "=================================================================="
	exit 0




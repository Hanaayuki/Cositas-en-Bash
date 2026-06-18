#!/bin/bash

#Creado por Hanaayuki
#github.com/hanaayuki

#Vale voy a enseñar como hacer un blackjack uwu primero lo que vamos a hacer es crear una funcion para mostrar 
#el menu cualquier cosa que no entiendad los comandos los subire a guia.sh en un futuro 

usuario=$(whoami)

# --- VARIABLES GLOBALES Y LOGICA DEL JUEGO ---

# Inicializar la baraja (S = Espadas, C = Tréboles, H = Corazones, D = Diamantes)
baraja=()
valores=(2 3 4 5 6 7 8 9 10 J Q K A)
for palo in S C H D; do
    for valor in "${valores[@]}"; do
        baraja+=("$valor$palo")
    done
done

# AHORA Vamos a crear la Función para repartir una carta
repartir_carta() {
    echo "${baraja_mezclada[$indice_carta]}"
    ((indice_carta++))
}

# Y la función para calcular el valor de una mano
calcular_mano() {
    local mano=("$@")
    local total=0
    local ases=0

    for carta in "${mano[@]}"; do
# Extraeraemos el valor quitando el último carácter (el palos)
        local val="${carta::-1}"
        
        if [[ "$val" =~ ^[0-9]+$ ]]; then
            ((total += val))
        elif [[ "$val" =~ ^[JQK]$ ]]; then
            ((total += 10))
        elif [[ "$val" == "A" ]]; then
            ((total += 11))
            ((ases++))
        fi
    done

# Creamos  el valor de los Ases si nos pasamos de 21
    while (( total > 21 && ases > 0 )); do
        ((total -= 10))
        ((ases--))
    done

    echo "$total"
}

# Función para ejecutar una partida de juego
jugar_blackjack() {
    echo "Hola $usuario Vamos a repartir las cartas"
    
    # Aqui vamos a mezclar la baraja de forma aleatoria
    baraja_mezclada=($(shuf -e "${baraja[@]}"))
    indice_carta=0

    #y ahora nos vamos a centrar mas el juegador
    # Manos iniciales
    mano_jugador=($(repartir_carta) $(repartir_carta))
    mano_banca=($(repartir_carta) $(repartir_carta))

    # Ahora vamos a crear el turno del jugador vamos tu
    while true; do
        puntos_jugador=$(calcular_mano "${mano_jugador[@]}")
        
        echo -e "\nTus cartas: ${mano_jugador[*]} (Total: $puntos_jugador)"
        echo "Carta visible de la banca: ${mano_banca[0]}"

        if (( puntos_jugador == 21 )); then
            echo "¡Blackjack o 21 perfecto!"
            break
        elif (( puntos_jugador > 21 )); then
            echo "¡Te pasaste de 21! Has perdido."
            return 0
        fi

        read -p "¿Quieres (P)edir carta o (Q)uedarte? [p/q]: " accion
        case "${accion,,}" in
            p)
                mano_jugador+=($(repartir_carta))
                ;;
            q)
                break
                ;;
        esac
    done

    # Turno de la Banca (juega solo si el jugador no se ha pasado)
    puntos_jugador=$(calcular_mano "${mano_jugador[@]}")
    puntos_banca=$(calcular_mano "${mano_banca[@]}")

    echo -e "\n--- Turno de la Banca ---"
    echo "Cartas de la banca: ${mano_banca[*]} (Total: $puntos_banca)"

    # La banca pide carta obligatoriamente si tiene menos de 17
    while (( puntos_banca < 17 )); do
        echo "La banca pide carta..."
        sleep 1
        mano_banca+=($(repartir_carta))
        puntos_banca=$(calcular_mano "${mano_banca[@]}")
        echo "Cartas de la banca: ${mano_banca[*]} (Total: $puntos_banca)"
    done

    # Aqui vamos a determinar el ganador creando un pequeño menu de resultado finales  
    echo "=================================="
    echo "          RESULTADO FINAL         "
    echo "=================================="
    echo "Tus puntos: $puntos_jugador       "
    echo "Puntos de la banca: $puntos_banca "
    echo "----------------------------------"

    if (( puntos_banca > 21 )); then
        echo "¡La banca se pasó! ¡GANASTE! 🎉"
    elif (( puntos_jugador > puntos_banca )); then
        echo "¡Ganaste a la banca! 🎉"
    elif (( puntos_jugador < puntos_banca )); then
        echo "La banca gana. Mejor suerte la próxima vez. 😢"
    else
        echo "¡Empate! Se devuelven las apuestas. 🤝"
    fi
}

#Menu de ayuda 
mostrar_ayuda(){
   echo "========================================================================================================"
   echo "Tu objetivo: Sumar 21 puntos con tus cartas (o quedarte lo más cerca posible) sin pasarte"
   echo "Tu rival: Juegas solo contra el crupier. Gana el que se acerque más a 21"
   echo "El valor de las cartas: Las figuras (J, Q, K) valen 10, el As vale 1 o 11 (lo que te convenga)"
   echo ", y las demás valen su número."
   echo "Cómo se juega:"
   echo "Te dan dos cartas. Si quieres más para acercarte a 21, dices pido Si estás conforme, dices Me planto"
   echo ". Si te pasas de 21, pierdes. Al final, el crupier juega su mano y se ve quién ganó."
   echo "========================================================================================================"
   
}


#Menu del BlackJack
while true; do
    echo "==================================================="
    echo "   Hola $usuario Bienvenido a Blackbotfer 3000     "
    echo "         Porfavor  selecione una opcion 	     "
    echo "					             "
    echo "---> 1) Jugar					     "
    echo "---> 2) Como jugar blacjack			     "
    echo "---> 3) Pagina del creador		             "
    echo "---> 4) Salir				             "
    echo "==================================================="
    read -p "selecione una opcion: " opcion

    #vale ahora vamos a crerar el juego para que las persodnas escoan una opcion
    case $opcion in
         1)
            jugar_blackjack
            ;;
         2)
            mostrar_ayuda
            ;;
        3) 
            clear
           
            url="https://github.com/Hanaayuki"

            echo "==================================================="
            echo "            PÁGINA DEL CREADOR                      "
            echo "==================================================="
            echo " ¡Gracias por jugar! Puedes ver este y otros       "
            echo " proyectos en mi perfil de GitHub.                 "
            echo "---------------------------------------------------"
            echo "  url=$url"
            
           
            xdg-open "$url" 2>/dev/null || start "$url" 2>/dev/null
            
            echo "==================================================="
            echo ""
            read -p "Presiona [Enter] para volver al menú..."
            ;;
         4)
            echo "Byeeeeeeeee"
            exit 0
            ;;
         *)
            echo "Opcion no valida, intenta de nuevo."
            ;;
    esac
done

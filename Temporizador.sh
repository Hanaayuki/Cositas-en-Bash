#!/bin/bash
usuario=$(whoami)
echo "Hola $usuario que tal estas,por favor ingrese los segundos del temporizador"
read segundos

while [ "$segundos" -gt 0 ]; do
	echo "El tiempo  que falta para que finalise el temporizador $segundos  mi amo $usuario"
	sleep 1
	segundos=$((segundos -1))

done

echo "==================="
echo " TIEMPO FINALIZADO "
echo "  mi lord $usuario "
echo "===================" 

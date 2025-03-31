#!/bin/bash

# Verificar si se está ejecutando como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Este script debe ejecutarse como root."
    exit 1
fi

# Verificar si se pasaron 3 argumentos
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <usuario> <grupo> <ruta_al_archivo>"
    exit 1
fi

# Asignar argumentos a variables
USUARIO=$1
GRUPO=$2
RUTA_ARCHIVO=$3

# Verificar si el archivo existe
if [ ! -e "$RUTA_ARCHIVO" ]; then
    echo "Error: El archivo '$RUTA_ARCHIVO' no existe." | tee -a ejercicio1.log
    exit 1
fi

# Verificar si el grupo existe, si no crearlo
if getent group "$GRUPO" > /dev/null; then
    echo "El grupo '$GRUPO' ya existe." | tee -a ejercicio1.log
else
    groupadd "$GRUPO"
    echo "Grupo '$GRUPO' creado." | tee -a ejercicio1.log
fi

# Verificar si el usuario existe, si no crearlo
if id "$USUARIO" &> /dev/null; then
    echo "El usuario '$USUARIO' ya existe. Se agrega al grupo '$GRUPO'." | tee -a ejercicio1.log
    usermod -aG "$GRUPO" "$USUARIO"
else
    useradd -m -g "$GRUPO" "$USUARIO"
    echo "Usuario '$USUARIO' creado y asignado al grupo '$GRUPO'." | tee -a ejercicio1.log
fi

# Cambiar propietario y grupo del archivo
chown "$USUARIO":"$GRUPO" "$RUTA_ARCHIVO"
echo "Propietario y grupo del archivo '$RUTA_ARCHIVO' cambiados a '$USUARIO:$GRUPO'." | tee -a ejercicio1.log

# Cambiar permisos del archivo
chmod 740 "$RUTA_ARCHIVO"
echo "Permisos del archivo '$RUTA_ARCHIVO' cambiados a 740 (rwxr-----)." | tee -a ejercicio1.log

echo "Script completado exitosamente." | tee -a ejercicio1.log

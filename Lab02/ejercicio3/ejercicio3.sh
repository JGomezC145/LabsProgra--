#!/bin/bash

# Directorio a Monitorear
DIRECTORIO="$1"

# Verificar si se pasó un argumento
if [ -z "$DIRECTORIO" ]; then
    echo "Uso: $0 <ruta_del_directorio_a_monitorear>"
    exit 1
fi

# Verificar si el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: El directorio '$DIRECTORIO' no existe."
    exit 1
fi

# Archivo de log
LOG_FILE="directorio_monitoreo.log"

# Limpiar log anterior si existe
> "$LOG_FILE"

echo "Monitoreando el directorio: $DIRECTORIO" | tee -a "$LOG_FILE"

# Ejecutar inotifywait de manera continua para detectar eventos
inotifywait -m -r -e create -e modify -e delete --format '%T %w %f %e' --timefmt '%Y-%m-%d %H:%M:%S' "$DIRECTORIO" |
while read FECHA RUTA ARCHIVO EVENTO; do
    echo "$FECHA - Evento: $EVENTO en $RUTA$ARCHIVO" | tee -a "$LOG_FILE"
done
# El script se ejecutará indefinidamente hasta que se interrumpa manualmente
# (Ctrl+C). Los eventos detectados se registrarán en el archivo de log.
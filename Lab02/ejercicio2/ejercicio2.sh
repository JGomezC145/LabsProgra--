#!/bin/bash

# Verificar si se pasó un argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <comando_para_ejecutar>"
    exit 1
fi

# Asignar argumento a variable
COMANDO=$1
LOG_FILE="log.txt"
TEMP_PID_FILE="process.pid"

# Limpiar archivo de log anterior si existe
> "$LOG_FILE"

# Ejecutar el proceso en segundo plano y guardar su PID
$COMANDO &
PID=$!
echo $PID > "$TEMP_PID_FILE"

echo "Proceso '$COMANDO' iniciado con PID $PID." | tee -a "$LOG_FILE"

# Monitorear el proceso mientras esté activo
while kill -0 $PID 2> /dev/null; do
    # Obtener uso de CPU y memoria usando ps
    CPU_MEM_USAGE=$(ps -p $PID -o %cpu,%mem --no-headers)
    
    # Registrar datos con la hora actual
    echo "$(date +%Y-%m-%d\ %H:%M:%S) $CPU_MEM_USAGE" >> "$LOG_FILE"
    
    # Esperar 1 segundo antes de la siguiente medición
    sleep 1
done

echo "Proceso terminado." | tee -a "$LOG_FILE"

# Generar gráfico con gnuplot
gnuplot -persist <<-EOFMarker
    set title "Uso de CPU y Memoria vs Tiempo"
    set xlabel "Tiempo"
    set ylabel "Uso (%)"
    set xdata time
    set timefmt "%Y-%m-%d %H:%M:%S"
    set format x "%H:%M:%S"
    set grid
    set datafile separator " "
    set key outside
    plot "$LOG_FILE" using 1:2 title "CPU (%)" with lines, \
         "$LOG_FILE" using 1:3 title "Memoria (%)" with lines
EOFMarker

# Eliminar archivo temporal de PID
rm -f "$TEMP_PID_FILE"

#!/bin/bash

# Verificar si se pasó un argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <archivo_log>"
    exit 1
fi

# Asignar argumento a variable
LOG_FILE=$1

# Verificar si el archivo existe
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: El archivo '$LOG_FILE' no existe."
    exit 1
fi

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

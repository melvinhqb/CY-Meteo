#!/usr/local/bin/gnuplot -persist

VALUE = ARG1
DATAFILE = ARG2
PNGFILE = ARG3
LOCATION = ARG4
DATE_MIN = strftime("%d/%m/%Y", strptime("%Y-%m-%d",ARG5))
DATE_MAX = strftime("%d/%m/%Y", strptime("%Y-%m-%d",ARG6))
if (DATE_MIN eq DATE_MAX) {
     TIME = " on all dates"
} else {
     TIME = "\nbetween ".DATE_MIN." and ".DATE_MAX
}
TITLE = VALUE." vector map of ".LOCATION.TIME

set terminal png enhanced font "arial,10" fontscale 1.0 size 600, 400
set output PNGFILE

set title TITLE

set xlabel "Longitude"
set ylabel "Latitude"

stats DATAFILE u 1:2 nooutput
set xrange [STATS_min_x - 10:STATS_max_x + 10]
set yrange [STATS_min_y - 10:STATS_max_y + 10]

plot DATAFILE using 1:2:($3*pi/180):4 with vectors notitle

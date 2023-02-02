#!/usr/local/bin/gnuplot -persist

VALUE = ARG1
UNIT = ARG2
DATAFILE = ARG3
PNGFILE = ARG4
LOCATION = ARG5
DATE_MIN = strftime("%d/%m/%Y", strptime("%Y-%m-%d",ARG6))
DATE_MAX = strftime("%d/%m/%Y", strptime("%Y-%m-%d",ARG7))
if (DATE_MIN eq DATE_MAX) {
     TIME = " on all dates"
} else {
     TIME = "\nbetween ".DATE_MIN." and ".DATE_MAX
}
TITLE = VALUE." averages vs. station ID in ".LOCATION.TIME

set term png font "arial,10" fontscale 1.0 size 600, 400
set output PNGFILE

set title TITLE

set xlabel "Station ID"
set ylabel VALUE." (".UNIT.")"

set autoscale xfix

set offsets 0,0,1,1

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5 # blue
set style line 2 lc rgb '#cc2936' lt 1 lw 2 pt 7 ps 1.5 # red
set style line 3 lc rgb '#6d9f71' lt 1 lw 2 pt 7 ps 1.5 # yellow

set output PNGFILE

plot DATAFILE using 1:3:4 with filledcurves lc '#f1bf98' fs transparent notitle, \
     DATAFILE using 1:2 with lines ls 1 title "Average", \
     DATAFILE using 1:3 with lines ls 2 title "Min", \
     DATAFILE using 1:4 with lines ls 3 title "Max"
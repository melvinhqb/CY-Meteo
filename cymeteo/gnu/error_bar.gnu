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

stats DATAFILE nooutput
N = STATS_records
stats DATAFILE u 3:4 nooutput
min_val = STATS_min_x

set terminal png enhanced font "arial,10" fontscale 1.0 size 600, 400
set output PNGFILE

set title TITLE

set xlabel "Station ID"
set ylabel VALUE." (".UNIT.")"

set xrange [ -1 : N ] noreverse writeback

set xtics border in scale 1,0.5 nomirror rotate  autojustify
set ytics border in scale 1,0.5 nomirror norotate  autojustify

set offsets 0, 0, 2, 2

plot DATAFILE using 0:2:3:4:xticlabel(1) w yerr pt 7 notitle

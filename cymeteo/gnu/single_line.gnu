#!/usr/local/bin/gnuplot -persist

VALUE = ARG1
UNIT = ARG2
DATAFILE = ARG3
PNGFILE = ARG4
LOCATION = ARG5
#reset
#stats DATAFILE u (strptime("%Y-%m-%dT%H",strcol(1))):2 nooutput name 'DATE'
#DATE_min = strftime("%d/%m/%Y", DATE_min_x)
#DATE_max = strftime("%d/%m/%Y", DATE_max_x)
DATE_MIN = strftime("%d/%m/%Y", strptime("%Y-%m-%d",ARG6))
DATE_MAX = strftime("%d/%m/%Y", strptime("%Y-%m-%d",ARG7))
if (DATE_MIN eq DATE_MAX) {
     TIME = " on all dates"
} else {
     TIME = "\nbetween ".DATE_MIN." and ".DATE_MAX
}
TITLE = VALUE." averages vs. time in ".LOCATION.TIME

set terminal png enhanced font "arial,10" fontscale 1.0 size 600, 400 
set output PNGFILE

set title TITLE

set xlabel "Time"
set ylabel VALUE." (".UNIT.")"

#set xtics rotate by 45 right

set xdata time
set style data lines
set timefmt "\"%Y-%m-%dT%H\""
set format x "%d/%m/%y\n%H:%M"

set autoscale xfix

set xtics rotate by 45 right nomirror offset 3
set ytics nomirror

plot DATAFILE using 1:2 with linespoints ls 1 smooth csplines notitle

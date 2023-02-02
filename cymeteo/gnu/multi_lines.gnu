#!/usr/local/bin/gnuplot

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
TITLE = VALUE." vs. time vs. station ID in ".LOCATION.TIME

set terminal png font "arial,10" fontscale 1.0 size 600, 400 
set output PNGFILE

set title TITLE

set xlabel "Days"
set ylabel VALUE." (".UNIT.")"

set xdata time
set style data lines
set timefmt "\"%Y-%m-%d\""
set format x "%d/%m/%y"

set auto xfix

set xtics rotate by 45 right nomirror offset 3
set ytics nomirror

set palette defined ( \
0 "#FF0000",\
2 "#FF6200",\
4 "#FF9000",\
6 "#FFC800",\
8 "#FFFF00",\
10 "#8CC800",\
12 "#0EAC00",\
14 "#00A0C4",\
16 "#005FB2",\
18 "#0011A8",\
20 "#6100A1",\
22 "#C6007D",\
24 "#FF0000" )

set cbrange [0:24]
set cbtics (3,6,9,12,15,18,21)

plot DATAFILE using 2:4:(int($3) % 24) w l lc palette z notitle

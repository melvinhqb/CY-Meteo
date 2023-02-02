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
TITLE = VALUE." interpolated map of ".LOCATION.TIME

set terminal png font "arial,10" fontscale 1.0 size 600, 400
set output PNGFILE

set title TITLE

set xlabel "Longitude"
set ylabel "Latitude"
set cblabel VALUE

set view map
set dgrid3d 500,500,2
set pm3d at b
set auto fix

#if (VALUE eq "Height") set cbrange[0:*]
#if (VALUE eq "Moisture") set cbrange[0:100]

unset key
unset surface
splot DATAFILE
set terminal postscript color solid 'Times' 12
set output 'session_histogram.ps'
set pointsize 0.75
set xlabel "Session Time" offset 0,0.5
set ylabel "CDF" offset 1.7,0
set xrange [1:400]
set mxtics 10
set yrange [0:1]
set ytics border nomirror
set mytics 2
set size 1.0,0.75
set key  below
#set logscale x
set grid xtics ytics
set title "Session Time CDF - `cat make_zipf_description.txt`"
plot \
   'session_histogram.txt' using 1:3 axes x1y1 title 'generated' with lines linetype 1 linewidth 4

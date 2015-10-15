set terminal postscript color solid 'Times' 12
set output 'distribution.ps'
set pointsize 0.75
set xlabel "Rank" offset 0,0.5
set ylabel "Number of Views" offset 1.7,0
#set xrange [50:80]
set mxtics 10
#set yrange [0:60]
set ytics border nomirror
set mytics 10
set size 1.0,0.75
unset key
set logscale xy
set title "Popularity Distribution"
plot \
   'distribution.txt' using 1:2 axes x1y1 title 'generated' with lines linetype 2 linewidth 4

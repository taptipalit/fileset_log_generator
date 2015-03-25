set terminal postscript color solid 'Times' 12
set output 'dist_unsorted.ps'
set pointsize 0.75
set xlabel "Rank" offset 0,0.5
set ylabel "Number of Views" offset 1.7,0
#set xrange [1:10000]
set mxtics 10
#set yrange [0:60]
set ytics border nomirror
set mytics 10
set size 1.0,0.75
set key below
set logscale xy
set title "Popularity Distribution - `cat make_zipf_description.txt`"
#plot \
   'distribution.txt' using 1:2 axes x1y1 title 'generated' with lines linetype 2 linewidth 4
plot \
   'distribution.txt' using 1:3 axes x1y1 title 'unsorted' with lines linetype 1 linewidth 4, \
   'distribution.txt' using 1:2 axes x1y1 title 'sorted' with lines linetype 2 linewidth 4

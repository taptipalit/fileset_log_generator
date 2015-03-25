set terminal postscript color solid 'Times' 12
set output 'memory_cdf.ps'
set pointsize 0.75
set xlabel "Cumulative Size of Distribution (MB)" offset 0,0.5
set ylabel "Fraction of total sessions" offset 1.7,0
set xrange [0:30000]
set mxtics 4
#set yrange [0:100]
#set logscale y
set ytics border nomirror
set mytics 2
set size 1.0,0.75
set key below
set grid xtics ytics
set title "Memory CDF - `cat make_zipf_description.txt`"
plot \
   'memory.txt' using 2:4 axes x1y1 title 'actual' with lines linetype 1 linewidth 4, \
   'memory.txt' using 3:4 axes x1y1 title 'maximum session' with lines linetype 2 linewidth 4

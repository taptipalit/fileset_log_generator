set terminal postscript color solid 'Times' 12
set output 'memory_compare.ps'
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
set title "Memory CDF - Compare Zipf Distributions"
plot \
   'v50000s14400a1.0/memory.txt' using 2:5 axes x1y1 title 'video size -1.0' with lines linetype 1 linewidth 4, \
   'v50000s14400a1.0/memory.txt' using 3:5 axes x1y1 title 'maximum session -1.0' with lines linetype 3 linewidth 4, \
   'v10000s14400/memory.txt' using 2:5 axes x1y1 title 'video size -0.8' with lines linetype 4 linewidth 4, \
   'v10000s14400/memory.txt' using 3:5 axes x1y1 title 'maximum session -0.8' with lines linetype 5 linewidth 4, \
   'memory.txt' using 2:5 axes x1y1 title 'video size -0.6' with lines linetype 7 linewidth 4, \
   'memory.txt' using 3:5 axes x1y1 title 'maximum session -0.6' with lines linetype 8 linewidth 4

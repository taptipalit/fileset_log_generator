set terminal postscript color solid 'Times' 12
set output 'memory.ps'
set pointsize 0.75
set xlabel "Rank" offset 0,0.5
set ylabel "Cumulative Size of Files (MB)" offset 1.7,0
#set xrange [50:80]
set mxtics 4
#set yrange [0:100]
#set logscale y
set ytics border nomirror
set mytics 2
set size 1.0,0.75
set key below
set title "Memory Use - `cat make_zipf_description.txt`"
plot \
   'memory.txt' using 1:2 axes x1y1 title 'actual' with lines linetype 1 linewidth 4, \
   'memory.txt' using 1:3 axes x1y1 title 'maximum session' with lines linetype 2 linewidth 4
#   'memory.txt' using 1:4 axes x1y1 title 'using blocks' with lines linetype 3 linewidth 4

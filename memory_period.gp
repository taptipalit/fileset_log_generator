set terminal postscript color solid 'Times' 12
set output 'memory_period.ps'
set pointsize 0.75
set xlabel "Fraction of Sessions" offset 0,0.5
set ylabel "Period of Video (MB)" offset 1.7,0
#set xrange [50:80]
set mxtics 4
set yrange [0:100000]
#set logscale y
set ytics border nomirror
set mytics 2
set size 1.0,0.75
set key below
set grid xtics ytics
set title "Memory Period - `cat make_zipf_description.txt`"
plot \
   'memory.txt' using 4:5 axes x1y1 title '' with lines linetype 1 linewidth 4
# plot \
   'memory.txt' using 1:5 axes x1y1 title '' with lines linetype 1 linewidth 4

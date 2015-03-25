set terminal postscript color solid 'Times' 12
set output 'session_frac_histogram.ps'
set pointsize 0.75
set xlabel "Download Fraction" offset 0,0.5
set ylabel "CDF" offset 1.7,0
#set xrange [50:80]
set mxtics 4
#set yrange [0:1]
set ytics border nomirror
set mytics 2
set size 1.0,0.75
set key  below
set grid xtics ytics
set title "Sessions Fraction CDF - `cat make_zipf_description.txt`"
plot \
   'reference/youtube_everywhere_fig_10.txt' using 1:2 axes x1y1 title 'target' with lines linetype 2 linewidth 4,\
   'session_frac_histogram.txt' using 1:2 axes x1y1 title 'generated' with lines linetype 1 linewidth 4

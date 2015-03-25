set terminal postscript color solid 'Times' 12
set output 'popular_dur.ps'
set pointsize 0.75
set xlabel "Duration" offset 0,0.5
set ylabel "Number of Views" offset 1.7,0
#set xrange [50:80]
set mxtics 4
set yrange [0:1000]
#set logscale y
set ytics border nomirror
set mytics 2
set size 1.0,0.75
unset key
set title "Popularity vs. Duration - `cat make_zipf_description.txt`"
plot \
   'popular_dur.txt' using 1:2 axes x1y1 title 'generated' with points pointtype 3 pointsize 0.5

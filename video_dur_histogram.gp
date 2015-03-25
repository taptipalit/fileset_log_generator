set terminal postscript color solid 'Times' 12
set output 'video_dur_histogram.ps'
set pointsize 0.75
set xlabel "Duration" offset 0,0.5
set ylabel "CDF" offset 1.7,0
set xrange [10:1000]
set mxtics 10
#set yrange [0:60]
set ytics border nomirror
#set mytics 2
set size 1.0,0.75
set key  below
set logscale x
set grid xtics ytics
set title "Duration CDF - `cat make_zipf_description.txt`"
plot \
   'reference/youtube_everywhere_fig_3_pc.txt' using 1:2 axes x1y1 title 'target' with lines linetype 2 linewidth 4,\
   'video_dur_histogram.txt' using 1:2 axes x1y1 title 'generated' with lines linetype 1 linewidth 4

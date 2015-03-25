set terminal postscript color solid 'Times' 12
set output 'video_dur_prob.ps'
set pointsize 0.75
set xlabel "Duration" offset 0,0.5
set ylabel "PDF" offset 1.7,0
#set xrange [50:80]
set mxtics 4
#set yrange [0:60]
set ytics border nomirror
set mytics 2
set size 1.0,0.75
set key  below
set title "Video Duration Distribution - `cat make_zipf_description.txt`"
plot \
   'video_dur_prob.txt' using 1:5 axes x1y1 title 'all data' with lines linetype 2 linewidth 4,\
   'video_dur_prob.txt' using 1:2 axes x1y1 title 'high popularity' with lines linetype 3 linewidth 4,\
   'video_dur_prob.txt' using 1:4 axes x1y1 title 'low popularity' with lines linetype 1 linewidth 4
#plot \
   'video_dur_prob.txt' using 1:5 axes x1y1 title 'all data' with lines linetype 2 linewidth 4,\
   'video_dur_prob.txt' using 1:2 axes x1y1 title 'high popularity' with lines linetype 3 linewidth 4,\
   'video_dur_prob.txt' using 1:3 axes x1y1 title 'middle popularity' with lines linetype 4 linewidth 4,\
   'video_dur_prob.txt' using 1:4 axes x1y1 title 'low popularity' with lines linetype 5 linewidth 4

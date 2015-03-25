all : STDOUT graphs

# MIXED_VIDEO
STDOUT: make_zipf Makefile
	./make_zipf video_files-SD-20000.list video_files-HD-8000.list | tee STDOUT

#STDOUT: make_zipf Makefile
#	./make_zipf video_files-SD-20000.list | tee STDOUT

# HD_VIDEO
#STDOUT: make_zipf Makefile
#	./make_zipf video_files-HD-8000.list | tee STDOUT

#STDOUT: make_zipf Makefile
#	./make_zipf video_files-3xHD-4500.list | tee STDOUT

#STDOUT: make_zipf Makefile
#	./make_zipf video_files-60000.list | tee STDOUT

#STDOUT: make_zipf Makefile
#	./make_zipf | tee STDOUT

video_files : make_zipf
	./make_zipf

# gcc -Wall -g -o make_zipf -lm make_zipf.c
make_zipf : make_zipf.c
	gcc -Wall -g -o make_zipf make_zipf.c -lm

gen_3filesets : gen_3filesets.c
	gcc -Wall -g -o gen_3filesets -lm gen_3filesets.c

gen_fileset : gen_fileset.c
	gcc -Wall -g -o gen_fileset -lm gen_fileset.c

gen_fileset_delay : gen_fileset_delay.c
	gcc -Wall -g -o gen_fileset_delay -lm gen_fileset_delay.c

gen_filechunks : gen_filechunks.c
	gcc -Wall -g -o gen_filechunks -lm gen_filechunks.c

graphs: distribution.pdf video_dur_histogram.pdf video_dur_prob.pdf popular_dur.pdf memory.pdf session_histogram.pdf \
	session_frac_histogram.pdf session_info.pdf dist_unsorted.pdf memory_cdf.pdf session_chunk_histogram.pdf memory_period.pdf

distribution.pdf : distribution.txt distribution.gp
	gnuplot distribution.gp
	ps2pdf distribution.ps

video_dur_histogram.pdf : video_dur_histogram.txt video_dur_histogram.gp
	gnuplot video_dur_histogram.gp
	ps2pdf video_dur_histogram.ps

video_dur_prob.pdf : video_dur_prob.txt video_dur_prob.gp
	gnuplot video_dur_prob.gp
	ps2pdf video_dur_prob.ps

memory_cdf.pdf : memory.txt memory_cdf.gp
	gnuplot memory_cdf.gp
	ps2pdf memory_cdf.ps

memory_period.pdf : memory.txt memory_period.gp
	gnuplot memory_period.gp
	ps2pdf memory_period.ps

memory.pdf : memory.txt memory.gp
	gnuplot memory.gp
	ps2pdf memory.ps

popular_dur.pdf : popular_dur.txt popular_dur.gp
	gnuplot popular_dur.gp
	ps2pdf popular_dur.ps

session_frac_histogram.pdf : session_frac_histogram.txt session_frac_histogram.gp
	gnuplot session_frac_histogram.gp
	ps2pdf session_frac_histogram.ps

session_chunk_histogram.pdf : session_chunk_histogram.txt session_chunk_histogram.gp
	gnuplot session_chunk_histogram.gp
	ps2pdf session_chunk_histogram.ps

session_histogram.pdf : session_histogram.txt session_histogram.gp
	gnuplot session_histogram.gp
	ps2pdf session_histogram.ps

session_info.pdf : session_info.txt session_info.gp
	gnuplot session_info.gp
	ps2pdf session_info.ps

dist_unsorted.pdf : distribution.txt dist_unsorted.gp
	gnuplot dist_unsorted.gp
	ps2pdf dist_unsorted.ps

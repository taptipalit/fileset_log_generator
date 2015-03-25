/*
    gen_fileset_delay
    Creates a full set of video files using the contents of video_files.txt,
    with a user-specified delay between files.
          
    This file is Copyright (C) 2011  Jim Summers

    Authors: Jim Summers <jasummer@cs.uwaterloo.ca>
  
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 2 of the
    License, or (at your option) any later version.
  
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.
  
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA
*/

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <assert.h>

static char *basename;
static char *fileset_list_filename;

/* program will sleep this number of seconds between file writes */
static int delay = 1;

static int create_file( char *fname, int size );

int main(int argc, char *argv[])
{
    FILE *f;
    char file_line[100];
    char filename[100];
    char *curr;
    int	file_num;
    int file_bytes;
    double file_time;
    int count;

    /* get basename for files and the list of files to create */
    if (argc < 3 || argc > 4) {
	printf( "Usage: %s <basename> <fileset_list> {delay}\n", argv[0] );
	exit( 1 );
    }
    basename = argv[1];
    fileset_list_filename = argv[2];
    if (argc > 3) {
	delay = strtol( argv[3], NULL, 10 );
    }
    printf( "Creating full files specified in file %s with delay %d.\n",
		    fileset_list_filename, delay );

    /* open file list and skip to first useful line */
    f = fopen( fileset_list_filename, "rt" );
    while ((curr = fgets( file_line, sizeof( file_line ), f )) != NULL) {
	if (file_line[0] != '#')
	    break;
    }

    count = 0;
    while (curr != NULL) {
	if (sscanf( curr, "%d %d %lf", &file_num, &file_bytes, &file_time ) != 3) {
	    printf( "Error in format: %s\n", curr );
	    exit( 1 );
	}
	sprintf( filename, "%s%05d.txt", basename, file_num );
	printf( "%s %.1f MB\n", filename, file_bytes / 1048576.0 );
	create_file( filename, file_bytes );
	sleep( delay );
	curr = fgets( file_line, sizeof( file_line ), f );
    }
    exit( 0 );
}

/*
 * create file with specified name and size
 */
static int create_file( char *fname, int size )
{
    FILE *fout;
#define BLOCK_SIZE 64
    char filler[BLOCK_SIZE+1];
    int num_blocks;
    int end;
    int i,j;

    num_blocks = size / BLOCK_SIZE;
    if ((fout = fopen( fname, "w+" )) == NULL) {
	return( errno );
    }
    for (i=0;i<num_blocks;++i) {
	end = snprintf( filler, sizeof( filler ), "%s %d %d\n", fname, size, i );
	if (end < BLOCK_SIZE) {

	    /* find space before line number */
	    j = --end;
	    while (j > 0 && filler[j] != ' ') {
		--j;
	    }

	    /* repeat line number until buffer is full */
	    do {
		filler[end++] = filler[j++];
	    } while (end < BLOCK_SIZE-1);
	    filler[BLOCK_SIZE-1] = '\n';
	    filler[BLOCK_SIZE] = '\0';
	}
	fputs( filler, fout );
    }

    /* add last partial block */
    i = size - num_blocks * BLOCK_SIZE;
    if (i > 0) {
	fprintf( fout, "%.*s\n", i-1, filler );
    }
    fclose( fout );
    return( 0 );
}
 

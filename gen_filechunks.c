/*
    make_zipf
    Generates a set of file chunks of the specfied size
          
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
#include <errno.h>
#include <string.h>
#include <assert.h>

static char *basename;
static int chunk_size;
static int num_chunks;

static int create_file( char *fname, int size );

int main(int argc, char *argv[])
{
    char filename[100];
    int	file_num;

    /* get basename for files and the list of files to create */
    if (argc < 4) {
	printf( "Usage: %s <basename> <size> <num_chunks>\n", argv[0] );
	exit( 1 );
    }
    basename = argv[1];
    chunk_size = atoi( argv[2] );
    num_chunks = atoi( argv[3] );
    if (chunk_size < 128*1024) {
	printf( "Usage: %s is too small for a chunk size.\n", argv[2] );
	exit( 1 );
    }
    if (num_chunks < 1024) {
	printf( "Usage: %s is too small for a number of chunks.\n", argv[3] );
	exit( 1 );
    }

    for (file_num = 0; file_num < num_chunks; ++file_num) {
	sprintf( filename, "%s%06d.txt", basename, file_num );
	if (file_num % 100 == 0) {
	    printf( "%s ", filename );
	    if (file_num % 300 == 0) {
		printf( "\n" );
	    }
	}
	create_file( filename, chunk_size );
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

    /* round size up to chunk size */
    if (chunk_size > 1) {
	size = ((size + chunk_size - 1) / chunk_size) * chunk_size;
    }

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

#ifdef NEVER
/*
 * create file with specified name and size
 */
static int create_file( char *fname, int size )
{
    FILE *fout;
    static char filler[64] = "0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDE\n";
    int num_blocks;
    int i;

    num_blocks = size / sizeof( filler );
    if ((fout = fopen( fname, "wt" )) == NULL) {
	return( errno );
    }
    for (i=0;i<num_blocks;++i) {
	fputs( filler, fout );
    }

    /* add last partial block */
    i = size - num_blocks * sizeof( filler );
    if (i > 0) {
	fprintf( fout, "%*s\n", i-1, filler );
    }
    fclose( fout );
    return( 0 );
}
#endif

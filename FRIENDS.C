#include <stdio.h>


FILE *infile;

int addline(int);

void main(void) {

   int nplayers;   /* Number of players */
   int nscores;    /* Number of scores */
   int i;          /* Loop control var */

   infile=fopen("friends.in","r");


   /* Read in nplayers and nscores */
   fscanf(infile,"%d %d\n",&nplayers,&nscores);


   for (i=0; i<nplayers; i++) {

	printf("%d\n",addline(nscores));
   };
}


/*
    This function reads integers from a line
    of length len from the global FILE pointer
    and returns the sum
*/

int addline(int len) {

   int num;	/* Integer read */
   int total;	/* Total of all integers */
   int i;	/* Loop control var */

   /* Initialize total */
   total = 0;

   for (i=0; i<len; i++) {

	fscanf(infile,"%d",&num);   /* Read in num */
	total += num;	     /* Add num to total */
   };

   fscanf(infile,"\n");	/* Go to next line in infile */

   return(total);
}
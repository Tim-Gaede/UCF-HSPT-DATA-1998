#include <stdio.h>
#include <stdlib.h>

void main ()
{
 int numdata, i;
 int inputch;
 FILE *In;

 In = fopen ("yoyo.in", "rt");
 fscanf (In, "%d\n", &numdata);
 for (i=0;i<numdata;i++)
  {
   fscanf (In, "%c\n", &inputch);
   printf ("%c", (inputch & 128) ? '1' : '0');
   printf ("%c", (inputch & 64) ? '1' : '0');
   printf ("%c", (inputch & 32) ? '1' : '0');
   printf ("%c", (inputch & 16) ? '1' : '0');
   printf ("%c", (inputch & 8) ? '1' : '0');
   printf ("%c", (inputch & 4) ? '1' : '0');
   printf ("%c", (inputch & 2) ? '1' : '0');
   printf ("%c\n", (inputch & 1) ? '1' : '0');
  }
 fclose (In);
}
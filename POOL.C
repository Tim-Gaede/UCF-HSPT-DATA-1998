#include <stdio.h>
#include <stdlib.h>

void main ()
{
 int level, tol, numdata;
 int i, input;
 FILE *In;

 In = fopen ("pool.in", "rt");
 fscanf (In, "%d %d %d\n", &level, &tol, &numdata);
 for (i=0;i<numdata;i++)
  {
   fscanf (In, "%d\n", &input);
   if (input < level - tol)
     printf ("Add chlorine.\n");
   else
     printf ("Pool's fine.\n");
  }
 fclose (In);
}
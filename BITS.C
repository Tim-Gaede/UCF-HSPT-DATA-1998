#include <stdio.h>

main()
{
   FILE   *infile;
   int    numSets;
   int    i;
   int    k;
   int    j;
   char   screen[8][8];
   int    currentBitPos;
   int    column;

   /* Open input file */
   infile = fopen("bits.in", "r");

   /* Process each set */
   fscanf(infile, "%d\n", &numSets);
   for (i=0; i < numSets; i++)
   {
      /* Clear our virtual screen */
      for (k=0; k < 8; k++)
      {
	 for (j=0; j < 8; j++)
	    screen[k][j] = '.';
      }

      /* Process each column */
      for (j=0; j < 8; j++)
      {
	 fscanf(infile, "%d", &column);

         /* Largest bit value is 2^7 = 128 */
	 currentBitPos = 128;
	 for (k=7; k >= 0; k--)
	 {
	    /* Check to see if the current bit value fits within column value */
	    if (column >= currentBitPos)
            {
               screen[k][j] = '*';
               column -= currentBitPos;
            }

	    /* Go to next bit value */
	    currentBitPos= currentBitPos / 2;
	 }
      }

      /* Output screen */
      for (k=0; k < 8; k++)
      {
	 for (j=0; j < 8; j++)
	    printf("%c", screen[k][j]);
	 printf("\n");
      }

      /* Blank line */
      printf("\n");
   }
}

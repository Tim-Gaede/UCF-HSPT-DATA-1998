#include <stdio.h>

main()
{
   FILE   *infile;
   int    numSets;
   int    i;
   int    numPeppers;
   int    numSentences;
   int    j;
   char   sentence[81];
   int    k;
   int    count;

   /* Open the input file */
   infile = fopen("pepper.in", "r");

   /* Process each set */
   fscanf(infile, "%d\n", &numSets);
   for (i=0; i < numSets; i++)
   {
      /* Print the header */
      printf("Data Set #%d:\n\n", i+1);

      fscanf(infile, "%d %d\n", &numPeppers, &numSentences);

      /* Process each sentence in the set */
      for (j=0; j < numSentences; j++)
      {
	/* Read and print the sentence */
	 fgets(sentence, 80, infile);
	 sentence[strlen(sentence)-1] = '\0';
	 printf("%s\n", sentence);

	 /* Go to all upper-case for ease of checking */
	 for (k=0; k < strlen(sentence); k++)
	    sentence[k] = toupper(sentence[k]);

	 /* Count how many times the substring "PEPPER" appears */
	 count = 0;
	 for (k=0; k < strlen(sentence)-5; k++)
	 {
	    if (strncmp(&sentence[k], "PEPPER", 6) == 0)
	       count++;
	 }

         /* Check to see if we counted too many and output appropriately */
	 if (count > numPeppers)
            printf("Ah-choo!\n\n");
         else
	    printf("Joel does not sneeze.\n\n");
      }

      /* Extra blank line */
      printf("\n");
   }
}

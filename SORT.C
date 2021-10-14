#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>


char Prefixes[100][21];
int nPrefixes;


typedef struct tagTWord
{
  char Text[21];
  int idxPrefix;
} TWord;


TWord Words[1000];
int nWords;


//********************************************************************

/* This function looks through each word in the Words[] array and
   figures out the appropriate prefix to file this word under.
*/
void FindPrefixesForWords(void)
{
  int loop, loop2;
  int idxMatch, LengthOfMatch;
  int temp;

  for (loop = 0; loop < nWords; loop++)
  {
    idxMatch = -1;
    LengthOfMatch = 0;

    for (loop2 = 0; loop2 < nPrefixes; loop2++)
    {
      temp = strlen(Prefixes[loop2]);
      if (strncmp(Words[loop].Text, Prefixes[loop2], temp) == 0)
      {
        //the word matches this prefix. Is it the longest matching prefix so far?
        if (LengthOfMatch < temp)
        {
          LengthOfMatch = temp;
          idxMatch = loop2;
        }
      }
    }

    Words[loop].idxPrefix = idxMatch;

  }

}


//********************************************************************


/* This function takes an array of indices into the Words[] array,
   and sort them. */
void SortWordsOfSamePrefix(int *WordsToSort, int nWordsToSort)
{
  int loop, loop2, temp;

  if (nWordsToSort < 2)
    return;

  for (loop = nWordsToSort-1; loop > 0; loop--)
    for (loop2 = 0; loop2 < loop; loop2++)
      if (strcmp(Words[WordsToSort[loop2]].Text, Words[WordsToSort[loop2+1]].Text) > 0)
      {
        temp = WordsToSort[loop2];
        WordsToSort[loop2] = WordsToSort[loop2+1];
        WordsToSort[loop2+1] = temp;
      }
}


//********************************************************************


void PrintPrefix(int idxPrefix)
{
  int loop;
  int MatchingWords[1000];
  int nMatchingWords = 0;

  //we don't print anything if no words match this prefix, so first see if
  //any words match this prefix
  for (loop = 0; loop < nWords; loop++)
    if (Words[loop].idxPrefix == idxPrefix)
    {
      MatchingWords[ nMatchingWords ] = loop; 
      nMatchingWords++;
    }

  if (nMatchingWords > 0)
  {
    char Prefix[21];

    //words match this prefix. Print the prefix name
    strcpy(Prefix, Prefixes[idxPrefix]);
    Prefix[0] = (char)toupper(Prefix[0]);
    printf("%s\n", Prefix);

    //sort all the entries of this prefix
    SortWordsOfSamePrefix(MatchingWords, nMatchingWords);

    //print the entries for this prefix
    for (loop = 0; loop < nMatchingWords; loop++)
      printf("  %s\n", Words[MatchingWords[loop]].Text);

    printf("\n");
  }
}


//********************************************************************


void main()
{
  int DictionaryCount = 0;
  int loop;
  char s[256];
  char *p;

  do
  {
    fgets(s, sizeof(s), stdin);
    sscanf(s, "%d", &nPrefixes);
    if (nPrefixes > 0)
    {
      //load in the data
      for (loop = 0; loop < nPrefixes; loop++)
      {
        fgets(s, sizeof(s), stdin);
        p = strchr(s, '\n');
        if (p) *p = '\0';
        strcpy(Prefixes[loop], s);
      }

      fgets(s, sizeof(s), stdin);
      sscanf(s, "%d", &nWords);

      for (loop = 0; loop < nWords; loop++)
      {
        fgets(s, sizeof(s), stdin);
        p = strchr(s, '\n');
        if (p) *p = '\0';
        strcpy(Words[loop].Text, s);
      }

      //find the prefix of each word
      FindPrefixesForWords();

      //print the Dictionary # header
      ++DictionaryCount;
      printf("---Dictionary #%d---\n", DictionaryCount);

      //for each prefix that has words matching it, print the prefix & words
      for (loop = 0; loop < nPrefixes; loop++)
        PrintPrefix(loop);

    }
  }
  while (nPrefixes > 0);

}



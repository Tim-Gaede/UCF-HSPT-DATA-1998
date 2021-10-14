/* Program CHANGE */

#include <stdio.h>
#include <stdlib.h>

void main ()
{
 int quarters, dimes, nickels, pennies; /*Kept out of an array for readability*/
 int target; /*the amount the soda costs*/
 int overage; /*number of kicks*/
 int left; /*The amount remaining to get to target*/
 FILE *In;
 int i, n;

 In = fopen ("change.in", "rt");
 fscanf (In, "%d\n", &n);
 for (i=0;i<n;i++)
  {
   fscanf (In, "%d %d %d %d %d\n", &quarters, &dimes, &nickels, &pennies, &target);
   printf ("Data set #%d: %d %d %d %d %d\n", i+1, quarters, dimes, nickels,
   														pennies, target);

/*The first solution I thought of was what's known as greedy.  Take out as
  many of the biggest as you can, and then the next biggest, and so on.
  For American change, greedy works to find exact change.  But this problem
  is to find least overage, and there are a few cases (try 0 3 1 0 23 or
  0 3 1 4 23) where greedy doesn't give the best solution.  I then tried to
  modify it by backtracking a level, but there are always extra cases.  So
  I thought about it a little more, and realized that greedy did always find
  best less-than-or-egual-to.  So I decided to work backwards.  Note
  that the maximal change possible is 25*100+10*100+5*100+1*100=4100 - well
  within a 16-bit integer*/

   left = quarters*25+dimes*10+nickels*5+pennies;
   while ((quarters) && (left >= target+25))
    {
     quarters--;
     left -= 25;
    }
   while ((dimes) && (left >= target+10))
    {
     dimes--;
     left -= 10;
    }
   while ((nickels) && (left >= target+5))
    {
     nickels--;
     left -= 5;
    }
   while ((pennies) && (left >= target+1))
    {
     pennies--;
     left--;
    }

   overage = left - target;
   printf ("   Ali, use ");
   if (quarters)
     printf ("%d quarter(s), ", quarters);
   if (dimes)
     printf ("%d dime(s), ", dimes);
   if (nickels)
     printf ("%d nickel(s), ", nickels);
   if (pennies)
     printf ("%d penny(s), ", pennies);
   printf ("\n        and kick the machine %d time(s)!\n\n", overage);
  }
 fclose (In);
}

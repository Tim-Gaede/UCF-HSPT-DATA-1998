#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>



long int DoIt(long int MilesPerStop)
{
  long int BananasAtThisStop = 100000;
  int CurMile = 0;

  if ((MilesPerStop <= 0) || (MilesPerStop >= 250))
    return 0;

  while (CurMile < 500)
  {
    long int BananasAtNextStop = 0;
    long int MilesToNextStop = min((500 - CurMile), MilesPerStop);

    assert(BananasAtThisStop >= MilesToNextStop);
    assert(MilesToNextStop > 0);
    assert(BananasAtThisStop >= MilesToNextStop);

    while (BananasAtThisStop > MilesToNextStop * 2)
    {
      long int BananasOnCamel = min(BananasAtThisStop, 500);
      BananasAtThisStop -= BananasOnCamel;
      BananasOnCamel -= MilesToNextStop;                        //camel ate these bananas on the way to next stop
      if (BananasAtThisStop > MilesToNextStop * 2)              //okay, it's worth it to make another trip back
        BananasAtNextStop += BananasOnCamel - MilesToNextStop;  //offload bananas, but keep enough bananas for the trip home
      else
        BananasAtNextStop += BananasOnCamel;                    //offload all bananas; not going back to last spot
    }

    CurMile += MilesToNextStop;
    BananasAtThisStop = BananasAtNextStop;

  }

  assert(CurMile == 500);
  return BananasAtThisStop;
}


void main()
{
  int nMilesPerStop;
  long int nTotal;
  char s[256];
  while (fgets(s, sizeof(s), stdin) != NULL)
  {
    sscanf(s, "%d", &nMilesPerStop);
    nTotal = DoIt(nMilesPerStop);
    printf("By moving the bananas %d miles per step, %ld bananas get to market.\n",
           nMilesPerStop, nTotal);
  }

}
#include <stdio.h>

/*                1998 Annual UCF High School Programming Contest

                       Problem: Elelator Go Down the Hole!
    Problem by : Phillip Dexheimer
    Solution by: Michael Kujawa
*/

//Remove the next six lines if your compiler has 'bool' built-in
typedef int bool;
enum
{
    false,
    true
};

//Maximum number of floors.  The problem states that there will be less
//than 100 floors, so the maximum is 99.
#define MAX 99

int  nFloors;           //-Number of floors in the current building
bool Matrix[MAX][MAX];  //-Matrix of floor connectivity from the input
bool Visited[MAX];      //-Floors visited by Herman in the current test
int Destination;        //-Floor Herman is trying to get to in the current test



/* PathSearch
    Recursive function that follows the steps outlined in the problem spec.

    1) Herman marks the current floor as used on his "clipboard" (which is
       represented by the array, Visited.
    2) Then he checks to see if he has arrived at his destination floor.  If
       so he stops. (I guess he uses the stairs to get to his next starting
       floor ;)
    3) If hasn't finished, he explores the unvisited floors, where "explore"
       means starting the process over again from the new floor.

    So much work!

    Incidentally, this algorithm is called: "Depth First Search".
*/
bool PathSearch(int CurFloor)
{
    //Step 1.  Mark the floor as visited
    Visited[CurFloor] = true;

    //Step 2.  Check to see if Herman is done
    if (CurFloor == Destination)
        return true;

    //Step 3.  Explore the remaining floors
    for (int NextFloor = 0; NextFloor < nFloors; NextFloor++)
    {
        if (Matrix[CurFloor][NextFloor] && !Visited[NextFloor])
            if (PathSearch(NextFloor))
                return true;
    }

    return false;
}



/* bPathExists
    This is a wrapper for PathSearch, making it easier to use in main().
    This just does some sanity checking and initializes some variables.
*/
bool bPathExists(int From, int To)
{
    //Sanity checking: make sure the start and destination floor are in the
    //building.  I wasn't evil enough to put any of these in the input.
    if ((From < 0) || (From >= nFloors) || (To < 0) || (To >= nFloors))
        return false;

    //Initialize the variables PathSearch uses
    Destination = To;
    for (int i=0; i < nFloors; i++)
        Visited[i] = false;

    //Do it.
    return PathSearch(From);
}



/* main
    This is all very straight-forward so I didn't add any comments to the
    function body.  After opening the file it reads in each case and
    hands it to bPathExists, printing the appropriate message afterwards.
*/
void main()
{
FILE *F;
int Set = 0;

    F = fopen("elevator.in", "r");

    fscanf(F, "%d", &nFloors);
    while (nFloors > 0)
    {
    int nTests;
        for (int row=0; row < nFloors; row++)
            for (int col=0; col < nFloors; col++)
                fscanf(F, "%d", &Matrix[row][col]);

        printf("Building #%d:\n", ++Set);
        fscanf(F, "%d", &nTests);
        for (int Test = 0; Test < nTests; Test++)
        {
        int From, To;
            fscanf(F, "%d %d", &From, &To);
            printf("%d %d: ", From, To);
            if (bPathExists(From-1, To-1))
                printf("Possible\n");
            else
                printf("Not Possible\n");
        }
        printf("\n");

        fscanf(F, "%d", &nFloors);
    }
    fclose(F);
}

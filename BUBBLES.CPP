#include <stdio.h>
#include <math.h>
/*                1998 Annual UCF High School Programming Contest

                       Problem: Benjamin's Bubbles
    Problem by : Glenn Martin
    Solution by: Michael Kujawa
*/
//Remove the next six lines if your compiler has 'bool' built-in
typedef int bool;
enum
{
    false,
    true
};


//Some structures to ease parameter passing between functions
struct TPoint
{
    double x, y;
};

struct TRect
{
    int left, top, right, bottom;
};

struct TBubble
{
    TPoint Center;
    double Radius;
};



/* Distance
    Good old Pythagorean's therom to find the distance between two points
*/
double Distance(TPoint Pt1, TPoint Pt2)
{
    double dx = Pt2.x - Pt1.x;
    double dy = Pt2.y - Pt1.y;

    return sqrt(dx*dx + dy*dy);
}


/* bPointInBubble
    Determines if a point (x,y) is in or on the circle defined by Bubble.
    This can easily checked by calculating the distance from the center of
    the circle to the point being checked.  If the distance is greater than
    the circle's radius the point is outside the circle.
*/
bool PointInBubble(double x, double y, TBubble Bubble)
{
TPoint Pt;
    Pt.x = x; Pt.y = y;
    return Distance(Pt, Bubble.Center) <= Bubble.Radius;
}



/* TileDamaged
    Determines if a tile is completely inside of a bubble.  Since a tile is
    just a rectangle, and a bubble is just a circle, this function is checking
    if a rectangle is in a circle.  This can only happen if all four of the
    rectangle's vertices on, or inside the circle.  So bTile
*/
bool TileDamaged(TBubble Bubble, TRect Rect)
{
    //All four vertices of Rect is in Bubble
    return PointInBubble(Rect.left, Rect.top, Bubble) &&
           PointInBubble(Rect.left, Rect.bottom, Bubble) &&
           PointInBubble(Rect.right, Rect.top, Bubble) &&
           PointInBubble(Rect.right, Rect.bottom, Bubble);
}


/* Main
    Several things make this into a much easier problem if you realize them:
    1) There are only possible 2500 tiles to damage so you can just check
       them all.
    2) The bubble test are independant of each other.  Because of this, even if
       a tile is partially hit by four bubles you don't need to worry that sum
       of their damage might completely damage the tile.

    Therefore, all that must be done for each bubble is to check all tiles
    on the floor and print out the ones that are completely damaged.
*/
void main()
{
FILE    *F;
TBubble Bubble;
TRect   Tile;
int     nBubbles, Width, Height;

    F = fopen("bubbles.in","r");

    fscanf(F, "%d %d %d", &Width, &Height, &nBubbles);
    for (int SetNo = 1; SetNo <= nBubbles; SetNo++)
    {
    int nDamaged = 0;

        printf("Bubble #%d:\n", SetNo);

        //Read the bubble from the input
        fscanf(F, "%lf %lf %lf", &Bubble.Center.x,  &Bubble.Center.y,  &Bubble.Radius);

        //Loop through all the tiles
        for (int y=0; y < Height; y++)
          for (int x = 0; x < Width; x++)
          {
            Tile.left = x*2;
            Tile.bottom = y*2;
            Tile.right = Tile.left + 2;
            Tile.top = Tile.bottom + 2;

            //If the tile is completely damaged, print it out
            if (TileDamaged(Bubble, Tile))
            {
                printf("   Floor tile (%d, %d) is damaged.\n", x+1, y+1);
                nDamaged++;
            }
          }

         if (!nDamaged)
             printf("   No tiles are damaged.\n");

        printf("\n");
    }

    fclose(F);
}

(*                1998 Annual UCF High School Programming Contest

                       Problem: Benjamin's Bubbles
    Problem by : Glenn Martin
    Solution by: Michael Kujawa
*)

{ Some structures to ease parameter passing between functions }
Type
    TPoint = Record
      x, y : real;
    End;

    TRect = Record
        left, top, right, bottom : Integer;
    End;

    TBubble = Record
        Center : TPoint;
        Radius : real;
    End;



{ Distance
    Good old Pythagorean's therom to find the distance between two points
}
Function Distance(Pt1, Pt2 : TPoint) : real;
Var
   dx, dy : real;
Begin
    dx := Pt2.x - Pt1.x;
    dy := Pt2.y - Pt1.y;

    Distance := sqrt(dx*dx + dy*dy);
End;


{ bPointInBubble
    Determines if a point (x,y) is in or on the circle defined by Bubble.
    This can easily checked by calculating the distance from the center of
    the circle to the point being checked.  If the distance is greater than
    the circle's radius the point is outside the circle.
}
Function PointInBubble(x, y : real; Bubble : TBubble ) : Boolean;
Var
   Pt : TPoint ;
Begin
    Pt.x := x; Pt.y := y;
    PointInBubble := Distance(Pt, Bubble.Center) <= Bubble.Radius;
End;



{ TileDamaged
    Determines if a tile is completely inside of a bubble.  Since a tile is
    just a rectangle, and a bubble is just a circle, this function is checking
    if a rectangle is in a circle.  This can only happen if all four of the
    rectangle's vertices on, or inside the circle.  So bTile
}
Function TileDamaged(Bubble : TBubble; Rect : TRect) : Boolean;
Begin
    TileDamaged := PointInBubble(Rect.left, Rect.top, Bubble) and
                   PointInBubble(Rect.left, Rect.bottom, Bubble) and
                   PointInBubble(Rect.right, Rect.top, Bubble) and
                   PointInBubble(Rect.right, Rect.bottom, Bubble);
End;


{ Main
    Several things make this into a much easier problem if you realize them:
    1) There are only possible 2500 tiles to damage so you can just check
       them all.
    2) The bubble test are independant of each other.  Because of this, even if
       a tile is partially hit by four bubles you don't need to worry that sum
       of their damage might completely damage the tile.

    Therefore, all that must be done for each bubble is to check all tiles
    on the floor and print out the ones that are completely damaged.
}
Var
   F      : Text;
   Bubble : TBubble;
   Tile   : TRect;
   nBubbles,
   nDamaged,
   SetNo,
   x, y,
   Width,
   Height : Integer;

Begin
    Assign(F, 'Bubbles.in');
    Reset(F);

    Read(F, Width, Height, nBubbles);
    for SetNo := 1 to nBubbles do
    Begin
        Writeln('Bubble #', SetNo, ':');

        {Read the bubble from the input}
        Read(F, Bubble.Center.x, Bubble.Center.y, Bubble.Radius);

        nDamaged := 0;

        {Loop through all the tiles}
        for y := 0 to Height-1 do
            for x := 0 to Width-1 do
            Begin
                Tile.left := x*2;
                Tile.bottom := y*2;
                Tile.right := Tile.left + 2;
                Tile.top := Tile.bottom + 2;

                {If the tile is completely damaged, print it out}
                if TileDamaged(Bubble, Tile) then
                Begin
                    Writeln('   Floor tile (', x+1, ', ', y+1, ') is damaged.');
                    inc(nDamaged);
                End;
            End;
        if nDamaged = 0 then
            Writeln('   No tiles are damaged.');

        Writeln;
    End;

    Close(F);
End.

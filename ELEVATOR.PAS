program Elevator;

{ Maximum number of floors.  The problem states that there will be less
  than 100 floors, so the maximum is 99. }
const MAX=99;

Var
  nFloors : Integer;                          {-Number of floors in the }
                                              {  current building }
  Matrix  : Array[1..MAX, 1..MAX] of boolean; {-Matrix of floor connectivity }
                                              { from the input }
  Visited : Array[1..MAX] of boolean;         {-Floors visited by Herman in }
                                              { the current test }
  Destination : Integer;                      {-Floor Herman is trying to get }
                                              { to in the current test }


{ PathSearch
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
}
Function PathSearch(CurFloor : Integer) : boolean;
Var
    NextFloor : Integer;
    Ret       : boolean;

Begin
    Ret := false;
    { Step 1.  Mark the floor as visited }
    Visited[CurFloor] := true;

    { Step 2.  Check to see if Herman is done }
    if CurFloor = Destination then
        Ret := true;

    { Step 3.  Explore the remaining floors }
    for NextFloor := 1 to nFloors do
        if Matrix[CurFloor, NextFloor] and not Visited[NextFloor] then
            if PathSearch(NextFloor) then
            begin
                Ret := true;
                break;
            end;

    PathSearch := Ret;
End;



{ bPathExists
    This is a wrapper for PathSearch, making it easier to use in main().
    This just does some sanity checking and initializes some variables.
}
Function bPathExists(FromFloor, ToFloor : Integer) : boolean;
Var
    i : Integer;

Begin
    { Sanity checking: make sure the start and destination floor are in the
      building.  I wasn't evil enough to put any of these in the input. }
    if (FromFloor <= 0) or (FromFloor > nFloors) or
       (ToFloor <= 0) or (ToFloor > nFloors) then
        bPathExists := false
    else
    begin
        { Initialize the variables PathSearch uses }
        Destination := ToFloor;
        for i := 1 to nFloors do
            Visited[i] := false;

        { Do it. }
        bPathExists := PathSearch(FromFloor);
    end;
End;



{
    This is all very straight-forward so I didn't add any comments to the
    function body.  After opening the file it reads in each case and
    hands it to bPathExists, printing the appropriate message afterwards.
}
Var
    F      : Text;
    nTests : Integer;
    SetNo,
    Test,
    FromFloor,
    ToFloor,
    Row,
    Col    : Integer;

Begin
    Assign(F, 'elevator.in');
    reset(F);
    SetNo := 0;

    Read(F, nFloors);
    while nFloors > 0 do
    begin
        for Row := 1 to nFloors do
            for Col := 1 to nFloors do
            begin
                Read(F, Test);
                Matrix[Row, Col] := boolean(Test);
            end;

        Inc(SetNo);
        Writeln('Building #', SetNo, ':');
        Read(F, nTests);
        for Test := 1 to nTests do
        begin
            Read(F, FromFloor, ToFloor);
            Write(FromFloor, ' ', ToFloor, ': ');
            if bPathExists(FromFloor, ToFloor) then
                Writeln('Possible')
            else
                Writeln('Not Possible');
        end;
        Writeln;

        Read(F, nFloors);
    end;
End.
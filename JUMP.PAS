program jump;

type
  BoardArr = array [1..20] of boolean;

{Will hold the representations of the game board - 20 just for a buffer}

var
  Matrix : array[1..20, 1..20] of integer;
  {The Matrix describing possible moves}

  FinalState, BoardState : BoardArr;
  {Final is the target, board is the current state of the game}

  Path : array [0..20, 1..2] of integer;
  {Will store the path}

  SolveDepth, n, NumSets, m : integer;
  {Solvedepth is the number of moves necessary to reach a soln}
  {n is the same as in the problem description}
  {NumSets is the number of sets of data in the file}
  {m is the number of games to test on a particular board}

  i, j, k : integer;
  {loop vars}

  temp : char;
  {for reading the state of the board}

  t2 : boolean;
  {Just to check the result of the fcn.  Should *never* be false}

  InFile : TEXT;



procedure PrintPath (depth : integer);
{Prints the path taken so far, to a given number of moves}
var i : integer;

begin
  for i := 0 to depth-1 do
    writeln ('    ', Path[i][1]:2, ' -> ', Path[i][2]:2);
end;




function SolveIt (depth : integer) : boolean;
{The actual recursive fcn that does the work}
{The first if is just an optimization - the code will work without it,}
{albeit much slower.  I'm sorry about the goto, but I couldn't think of a}
{way around it in Pascal - my C soln is a little cleaner}
label 1;

var
  i, j, hopover : integer;
  Soln, retval : boolean;

begin
  {Only check to see if we've won if we've actually made enough moves}
  if (depth = SolveDepth) then
   begin
    Soln := true;
    for i := 1 to n do
      if (BoardState[i] <> FinalState[i]) then
        Soln := false;
    retval := Soln;
    if (Soln) then
      PrintPath(depth);
   end
  else
   begin
    {This is hardly elegant, but it works for this problem.  Check _every_ }
    {move possible from the current board state}
    retval := false;
    for i := 1 to n do
      for j := 1 to n do
       begin
        if (BoardState[i] and (not BoardState[j]) and (Matrix[i][j] <> 0)) then
         begin
          hopover := Matrix[i][j];
          if (BoardState[hopover]) then
           begin
            {Assume that it's the move we want, and move pegs accordingly}
            BoardState[i] := false;
            BoardState[hopover] := false;
            BoardState[j] := true;
            {Don't forget about Path}
            Path[depth][1] := i;
            Path[depth][2] := j;
            {Try it out}
            retval := SolveIt(depth+1);
            if (retval) then
             begin
              {If it worked, then we exit and back off the stack}
              goto 1;
             end
            else
             begin
              {If it didn't, we've got to undo the move we just made and try}
              {something else}
              BoardState[i] := true;
              BoardState[hopover] := true;
              BoardState[j] := false;
             end;
           end;
         end;
       end;
   end;
  1: SolveIt := retval;
end;



begin {The real deal}
  assign (InFile, 'jump.in');
  reset (InFile);

  readln (InFile, NumSets);
  for i := 1 to NumSets do
   begin
    readln (Infile, n);

    for j := 1 to n do
     begin
      for k := 1 to n do
        read (Infile, Matrix[j][k]);
      readln (InFile);
     end;

    readln (Infile, m);
    writeln ('Board #', i, ':');

    for j := 1 to m do
     begin
      for k := 1 to 20 do
       begin
        BoardState[k] := false; {Initialize everything to false}
        FinalState[k] := false;
       end;

      for k := 1 to n do
       begin
        read (InFile, temp);
        if (temp = '*') then
          BoardState[k] := true;
       end;
      readln (InFile);
                                  {and read in both board states}
      for k := 1 to n do
       begin
        read (InFile, temp);
        if (temp = '*') then
          FinalState[k] := true;
       end;
      readln (InFile);

      writeln ('  Solution for puzzle #', j, ':');

      {The number of moves necessary is equal to the number of pegs}
      {in the starting state minus the number of pegs in the }
      {final state}
      SolveDepth := 0;
      for k := 1 to n do
       begin
        if (BoardState[k]) then inc(SolveDepth);
        if (FinalState[k]) then dec(SolveDepth);
       end;

      t2 := SolveIt(0);

      {This if had better never be executed - if it is, it's a wrong answer}
      {But it is quite useful for debugging}
      if (not t2) then
        writeln ('Aughh!');
     end;
   end;
  close (InFile);
end. {That's all she wrote}
program bits;

var infile:text;
    numSets:integer;
    i:integer;
    k:integer;
    j:integer;
    screen:array[1..8, 1..8] of char;
    column:integer;
    currentBitPos:integer;

begin
   (* Open the input file *)
   assign(infile, 'bits.in');
   reset(infile);

   (* Process each set *)
   readln(infile, numSets);
   for i:=1 to numSets do
   begin
      (* Clear our virtual screen *)
      for k:=1 to 8 do
      begin
	 for j:=1 to 8 do
	    screen[k, j]:='.';
      end;

      (* Read each column *)
      for j:=1 to 8 do
      begin
	 read(infile, column);

	 (* Largest bit value is 2^7 = 128 *)
	 currentBitPos:=128;
	 for k:=8 downto 1 do
	 begin
	    (* Check to see if current bit value fits within column value *)
	    if column >= currentBitPos then
	    begin
	       screen[k, j]:='*';
	       column:=column - currentBitPos;
	    end;

            (* Go to next bit value *)
	    currentBitPos:=currentBitPos div 2;
	 end;
      end;

      (* Print out screen *)
      for k:=1 to 8 do
      begin
	 for j:=1 to 8 do
	    write(screen[k, j]);
	 writeln;
      end;

      (* Blank line *)
      writeln;
   end;
end.



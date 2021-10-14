Program CHANGE;

var
  quarters, dimes, nickels, pennies : integer;
  target, left, overage : integer;
  infile : text;
  i, n : integer;

{target is the cost of the soda}
{left is how much change I have left, as I am eliminating coins}
{overage is the number of times I kick the machine}

begin
  assign(infile, 'change.in');
  reset(infile);

  readln(infile, n);
  for i := 1 to n do
   begin
     readln (infile, quarters, dimes, nickels, pennies, target);

     writeln ('Data set #', i, ': ', quarters, ' ', dimes, ' ', nickels, ' ',
               pennies, ' ', target);

{This algorithm is greedy, but it is done backwards (ie, eliminating coins
 rather than adding them)  For a better explanation, read the C file.  I
 put in a paragraph explaining my thought processes - the algorithm's the
 same, and the code is actually strikingly similar}

     left := quarters*25 + dimes*10 + nickels*5 + pennies;

     while (quarters > 0) and (left >= target+25) do
      begin
        dec(quarters);
        left := left - 25;
      end;
     while (dimes > 0) and (left >= target+10) do
      begin
        dec(dimes);
        left := left - 10;
      end;
     while (nickels > 0) and (left >= target+5) do
      begin
        dec(nickels);
        left := left - 5;
      end;
     while (pennies > 0) and (left >= target+1) do
      begin
        dec(pennies);
        left := left - 1;
      end;

     overage := left - target;
     write ('   Ali, use ');
     if (quarters > 0) then
       write (quarters, ' quarter(s), ');
     if (dimes > 0) then
       write (dimes, ' dime(s), ');
     if (nickels > 0) then
       write (nickels, ' nickel(s), ');
     if (pennies > 0) then
       write (pennies, ' penny(s), ');
     writeln;
     writeln ('        and kick the machine ', overage, ' time(s)!');
     writeln;
   end;
  close(infile);
end.
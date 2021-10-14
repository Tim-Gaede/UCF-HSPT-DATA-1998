program Yoyo;

var
  i, numdata : integer;
  inputch : char;
  inputval : integer;
  InFile : text;

begin
  assign (InFile, 'yoyo.in');
  reset (InFile);
  readln (InFile, numdata);
  for i := 1 to numdata do
   begin
    readln (InFile, inputch);
    inputval := ord(inputch);
    write (inputval div 128);
    inputval := inputval mod 128;
    write (inputval div 64);
    inputval := inputval mod 64;
    write (inputval div 32);
    inputval := inputval mod 32;
    write (inputval div 16);
    inputval := inputval mod 16;
    write (inputval div 8);
    inputval := inputval mod 8;
    write (inputval div 4);
    inputval := inputval mod 4;
    write (inputval div 2);
    inputval := inputval mod 2;
    writeln (inputval div 1);
   end;
  close (InFile);
end.
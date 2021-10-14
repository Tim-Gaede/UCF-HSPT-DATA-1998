program friends;

var
   infile:text;

   nplayers:integer;    { Number of players }
   nscores:integer;     { Number of scores  }
   n:integer;           { Loop control var  }


function addline(len:integer):integer;

var
   num:integer;         { Integer read from file }
   total:integer;       { Total of all integers }
   i:integer;           { Loop control var }

begin

     {Initialize total}
     total := 0;

     for i:=1 to len do
      begin

          read(infile,num);             { Read in num }
          total := total + num;         { Add num to total }
      end;

     readln(infile);            { Go to next line in infile }

     addline:=total;            { Return total }

end; {addline}


begin {main}

  assign(infile,'friends.in');
  reset(infile);

  { Read in nplayers and nscores }
  read(infile,nplayers);
  readln(infile,nscores);

  for n:=1 to nplayers do
      writeln(addline(nscores));

  close(infile);

end.


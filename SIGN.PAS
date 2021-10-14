program sign;

var
   infile:text;
   rot,blink:double;            { Rotation and blinking rates }
   nsigns:integer;              { Number of signs }
   csign:integer;               { Current sign }
   ntests:integer;              { Number of tests for current sign }
   ctest:integer;               { Current test }
   tindex:double;               { Time index to test }


function findAngle(time:double):double;

var
   angle:double;        { Current angle of the sign }
   circles:double;      { Used to find the angle in the range [0,360) }
   incidence:double;    { Angle of incidence of the sign wrt Mike }

begin

     { Find the current angle of the sign }

     circles := trunc( time / rot );
     angle := ((time / rot) * 360) - (circles*360);


     { Now, compute the angle of incidence }

     if (angle >= 270) then       incidence := angle - 270
     else if (angle >= 180) then  incidence := 270 - angle
     else if (angle >= 90)  then  incidence := angle - 90
     else                         incidence := 90 - angle;

     findAngle := incidence;  { Return the angle of incidence }
end;


function checkBlink(time:double):boolean;

var
   interval:double;     { Used to reduce the time index to an
                          interval of 2*blink }

   simpletime:double;   { The offset of time within the corresponding
                          interval }

begin

     interval := trunc( time / (2*blink) );
     simpletime := time - (interval * 2*blink);

     { The sign is on if time falls in the second half
       of the 2*blink interval, so: }

     if  (simpletime >= blink) then
         checkBlink := true
     else
         checkBlink := false;
end;


function checkSign(time:double):boolean;

var
   angle:double;
   on:boolean;

begin
     if (rot<>0) then
        angle := findAngle(time)    { Get angle of incidence if
                                      the sign is rotating }
     else
        angle := 90;                { The sign's not rotating! }

     if (blink<>0) then
         on := checkBlink(time)      { Check if the sign is on only
                                       if it's blinking}
     else
         on := false;                { The sign's always dead! }


     if ( (angle > 10) and on) then

         checkSign := true
     else
         checkSign := false;
end;


begin {main}

      {Open input file}
      assign(infile,'sign.in');
      reset(infile);

      {Get number of signs}
      readln(infile,nsigns);

      for csign:=1 to nsigns do
       begin

            {Get sign parameters}
            read(infile,rot);
            readln(infile,blink);

            {Get number of tests}
            readln(infile,ntests);

            {Start the output for this sign}
            writeln('Sign #',csign,':');

            for ctest:=1 to ntests do
             begin

                  {Get time index for this test}
                  readln(infile,tindex);

                  if (checkSign(tindex)) then

                     writeln('   Mike sees it!')
                  else
                     writeln('   Mike is blind.');
             end;

            writeln;
       end;
end.
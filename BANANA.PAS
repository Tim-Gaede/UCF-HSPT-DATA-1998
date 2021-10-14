program Banana;


function min(a : longint; b : longint) : longint;
begin
  if (a < b) then
    min := a
  else
    min := b;
end;


function CalculateTrip(MilesPerStop : integer) : longint;
var
  BananasAtThisStop : longint;
  CurMile : integer;
  BananasAtNextStop : longint;
  MilesToNextStop   : longint;
  BananasOnCamel    : longint;
begin
  BananasAtThisStop := 100000;
  CurMile := 0;


  if (MilesPerStop <= 0) or (MilesPerStop >= 250) then
    CalculateTrip := 0
  else
  begin
    while CurMile < 500 do
    begin
      BananasAtNextStop := 0;
      MilesToNextStop := min((500 - CurMile), MilesPerStop);

      while (BananasAtThisStop > MilesToNextStop * 2) do
      begin
        BananasOnCamel := min(BananasAtThisStop, 500);
        Dec(BananasAtThisStop, BananasOnCamel);
        Dec(BananasOnCamel, MilesToNextStop);                      {camel ate these bananas on the way to next stop}
        if (BananasAtThisStop > MilesToNextStop * 2) then          {okay, it's worth it to make another trip back}
          Inc(BananasAtNextStop, BananasOnCamel - MilesToNextStop) {offload bananas, but keep enough bananas for return trip}
        else
          Inc(BananasAtNextStop, BananasOnCamel);                  {offload all bananas; not going back to last spot}
      end;

      Inc(CurMile, MilesToNextStop);
      BananasAtThisStop := BananasAtNextStop;

    end;
    CalculateTrip := BananasAtThisStop;
  end;
end;


var
  nMilesPerStop : integer;
  nTotal : longint;
  InFile, OutFile : Text;

begin {main}
  assign(InFile, 'banana.in');
  reset(InFile);
  assign(OutFile, 'banana.out');
  rewrite(OutFile);

  repeat
    ReadLn(InFile, nMilesPerStop);
    if (nMilesPerStop > 0) then
    begin
      nTotal := CalculateTrip(nMilesPerStop);
      WriteLn(OutFile, 'By moving the bananas ', nMilesPerStop,
              ' miles per step, ', nTotal,
              ' bananas get to market.');
    end;
  until nMilesPerStop <= 0;
  close(InFile);
  close(OutFile);

end.

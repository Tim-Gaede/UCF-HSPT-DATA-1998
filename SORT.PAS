program Sort;

type TWord  = record
  Text      : string[20];
  idxPrefix : integer;
end;

var
  Prefixes  : array[1..100] of string[20];
  nPrefixes : integer;

  Words     : array[1..1000] of TWord;
  nWords    : integer;

  InFile    : Text;
  OutFile   : Text;


function HasPrefix(Prefix : string; Text : string) : boolean;
var
  temp : string;
begin
  HasPrefix := false;
  if length(Text) >= Length(Prefix) then
  begin
    Delete(Text, length(Prefix)+1, 255); { strip off everything but the prefix }
    HasPrefix := Prefix = Text;
  end;
end;



{ This function looks through each word in the Words[] array and
   figures out the appropriate prefix to file this word under.
}
procedure FindPrefixesForWords;
var
  loop, loop2 : integer;
  idxBestMatch, LengthOfBestMatch : integer;
  temp : integer;
begin

  for loop := 1 to nWords do
  begin
    idxBestMatch := 0;
    LengthOfBestMatch := 0;
    for loop2 := 1 to nPrefixes do
    begin
      temp := length(Prefixes[loop2]);

      if HasPrefix(Prefixes[loop2], Words[loop].Text) then
      begin {the word matches this prefix. Is it the longest matching prefix so far?}
        if LengthOfBestMatch < temp then
        begin
          LengthOfBestMatch := temp;
          idxBestMatch := loop2;
        end;
      end;
    end;

    Words[loop].idxPrefix := idxBestMatch;
  end;

end;




{ This function takes an array of indices into the Words[] array,
   and sort them. }
procedure SortWordsOfSamePrefix(var WordsToSort : array of integer; nWordsToSort : integer);
var
  loop, loop2, temp : integer;
  hi, lo : integer;
begin
  lo := Low(WordsToSort);
  hi := lo + nWordsToSort - 1;

  {bubble-sort}
  for loop := hi downto lo+1 do
    for loop2 := lo to loop-1 do
    begin
      if Words[WordsToSort[loop2]].Text > Words[WordsToSort[loop2+1]].Text then
      begin
        temp := WordsToSort[loop2];
        WordsToSort[loop2] := WordsToSort[loop2+1];
        WordsToSort[loop2+1] := temp;
      end;
    end;
end;



procedure PrintWordsForPrefix(idxPrefix : integer);
var
  loop : integer;
  MatchingWords : array[1..1000] of integer;
  nMatchingWords : integer;
  Prefix  : string[21];

begin
  nMatchingWords := 0;
  {we don't print anything if no words match this prefix, so first see if}
  {any words match this prefix}

  for loop := 1 to nWords do
    if Words[loop].idxPrefix = idxPrefix then
    begin
      inc(nMatchingWords);
      MatchingWords[ nMatchingWords ] := loop;
    end;

  if nMatchingWords > 0 then
  begin
    {words match this prefix. Print the prefix name}
    Prefix := Prefixes[idxPrefix];
    Prefix[1] := upcase(Prefix[1]);
    WriteLn(OutFile, Prefix);

    {sort all the entries of this prefix}
    SortWordsOfSamePrefix(MatchingWords, nMatchingWords);

    {print the entries for this prefix}
    for loop := 1 to nMatchingwords do
      WriteLn(OutFile, '  ', Words[MatchingWords[loop]].Text);

    WriteLn(OutFile);
  end;
end;



var
  DictionaryCount : integer;
  loop : integer;
  s : string;

begin {main}
  DictionaryCount := 0;

  assign(InFile, 'sort.in');
  reset(InFile);
  assign(OutFile, 'sort.out');
  rewrite(OutFile);

  repeat
    ReadLn(InFile, nPrefixes);
    if nPrefixes > 0 then
    begin
      {load in the data}
      for loop := 1 to nPrefixes do
      begin
        ReadLn(InFile, s);
        Prefixes[loop] := s;
      end;

      ReadLn(InFile, nWords);
      for loop:= 1 to nWords do
      begin
        ReadLn(InFile, s);
        Words[loop].Text := s;
      end;

      {find the prefix of each word}
      FindPrefixesForWords;

      {print the Dictionary # header}
      inc(DictionaryCount);
      WriteLn(OutFile, '---Dictionary #', DictionaryCount, '---');
      {for each prefix that has words matching it, print the prefix & words}
      for loop := 1 to nPrefixes do
        PrintWordsForPrefix(loop);
    end;
  until nPrefixes <= 0;

  close(OutFile);
  close(InFile);

end.

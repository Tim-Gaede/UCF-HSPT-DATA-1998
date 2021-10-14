program pepper;

var infile:text;
    numSets:integer;
    i:integer;
    numPeppers:integer;
    numSentences:integer;
    j:integer;
    sentence:string;
    k:integer;
    count:integer;

begin
   (* Open the input file *)
   assign(infile, 'pepper.in');
   reset(infile);

   (* Process each set *)
   readln(infile, numSets);
   for i:=1 to numSets do
   begin
      (* Print the header *)
      writeln('Data Set #', i, ':');
      writeln;

      readln(infile, numPeppers, numSentences);

      (* Process each sentence in the set *)
      for j:=1 to numSentences do
      begin
         (* Read and print the sentence *)
         readln(infile, sentence);
         writeln(sentence);

         (* Go to all upper-case for ease of checking *)
         for k:=1 to length(sentence) do
            sentence[k]:=upcase(sentence[k]);

         (* Count how many times the substring "PEPPER" appears *)
         count:=0;
         for k:=1 to length(sentence)-5 do
         begin
            if copy(sentence, k, 6) = 'PEPPER' then
               count:=count + 1;
         end;

         (* Check to see if we counted too many and output appropriately *)
         if count > numPeppers then
            writeln('Ah-choo!')
         else
            writeln('Joel does not sneeze.');

         (* Don't forget the blank line *)
         writeln;
      end;

      (* Extra blank line between sets *)
      writeln;
   end;
end.

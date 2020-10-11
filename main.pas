uses consts, types, parsing;//;, const, parsing;

var
 InFile, OutFile: text;
 Reg, SecReg: TLong;
 correct: boolean;
 NLine: integer;
 Less: boolean;
begin
 correct:= true;
 NLine:=1;
 Assign(InFile, InfileName);
 Assign(OutFile, OutfileName);
 reset (InFile);
 FullZero (reg, secreg);
 while not EOF (InFile) and correct  do
   begin
   Correct:= ReadTlong (InFile, Reg, NLine);
   if (NLine >= 3) and (NLine mod 2 = 0) then
     secreg:= reg;
   Less:= Tless (reg, secreg); // true - reg > secreg, else reg < secreg
  // writeln ();
  // writeln (less);
  // writeln ();
   
   
   end;
 rewrite (OutFile);
 WriteTLong (OutFile, reg); 
 close (outfile);
end.
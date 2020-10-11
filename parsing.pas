unit parsing;

interface

uses types, consts;

function ReadTLong (var InFile: text; var Reg: TLong; var NLine: integer): boolean;
Procedure CheckLine (var line: string; var correct: boolean; const Nline: integer; var Reg:Tlong);
Procedure CheckLineMod (var line: string;var correct: boolean;const Nline:integer);
Procedure WriteTLong (const OutFile: text; const reg: Tlong);
Function Tless (const reg: tlong;const secreg: tlong): boolean;
Procedure FullZero (var reg, secreg: tlong);

implementation

Procedure FullZero (var reg, secreg: tlong);
var
  i: integer;
begin
  for i:=1 to n do
  begin
    reg.data[1]:= '0';
    secreg.data[1]:= '0';
  end;
end;
Procedure CheckLine (var line: string; var correct: boolean; const Nline: integer; var Reg: Tlong);
 var
  i: integer;
  k: byte;
  correctable: boolean;
 begin
 i:=1;
 if length(line) > 300 then
  begin
   correct:= false;
   writeln ('Количество элементов в ',Nline,' превышает 300');
  end;
 if (line[1] = '-') and (length(line)>1) and (correct) then
  begin
  reg.sign:=false;
  Delete (line,1,1);
  end
 else
  reg.sign:=true;
 while (i<=length(line)) and correct do
  begin
  k:=1;
  correctable:=false;
  while (k<=8) and not correctable  do
   begin
   //write (line[i],' = ',numbers[k],' / ');
   if line[i] <> Numbers[k] then
    begin
    correctable:=false;
    end
    else
    correctable:=true;
    k:=k+1;
    end;
   if not correctable then
    begin
    writeln();
    writeln ('В ',Nline,' строке ', i,' элемент не цифра');
    correct:=false;
    end;
   i:=i+1;
  end;
end;

Procedure CheckLineMod (var line: string;var correct: boolean;const Nline:integer);
 begin
 if  (line <> '+') and (line <> '-') then
  begin
  correct:=false;
  writeln ('Знак операции в строке ', Nline,' указан неверно'); 
  writeln (line,' ', length(line));
  end;
 end;

Procedure SummTLong(Reg, Summ: Tlong);

begin



end;
function ReadTLong (var InFile: text; var Reg: Tlong; var NLine: integer): boolean;
 var
  correct: boolean;
  line: string;
  Transf: string[3];
  Inter,i: integer;
  summ: Tlong;
 begin
 correct:= true;
 line:= '';
 readln (infile, line);
 writeln (line);
 if (Nline mod 2 <> 0) then
   CheckLine (line, Correct, Nline, reg)
  else
  CheckLineMod (line, correct, Nline);
  if (correct) and (Nline mod 2 <> 0) then
   begin
    inter:=0;
    while (length(line)>1) and (line[1] = '0') do
     delete (line,1,1);
    if (length(line) mod 4 = 0) then
     inter:=1 + length(line) div 4
    else
     inter:=2 + length(line) div 4;
     reg.data[1]:=InttoStr(inter);
     write ();
   for i:=2 to inter+1 do
    begin
     reg.data[i]:=Copy(line, length(line)-3, 4);
     Delete (line, length(line)-3, 4);
    end;
    for i:=1 to strtoint(reg.data[1]) do
     write (reg.data[i],' / ');
    writeln();
    for i:=1 to inter do
     begin
      summ.data[i]:= reg.data[i];
      summ.sign:= reg.sign;
     end;
   end; 
  Nline:= Nline+1;
  result:=correct;
 end;

 
 
 Function Tless (const reg: tlong;const secreg: tlong):boolean;
 var
   k, i, fst, scn: integer;
   reason: boolean;
 begin
   reason:= true;
   if (reg.data[1] <> '0') and (secreg.data[1] <> '0') then
   begin
   if strtoint(reg.data[1]) > strtoint(secreg.data[1]) then
     k:= strtoint(reg.data[1])
   else
     k:= strtoint(reg.data[1]);
   writeln ('k=',k);
   write (strtoint(reg.data[3]));
   writeln ();
   while (k <= 2) and (reason)  do
   begin
     fst:= strtoint (reg.data[k]);
     scn:= strtoint (secreg.data[k]);
     if fst > scn then
     begin
      reason:= false;
      result:= true
     end
     else
       if fst < scn then
         begin
          reason:= false;
          result:= false
         end
       else
         k:= k-1
     end;
  end;
 end;
 
 Procedure WriteTLong (const OutFile: text; const reg: Tlong);
 var i: integer;
 begin
   if reg.sign then
     write (outfile, '+')
   else
     write (outfile, '-');
   if reg.data[1] <> '0' then
    for i:= strtoint(reg.data[1]) downto 2 do
      write (outfile, reg.data[i]);
 end;
 
end.
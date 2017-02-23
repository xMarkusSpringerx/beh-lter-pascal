PROGRAM WC_ADS_Test;

USES WC_ADS;
VAR t : TreePtr;

BEGIN
  t := NIL;
  
  (*binäre Suche*)
  Insert(t, 'a');
  Insert(t, 'b');
  Insert(t, 'c');
  Insert(t, 'd');
  Insert(t, 'a');
  Insert(t, 'c');
  Insert(t, 'd');
  Insert(t, 'b');
  Insert(t, 'a');

  WriteLn();

  WriteTreeInOrder(t); 
  WriteLn();
  WriteLn('remove "c":');

  Remove(t, 'c');
  Remove(t, 'c');

  WriteTreeInOrder(t); 


  WriteLn();
  WriteLn('Enthält Zeichen "a"? --> ', Contains(t, 'a'));


  DisposeTree(t);
  
  ReadLn();
END.
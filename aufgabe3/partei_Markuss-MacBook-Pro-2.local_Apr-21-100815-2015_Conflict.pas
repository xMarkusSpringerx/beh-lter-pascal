PROGRAM WC_ADT_Test;

  USES
    WS_ADT;

  
  VAR
    wordSet1, wordSet2 : WordSet;
    
BEGIN
  InitWordSet(wordSet1);
  InitWordSet(wordSet2);

  (*I-*)
  Assign(inFile, repl_file);
  Reset(inFile);
  IF IOResult <> 0 THEN BEGIN
    WriteLn('ERROR');
    HALT;
  END;
  (*I+*)
  WHILE NOT Eof(inFile) DO BEGIN
    ReadLn(inFile, single_line);
  END;

END.
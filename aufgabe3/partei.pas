PROGRAM WC_ADT_Test;

  USES
    WS_ADT, WordReader;

  CONST
    //path = 'Hagenberg/ADF & PRG/Uebung4/aufgabe3/';
    path = '';
    
  PROCEDURE WriteTxtToWordSet(VAR ws : WordSet; filename : STRING);
  VAR
    w: Word;

  BEGIN (*WordCounter*)
    
    OpenFile(path+'Parteiprogramme/'+filename, toLower);

    ReadWord(w);
    WHILE w <> '' DO BEGIN
      (*insert word in data structure and count its occurence*)
      Insert(ws, w);
      ReadWord(w);
    END; (*WHILE*)
    CloseFile;
  END;

  VAR
  grueneWS, spoeWS, oevpWS, fpoeWS: WordSet;
  res_wordSet : WordSet;
     

BEGIN
  InitWordSet(grueneWS);
  InitWordSet(spoeWS);
  InitWordSet(oevpWS);
  InitWordSet(fpoeWS);
  InitWordSet(res_wordSet);
  
  WriteTxtToWordSet(grueneWS, 'gruene.txt');
  WriteTxtToWordSet(spoeWS, 'spoe.txt');
  WriteTxtToWordSet(oevpWS, 'oevp.txt');
  WriteTxtToWordSet(fpoeWS, 'fpoe.txt');


    res_wordSet := Intersection(grueneWS, oevpWS);
    WriteLn('gruene geschnitten oevp: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Intersection(grueneWS, fpoeWS);
    WriteLn('gruene geschnitten fpoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Intersection(grueneWS, spoeWS);
    WriteLn('gruene geschnitten spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Intersection(oevpWS, fpoeWS);
    WriteLn('oevp geschnitten fpoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Intersection(oevpWS, spoeWS);
    WriteLn('oevp geschnitten spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Intersection(fpoeWS, spoeWS);
    WriteLn('fpoe geschnitten spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    WriteLn; (*Leerzeile für bessere Lesbarkeit*)
    res_wordSet := Union(grueneWS, oevpWS);
    WriteLn('gruene vereint mit oevp: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Union(grueneWS, fpoeWS);
    WriteLn('gruene vereint mit fpoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Union(grueneWS, spoeWS);
    WriteLn('gruene vereint mit spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Union(oevpWS, fpoeWS);
    WriteLn('oevp vereint mit fpoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Union(oevpWS, spoeWS);
    WriteLn('oevp vereint mit spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Union(fpoeWS, spoeWS);
    WriteLn('fpoe vereint mit spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    WriteLn; (*Leerzeile für bessere Lesbarkeit*)
    res_wordSet := Difference(grueneWS, oevpWS);
    WriteLn('gruene ohne oevp: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Difference(grueneWS, fpoeWS);
    WriteLn('gruene ohne fpoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Difference(grueneWS, spoeWS);
    WriteLn('gruene ohne spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Difference(oevpWS, fpoeWS);
    WriteLn('oevp ohne fpoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Difference(oevpWS, spoeWS);
    WriteLn('oevp ohne spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
    res_wordSet := Difference(fpoeWS, spoeWS);
    WriteLn('fpoe ohne spoe: ', Cardinality(res_wordSet));
    DisposeWS(res_wordSet);
  ReadLn();
END.
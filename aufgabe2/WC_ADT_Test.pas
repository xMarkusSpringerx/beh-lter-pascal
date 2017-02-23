PROGRAM WC_ADT_Test;

  USES
    WC_ADT;

  
  VAR
    tree1, tree2 : Tree;
    
BEGIN
  tree1 := NIL;
  WriteLn('Tree1: ');
  (*binäre Suche*)
  Insert(tree1, 'a');
  Insert(tree1, 'b');
  Insert(tree1, 'c');
  Insert(tree1, 'd');
  Insert(tree1, 'a');
  Insert(tree1, 'c');
  Insert(tree1, 'd');
  Insert(tree1, 'b');
  Insert(tree1, 'a');

  WriteLn();

  WriteTreeInOrder(tree1); 
  WriteLn();
  WriteLn('remove "c":');

  Remove(tree1, 'c');
  Remove(tree1, 'c');

  WriteTreeInOrder(tree1); 


  WriteLn();
  WriteLn('Enthält Zeichen "a"? --> ', Contains(tree1, 'a'));

  DisposeTree(tree1);
  WriteLn('_______________');
  tree2 := NIL;
  WriteLn('Tree2: ');
  (*binäre Suche*)
  Insert(tree2, 'x');
  Insert(tree2, 'y');
  Insert(tree2, 'z');
  Insert(tree2, 'w');
  Insert(tree2, 'a');
  Insert(tree2, 'c');
  Insert(tree2, 'd');
  Insert(tree2, 'b');
  Insert(tree2, 'a');

  WriteLn();

  WriteTreeInOrder(tree2); 
  WriteLn();
  WriteLn('remove "z":');

  Remove(tree2, 'z');

  WriteTreeInOrder(tree2); 


  WriteLn();
  WriteLn('Enthält Zeichen "p"? --> ', Contains(tree2, 'p'));

  DisposeTree(tree1);
  
  ReadLn();
END.
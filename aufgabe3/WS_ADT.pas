UNIT WS_ADT;

  INTERFACE
    
    TYPE
      WordSet = POINTER;
    

    PROCEDURE InitWordSet(VAR ws: WordSet);

    PROCEDURE Insert(VAR ws : WordSet; word : STRING);

    FUNCTION Contains(ws : WordSet; word :STRING) : BOOLEAN;

    FUNCTION IsEmpty(ws : WordSet) : BOOLEAN;

    PROCEDURE Remove(VAR ws : WordSet; word : STRING);

    PROCEDURE WriteWordSetInOrder(ws : WordSet);


    FUNCTION Union(s1, s2: WordSet): WordSet;

    FUNCTION Intersection(s1, s2: WordSet): WordSet;

    FUNCTION Difference(s1, s2: WordSet): WordSet;

    FUNCTION Cardinality(ws : WordSet): LONGINT;

    PROCEDURE DisposeWS(VAR ws: WordSet);

    
  IMPLEMENTATION
    
    TYPE
        NodePtr = ^NodeRec;
        NodeRec = RECORD
          word : STRING;
          left, right: NodePtr;
        END;

        
  FUNCTION NewNode(word : STRING) : NodePtr;
  VAR 
    n : NodePtr;
  BEGIN
    New(n);
    n^.word := word;
    n^.left := NIL;
    n^.right := NIL;
    NewNode := n;
  END;


  PROCEDURE InitWordSet(VAR ws: WordSet);
  BEGIN
    ws := NIL;
  END;

  PROCEDURE Insert(VAR ws : WordSet; word : STRING);
  BEGIN
    IF (NodePtr(ws) = NIL) THEN BEGIN
      ws := NewNode(word);
    END ELSE BEGIN
      IF (word <> NodePtr(ws)^.word) THEN BEGIN    
        IF(word < NodePtr(ws)^.word) THEN BEGIN
          Insert(NodePtr(ws)^.left, word);
        END ELSE BEGIN
          Insert(NodePtr(ws)^.right, word);
        END;
      END;
    END;
  END;
  

  FUNCTION IsEmpty(ws : WordSet) : BOOLEAN;
  BEGIN
    IsEmpty := (NodePtr(ws) = NIL);
  END;

  FUNCTION Contains(ws : WordSet; word :STRING) : BOOLEAN;
  BEGIN
    IF (ws = NIL) THEN BEGIN
      Contains := FALSE;
    END ELSE IF (NodePtr(ws)^.word = word) THEN BEGIN
      Contains := TRUE;
    END ELSE IF (word < NodePtr(ws)^.word) THEN BEGIN
      Contains := Contains(NodePtr(ws)^.left, word);
    END ELSE BEGIN
      Contains := Contains(NodePtr(ws)^.right, word);
    END;
  END;

  PROCEDURE DisposeWS(VAR ws: WordSet);
  BEGIN
    IF NodePtr(ws) <> NIL THEN BEGIN
      DisposeWS(NodePtr(ws)^.left);
      DisposeWS(NodePtr(ws)^.right);
      Dispose(NodePtr(ws));
      ws := NIL;
    END; (*IF*)
  END; (*DisposeWS*)


  PROCEDURE Remove(VAR ws : WordSet; word : STRING);
  
    PROCEDURE DisposeAndReplaceNode(parent, cur, replacement : NodePtr);
    BEGIN
      IF parent = NIL THEN BEGIN
        ws := cur^.left;
        Dispose(cur);
      END ELSE BEGIN
        IF word <= parent^.word THEN
          parent^.left := replacement
        ELSE
          parent^.right := replacement;
        
        Dispose(cur);
      END;(*ELSE*)
    END;
  
  VAR
    cur, parent, leftNode, parentOfLeftNode : NodePtr;
  BEGIN
   (*find node with word*)
    parent := NIL;
    cur := ws;
    
    WHILE(cur <> NIL) AND (cur^.word <> word) DO BEGIN
      IF(word <= cur^.word) THEN BEGIN
        parent := cur;
        cur := cur^.left;
      END ELSE BEGIN
        parent := cur;
        cur := cur^.right;
      END;
    END;
    IF (cur <> NIL) THEN BEGIN (*node with word has been found*)
      IF cur^.right = NIL THEN BEGIN
        (*cur has no right child*)
        DisposeAndReplaceNode(parent, cur, cur^.left);
      END ELSE IF (cur^.right^.left = NIL) THEN BEGIN
        (*right child of cur has no left child*)
        cur^.right^.left := cur^.left;
        DisposeAndReplaceNode(parent, cur, cur^.right);
      END ELSE BEGIN
        (*search left most node in right sub-tree*)
        parentOfLeftNode := cur^.right;
        leftNode := parentOfLeftNode^.left; (*cur^.right^.left*)
        WHILE leftNode^.left <> NIL DO BEGIN
          parentOfLeftNode := leftNode;
          leftNode := leftNode^.left;
        END;
        leftNode^.left := cur^.left;
        parentOfLeftNode^.left := leftNode^.right;
        leftNode^.right := cur^.right;
        DisposeAndReplaceNode(parent, cur, leftNode);
      END;
    END;
  END;

  PROCEDURE WriteWordSetInOrder(ws : WordSet);
  BEGIN
    IF(ws <> NIL) THEN BEGIN
      WriteWordSetInOrder(NodePtr(ws)^.left);
      Write(NodePtr(ws)^.word, ' ');
      WriteWordSetInOrder(NodePtr(ws)^.right);
    END; (* ELSE DO NOTHING *)

  END;



  FUNCTION Union(s1, s2: WordSet):WordSet;

    PROCEDURE Unite(ws : WordSet; VAR res_ws : WordSet);
    BEGIN
      IF(ws <> NIL) THEN BEGIN
        Unite(NodePtr(ws)^.left, res_ws);
        Insert(res_ws, NodePtr(ws)^.word);
        Unite(NodePtr(ws)^.right, res_ws);
      END;
    END; 

  VAR
    res_ws : WordSet;
  
  BEGIN
    InitWordSet(res_ws);
    Unite(s1, res_ws);
    Unite(s2, res_ws);
    Union := res_ws;

  END;


  FUNCTION Intersection(s1, s2: WordSet): WordSet;
  VAR
    comparison_ws : WordSet;

    PROCEDURE Intersect(ws : WordSet; VAR res_ws : WordSet);
    BEGIN
      IF(ws <> NIL) THEN BEGIN
        Intersect(NodePtr(ws)^.left, res_ws);
        IF(Contains(comparison_ws, NodePtr(ws)^.word)) THEN BEGIN
          Insert(res_ws, NodePtr(ws)^.word);
        END;
        Intersect(NodePtr(ws)^.right, res_ws);

      END;
    END; 

  VAR
    res_ws : WordSet;
  
  BEGIN
    InitWordSet(res_ws);

    comparison_ws := s2;
    Intersect(s1, res_ws);

    comparison_ws := s1;
    Intersect(s2, res_ws);
    Intersection := res_ws;
  END;


  FUNCTION Difference(s1, s2: WordSet): WordSet;
  VAR
    comparison_ws : WordSet;

    PROCEDURE Diff(ws : WordSet; VAR res_ws : WordSet);
    BEGIN
      IF(ws <> NIL) THEN BEGIN
        Diff(NodePtr(ws)^.left, res_ws);
        IF(Contains(comparison_ws, NodePtr(ws)^.word) = FALSE) THEN BEGIN
          Insert(res_ws, NodePtr(ws)^.word);
        END;
        Diff(NodePtr(ws)^.right, res_ws);
      END;
    END; 

  VAR
    res_ws : WordSet;
  
  BEGIN
    InitWordSet(res_ws);
    comparison_ws := s2;
    Diff(s1, res_ws);
    comparison_ws := s1;
    Diff(s2, res_ws);
    Difference := res_ws;
  END;

  // Count number of leaves
  FUNCTION Cardinality(ws : WordSet): LONGINT;
  BEGIN
    IF ws = NIL THEN BEGIN
      Cardinality := 0;
    END ELSE BEGIN
      Cardinality := 1 + Cardinality(NodePtr(ws)^.right) + Cardinality(NodePtr(ws)^.left);
    END;
  END;
 
BEGIN

END.
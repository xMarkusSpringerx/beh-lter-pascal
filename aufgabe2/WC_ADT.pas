UNIT WC_ADT;

  INTERFACE
    
    TYPE
      Tree = POINTER;
      
    PROCEDURE InitTree(VAR t: Tree);
    FUNCTION isEmpty(t: Tree): BOOLEAN;
    PROCEDURE Insert(VAR t : Tree; s : STRING);
    FUNCTION Contains(t : Tree; val :STRING) : BOOLEAN;
    PROCEDURE Remove(VAR t : Tree; val : STRING);
    PROCEDURE WriteTreeInOrder(t : Tree);
    PROCEDURE DisposeTree(VAR t: Tree);
    
  IMPLEMENTATION
    
    TYPE
      NodePtr = ^NodeRec;
      NodeRec = RECORD
        left, right: NodePtr;
        val: STRING;
      END;
      
    PROCEDURE InitTree(VAR t: Tree);
    BEGIN
      t := NIL;
    END;

    PROCEDURE DisposeTree(VAR t: Tree);
    BEGIN
      IF NodePtr(t) <> NIL THEN BEGIN
        DisposeTree(NodePtr(t)^.left);
        DisposeTree(NodePtr(t)^.right);
        Dispose(NodePtr(t));
        t := NIL;
      END; (*IF*)
    END; (*DisposeWS*)
      
    FUNCTION isEmpty(t: Tree): BOOLEAN;
    BEGIN
      isEmpty := (NodePtr(t) = NIL);
    END;
      

    FUNCTION NewNode(s: STRING): NodePtr;
    VAR
      n: NodePtr;
    BEGIN
      New(n);
      n^.val := s;
      n^.left := NIL;
      n^.right := NIL;
      NewNode := n;
    END;

  PROCEDURE WriteTreeInOrder(t : Tree);
  BEGIN
    IF(t <> NIL) THEN BEGIN
      WriteTreeInOrder(NodePtr(t)^.left);
      Write(NodePtr(t)^.val, ' ');
      WriteTreeInOrder(NodePtr(t)^.right);
    END; (* ELSE DO NOTHING *)
  END;  


  PROCEDURE Insert(VAR t : Tree; s : STRING);
  BEGIN
    IF (t = NIL) THEN BEGIN
      t := NewNode(s);
    END ELSE BEGIN  
      IF(s <= NodePtr(t)^.val) THEN BEGIN
        Insert(NodePtr(t)^.left, s);
      END ELSE BEGIN
        Insert(NodePtr(t)^.right, s);
      END;
    END;
  END;
  
  FUNCTION Contains(t : Tree; val :STRING) : BOOLEAN;
  BEGIN
    IF (t = NIL) THEN BEGIN
      Contains := FALSE;
    END ELSE IF (NodePtr(t)^.val = val) THEN BEGIN
      Contains := TRUE;
    END ELSE IF (val < NodePtr(t)^.val) THEN BEGIN
      Contains := Contains(NodePtr(t)^.left, val);
    END ELSE BEGIN
      Contains := Contains(NodePtr(t)^.right, val);
    END;
  END;


  PROCEDURE Remove(VAR t : Tree; val : STRING);
  
    PROCEDURE DisposeAndReplaceNode(parent, cur, replacement : NodePtr);
    BEGIN
      IF parent = NIL THEN BEGIN
        t := cur^.left;
        Dispose(cur);
      END ELSE BEGIN
        IF val <= parent^.val THEN
          parent^.left := replacement
        ELSE
          parent^.right := replacement;
        
        Dispose(cur);
      END;(*ELSE*)
    END;
  
  VAR
    cur, parent, leftNode, parentOfLeftNode : NodePtr;
  BEGIN
   (*find node with val*)
    parent := NIL;
    cur := t;
    
    WHILE(cur <> NIL) AND (cur^.val <> val) DO BEGIN
      IF(val <= cur^.val) THEN BEGIN
        parent := cur;
        cur := cur^.left;
      END ELSE BEGIN
        parent := cur;
        cur := cur^.right;
      END;
    END;
    IF (cur <> NIL) THEN BEGIN (*node with val has been found*)
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
  
 
BEGIN

END.
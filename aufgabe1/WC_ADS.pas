UNIT WC_ADS;

INTERFACE

TYPE
  TreeNodePtr = ^TreeNode;
  TreeNode = RECORD
               val : STRING;
               left, right : TreeNodePtr;
             END;
  TreePtr = TreeNodePtr;



FUNCTION NewNode(val : STRING) : TreeNodePtr;
PROCEDURE WriteTreeInOrder(t : TreePtr);

PROCEDURE Insert(VAR t : TreePtr; val : STRING);

FUNCTION Contains(t : TreePtr; val :STRING) : BOOLEAN;

FUNCTION IsEmpty(t : TreePtr) : BOOLEAN;

PROCEDURE Remove(VAR t : TreePtr; val : STRING);

PROCEDURE DisposeTree(VAR t: TreePtr);

IMPLEMENTATION

  
  FUNCTION IsEmpty(t : TreePtr) : BOOLEAN;

  BEGIN
    IF t = NIL THEN BEGIN
      IsEmpty := TRUE;
    END ELSE BEGIN
      IsEmpty := FALSE;
    END;
  END;

  PROCEDURE DisposeTree(VAR t: TreePtr);
  BEGIN
    IF t <> NIL THEN BEGIN
      DisposeTree(t^.left);
      DisposeTree(t^.right);
      Dispose(t);
      t := NIL;
    END; (*IF*)
  END; (*DisposeTree*)

  PROCEDURE WriteTreeInOrder(t : TreePtr);
  BEGIN
    IF(t <> NIL) THEN BEGIN
      WriteTreeInOrder(t^.left);
      Write(t^.val, ' ');
      WriteTreeInOrder(t^.right);
    END; (* ELSE DO NOTHING *)
  END;

  FUNCTION NewNode(val : STRING) : TreeNodePtr;
  VAR 
    n : TreeNodePtr;
  BEGIN
    New(n);
    n^.val := val;
    n^.left := NIL;
    n^.right := NIL;
    
    NewNode := n;
  END;

  PROCEDURE Insert(VAR t : TreePtr; val : STRING);
  BEGIN
    IF (t = NIL) THEN BEGIN
      t := NewNode(val);
    END ELSE BEGIN  
      IF(val <= t^.val) THEN BEGIN
        Insert(t^.left, val);
      END ELSE BEGIN
        Insert(t^.right, val);
      END;
    END;
  END;
  
  FUNCTION Contains(t : TreePtr; val :STRING) : BOOLEAN;
  BEGIN
    IF (t = NIL) THEN BEGIN
      Contains := FALSE;
    END ELSE IF (t^.val = val) THEN BEGIN
      Contains := TRUE;
    END ELSE IF (val < t^.val) THEN BEGIN
      Contains := Contains(t^.left, val);
    END ELSE BEGIN
      Contains := Contains(t^.right, val);
    END;
  END;


  PROCEDURE Remove(VAR t : TreePtr; val : STRING);
  
    PROCEDURE DisposeAndReplaceNode(parent, cur, replacement : TreeNodePtr);
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
    cur, parent, leftNode, parentOfLeftNode : TreeNodePtr;
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
  

END.
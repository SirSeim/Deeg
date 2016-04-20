module.exports = {
  program1: '(Program (Block (VarDec \'x\' of type:undefined = 3)))',
  program2: '(Program (Block (VarDec \'fibonacci\' of type:undefined =
              (FunctionDef params:(Params (x)) type:undefined (Block
                (VarDec \'a\' of type:undefined = 0)
                (VarDec \'b\' of type:undefined = 1)
                (VarDec \'c\' of type:undefined = null)
                (If (BinaryOp < x 3) then (Return 1))
                (While (BinaryOp > x 0) then (Block
                  (VarAssign c value:(BinaryOp + a b))
                  (VarAssign a value:b)
                  (VarAssign b value:c)
                  (VarAssign x modifier:-- value:null)))
                (Return c))))))',
  program3: '(Program (Block (if true
                      (Block (Invoke print("hello"))) else if false
                      (Block (Invoke print("goodbye") else
                      (Block (Invoke print ("peace")))))))
                      (Block (if true
                      (Block (Invoke print ("Suhh Dude!"))))',
  program4: '(Program (Block (VarDec (gcd (Function (a,b)))))
                      (Block (if (!b)))
                      (Block  (Invoke (Return (deeg a))))
                              (Invoke gcd (b, a % b)))',
  program5: '(Program (Block (BinaryOp ** 3 (BinaryOp + 4 5))
                      (UnaryOp - (BinaryOp ** 2 (BinaryOp + 4 5)))
                      (BinaryOp ** 3 (BinaryOp ** 4 5))
                      (BinaryOp ** 2 (BinaryOp ** 1 (BinaryOp + (UnaryOp - 3) 1)))
                      (BinaryOp ** 2 (UnaryOp - (BinaryOp ** 3 (UnaryOp - 4))))))',
  programPM1: '(Program (Block
                (VarDec \'varMatch\' of type:undefined = 
                  (FunctionDef params:(Params (x)) type:undefined (Block 
                    (Match x with (PatBlock 
                      (PatLine (Patterns (Pattern 3))   
                        then (Return true))
                      (PatLine (Patterns (Pattern (WildCard)))  
                        then (Return false)))))))))',
  programPM2: '(Program (Block
                (VarDec \'listMatch\' of type:undefined =
                  (FunctionDef params:(Params (l)) type:undefined (Block
                    (Match l with (PatBlock
                      (PatLine (Patterns (Pattern head) | (Pattern tail))
                        then (Return head))
                      (PatLine (Patterns (Pattern (WildCard type:int)) | (Pattern tail))
                        then (Return true))
                      (PatLine (Patterns (Pattern (WildCard)) | (Pattern tail))
                        then (Return false)))))))))'
}

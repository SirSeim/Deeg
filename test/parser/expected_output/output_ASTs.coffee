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
  program3: '(Program (Block
              (If true then (Block
                (FunctionCall print params:((StringLiteral 68, 65, 6c, 6c, 6f))))
              (else if false then (Block
                (FunctionCall print
                  params:((StringLiteral 67, 6f, 6f, 64, 62, 79, 65))))))
              (If true then
                (FunctionCall print
                  params:((StringLiteral 53, 75, 68, 68, 20, 44, 75, 64, 65, 21))))))',
  program4: '(Program (Block
              (VarDec \'gcd\' of type:undefined =
                (FunctionDef params:(Params (a,b)) type:undefined (Block
                  (If (BinaryOp == b 0) then (Return a))
                  (Return (FunctionCall gcd params:(b, (BinaryOp % a b)))))))))',
  program5: '(Program (Block (BinaryOp ** 3 (BinaryOp + 4 5))
                      (UnaryOp - (BinaryOp ** 2 (BinaryOp + 4 5)))
                      (BinaryOp ** 3 (BinaryOp ** 4 5))
                      (BinaryOp ** 2 (BinaryOp ** 1 (BinaryOp + (UnaryOp - 3) 1)))
                      (BinaryOp ** 2 (UnaryOp - (BinaryOp ** 3 (UnaryOp - 4))))))',
  program6: '(Program (Block
              ((StdFor cat:undefined in cat_array, undefined) then (Block
                (FunctionCall print params:((BinaryOp +
                  (StringLiteral 6d, 72, 2e, 20) cat)))))
              ((StdFor duck:undefined in duck_array, ids and exps yay) then (Block
                (FunctionCall print params:((BinaryOp +
                  (BinaryOp + duck (StringLiteral 20, 61, 6e, 64, 20)) dog)))))
              ((For count int_expression) then (Block
                (FunctionCall print params:((StringLiteral 68, 65, 6c, 6c, 6f)))))
              ((For count 5) then (Block
                (FunctionCall print params:((StringLiteral 73, 75, 70)))))
              ((For [object Object] counts int_expression) then (Block
                (FunctionCall print params:((BinaryOp + i
                  (StringLiteral 20, 68, 65, 6c, 6c, 6f, 28, 73, 29))))))
              (While is_running then (Block
                (FunctionCall runFaster params:(undefined))))))',
  program7: '(Program (Block
              (VarDec \'x\' of type:undefined = 5)
              (VarAssign x modifier:+= value:5)
              (VarAssign x modifier:-= value:5)
              (VarAssign x modifier:/= value:5)
              (VarAssign x modifier:*= value:5)
              (VarAssign x modifier:%= value:5)
              (VarAssign x modifier:++ value:null)
              (VarAssign x modifier:-- value:null)))',
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
                        then (Return false)))))))))',
  programEko1: '(Program (Block
                  (VarDec \'x\' of type:undefined = 100)
                  (VarAssign x modifier:+= value:2)
                  (VarAssign x modifier:-= value:3)
                  (VarAssign x modifier:%= value:12)
                  (VarDec \'y\' of type:undefined = 1000)
                  (VarAssign y modifier:*= value:12)
                  (VarAssign y modifier:/= value:23)
                  (VarAssign y modifier:++ value:null)))',

  programEko2: '(Program (Block (Class circle extends shapes: (Block ))))',

  programEko3: '(Program (Block
                  (VarDec \'x\' of type:undefined = 32)
                  (If (BinaryOp and (BinaryOp < x 10) (BinaryOp > x 45)) then
                    (FunctionCall print params:((StringLiteral 65, 72, 72, 6f, 72)))
                  (else
                    (FunctionCall print
                      params:((StringLiteral 57, 6f, 6f, 68, 6f, 6f)))))))',

  programEko4: '(Program (Block
                  (VarDec \'friends_list\' of type:undefined =
                    [(StringLiteral 42, 6f, 62),
                    (StringLiteral 44, 6f, 6e, 6e, 61),
                    (StringLiteral 53, 68, 61, 67, 67, 79)])
                  (VarDec \'grades_list\' of type:[object Object] =
                    [99, 95, 90, 96])))',

  programEko5: '(Program (Block (FunctionCall print params:((StringLiteral 73, 64)))
                (FunctionCall print params:((StringLiteral 61, 62)))
                (FunctionCall print params:((StringLiteral 61, 62, 73)))
                (FunctionCall print params:((StringLiteral 65, 66)))))'
}

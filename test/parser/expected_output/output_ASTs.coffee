module.exports = {
  program1: '(Program (Block (VarDec \'x\' = 3)))',

  program2: '(Program (Block (VarDec \'fibonacci\' =
              (FunctionDef params:(Params (x)) type:undefined (Block
                (VarDec \'a\' = 0)
                (VarDec \'b\' = 1)
                (VarDec \'c\')
                (If (BinaryOp < x 3) then (Deeg 1))
                (While (BinaryOp > x 0) then (Block
                  (VarAssign c = value:(BinaryOp + a b))
                  (VarAssign a = value:b)
                  (VarAssign b = value:c)
                  (VarAssign x modifier:-- = value:null)))
                (Deeg c))))))',

  program3: '(Program (Block
              (If true then (Block
                (FunctionCall print params:((StringLiteral 68, 65, 6c, 6c, 6f))))
              (else if false then (Block
                (FunctionCall print params:((StringLiteral
                  67, 6f, 6f, 64, 62, 79, 65)))))
              (else if (BinaryOp > 3 0) then (Block
                (FunctionCall print params:((StringLiteral 70, 65, 61, 63, 65)))))
              (else (Block
                (FunctionCall print params:((StringLiteral
                  6e, 61, 6d, 61, 73, 74, 65))))))
              (If (BinaryOp > 4 0) then
                (FunctionCall calc params:(undefined))
              (else if (BinaryOp < 5 3) then
                (FunctionCall decalc params:(undefined)))
              (else if (BinaryOp < 8 5) then
                (FunctionCall decalc params:(undefined)))
              (else (FunctionCall print params:((StringLiteral 66, 61, 69, 6c)))))
              (If true then (FunctionCall calc params:(undefined))
              (else (FunctionCall decalc params:(undefined))))
              (If true then (FunctionCall print params:((StringLiteral
                53, 75, 68, 68, 20, 44, 75, 64, 65, 21))))))',

  program4: '(Program (Block
              (VarDec \'gcd\' = (FunctionDef params:(Params (a,b))
                  type:undefined (Block
                (If (BinaryOp == b 0) then (Deeg a))
                (Deeg (FunctionCall gcd params:(b, (BinaryOp % a b)))))))))',

  program5: '(Program (Block (BinaryOp ** 3 (BinaryOp + 4 5))
                      (UnaryOp - (BinaryOp ** 2 (BinaryOp + 4 5)))
                      (BinaryOp ** 3 (BinaryOp ** 4 5))
                      (BinaryOp ** 2 (BinaryOp ** 1 (BinaryOp + (UnaryOp - 3) 1)))
                      (BinaryOp ** 2 (UnaryOp - (BinaryOp ** 3 (UnaryOp - 4))))))',

  program6: '(Program (Block
              ((StdFor cat:undefined in cat_array) then (Block
                (FunctionCall print params:((BinaryOp +
                  (StringLiteral 6d, 72, 2e, 20) cat)))))
              ((StdFor duck:undefined in duck_array,
                dog:undefined in dog_array) then (Block
                  (FunctionCall print params:((BinaryOp +
                    (BinaryOp + duck (StringLiteral 20, 61, 6e, 64, 20)) dog)))))
              ((For count int_expression) then (Block
                (FunctionCall print params:((StringLiteral 68, 65, 6c, 6c, 6f)))))
              ((For count 5) then (Block
                (FunctionCall print params:((StringLiteral 73, 75, 70)))))
              ((For i counts int_expression) then (Block
                (FunctionCall print params:((BinaryOp +
                  i (StringLiteral 20, 68, 65, 6c, 6c, 6f, 28, 73, 29))))))
              ((For count 5) then (FunctionCall print
                params:((StringLiteral 77, 69, 6e))))
              (While is_running then (Block
                (FunctionCall runFaster params:(undefined))))
              (While true then (FunctionCall dive params:(undefined)))))',

  program7: '(Program (Block
              (VarDec \'x\' = 5)
              (VarAssign x modifier:+= = value:5)
              (VarAssign x modifier:-= = value:5)
              (VarAssign x modifier:/= = value:5)
              (VarAssign x modifier:*= = value:5)
              (VarAssign x modifier:%= = value:5)
              (VarAssign x modifier:++ = value:null)
              (VarAssign x modifier:-- = value:null)))',

  program8: '(Program (Block
              (VarDec \'addComplex\' = (FunctionDef
                  params:(Params (a,b)) type:undefined
                (Deeg (BinaryOp + a b))))
              (VarDec \'pointless\' = (FunctionDef
                  params:(Params (a,b)) type:undefined (Block
                (FunctionCall print params:(a))
                (FunctionCall print params:(b)))))
              (FunctionCall print params:((FunctionCall
                  addComplex params:((StringLiteral 61, 64, 64),
                    (StringLiteral 72, 65, 64, 75, 63, 65)))))
                (FunctionCall print params:(undefined))))',

  program9: '(Program (Block
              (TrailingIf (FunctionCall
                  print params:((StringLiteral 68, 65, 79))) if true else
                (FunctionCall print params:((StringLiteral 62, 79, 65))))
              (TrailingIf (FunctionCall
                print params:((StringLiteral 66, 69, 72, 65, 64))) if hired)))',

  program10: '(Program (Block
                (If (BinaryOp or (FunctionCall run params:(undefined))
                    (FunctionCall walk params:(undefined))) then (Block
                  (FunctionCall print params:((StringLiteral 6d, 6f, 76, 69, 6e, 67))))
                (else (Block (FunctionCall
                  print params:((StringLiteral 6c, 61, 7a, 79))))))
                (TrailingIf (FunctionCall print
                    params:((StringLiteral 6d, 6f, 76, 69, 6e, 67)))
                  if (BinaryOp or (FunctionCall run params:(undefined))
                    (FunctionCall walk params:(undefined)))
                  else (FunctionCall print
                    params:((StringLiteral 6c, 61, 7a, 79))))))',

  programPM1: '(Program (Block
                (VarDec \'varMatch\' =
                  (FunctionDef params:(Params (x)) type:undefined (Block
                    (Match x with (PatBlock
                      (PatLine (Patterns (Pattern 3)) then (Deeg true))
                      (PatLine (Patterns (Pattern (WildCard ))) then
                        (Deeg false)))))))))',

  programPM2: '(Program (Block
                (VarDec \'listMatch\' = (FunctionDef
                    params:(Params (l)) type:undefined (Block
                  (Match l with (PatBlock
                    (PatLine (Patterns
                      (Pattern head) | (Pattern tail)) then (Deeg head))
                    (PatLine (Patterns (Pattern
                      (WildCard  type:int)) | (Pattern tail)) then (Deeg true))
                    (PatLine (Patterns (Pattern
                      (WildCard )) | (Pattern tail)) then (Deeg false)))))))))',

  programEko1: '(Program (Block
                  (VarDec \'x\' = 100)
                  (VarAssign x modifier:+= = value:2)
                  (VarAssign x modifier:-= = value:3)
                  (VarAssign x modifier:%= = value:12)
                  (VarDec \'y\' = 1000)
                  (VarAssign y modifier:*= = value:12)
                  (VarAssign y modifier:/= = value:23)
                  (VarAssign y modifier:++ = value:null)))',

  programEko2: '(Program (Block
                  (Class circle extends shapes: (Block ))
                  (Class square extends circle:
                    (VarDec \'value\' = (StringLiteral 77, 74, 66)))
                  (Class rectangle extends shapes: (Block
                    (VarDec \'value\' = (StringLiteral 6e, 69, 63, 65))))))',

  programEko3: '(Program (Block
                  (VarDec \'x\' = 32)
                  (If (BinaryOp and (BinaryOp < x 10) (BinaryOp > x 45)) then
                    (FunctionCall
                      print params:((StringLiteral 65, 72, 72, 6f, 72)))
                  (else (FunctionCall
                    print params:((StringLiteral 57, 6f, 6f, 68, 6f, 6f)))))))',

  programEko4: '(Program (Block
                  (VarDec \'friends_list\' =
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

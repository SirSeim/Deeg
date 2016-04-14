module.exports = {
  program1: '(Program (Block (VarDec \'x\' of type:undefined = 3)))',
  program2: '(Program (Block (VarDec (fibonacci (Func (x))
                      (Block (VarDec (a 0) (VarDec (b 1) (VarDec (c))))
                      (Block (if (< x 3)
                      (Block deeg 1) else deeg c)
                      (Block (Return (while (> --x 0) c = a + b, a = b, b = c))))))))',
  program3: '(Program (Block (if true
                      (Block (Invoke print("hello"))) else if false
                      (Block (Invoke print("goodbye") else
                      (Block (Invoke print ("peace")))))))
                      (Block (if true
                      (Block (Invoke print ("Suhh Dude!"))))'                    
}

chai = require 'chai'
expect = chai.expect


Program = require '#{__dirname}/../../entities/program.coffee'
Block = require '#{__dirname}/../../entities/block.coffee'
Type = require '#{__dirname}/../../entities/type.coffee'

ForStatement = require '#{__dirname}/../../entities/forstatement.coffee'
StdFor = require '#{__dirname}/../../entities/stdfor.coffee'
StdForIdExp = require '#{__dirname}/../../entities/stdforidexp.coffee'
CountFor = require '#{__dirname}/../../entities/countfor.coffee'
CountsFor = require '#{__dirname}/../../entities/countsfor.coffee'
IfStatement = require '#{__dirname}/../../entities/ifstatement.coffee'
ElseIfStatement = require '#{__dirname}/../../entities/elseifstatement.coffee'
ElseStatement = require '#{__dirname}/../../entities/elsestatement.coffee'

# MatchStatement = require '#{__dirname}/../../entities/matchstatement.coffee'
#     this file doesn't exist yet
# PatBlock = require '#{__dirname}/../../entities/patblock.coffee'
# PatLine = require '#{__dirname}/../../entities/patline.coffee'
# Patterns = require '#{__dirname}/../../entities/patterns.coffee'
# Pattern = require '#{__dirname}/../../entities/pattern.coffee'

WhileStatement = require '#{__dirname}/../../entities/whilestatement.coffee'
ReturnStatement = require '#{__dirname}/../../entities/returnstatement.coffee'
ClassDefinition = require '#{__dirname}/../../entities/classdefinition.coffee'

VariableDeclaration = require '#{__dirname}/../../entities/variabledeclaration.coffee'
VariableAssignment = require '#{__dirname}/../../entities/variableassignment.coffee'
VariableExpression = require '#{__dirname}/../../entities/variableexpression.coffee'
Args = require '#{__dirname}/../../entities/args.coffee'
ExpList = require '#{__dirname}/../../entities/explist.coffee'

FunctionExp = require '#{__dirname}/../../entities/functionexp.coffee'
Params = require '#{__dirname}/../../entities/params.coffee'
ParamList = require '#{__dirname}/../../entities/paramlist.coffee'

TrailingIf = require '#{__dirname}/../../entities/trailingif.coffee'
VariableReference = require '#{__dirname}/../../entities/variablereference.coffee'
FieldAccess = require '#{__dirname}/../../entities/fieldaccess.coffee'
IterableItem = require '#{__dirname}/../../entities/iterableitem.coffee'
Range = require '#{__dirname}/../../entities/range.coffee'
IntegerLiteral = require '#{__dirname}/../../entities/integerliteral.coffee'
FloatLiteral = require '#{__dirname}/../../entities/floatliteral.coffee'
BooleanLiteral = require '#{__dirname}/../../entities/booleanliteral.coffee'
StringLiteral = require '#{__dirname}/../../entities/stringliteral.coffee'

List = require '#{__dirname}/../../entities/list.coffee'
Dict = require '#{__dirname}/../../entities/dict.coffee'
BindingList = require '#{__dirname}/../../entities/bindinglist.coffee'
Binding = require '#{__dirname}/../../entities/binding.coffee'
# Function = require '#{__dirname}/../../entities/function.coffee'
# i have no idea how this differs from FunctionExp

BinaryExpression = require '#{__dirname}/../../entities/binaryexpression.coffee'
UnaryExpression = require '#{__dirname}/../../entities/unaryexpression.coffee'


describe 'Entities', ->

  describe 'Program Entity', ->
    context 'when contructing a program', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new Program 'body').toString()).to.eql('(Program body)')
        done()

  describe 'Block Entity', ->
    context 'when contructing a block', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new Block ['Stmt', 'Stmt']).toString()).to.eql('(Block Stmt Stmt)')
        done()

  describe 'Type Entity', ->
    context 'when constructing a bool type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.BOOL).toString()).to.eql('bool')
        done()
    context 'when constructing a int type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.INT).toString()).to.eql('int')
        done()
    context 'when constructing a string type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.STRING).toString()).to.eql('string')
        done()
    context 'when constructing a float type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.FLOAT).toString()).to.eql('float')
        done()
    context 'when constructing a list type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.LIST).toString()).to.eql('List')
        done()
    context 'when constructing a dict type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.DICT).toString()).to.eql('Dict')
        done()
    context 'when constructing a function type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.FUNCTION).toString()).to.eql('Function')
        done()
    context 'when constructing an unknown type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.UNKNOWN).toString()).to.eql('¯\_(ツ)_/¯')
        done()

  # describe 'ForStatement Entity', ->
  #   context 'when constructing a type', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect(())

  describe 'VariableDeclaration Entity', ->
    context 'when constructing a variable declaration', ->
      it 'constructs and toStrings correctly', (done) ->
        token = {
          kind: 'id',
          lexeme: 'foo',
          line: 3,
          col: 1
        }
        expect((new VariableDeclaration token, 'bool', 3).toString())
          .to.eql('(VarDec \'foo\' of type:bool = 3)')
        done()

  describe "Args Entity" , ->
    context 'when constructing an args', ->
      it 'constructs and Args correctly', (done) ->
        expect((new Args 'expList').toString()).to.eql('(expList)')
        done()

  describe 'StdFor Entity', ->
    context 'when constructing a standard for', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new StdFor 'foo', 'int', 'dict', 'bar').toString())
          .to.eql('(StdFor foo:int in dict, bar)')
        done()

  # Maybe we don't need StdForIdExp.
  # describe 'StdForIdExp', -> #this is not correct. entity declaration is not finished
  #   context 'when constructing a standard for id expression', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect(new StdForIdExp ['(foo in bar)'], 'Body').toString()
  #       .to.eql('(StdForIdExp idexplist:(foo in bar) body:Body)')
  #       done()

  describe 'CountFor Entity', ->
    context 'when constructing a count for', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new CountFor 2).toString()).to.eql('(For count 2)')
        done()

  describe 'CountsFor Entity', ->
    context 'when constructing a counts for', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new CountsFor 'foo', 2).toString()).to.eql('(For foo counts 2)')
        done()

  describe 'IfStatement Entity', ->
    context 'when constructing an if statement', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new IfStatement ['foo in bar'], 'Body').toString())
          .to.eql('(If foo in bar then Body)')
        #incomplete, needs to account for if, elseif, else statements
        done()

  # describe 'WhileStatement Entity', ->
  #   context 'when constructing a while statement', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect((new WhileStatement foo in bar , 'Body' ).toString())
  #          .to.eql('(While foo in bar then Body)')
  #     needs some work
  #     done()

  describe 'ReturnStatement Entity', ->
    context 'when constructing a return statement of a string', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new ReturnStatement 'hello').toString()).to.eql('(Return hello)')
        done()
    context 'when constructing a return statement of an int', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new ReturnStatement 5).toString()).to.eql('(Return 5)')
        done()
    context 'when constructing a return statement of a boolean', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new ReturnStatement true).toString()).to.eql('(Return true)')
        done()

  describe 'IntegerLiteral Entity', ->
    context 'when constructing an integer literal', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new IntegerLiteral {lexeme:5}).toString()).to.eql(5)
        done()
    context 'when constructing an integer literal (0)', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new IntegerLiteral {lexeme:0}).toString()).to.eql(0)
        done()
    context 'when constructing a negative integer literal', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new IntegerLiteral {lexeme:-10}).toString()).to.eql(-10)
        done()

  describe 'FloatLiteral Entity', ->
    context 'when constructing a float literal', ->
      it 'constructs and toStrings correctly', (done) ->
        token = {
          value: 2.5
          lexeme: 2.5
        }
        expect((new FloatLiteral token).toString()).to.eql(2.5)
        done()
    context 'when constructing a negative float literal', ->
      it 'constructs and toStrings correctly', (done) ->
        token = {
          value: -2.5
          lexeme: -2.5
        }
        expect((new FloatLiteral token).toString()).to.eql(-2.5)
        done()



  
  describe 'BooleanLiteral Entity', ->
    context 'when constructing a boolean literal', ->
      it 'constructs and toStrings correctly (true)', (done) ->
        hiho = {
          kind: 'true'
          lexeme: 'true'
        }
        expect((new BooleanLiteral hiho).toString()).to.eql('true')
        done()
    context 'when constructing a boolean literal (false)', ->
      it 'constructs and toStrings correctly', (done) ->
        biho = {
          kind: 'false'
          lexeme: 'false'
        }
        expect((new BooleanLiteral biho).toString()).to.eql('false')
        done()

  describe 'StringLiteral Entity', ->
    context 'when constructing a string literal of one character', ->
      it 'constructs and toStrings correctly', (done) ->
        token = {
          lexeme: [
            '20'
          ]
        }
        expect((new StringLiteral token).toString()).to.eql('(StringLiteral 20)')
        done()
    context 'when constructing a string literal of multiple characters', ->
      it 'constructs and toStrings correctly', (done) ->
        string = {
          lexeme: [
            '20',
            '25',
            '2a'
          ]
        }
        expect((new StringLiteral string).toString()).to.eql('(StringLiteral 20, 25, 2a)')
        done()

  describe 'List Entity', ->
    context 'when constructing a list', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new List [5,6,7,8]).toString()).to.eql('[5, 6, 7, 8]')
        done()
    context 'when constructing a single element list', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new List [5]).toString()).to.eql('[5]')
        done()
    context 'when constructing a single element string list', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new List ['hi']).toString()).to.eql('[hi]')
        done()

  describe 'Dict Entity', ->
    context 'when constructing a dictionary', ->
      it 'constructs and toStrings correctly', (done) ->
        token1 = [
          (new Binding 'hey', Type.INT, 1),
          (new Binding 'wassup', Type.INT, 2),
          (new Binding 'hello', Type.INT, 3)
        ]
        token2 = new BindingList token1
        expect((new Dict token2).toString()).to.eql('Dict Binding hey [int] to 1,
           Binding wassup [int] to 2, Binding hello [int] to 3')
        done()

  describe 'BindingList Entity', ->
    context 'when constructing a binding list of type INT', ->
      it 'constructs and toStrings correctly', (done) ->
        token = [
          (new Binding 'hey', Type.INT, 1),
          (new Binding 'wassup', Type.INT, 2),
          (new Binding 'hello', Type.INT, 3)
        ]
        expect((new BindingList token).toString())
            .to.eql('Binding hey [int] to 1, Binding wassup [int] to 2,
            Binding hello [int] to 3')
        done()
    context 'when constructing a binding list of type STRING', ->
      it 'constructs and toStrings correctly', (done) ->
        token = [
          (new Binding 'hey', Type.STRING, 'one'),
          (new Binding 'wassup', Type.STRING, 'two'),
          (new Binding 'hello', Type.STRING, 'three')
        ]
        expect((new BindingList token).toString())
            .to.eql('Binding hey [string] to one, Binding wassup [string] to two,
            Binding hello [string] to three')
        done()
    context 'when constructing a binding list of mixed types', ->
      it 'constructs and toStrings correctly', (done) ->
        token = [
          (new Binding 'hey', Type.INT, 1),
          (new Binding 'wassup', Type.STRING, 'two'),
          (new Binding 'hello', Type.BOOL, false)
        ]
        expect((new BindingList token).toString())
            .to.eql('Binding hey [int] to 1, Binding wassup [string] to two,
            Binding hello [bool] to false')
        done()

  describe 'Binding Entity', ->
    context 'when constructing an int binding', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new Binding 'hi', Type.INT, 5).toString())
            .to.eql('Binding hi [int] to 5')
        done()
    context 'when constructing a string binding', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new Binding 'hi', Type.STRING, 'hello there, Sally!').toString())
            .to.eql('Binding hi [string] to hello there, Sally!')
        done()
    context 'when constructing a bool binding', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new Binding 'hi', Type.BOOL, false).toString())
            .to.eql('Binding hi [bool] to false')
        done()

  # needs: operator to have a .lexeme, so token?
  # describe 'BinaryExpression Entity', ->
  #   context 'when constructing a binary expression', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect((new BinaryExpression '==' 5 5).toString()).to.eql('(BinaryOp == 5 6)')

  #same as above: needs proper definition of the operator
  # describe 'UnaryExpression Entity', ->
  #   context 'when constructing a unary expression', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect((new UnaryExpression '-', 5).toString()).to.eql('(UnaryOp - 5)')
  #       done()

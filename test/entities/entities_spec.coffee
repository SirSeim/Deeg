chai = require 'chai'
expect = chai.expect


Program = require "#{__dirname}/../../entities/program.coffee"
Block = require "#{__dirname}/../../entities/block.coffee"
Type = require "#{__dirname}/../../entities/type.coffee"

ForStatement = require "#{__dirname}/../../entities/forstatement.coffee"
StdFor = require "#{__dirname}/../../entities/stdfor.coffee"
StdForIdExp = require "#{__dirname}/../../entities/stdforidexp.coffee"
CountFor = require "#{__dirname}/../../entities/countfor.coffee"
CountsFor = require "#{__dirname}/../../entities/countsfor.coffee"
IfStatement = require "#{__dirname}/../../entities/ifstatement.coffee"
ElseIfStatement = require "#{__dirname}/../../entities/elseifstatement.coffee"
ElseStatement = require "#{__dirname}/../../entities/elsestatement.coffee"

# MatchStatement = require "#{__dirname}/../../entities/matchstatement.coffee"
#     this file doesn't exist yet
# PatBlock = require "#{__dirname}/../../entities/patblock.coffee"
# PatLine = require "#{__dirname}/../../entities/patline.coffee"
# Patterns = require "#{__dirname}/../../entities/patterns.coffee"
# Pattern = require "#{__dirname}/../../entities/pattern.coffee"

WhileStatement = require "#{__dirname}/../../entities/whilestatement.coffee"
ReturnStatement = require "#{__dirname}/../../entities/returnstatement.coffee"
ClassDefinition = require "#{__dirname}/../../entities/classdefinition.coffee"

VariableDeclaration = require "#{__dirname}/../../entities/variabledeclaration.coffee"
VariableAssignment = require "#{__dirname}/../../entities/variableassignment.coffee"
VariableExpression = require "#{__dirname}/../../entities/variableexpression.coffee"
Args = require "#{__dirname}/../../entities/args.coffee"
ExpList = require "#{__dirname}/../../entities/explist.coffee"

FunctionCall = require "#{__dirname}/../../entities/functioncall.coffee"
FunctionDef = require "#{__dirname}/../../entities/functiondef.coffee"
Params = require "#{__dirname}/../../entities/params.coffee"
ParamList = require "#{__dirname}/../../entities/paramlist.coffee"

TrailingIf = require "#{__dirname}/../../entities/trailingif.coffee"
VariableReference = require "#{__dirname}/../../entities/variablereference.coffee"
FieldAccess = require "#{__dirname}/../../entities/fieldaccess.coffee"
# IterableItem = require "#{__dirname}/../../entities/iterableitem.coffee" DOESN'T EXIST
Range = require "#{__dirname}/../../entities/range.coffee"
IntegerLiteral = require "#{__dirname}/../../entities/integerliteral.coffee"
FloatLiteral = require "#{__dirname}/../../entities/floatliteral.coffee"
BooleanLiteral = require "#{__dirname}/../../entities/booleanliteral.coffee"
StringLiteral = require "#{__dirname}/../../entities/stringliteral.coffee"

List = require "#{__dirname}/../../entities/list.coffee"
Dict = require "#{__dirname}/../../entities/dict.coffee"
BindingList = require "#{__dirname}/../../entities/bindinglist.coffee"
Binding = require "#{__dirname}/../../entities/binding.coffee"

BinaryExpression = require "#{__dirname}/../../entities/binaryexpression.coffee"
UnaryExpression = require "#{__dirname}/../../entities/unaryexpression.coffee"


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
  #   context 'when constructing a for statement', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       it = new forIterate
  #       expect((new ForStatement it, 'body').toString()).to.eql('it then body')
  #       done()

  describe 'StdFor Entity', ->
    context 'when constructing a standard for', ->
      it 'constructs and toStrings correctly', (done) ->
        token = {
          kind: 'id',
          lexeme: 'foo'
        }
        expect((new StdFor [token], ['int'], ['dict']).toString())
          .to.eql('(StdFor foo:int in dict)')
        done()
  
  # Maybe we don't need StdForIdExp.
  # describe 'StdForIdExp Entity', -> #this is not correct. entity declaration
  # is not finished
  #   context 'when constructing a standard for id expression', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect((new StdForIdExp ['(foo in bar)'], 'Body').toString())
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
        token = {
          kind: 'id',
          lexeme: 'foo'
        }
        expect((new CountsFor token, 2).toString()).to.eql('(For foo counts 2)')
        done()

  describe 'IfStatement Entity', ->
    context 'when constructing an if statement', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new IfStatement ['foo in bar'], 'Body').toString())
          .to.eql('(If foo in bar then Body)')
        done()

  describe 'ElseIfStatement Entity', ->
    context 'when constructing an else if statement true else if statement', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new ElseIfStatement ['foo in bar'], 'Body',
          (new ElseIfStatement 5 == 5, 'Body')).toString())
          .to.eql('(else if foo in bar then Body) (else if true then Body)')
        done()
    context 'when constructing an else if statement false else if statement', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new ElseIfStatement ['foo in bar'], 'Body',
          (new ElseIfStatement 5 == 7, 'Body')).toString())
          .to.eql('(else if foo in bar then Body) (else if false then Body)')
        done()
    context 'when constructing an else if statement no else if statement', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new ElseIfStatement ['foo in bar'], 'Body').toString())
          .to.eql('(else if foo in bar then Body)')
        done()

  describe 'ElseStatement Entity', ->
    context 'when constructing an else statement', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new ElseStatement 'Body').toString())
          .to.eql('(else Body)')
        done()

  describe 'WhileStatement Entity', ->
    context 'when constructing a while statement', ->
      it 'constructs and toStrings correctly', (done) ->
        foo = 1
        bar = 1
        expect((new WhileStatement ['foo in bar'] , 'Body' ).toString())
          .to.eql('(While foo in bar then Body)')
        done()

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

  # describe 'ClassDefinition Entity', ->
  #   context 'when constructing a class definition', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect((new ClassDefinition 'hello').toString()).to.eql('(ClassDefinition)')
  #       done()

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
  # describe 'VariableAssignment Entity', ->
  #   context 'when constructing a variable assignment', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       token = {
  #         kind: 'id',
  #         lexeme: 'foo',
  #         line: 3,
  #         col: 1
  #       }
  #       expect((new VariableAssignment token, 'bool', 3).toString())
  #         .to.eql('(VarDec \'foo\' of type:bool = 3)')
  #       done()

  # describe 'VariableExpression Entity', ->
  # context 'when constructing a variable expression', ->
  #   it 'constructs and toStrings correctly', (done) ->
  #     token = {
  #       kind: 'id',
  #       lexeme: 'foo',
  #       line: 3,
  #       col: 1
  #     }
  #     expect((new VariableExpression token, 'bool', 3).toString())
  #       .to.eql('(VarDec \'foo\' of type:bool = 3)')
  #     done()

  describe 'Args Entity' , ->
    context 'when constructing an args', ->
      it 'constructs and Args correctly', (done) ->
        expect((new Args 'expList').toString()).to.eql('(expList)')
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
        expect((new List ['5','6','7','8']).toString()).to.eql('[5,6,7,8]')
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
        expect((new Dict token2).toString()).to.eql('Dict {Binding hey [int] to 1,
           Binding wassup [int] to 2, Binding hello [int] to 3}')
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

  describe 'BinaryExpression Entity', ->
    context 'when constructing a binary expression ==', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new BinaryExpression {lexeme:'=='}, 5, 5).toString())
        .to.eql('(BinaryOp == 5 5)')
        done()
    context 'when constructing a binary expression <=', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new BinaryExpression {lexeme:'<='}, 5, 5).toString())
        .to.eql('(BinaryOp <= 5 5)')
        done()
    context 'when constructing a binary expression and', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new BinaryExpression {lexeme:'and'}, true, true).toString())
        .to.eql('(BinaryOp and true true)')
        done()

  describe 'UnaryExpression Entity', ->
    context 'when constructing a unary expression -', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new UnaryExpression {lexeme: '-'}, 5).toString()).to.eql('(UnaryOp - 5)')
        done()
    context 'when constructing a unary expression !', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new UnaryExpression {lexeme: '!'}, true).toString())
        .to.eql('(UnaryOp ! true)')
        done()
    context 'when constructing a unary expression not', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((new UnaryExpression {lexeme: 'not'}, false).toString())
        .to.eql('(UnaryOp not false)')
        done()

  # describe 'Function Entity', ->
  #   context 'when constructing a function entity', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect((new Function [1, 2, 3], Type.INT, 'body').toString())
  #        .to.eql('(FunctionDef params: [1, 2, 3] type: int body)')
  #       done()

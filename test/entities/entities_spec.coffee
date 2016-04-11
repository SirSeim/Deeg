chai = require 'chai'
expect = chai.expect


Program = require '#{__dirname}/../../entities/program.coffee'
Block = require '#{__dirname}/../../entities/block.coffee'
Type = require '#{__dirname}/../../entities/type.coffee'

VariableDeclaration = require '#{__dirname}/../../entities/variabledeclaration.coffee'

# ForStatement = require '#{__dirname}/../../entities/forstatement.coffee'
StdFor = require '#{__dirname}/../../entities/stdfor.coffee'
StdForIdExp = require '#{__dirname}/../../entities/stdforidexp.coffee'
CountFor = require '#{__dirname}/../../entities/countfor.coffee'
CountsFor = require '#{__dirname}/../../entities/countsfor.coffee'

IfStatement = require '#{__dirname}/../../entities/ifstatement.coffee'
WhileStatement = require '#{__dirname}/../../entities/whilestatement.coffee'
ReturnStatement = require '#{__dirname}/../../entities/returnstatement.coffee'

IntegerLiteral = require '#{__dirname}/../../entities/integerliteral.coffee'
FloatLiteral = require '#{__dirname}/../../entities/floatliteral.coffee'
BooleanLiteral = require '#{__dirname}/../../entities/booleanliteral.coffee'
StringLiteral = require '#{__dirname}/../../entities/stringliteral.coffee'

List = require '#{__dirname}/../../entities/list.coffee'
Dict = require '#{__dirname}/../../entities/dict.coffee'
Function = require '#{__dirname}/../../entities/function.coffee'

# FunctionInvocation = require '.#{__dirname}/../../entities/functioninvocation.coffee'
VariableReference = require '#{__dirname}/../../entities/variablereference.coffee'
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
    context 'when constructing a type', ->
      it 'constructs and toStrings correctly', (done) ->
        expect((Type.BOOL).toString()).to.eql('bool')
        done()

  describe 'VariableDeclaration Entity', ->
    context 'when constructing a variable declaration', ->
      it 'constructs and toStrings correctly', (done) ->
        token = {
          kind: 'id',
          lexeme: 'foo',
          line: 3,
          col: 1
        }
        expect((new VariableDeclaration token, 3, 'bool').toString())
          .to.eql('(VarDec \'foo\' of type:bool = 3)')
        done()

  describe "Args Entity" , ->
    context 'when constructing an args', ->
      it 'constructs and Args correctly', (done) ->
        expect((new Args 'expList').toString())).to.eql('(expList)')
        
  # STDFOR NEEDS TO BE WORKED ON
  # describe 'StdFor Entity', ->
  #   context 'when constructing a standard for', ->
  #     it 'constructs and toStrings correctly', (done) ->
  #       expect((new StdFor ['(foo in bar)'], 'Body').toString())
  #         .to.eql('(StdFor idexplist:(foo in bar) body:Body)')
  #       done()

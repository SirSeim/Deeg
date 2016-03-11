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

FunctionInvocation = require '.#{__dirname}/../../entities/functioninvocation.coffee'
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
        expect((new Type 'bool').toString()).to.eql('bool')
        done()

  describe 'VariableDeclaration Entity', ->
    context 'when constructing a variable declaration', ->
      it ''

  # describe 'scanning valid deeg programs', ->
  #   describe 'deeg program #1', ->
  #     context 'when test program1.deeg is passed through the scanner', ->
  #       expectedTokens1 = outputTokens.program1
  #       it 'returns the appropriate tokens', (done) ->
  #         scan "#{validScannerPrograms}/program1.deeg", (err, tokens) ->
  #           expect(tokens).to.eql(expectedTokens1)
  #           done()
  #       it 'has no errors', (done) ->
  #         scan "#{validScannerPrograms}/program1.deeg", (err, tokens) ->
  #           expect(err).to.be.null
  #           done()

  #   describe 'deeg program #2', ->
  #     context 'when test program2.deeg is passed through the scanner', ->
  #       expectedTokens2 = outputTokens.program2
  #       it 'returns the appropriate tokens', (done) ->
  #         scan "#{validScannerPrograms}/program2.deeg", (err, tokens) ->
  #           expect(tokens).to.eql(expectedTokens2)
  #           done()
  #       it 'has no errors', (done) ->
  #         scan "#{validScannerPrograms}/program2.deeg", (err, tokens) ->
  #           expect(err).to.be.null
  #           done()

  #   describe 'deeg program #3', ->
  #     context 'when test program3.deeg is passed through the scanner', ->
  #       expectedTokens3 = outputTokens.program3
  #       it 'returns the appropriate tokens', (done) ->
  #         scan "#{validScannerPrograms}/program3.deeg", (err, tokens) ->
  #           expect(tokens).to.eql(expectedTokens3)
  #           done()
  #       it 'has no errors', (done) ->
  #         scan "#{validScannerPrograms}/program3.deeg", (err, tokens) ->
  #           expect(err).to.be.null
  #           done()

  #   describe 'deeg program #4', ->
  #     context 'when test program4.deeg is passed through the scanner', ->
  #       expectedTokens4 = outputTokens.program4
  #       it 'returns the appropriate tokens', (done) ->
  #         scan "#{validScannerPrograms}/program4.deeg", (err, tokens) ->
  #           expect(tokens).to.eql(expectedTokens4)
  #           done()
  #       it 'has no errors', (done) ->
  #         scan "#{validScannerPrograms}/program4.deeg", (err, tokens) ->
  #           expect(err).to.be.null
  #           done()

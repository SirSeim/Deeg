_ = require 'underscore'
HashMap = require('hashmap').HashMap
DeegEntities = require '#{__dirname}/../../entities/deegentities.coffee'
ReturnStatement = require '#{__dirname}/../../entities/returnstatement.coffee'
Type = require '#{__dirname}/../../entities/type.coffee'
VariableReference = require '#{__dirname}/../../entities/variablereference.coffee'
ExpressionSet = require './expressions.coffee'

map = null
lastId = 0
fakeVarCounter = 0

module.exports = (program) ->
  map = new HashMap()
  lastId = 0
  gen program

module.exports.makeFakeVariable = () ->
  fakeVar = new VariableReference { 'lexeme' : "#{++fakeVarCounter}", 'kind':'ID'}

indentPadding = 4
indentLevel = 0

emit = (line) ->
  pad = indentPadding * indentLevel
  console.log(Array(pad+1).join(' ') + line)

makeOp = (op) ->
  {'!': '!', and: '&&', or: '||', '==': '===', '!=': '!=='}[op] or op

makeVariable = do (lastId = 0, map = new HashMap()) ->
  (v) ->
    map.set v, ++lastId if not map.has v
    '_v' + map.get v

gen = (e) ->
  generator[e.constructor.name](e)

generator =

  Program: (program) ->
    indentLevel = 0
    emit '(function () {'
    gen program.block
    emit '}());'

  Block: (block) ->
    indentLevel++
    gen statement for statement in block.statements
    indentLevel--

  ClassDefinition: (c) ->


  IfStatement: (s) ->


  ElseIfStatement: (s) ->


  ElseStatement: (s) ->


  WhileStatement: (s) ->
    emit "while (#{gen s.condition}) {"
    gen s.body
    emit '}'

  MatchStatement: (s) ->


  PatBlock: (pb) ->


  PatLine: (pl) ->


  Patterns: (patterns) ->


  Pattern: (p) ->


  ForStatement: (s) ->


  StdFor: (s) ->


  StdForIdExp: (s) ->


  CountsFor: (s) ->


  CountFor: (s) ->


  ReturnStatement: (s) ->
    emit "return #{gen s.value};"


  VariableDeclaration: (v) ->
    emit "var #{makeVariable v} = #{gen v.value};"


  VariableAssignment: (v) ->


  VariableExpression: (v) ->


  Args: (a) ->


  ExpList: (e) ->


  Function: (f) ->

  Params: (p) ->

  ParamsList: (p) ->


  Binding: (b) ->


  Exp: (e) ->


  IntegerLiteral: (literal) ->
    emit literal.toString()


  BooleanLiteral: (literal) ->
    emit literal.toString()

  VariableReference: (v) ->


  UnaryExpression: (e) ->


  BinaryExpression: (e) ->

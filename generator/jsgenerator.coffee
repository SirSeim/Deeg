_ = require 'underscore'
HashMap = require('hashmap').HashMap
DeegEntities = require '#{__dirname}/../../entities/deegentities.coffee'
ReturnStatement = require '#{__dirname}/../../entities/returnstatement.coffee'
Type = require '#{__dirname}/../../entities/type.coffee'
VariableReference = require '#{__dirname}/../../entities/variablereference.coffee'
ExpressionSet = require './expressions.coffee'

map = null
lastId = 0
varCounter = 0
error = []

module.exports = (program, callback) ->
  map = new HashMap()
  lastId = 0
  programOutput = gen program
  callback error, programOutput

module.exports.makeVariable = ->
  variable = new VariableReference { 'lexeme' : "#{++varCounter}", 'kind':'ID'}

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

indexCounter = 0
makeIndex = () ->
  "_i" + indexCounter
  indexCounter++

gen = (e) ->
  generator[e.constructor.name](e)

generator =

  Program: (program) ->
    indentLevel = 0
    emit '(function () {'
    emit '\n'
    gen program.block
    emit '}());'

  Block: (block) ->
    indentLevel++
    gen statement for statement in block.statements
    indentLevel--

  ClassDefinition: (c) ->


  IfStatement: (s) ->
    emit "if (#{gen s.condition}) {"
    emit '\n'
    indentLevel++
    gen s.body
    indentLevel--
    if s.elseIfStatement
      gen s.elseIfStatement
    if s.elseStatement
      gen s.elseStatement
    emit '}'

  ElseIfStatement: (s) ->
    emit "} else if (#{gen s.condition}) {"
    emit '\n'
    indentLevel++
    gen s.body
    indentLevel--
    if s.elseIfStatement
      gen s.elseIfStatement

  ElseStatement: (s) ->
    emit "} else {"
    emit '\n'
    indentLevel++
    gen s.body
    indentLevel--

  WhileStatement: (s) ->
    emit "while (#{gen s.condition}) {"
    emit '\n'
    indentLevel++
    gen s.body
    indentLevel--
    emit '}'

  MatchStatement: (s) ->


  PatBlock: (pb) ->


  PatLine: (pl) ->


  Patterns: (patterns) ->


  Pattern: (p) ->


  ForStatement: (s) ->
    gen s.forIterate
    emit '\n'
    indexLevel++
    gen s.body
    indexLevel--
    emit '}'


  StdFor: (s) ->


  StdForIdExp: (s) ->


  CountsFor: (s) ->
    index = makeVariable s.id
    emit "for (var #{index} = 0; index < #{s.tally}; #{index} += 1) {"

  CountFor: (s) ->
    index = makeIndex
    emit "for (var #{index} = 0; index < #{s.tally}; #{index} += 1) {"


  ReturnStatement: (s) ->
    emit "return #{gen s.value};"


  VariableDeclaration: (v) ->
    emit "var #{makeVariable v.id} =" 
    emit "#{gen v.value}#{if !(v.value == FunctionDef)? then ";"}"


  VariableAssignment: (v) ->
    emit "#{makeVariable v.id} = #{gen v.value}#{if !v.modifier? then gen v.modifier}"
    emit '\n'

  VariableExpression: (v) ->


  Args: (a) ->


  ExpList: (e) ->


  FunctionDef: (f) ->
    emit "function (#{gen f.params}) {"
    indentLevel++
    gen f.body
    emitLevel--
    emit '}'

  FunctionCall: (f) ->
    emit "#{f.name}(#{emit f.params})"

  Params: (p) ->


  ParamList: (p) ->
    gen '('
    # for param in p.paramList
      

  Binding: (b) ->


  Exp: (e) ->


  IntegerLiteral: (literal) ->
    emit literal.toString()


  BooleanLiteral: (literal) ->
    emit literal.toString()

  VariableReference: (v) ->


  UnaryExpression: (e) ->


  BinaryExpression: (e) ->
    emit "( #{gen e.left} #{makeOp e.op.lexeme} #{gen e.right} )"

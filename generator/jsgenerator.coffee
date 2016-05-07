_ = require 'underscore'
HashMap = require('hashmap').HashMap
DeegEntities = require '#{__dirname}/../../entities/deegentities.coffee'
ReturnStatement = require '#{__dirname}/../../entities/returnstatement.coffee'
Type = require '#{__dirname}/../../entities/type.coffee'
VariableReference = require '#{__dirname}/../../entities/variablereference.coffee'
ExpressionSet = require './expressions.coffee'

map = new HashMap()
lastId = 0
varCounter = 0
error = []
programOutput = ''

module.exports = (program, indent=true, callback) ->
  map = new HashMap()
  lastId = 0
  varCounter = 0
  error = []
  programOutput = ''
  gen program, indent
  callback error, programOutput

# module.exports.makeVariable = ->
#   variable = new VariableReference { 'lexeme' : "#{++varCounter}", 'kind':'ID'}

indentPadding = 4
indentLevel = 0

emit = (line, indent=true) ->
  if indent
    pad = indentPadding * indentLevel
    programOutput += Array(pad+1).join(' ')
  programOutput += line

makeOp = (op) ->
  {'!': '!', and: '&&', or: '||', '==': '===', '!=': '!=='}[op] or op

makeVariable = (v) ->
    map.set v, ++lastId if not map.has v
    '_v' + map.get v

indexCounter = 0
makeIndex = () ->
  "_i" + indexCounter
  indexCounter++

gen = (e, indent=true) ->
  generator[e.constructor.name](e, indent)

generator =

  Program: (program, indent) ->
    indentLevel = 0
    emit '(function () {\n', indent
    gen program.block, indent
    emit '}());', indent
    return

  Block: (block, indent) ->
    indentLevel++
    for statement in block.statements
      gen statement, indent
      emit '\n', false
    # gen statement for statement in block.statements
    indentLevel--
    return

  ClassDefinition: (c, indent) ->
    emit 'test', indent
    return

  IfStatement: (s, indent) ->
    emit 'if (', indent
    gen s.condition, false
    emit ') {\n', false
    indentLevel++
    gen s.body, indent
    indentLevel--
    if s.elseIfStatement
      emit '\n', false
      gen s.elseIfStatement, indent
    if s.elseStatement
      emit '\n', false
      gen s.elseStatement, indent
    emit '}\n', indent
    return

  ElseIfStatement: (s, indent) ->
    emit '} else if (', indent
    gen s.condition, false
    emit ') {\n', false
    indentLevel++
    gen s.body, indent
    indentLevel--
    if s.elseIfStatement
      emit '\n', false
      gen s.elseIfStatement, indent
    return

  ElseStatement: (s, indent) ->
    emit '} else {\n', indent
    indentLevel++
    gen s.body, indent
    indentLevel--
    emit '\n', false
    return

  WhileStatement: (s, indent) ->
    emit 'while ('
    gen s.condition, false
    emit ') {\n', false
    indentLevel++
    gen s.body, indent
    indentLevel--
    emit '}', indent
    return

  ###MatchStatement: (s) ->


  PatBlock: (pb) ->


  PatLine: (pl) ->


  Patterns: (patterns) ->


  Pattern: (p) ->###


  ForStatement: (s, indent) ->
    gen s.forIterate, indent
    emit '\n', false
    indexLevel++
    gen s.body, indent
    indexLevel--
    emit '}', indent
    return


  StdFor: (s, indent) ->
    emit 'test', indent
    return

  StdForIdExp: (s, indent) ->
    emit 'test', indent
    return

  CountsFor: (s, indent) ->
    index = makeVariable s.id
    emit "for (var #{index} = 0; index < #{s.tally}; #{index} += 1) {", indent

  CountFor: (s, indent) ->
    index = makeIndex
    emit "for (var #{index} = 0; index < #{s.tally}; #{index} += 1) {", indent
    return

  ReturnStatement: (s, indent) ->
    emit 'return ', indent
    gen s.value, false
    emit ';', false
    return

  VariableDeclaration: (v, indent) ->
    emit "var #{makeVariable v.id} = ", indent
    gen v.value, false
    emit ";\n", false
    return

  VariableAssignment: (v, indent) ->
    emit "#{makeVariable v.id} ", indent
    if v.modifier
      gen v.modifier, false
    else
      emit '= ', false
    if v.value
      gen v.value, false
    emit 'd;\n', false
    return

  VariableExpression: (v, indent) ->
    emit 'test', indent
    return

  Args: (a, indent) ->
    emit 'test', indent
    return

  ExpList: (e, indent) ->
    emit 'test', indent
    return

  FunctionDef: (f, indent) ->
    emit 'function (', indent
    gen f.params, false
    emit ') {\n', false
    indentLevel++
    gen f.body, indent
    emitLevel--
    emit '}', indent
    return

  FunctionCall: (f, indent) ->
    emit "#{f.name}(", indent
    gen f.params, false
    emit ')', false
    return

  Params: (p, indent) ->
    gen p.paramList, indent
    return

  ParamList: (p, indent) ->
    emit p.paramList.toString(), indent
    return
      
  Binding: (b, indent) ->
    emit 'test', indent
    return

  Exp: (e, indent) ->
    emit 'test', indent
    return

  IntegerLiteral: (literal, indent) ->
    emit literal.toString(), indent
    return


  BooleanLiteral: (literal, indent) ->
    emit literal.toString(), indent
    return

  VariableReference: (v, indent) ->
    emit 'test', indent
    return

  UnaryExpression: (e, indent) ->
    emit 'test', indent
    return

  BinaryExpression: (e, indent) ->
    emit '( ', indent
    gen e.left, false
    emit " #{makeOp e.op.lexeme} ", false
    gen e.right, false
    emit ' )', false
    return

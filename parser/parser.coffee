# Parser module
#
#   parse = require './parser'
#   program = parse tokens

scanner = require '../scanner/scanner.coffee'
error = require '../error/error.coffee'

Program = require './entities/program.coffee'
Block = require './entities/block.coffee'
Type = require './entities/type.coffee'

VariableDeclaration = require './entities/variabledeclaration.coffee'

ForStatement = require './entities/forstatement.coffee'
StdFor = require './entities/stdfor.coffee'
StdForIdExp = require './entities/stdforidexp.coffee'
CountFor = require './entities/countfor.coffee'
CountsFor = require './entities/countsfor.coffee'

IfStatement = require './entities/ifstatement.coffee'
WhileStatement = require './entities/whilestatement.coffee'
ReturnStatement = require './entities/returnstatement.coffee'

IntegerLiteral = require './entities/integerliteral.coffee'
FloatLiteral = require './entities/floatliteral.coffee'
BooleanLiteral = require './entities/booleanliteral.coffee'
StringLiteral = require './entities/stringliteral.coffee'

List = require './entities/list.coffee'
Dict = require './entities/dict.coffee'
Function = require './entities/function.coffee'

FunctionInvocation = require '../entities/functioninvocation.coffee'
VariableReference = require './entities/variablereference.coffee'
BinaryExpression = require './entities/binaryexpression.coffee'
UnaryExpression = require './entities/unaryexpression.coffee'

tokens = []

module.exports = (scannerOutput) ->
  tokens = scannerOutput
  program = parseProgram()
  match 'EOF'
  program

parseProgram = ->
  new Program(parseBlock())

parseBlock = ->
  statements = []
  loop
    statements.push parseStatement()
    break unless at ['make','id','read','write','while']
  new Block(statements)

parseStatement = ->
  if at 'make'
    parseVariableDeclaration()
  else if at 'while'
    parseWhileStatement()
  else if at 'for'
    parseForStatement()
  else if at 'match'
    parseMatchStatement()
  else if at 'if'
    parseIfStatement()
  else
    error 'Statement expected', tokens[0]

parseVariableDeclaration = ->
  match 'make'
  id = match 'id'
  optionalTypeMatch()
  match '='
  new VariableDeclaration(id, type)

optionalTypeMatch = ->
  if optionalTypeCheck()
    match ':'
    type = parseType()

parseType = ->
  if at ['int', 'float', 'string', 'bool']
    Type.forName match().lexeme
  else
    error 'Type expected', tokens[0]

parseWhileStatement = ->
  match 'while'
  condition = parseExpression()
  match 'then'
  body = parseBlock()
  match 'end'
  new WhileStatement(condition, body)

# 'for' (StdFor | CountFor | CountsFor)
# 'then' (newline Block 'end' | Stmt 'end')
parseForStatement = ->
  match 'for'

  forIterate = determineForType()

  match 'then'

  if exists '\n'
    match '\n'
    body = parseBlock()
    match 'end'
  else
    body = parseStatement()
    match 'end'

  new ForStatement(forIterate, body)

#parseMatchStatement = ->
 # match 'match'

parseIfStatement = ->
  oneLiner = true
  match 'if'

  IfExpression = determineIfType()

  match 'then'

  if exists '\n'
    oneLiner = false
    match '\n'
    ifBody = parseBlock()
  if exists 'else if'
    elseIfExpressions = {}
    matchElseIfStatements()
  if exists 'else'
    match 'else'
    if exists '\n' && !oneLiner
      match '\n'
      elseBody = parseBlock()
    else if exists '\n' && oneLiner
      message = "Expected one line if statement but found new line"
      error message, tokens[0]
    match 'end'
    new IfStatement(IfExpression,ifBody,elseIfExpressions)
  else 
    new IfElseStatement(IfExpression,ifBody,elseIfExpressions,elseBody)

matchElseIfStatements =->
  match 'else if'

  IfExpression = determineIfType()

  match 'then'
  if exists '\n' && !oneLiner
    match '\n'
    elseIfbody = parseBlock()
    elseIfExpressions.push({IfExpression:elseIfbody})
  else if exists '\n' && oneLiner
    message = "Expected one line if statement but found new line"
    error message, tokens[0]
  if exists 'else if'
    matchElseIfStatements()
  else 
    return

determineForType = ->
  if exists 'id' and optionalTypeCheck() # true if StdFor
    parseStdFor()
  else if exists 'id'
    parseCountsFor()
  else if exists 'count'
    parseCountFor()
  else
    message = "Expected \"id\" or \"count\" but found \"#{tokens[0].kind}\""
    error message, tokens[0]

determineIfType =->
  return 
  
parseStdFor = ->
  idexplist = []
  idexplist.push(parseStdForIdExp())
  while exists 'and'
    match 'and'
    idexplist.push(parseStdForIdExp())

  new StdFor(idexplist)

parseStdForIdExp = ->
  id = match 'id'
  match 'in'
  exp = parseExpression()

  new StdForIdExp(id, exp)

parseCountsFor = ->
  id = match 'id'
  match 'counts'
  exp = parseExpression()


  new CountsFor(id, exp)

parseCountFor = ->
  match 'count'
  exp = parseExpression()

  new CountFor(exp)

optionalTypeCheck = ->
  exists ':'

exists = (kind) ->
  if tokens.length is 0
    error 'Unexpected end of source program'
  kind is undefined or kind is tokens[0].kind


match = (kind, optional=false) ->
  if tokens.length is 0
    error 'Unexpected end of source program'
  else if kind is undefined or kind is tokens[0].kind
    tokens.shift()
  else if optional
    return
  else
    error "Expected \"#{kind}\" but found \"#{tokens[0].kind}\"", tokens[0]
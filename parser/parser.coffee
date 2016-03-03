# Parser module
#
#   parse = require './parser'
#   program = parse tokens

scanner = require '../scanner/scanner'
error = require '../error/error'

Program = require './entities/program'
Block = require './entities/block'
Type = require './entities/type'

VariableDeclaration = require './entities/variabledeclaration'

ForStatement = require './entities/forstatement'
StdFor = require './entities/stdfor'
StdForIdExp = require './entities/stdforidexp'
CountFor = require './entities/countfor'
CountsFor = require './entities/countsfor'

IfStatement = require './entities/ifstatement'
WhileStatement = require './entities/whilestatement'
ReturnStatement = require './entities/returnstatement'

IntegerLiteral = require './entities/integerliteral'
FloatLiteral = require './entities/floatliteral'
BooleanLiteral = require './entities/booleanliteral'
StringLiteral = require './entities/stringliteral'

List = require './entities/list'
Dict = require './entities/dict'
Function = require './entities/function'

FunctionInvocation = require '../entities/functioninvocation'
VariableReference = require './entities/variablereference'
BinaryExpression = require './entities/binaryexpression'
UnaryExpression = require './entities/unaryexpression'

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

# 'for' (StdFor | CountFor | CountsFor) 'then' (newline Block 'end' | Stmt 'end')
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

determineForType = ->
  if exists 'id' and optionalTypeCheck() # true if StdFor
    parseStdFor()
  else if exists 'id'
    parseCountsFor()
  else if exists 'count'
    parseCountFor()
  else
    error "Expected \"id\" or \"count\" but found \"#{tokens[0].kind}\"", tokens[0]

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
# Parser module
#
#   parse = require './parser'
#   program = parse tokens

scanner = require '../scanner/scanner.coffee'
error = require '../error/error.coffee'

Program = require './entities/program.coffee'
Block = require './entities/block.coffee'
Type = require './entities/type.coffee'

ForStatement = require './entities/forstatement.coffee'
StdFor = require './entities/stdfor.coffee'
StdForIdExp = require './entities/stdforidexp.coffee'
CountFor = require './entities/countfor.coffee'
CountsFor = require './entities/countsfor.coffee'

IfStatement = require './entities/ifstatement.coffee'
ElseIfStatement = require './entities/elseifstatement.coffee'
ElseStatement = require './entities/elsestatement.coffee'

# MatchStatement = require './entities/matchstatement.coffee' this file doesn't exist yet
# PatBlock = require './entities/patblock.coffee'
# PatLine = require './entities/patline.coffee'
# Patterns = require './entities/patterns.coffee'
# Pattern = require './entities/pattern.coffee'

WhileStatement = require './entities/whilestatement.coffee'
ReturnStatement = require './entities/returnstatement.coffee'
# ClassDefinition = require './entities/classdefinition.coffee'

VariableDeclaration = require './entities/variabledeclaration.coffee'
VariableAssignment = require './entities/variableassignment.coffee'
VariableExpression = require './entities/variableexpression.coffee'
Args = require './entities/args.coffee'
ExpList = require './entities/explist.coffee'

FunctionExp = require './entities/functionexp.coffee'
Params = require './entities/params.coffee'
ParamList = require './entities/paramlist.coffee'

VariableReference = require './entities/variablereference.coffee'
IntegerLiteral = require './entities/integerliteral.coffee'
FloatLiteral = require './entities/floatliteral.coffee'
BooleanLiteral = require './entities/booleanliteral.coffee'
StringLiteral = require './entities/stringliteral.coffee'

List = require './entities/list.coffee'
Dict = require './entities/dict.coffee'
# Function = require './entities/function.coffee' i have no idea how this differs from FunctionExp

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
    match 'newline'
    break unless at ['EOF', 'end', 'else']
  new Block(statements)

parseStatement = -> 
  if at 'while'
    parseWhileStatement()
  else if at 'for'
    parseForStatement()
  else if at 'match'
    parseMatchStatement()
  else if at 'if'
    parseIfStatement()
  else if at 'deeg'
    parseReturnStatement()
  else if at 'class'
    parseClassDefinition()
  else if at 'to' # disclaimer, this is not correct
    parseBinding()
  else
    parseExpression()

parseClassDefinition = ->
  match 'class'
  id = match 'id'

  if exists 'extends'
    match 'extends'
    parentId = match 'id'

  body = parseBlock()

  match 'end'
  new ClassDefinition(id, body, parentId)

parseIfStatement = ->
  match 'if'
  condition = parseExpression()
  match 'then'
  body = parseBlock()
  if exists 'else if'
    elseIfStatement = parseElseIfStatement()
  if exists 'else'
    elseStatement = parseElseStatement()
  match 'end'
  new IfStatement(condition, body, elseIfStatement, elseStatement)

parseElseIfStatement = ->
  match 'else if'
  condition = parseExpression()
  match 'then'
  body = parseBlock()
  if exists 'else if'
    elseIfStatement = parseElseIfStatement()
  if exists 'else'
    elseStatement = parseElseStatement()
  new ElseIfStatement(condition, body, elseIfStatement, elseStatement)

parseElseStatement = ->
  match 'else'
  body = parseBlock()
  new ElseStatement(body)

parseWhileStatement = ->
  match 'while'
  condition = parseExpression()
  match 'then'
  body = parseBlock()
  match 'end'
  new WhileStatement(condition, body)

parseMatchStatement = ->
  match 'match'
  matchee = parseExpression()
  match 'with'
  match 'newline'
  patBlock = parsePatBlock()
  match 'end'
  new MatchStatement(matchee, patBlock)

parsePatBlock = ->
  unless exists 'newline'
    patLine = parsePatLine()
    match 'newline'
  new PatBlock(patLine)

parsePatLine = ->
  match '>>'
  patterns = parsePatterns()
  if exists 'if'
    match 'if'
    condition = parseExpression()
  match 'then'
  instruction = parseStatement()
  new PatLine(patterns, condition, instruction)

parsePatterns = ->
  tails = []
  head = parsePattern()
  while exists '|'
    match "|"
    tails.push parsePattern()
  new Patterns(head, tails)

parsePattern = ->
  if exists 'id'
    id = match 'id'
  else if exists '_'
    id = match '_'
  optionalTypeMatch()
  new Pattern(id, type)

parseForStatement = ->
  match 'for'
  forIterate = determineForType()
  match 'then'

  if exists 'newline'
    match 'newline'
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
    message = "Expected \"id\" or \"count\" but found \"#{tokens[0].kind}\""
    error message, tokens[0]

parseStdFor = ->
  id = match 'id'
  optionalTypeMatch()
  match 'in'
  range = parseExpression()
  if exists 'and'
    additionalList = parseStdForIdExp()
  new StdFor(id, type, range, additionalList)

parseStdForIdExp = ->
  idList = []
  expList = []
  while exists 'and'
    match 'and'
    idList.push match 'id'
    optionalTypeMatch()
    match 'in'
    expList.push parseExpression()
  new StdForIdExp(idList, typeList, expList)

parseCountsFor = ->
  id = match 'id'
  match 'counts'
  tally = parseExpression()
  new CountsFor(id, tally)

parseCountFor = ->
  match 'count'
  tally = parseExpression()
  new CountFor(tally)

parseReturnStatement = ->
  match 'deeg'
  new ReturnStatement(parseExpression())

parseType = ->
  if at ['bool', 'int', 'float', 'string', 'Dict']
    Type.forName match().lexeme
  else if at 'List'
    Type.forName match 'List'
    listType = optionalTypeMatch()
  else if at 'Function'
    args = []
    Type.forName match 'Function('
    unless exists ')'
      args.push parseType()
      while exists ','
        match ','
        args.push parseType()
    match ')'
    functionType = optionalTypeMatch()
  else
    error 'Type expected', tokens[0]

optionalTypeMatch = ->
  if optionalTypeCheck()
    match ':'
    type = parseType()

optionalTypeCheck = ->
  exists ':'

parseExpression = ->
  if at 'make'
    parseVariableDeclaration()
  else if at 'id'
    parseVariableAssignment()
  else if ((at '(') and areParams())
    parseFunctionExp()
  else
    parseExp0()

areParams = ->
  parens = 0
  position = 0
  for token in tokens
    parens++ if token.kind is '('
    parens-- if token.kind is ')'
    position++
    break if parens is 0
  tokens[position].kind is 'then'

parseVariableDeclaration = ->
  match 'make'
  id = match 'id'
  optionalTypeMatch()
  match '='
  value = parseExpression()
  new VariableDeclaration(id, type, value)

parseVariableAssignment = ->
  id = parseVariableExpression()
  match '='
  value = parseExpression()
  new VariableAssignment(id, value)

parseVariableExpression = ->
  id = match 'id'
  if exists '.'
    match '.'
    exp8 = parseExp8()
  else if exists '['
    match '['
    exp3 = parseExp3()
    match ']'
  while exists parseArgs()
    args = parseArgs()
    if exists '.'
      match '.'
      exp8 = parseExp8()
    else if exists '['
      match '['
      exp3 = parseExp3()
      match ']'
  new VariableExpression(id, args, exp8, exp3)

parseArgs = ->
  match '('
  expList = parseExpList()
  match ')'
  new Args(expList)

parseExpList = ->
  expList = [] 

  if exists 'newline'
    match 'newline'
  expList.push parseExpression()
  while exists ','
    match ','
    if exists 'newline'
      match 'newline'
    expList.push parseExpression()
  if exists 'newline'
    match 'newline'
  new ExpList(expList)

parseFunctionExp = ->
  params = parseParams()
  type = optionalTypeMatch()
  match 'does'
  body = parseBlock()
  match 'end'
  new FunctionExp(params, type, body)

parseParams = ->
  match '('
  paramList = parseParamList()
  match ')'
  new Params(paramList)

parseParamList = ->
  paramList = [] 
  # this list will have expressions and types may follow right after
  # null will follow if no type specified
  # e.g. (5:int, "two", "hello":string)
  # ==> [5, int, "two", null, "hello", string]
  if exists 'newline'
    match 'newline'
  paramList.push parseExpression()
  paramList.push optionalTypeMatch()
  while exists ','
    match ','
    if exists 'newline'
      match 'newline'
    paramList.push parseExpression()
    paramList.push optionalTypeMatch()
  if exists 'newline'
    match 'newline'
  new ParamList(paramList)


# parseIfStatement = ->
#   oneLiner = true
#   match 'if'

#   IfExpression = parseIf()

#   match 'then'

#   if exists 'newline'
#     oneLiner = false
#     match 'newline'
#     ifBody = parseBlock()
#   if exists 'else if'
#     elseIfExpressions = {}
#     matchElseIfStatements()
#   if exists 'else'
#     match 'else'
#     if exists 'newline' && !oneLiner
#       match 'newline'
#       elseBody = parseBlock()
#     else if exists 'newline' && oneLiner
#       message = "Expected one line if statement but found new line"
#       error message, tokens[0]
#     match 'end'
#     new IfElseStatement(IfExpression,ifBody,elseIfExpressions,elseBody) 
#   else 
#     match 'end'
#     new IfStatement(IfExpression,ifBody,elseIfExpressions)

# parseIf = ->


# matchElseIfStatements = ->
#   match 'else if'

#   IfExpression = parseIf()

#   match 'then'
#   if exists 'newline' && !oneLiner
#     match 'newline'
#     elseIfbody = parseBlock()
#     elseIfExpressions.push({IfExpression:elseIfbody})
#   else if exists 'newline' && oneLiner
#     message = "Expected one line if statement but found new line"
#     error message, tokens[0]
#   if exists 'else if'
#     matchElseIfStatements()
#   else 
#     return

parseExp0 = ->
  

parseExp1 = ->
  

parseExp2 = ->
  

parseExp3 = ->
  

parseExp4 = ->
  

parseExp5 = ->
  

parseExp6 = ->
  

parseExp7 = ->
  

parseExp8 = ->
  

parseExp9 = ->
  

parseExp10 = ->
  

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
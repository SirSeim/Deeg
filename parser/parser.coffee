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
ClassDefinition = require './entities/classdefinition.coffee'

VariableDeclaration = require './entities/variabledeclaration.coffee'
VariableAssignment = require './entities/variableassignment.coffee'
VariableExpression = require './entities/variableexpression.coffee'
Args = require './entities/args.coffee'
ExpList = require './entities/explist.coffee'

FunctionExp = require './entities/functionexp.coffee'
Params = require './entities/params.coffee'
ParamList = require './entities/paramlist.coffee'

TrailingIf = require './entities/trailingif.coffee'
VariableReference = require './entities/variablereference.coffee'
FieldAccess = require './entities/fieldaccess.coffee'
IterableItem = require './entities/iterableitem.coffee'
Range = require './entities/range.coffee'
IntegerLiteral = require './entities/integerliteral.coffee'
FloatLiteral = require './entities/floatliteral.coffee'
BooleanLiteral = require './entities/booleanliteral.coffee'
StringLiteral = require './entities/stringliteral.coffee'

List = require './entities/list.coffee'
Dict = require './entities/dict.coffee'
BindingList = require './entities/bindinglist.coffee'
Binding = require './entities/binding.coffee'
# Function = require './entities/function.coffee'
# i have no idea how this differs from FunctionExp

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
    statements.push parseStatement() # What if there's `newline` before the Stmt
    match 'newline'
    break if at ['EOF', 'end', 'else']
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
  new ElseIfStatement(condition, body, elseIfStatement)

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
  match 'newline' # maybe optional
  patBlock = parsePatBlock()
  match 'end'
  new MatchStatement(matchee, patBlock)

parsePatBlock = ->
  patLines = []
  loop
    patLines.push parsePatLine() # What if there's `newline` before the Stmt
    match 'newline'
    break if at 'end'
  new PatBlock(patLines)

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
    match '|'
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

parseStdFor = -> # use array of ids to range
  id = match 'id'
  type = optionalTypeMatch()
  match 'in'
  range = parseExpression()
  if exists 'and'
    additionalList = parseStdForIdExp()
  new StdFor(id, type, range, additionalList)

parseStdForIdExp = ->
  idList = []
  expList = []
  typeList = []
  while exists 'and'
    match 'and'
    idList.push match 'id'
    typeList.push optionalTypeMatch()
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

parseType = -> # TODO: needs work for class types, be more generalized
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
    parseType()

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

areParams = -> # WTF
  parens = 0
  position = 0
  for token in tokens
    parens++ if exists '('
    parens-- if exists ')'
    position++
    break if parens is 0
  tokens[position].kind is 'then'

parseVariableDeclaration = ->
  match 'make'
  id = match 'id'
  type = optionalTypeMatch()
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

  if not exists ')'
    expList = parseExpList()

  if exists 'newline'
    match 'newline'
  match ')'

  new Args(expList)

parseExpList = ->
  expArray = []

  if exists 'newline'
    match 'newline'
  expArray.push parseExpression()
  while exists ','
    match ','
    if exists 'newline'
      match 'newline'
    expArray.push parseExpression()
  if exists 'newline'
    match 'newline'
  new ExpList(expArray)

parseFunctionExp = ->
  params = parseParams()
  type = optionalTypeMatch()
  match 'does'
  body = parseBlock()
  match 'end'
  new FunctionExp(params, type, body)

parseParams = ->
  match '('

  if not exists ')'
    paramList = parseParamList()

  if exists 'newline'
    match 'newline'
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

parseExp0 = -> # the trailing if and possible else
  direction = parseExp1()
  if exists 'if'
    match 'if'
    condition = parseExp1()
    instruction = null
    direction = new TrailingIf(direction, condition, instruction)
    if exists 'else'
      match 'else'
      instruction = parseExp1()
      direction = new TrailingIf(direction, condition, instruction)

  direction

parseExp1 = -> # the or
  left = parseExp2()
  while exists 'or'
    match 'or'
    right = parseExp2()
    left = new BinaryExpression('or', left, right)
  left

parseExp2 = -> # the and
  left = parseExp3()
  while exists 'and'
    match 'and'
    right = parseExp3()
    left = new BinaryExpression('and', left, right)
  left

parseExp3 = -> # the relops
  left = parseExp4()
  if at ['<', '<=', '==', '!=', '>=', '>']
    op = match()
    right = parseExp4()
    left = new BinaryExpression(op, left, right)

parseExp4 = -> # list comprehension i think i.e. thru till by
  left = parseExp5()
  if ((exists 'thru') or (exists 'till'))
    op = match()
    right = parseExp5()
    if exists 'by'
      # include skip factor in range
      match 'by'
      left = new Range op, left, right, parseExp5()
    else
      left = new Range op, left, right
  left

parseExp5 = -> # addition subtraction
  left = parseExp6()
  while at ['+', '-']
    op = match()
    right = parseExp6()
    left = new BinaryExpression(op, left, right)
  left

parseExp6 = -> # multiplication division
  left = parseExp7()
  while at ['*', '/', '%']
    op = match()
    right = parseExp7()
    left = new BinaryExpression op, left, right
  left

parseExp7 = -> # the prefix ops
  if at ['-', 'not', '!']
    op = match()
    operand = parseExp8()
    new UnaryExpression op, operand
  else
    parseExp8()

parseExp8 = -> # the power (**)
  left = parseExp9()
  if exists '**'
    match '**'
    left = new BinaryExpression('**', left, parseExp5())
  left

parseExp9 = -> # property, set, args
  input = parseExp9()
  while (at ['.', '[', '('])
    while exists '.'
      match '.'
      input = new FieldAccess(input, parseExp10())
    while exists '['
      match '['
      input = new IterableItem(input, parseExp4())
      match ']'
    while exists '('
      input = new FunctionExp(input, parseArgs())
  input

parseExp10 = -> # literals, id, expression in parens
  if at ['true', 'false']
    new BooleanLiteral match()
  else if at 'INTLIT'
    new IntegerLiteral match()
  else if at 'FLOATLIT'
    new FloatLiteral match()
  else if at 'id'
    new VariableReference match()
  else if at '('
    match()
    expression = parseExpression()
    match ')'
    expression
  else if at 'STRINGLIT'
    new StringLiteral match()
  else if exists '{'
    parseDict()
  else if exists '['
    parseList()
  else
    CustomError 'Unlawful start of expression', tokens[0]

parseList = ->
  listicles = []
  match '['

  if not exists ']'
    listicles = parseExpList()

  if exists 'newline'
    match 'newline'
  match ']'
  new List(listicles)

parseDict = ->
  bindingArray = []
  match '{'

  if not exists '}'
    bindingArray = parseBindingList()

  if exists 'newline'
    match 'newline'
  match '}'
  new Dict(bindingArray)

parseBindingList = ->
  bindingList = []

  bindingList.push parseBinding()

  while exists ','
    match ','
    bindingList.push parseBinding()
  new BindingList(bindingList)

parseBinding = ->
  if exists 'newline'
    match 'newline'

  key = match 'id'
  type = optionalTypeMatch()

  match 'to'
  value = parseExpression()

  if exists 'newline'
    match 'newline'
  new Binding(key, type, value)

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

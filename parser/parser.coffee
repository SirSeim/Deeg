scanner = require "#{__dirname}/../scanner/scanner.coffee"
error = require "#{__dirname}/../error/error.coffee"
Program = require "#{__dirname}/../entities/program.coffee"
Block = require "#{__dirname}/../entities/block.coffee"
Type = require "#{__dirname}/../entities/type.coffee"

ForStatement = require "#{__dirname}/../entities/forstatement.coffee"
StdFor = require "#{__dirname}/../entities/stdfor.coffee"
StdForIdExp = require "#{__dirname}/../entities/stdforidexp.coffee"
CountFor = require "#{__dirname}/../entities/countfor.coffee"
CountsFor = require "#{__dirname}/../entities/countsfor.coffee"
IfStatement = require "#{__dirname}/../entities/ifstatement.coffee"
ElseIfStatement = require "#{__dirname}/../entities/elseifstatement.coffee"
ElseStatement = require "#{__dirname}/../entities/elsestatement.coffee"

MatchStatement = require "#{__dirname}/../entities/matchstatement.coffee"

PatBlock = require "#{__dirname}/../entities/patblock.coffee"
PatLine = require "#{__dirname}/../entities/patline.coffee"
Patterns = require "#{__dirname}/../entities/patterns.coffee"
Pattern = require "#{__dirname}/../entities/pattern.coffee"

WhileStatement = require "#{__dirname}/../entities/whilestatement.coffee"
ReturnStatement = require "#{__dirname}/../entities/returnstatement.coffee"
ClassDefinition = require "#{__dirname}/../entities/classdefinition.coffee"

VariableDeclaration = require "#{__dirname}/../entities/variabledeclaration.coffee"
VariableAssignment = require "#{__dirname}/../entities/variableassignment.coffee"
VariableExpression = require "#{__dirname}/../entities/variableexpression.coffee"
Args = require "#{__dirname}/../entities/args.coffee"
ExpList = require "#{__dirname}/../entities/explist.coffee"

FunctionExp = require "#{__dirname}/../entities/functionexp.coffee"
Params = require "#{__dirname}/../entities/params.coffee"
ParamList = require "#{__dirname}/../entities/paramlist.coffee"

TrailingIf = require "#{__dirname}/../entities/trailingif.coffee"
VariableReference = require "#{__dirname}/../entities/variablereference.coffee"
FieldAccess = require "#{__dirname}/../entities/fieldaccess.coffee"
IterableItem = require "#{__dirname}/../entities/iterableitem.coffee"
Range = require "#{__dirname}/../entities/range.coffee"
IntegerLiteral = require "#{__dirname}/../entities/integerliteral.coffee"
FloatLiteral = require "#{__dirname}/../entities/floatliteral.coffee"
BooleanLiteral = require "#{__dirname}/../entities/booleanliteral.coffee"
StringLiteral = require "#{__dirname}/../entities/stringliteral.coffee"

List = require "#{__dirname}/../entities/list.coffee"
Dict = require "#{__dirname}/../entities/dict.coffee"
BindingList = require "#{__dirname}/../entities/bindinglist.coffee"
Binding = require "#{__dirname}/../entities/binding.coffee"

BinaryExpression = require "#{__dirname}/../entities/binaryexpression.coffee"
UnaryExpression = require "#{__dirname}/../entities/unaryexpression.coffee"

tokens = []

module.exports = (scannerOutput, callback) ->
  tokens = scannerOutput
  parsingErrors = []
  state = {
    errors: parsingErrors
  }
  program = parseProgram(state)
  match 'EOF'
  callback parsingErrors, program

parseProgram = (state) ->
  new Program(parseBlock(state))

parseBlock = (state) ->
  statements = []
  loop
    statements.push parseStatement(state) # What if there's `newline` before the Stmt
    match 'newline'
    break if exists ['EOF', 'end', 'else']
  new Block(statements)

parseStatement = (state) ->
  if exists 'while'
    parseWhileStatement(state)
  else if exists 'for'
    parseForStatement(state)
  else if exists 'match'
    parseMatchStatement(state)
  else if exists 'if'
    parseIfStatement(state)
  else if exists 'deeg'
    parseReturnStatement(state)
  else if exists 'class'
    parseClassDefinition(state)
  else if exists 'to' # disclaimer, this is not correct
    parseBinding(state)
  else
    parseExpression(state)

parseClassDefinition = (state) ->
  match 'class'
  id = match 'id'

  if exists 'extends'
    match 'extends'
    parentId = match 'id'

  body = parseBlock(state)

  match 'end'
  new ClassDefinition(id, body, parentId)

parseIfStatement = (state) ->
  match 'if'
  condition = parseExpression(state)
  match 'then'
  if exists 'newline'
    match 'newline'
    body = parseBlock(state)
  else
    body = parseStatement(state)
  if exists 'else if'
    elseIfStatement = parseElseIfStatement(state)
  if exists 'else'
    elseStatement = parseElseStatement(state)
  match 'end'
  new IfStatement(condition, body, elseIfStatement, elseStatement)

parseElseIfStatement = (state) ->
  match 'else if'
  condition = parseExpression(state)
  match 'then'
  if exists 'newline'
    match 'newline'
    body = parseBlock(state)
  else
    body = parseStatement(state)
  if exists 'else if'
    elseIfStatement = parseElseIfStatement(state)
  new ElseIfStatement(condition, body, elseIfStatement)

parseElseStatement = (state) ->
  match 'else'
  if exists 'newline'
    match 'newline'
    body = parseBlock(state)
  else
    body = parseStatement(state)
  new ElseStatement(body)


parseWhileStatement = (state) ->
  match 'while'
  condition = parseExpression(state)
  match 'then'
  if exists 'newline'
    match 'newline'
    body = parseBlock(state)
  else
    body = parseStatement(state)
  match 'end'
  new WhileStatement(condition, body)

parseMatchStatement = (state) ->
  match 'match'
  matchee = parseExpression(state)
  match 'with'
  match 'newline' # maybe optional
  patBlock = parsePatBlock(state)
  match 'end'
  new MatchStatement(matchee, patBlock)

parsePatBlock = (state) ->
  patLines = []
  loop
    patLines.push parsePatLine(state) # What if there's `newline` before the Stmt
    match 'newline'
    break if exists 'end'
  new PatBlock(patLines)

parsePatLine = (state) ->
  match '>>'
  patterns = parsePatterns(state)
  if exists 'if'
    match 'if'
    condition = parseExpression(state)
  match 'then'
  instruction = parseStatement(state)
  new PatLine(patterns, condition, instruction)

parsePatterns = (state) ->
  tails = []
  head = parsePattern(state)
  while exists '|'
    match '|'
    tails.push parsePattern(state)
  new Patterns(head, tails)

parsePattern = (state) ->
  if exists '_'
    pattern = match '_'
  else
    pattern = parseExpression(state)
  type = optionalTypeMatch(state)
  new Pattern(pattern, type)

parseForStatement = (state) ->
  match 'for'
  forIterate = determineForType(state)
  match 'then'

  if exists 'newline'
    match 'newline'
    body = parseBlock(state)
  else
    body = parseStatement(state)
  match 'end'

  new ForStatement(forIterate, body)

determineForType = (state) ->
  if exists 'id' and optionalTypeCheck(state) # true if StdFor
    # DOES NOT WORK because we can only check one token ahead right now
    parseStdFor(state)
  else if exists 'id'
    parseCountsFor(state)
  else if exists 'count'
    parseCountFor(state)
  else
    message = "Expected \"id\" or \"count\" but found \"#{tokens[0].kind}\""
    error message, tokens[0]

parseStdFor = (state) -> # use array of ids to range
  id = match 'id'
  type = optionalTypeMatch(state)
  match 'in'
  range = parseExpression(state)
  if exists 'and'
    additionalList = parseStdForIdExp(state)
  new StdFor(id, type, range, additionalList)

parseStdForIdExp = (state) ->
  idList = []
  expList = []
  typeList = []
  while exists 'and'
    match 'and'
    idList.push match 'id'
    typeList.push optionalTypeMatch(state)
    match 'in'
    expList.push parseExpression(state)
  new StdForIdExp(idList, typeList, expList)

parseCountsFor = (state) ->
  id = match 'id'
  match 'counts'
  tally = parseExpression(state)
  new CountsFor(id, tally)

parseCountFor = (state) ->
  match 'count'
  tally = parseExpression(state)
  new CountFor(tally)

parseReturnStatement = (state) ->
  match 'deeg'
  new ReturnStatement(parseExpression(state))

parseType = (state) -> # TODO: needs work for class types, be more generalized
  if exists ['bool', 'int', 'float', 'string', 'Dict']
    Type.forName match().lexeme
  else if exists 'List'
    Type.forName match 'List'
    listType = optionalTypeMatch(state)
  else if exists 'Function'
    args = []
    Type.forName match 'Function('
    unless exists ')'
      args.push parseType(state)
      while exists ','
        match ','
        args.push parseType(state)
    match ')'
    functionType = optionalTypeMatch(state)
  else
    error 'Type expected', tokens[0]

optionalTypeMatch = (state) ->
  if optionalTypeCheck(state)
    match ':'
    parseType(state)

optionalTypeCheck = (state) ->
  exists ':'

parseExpression = (state) ->
  if exists 'make'
    parseVariableDeclaration(state)
  else if exists('id') and exists ['=','+=','-=','*=','/=','%=','++','--'], 1
    # Does not support full Deeg grammer for complex VarExp
    parseVariableAssignment(state)
  else if exists('(') and areParams(state)
    parseFunctionExp(state)
  else
    parseExp0(state)

areParams = (state) -> # WTF
  parens = 0
  position = 0
  while true
    parens++ if exists '(', position
    parens-- if exists ')', position
    position++
    break if parens is 0
  tokens[position].kind is 'does'

parseVariableDeclaration = (state) ->
  match 'make'
  id = match 'id'
  type = optionalTypeMatch(state)
  if exists '='
    match '='
    value = parseExpression(state)
  else
    value = null
  new VariableDeclaration(id, type, value)

parseVariableAssignment = (state) ->
  id = parseVariableExpression(state)
  if exists '='
    match '='
    value = parseExpression(state)
  else if exists '+='
    match '+='
    value = parseExpression(state)
    modifier = '+='
  else if exists '-='
    match '-='
    value = parseExpression(state)
    modifier = '-='
  else if exists '/='
    match '/='
    value = parseExpression(state)
    modifier = '/='
  else if exists '*='
    match '*='
    value = parseExpression(state)
    modifier = '*='
  else if exists '%='
    match '%='
    value = parseExpression(state)
    modifier = '%='
  else if exists '++'
    match '++'
    value = null
    modifier = '++'
  else if exists '--'
    match '--'
    value = null
    modifier = '--'
  new VariableAssignment(id, value, modifier)

parseVariableExpression = (state) ->
  id = match 'id'
  depth = []
  while exists ['.', '[', '(']
    if exists '.'
      match '.'
      depth.push parseExp8(state)
    else if exists '['
      match '['
      exp3 = parseExp3(state)
      match ']'
    else if exists '('
      depth.push parseArgs(state)
      if exists '.'
        match '.'
        depth.push parseExp8(state)
      else if exists '['
        match '['
        depth.push parseExp3(state)
        match ']'
      else
        reportError state, 'Invalid property/array following function call', tokens[0]
  new VariableExpression(id, depth)

parseArgs = (state) ->
  match '('

  if not exists ')'
    expList = parseExpList(state)

  if exists 'newline'
    match 'newline'
  match ')'

  new Args(expList)

parseExpList = (state) ->
  expArray = []

  if exists 'newline'
    match 'newline'
  expArray.push parseExpression(state)
  while exists ','
    match ','
    if exists 'newline'
      match 'newline'
    expArray.push parseExpression(state)
  if exists 'newline'
    match 'newline'
  new ExpList(expArray)

parseFunctionExp = (state) ->
  params = parseParams(state)
  type = optionalTypeMatch(state)
  match 'does'
  if exists 'newline'
    match 'newline'
    body = parseBlock(state)
  else
    body = parseStatement(state)
  match 'end'
  new FunctionExp(params, type, body)

parseParams = (state) ->
  match '('

  if not exists ')'
    paramList = parseParamList(state)

  if exists 'newline'
    match 'newline'
  match ')'
  new Params(paramList)

parseParamList = (state) ->
  paramList = []
  # this list will have expressions and types may follow right after
  # null will follow if no type specified
  # e.g. (5:int, "two", "hello":string)
  # ==> [5, int, "two", null, "hello", string]
  if exists 'newline'
    match 'newline'
  paramList.push parseExpression(state)
  paramList.push optionalTypeMatch(state)
  while exists ','
    match ','
    if exists 'newline'
      match 'newline'
    paramList.push parseExpression(state)
    paramList.push optionalTypeMatch(state)
  if exists 'newline'
    match 'newline'
  new ParamList(paramList)

parseExp0 = (state) -> # the trailing if and possible else
  direction = parseExp1(state)
  if exists 'if'
    match 'if'
    condition = parseExp1(state)
    match 'then'
    if exists 'newline'
      match 'newline'
      instruction = parseBlock(state)
    else
      instruction = parseStatement(state)
    direction = new TrailingIf(direction, condition, instruction)
    if exists 'else'
      match 'else'
      instruction = parseExp1(state)
      direction = new TrailingIf(direction, condition, instruction)
    match 'end'
  direction

parseExp1 = (state) -> # the or
  left = parseExp2(state)
  while exists 'or'
    match 'or'
    right = parseExp2(state)
    left = new BinaryExpression('or', left, right)
  left

parseExp2 = (state) -> # the and
  left = parseExp3(state)
  while exists 'and'
    match 'and'
    right = parseExp3(state)
    left = new BinaryExpression('and', left, right)
  left

parseExp3 = (state) -> # the relops
  left = parseExp4(state)
  if exists ['<', '<=', '==', '!=', '>=', '>']
    op = match()
    right = parseExp4(state)
    left = new BinaryExpression(op, left, right)
  left

parseExp4 = (state) -> # list comprehension i think i.e. thru till by
  left = parseExp5(state)
  if ((exists 'thru') or (exists 'till'))
    op = match()
    right = parseExp5(state)
    if exists 'by'
      # include skip factor in range
      match 'by'
      left = new Range op, left, right, parseExp5(state)
    else
      left = new Range op, left, right
  left

parseExp5 = (state) -> # addition subtraction
  left = parseExp6(state)
  while exists ['+', '-']
    op = match()
    right = parseExp6(state)
    left = new BinaryExpression(op, left, right)
  left

parseExp6 = (state) -> # multiplication division
  left = parseExp7(state)
  while exists ['*', '/', '%']
    op = match()
    right = parseExp7(state)
    left = new BinaryExpression op, left, right
  left

parseExp7 = (state) -> # the prefix ops
  if exists ['-', 'not', '!']
    op = match()
    operand = parseExp8(state)
    new UnaryExpression op, operand
  else
    parseExp8(state)

parseExp8 = (state) -> # the power (**)
  left = parseExp9(state)
  if exists '**'
    match '**'
    left = new BinaryExpression('**', left, parseExp5(state))
  left

parseExp9 = (state) -> # property, set, args
  input = parseExp10(state)
  while (exists ['.', '[', '('])
    while exists '.'
      match '.'
      input = new FieldAccess(input, parseExp10(state))
    while exists '['
      match '['
      input = new IterableItem(input, parseExp4(state))
      match ']'
    while exists '('
      input = new FunctionExp(input, parseArgs(state))
  input

parseExp10 = (state) -> # literals, id, expression in parens
  if exists ['true', 'false']
    new BooleanLiteral match()
  else if exists 'intlit'
    new IntegerLiteral match()
  else if exists 'floatlit'
    new FloatLiteral match()
  else if exists 'id'
    new VariableReference match()
  else if exists '('
    match()
    expression = parseExpression(state)
    match ')'
    expression
  else if exists 'strlit'
    new StringLiteral match()
  else if exists '{'
    parseDict(state)
  else if exists '['
    parseList(state)
  else
    # console.log 'broken'
    # print()
    reportError state, 'Unlawful start of expression', match()

parseList = (state) ->
  listicles = []
  match '['

  if not exists ']'
    listicles = parseExpList(state)

  if exists 'newline'
    match 'newline'
  match ']'
  new List(listicles)

parseDict = (state) ->
  bindingArray = []
  match '{'

  if not exists '}'
    bindingArray = parseBindingList(state)

  if exists 'newline'
    match 'newline'
  match '}'
  new Dict(bindingArray)

parseBindingList = (state) ->
  bindingList = []

  bindingList.push parseBinding(state)

  while exists ','
    match ','
    bindingList.push parseBinding(state)
  new BindingList(bindingList)

parseBinding = (state) ->
  if exists 'newline'
    match 'newline'

  key = match 'id'
  type = optionalTypeMatch(state)

  match 'to'
  value = parseExpression(state)

  if exists 'newline'
    match 'newline'
  new Binding(key, type, value)

exists = (kind, index=0) ->
  if tokens.length is 0
    error 'Unexpected end of source program'
  else if Array.isArray kind
    return tokens[index].kind in kind
  kind is undefined or (tokens[index] and kind is tokens[index].kind)

reportError = (state, message, token) ->
  if token.kind is token.lexeme
    addend = " with '#{token.kind}'"
  else
    addend = " with '#{token.kind}':#{token.lexeme}"
  state.errors.push error (message + addend), token

match = (kind, optional=false) ->
  if tokens.length is 0
    error 'Unexpected end of source program'
  else if kind is undefined or (tokens[0] and kind is tokens[0].kind)
    tokens.shift()
  else if optional
    return
  else
    error "Expected \"#{kind}\" but found \"#{tokens[0].kind}\"", tokens[0]

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
WildCard = require "#{__dirname}/../entities/wildcard.coffee"


WhileStatement = require "#{__dirname}/../entities/whilestatement.coffee"
ReturnStatement = require "#{__dirname}/../entities/returnstatement.coffee"
ClassDefinition = require "#{__dirname}/../entities/classdefinition.coffee"

VariableDeclaration = require "#{__dirname}/../entities/variabledeclaration.coffee"
VariableAssignment = require "#{__dirname}/../entities/variableassignment.coffee"
VariableExpression = require "#{__dirname}/../entities/variableexpression.coffee"
Args = require "#{__dirname}/../entities/args.coffee"
ExpList = require "#{__dirname}/../entities/explist.coffee"

FunctionExp = require "#{__dirname}/../entities/functionexp.coffee"
Function = require "#{__dirname}/../entities/function.coffee"
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
state = {
  errors: []
}

module.exports = (scannerOutput, callback) ->
  tokens = scannerOutput
  state.errors = []
  program = parseProgram()
  match 'EOF'
  callback state.errors, program

parseProgram = ->
  new Program(parseBlock())

parseBlock = ->
  statements = []
  loop
    statements.push parseStatement() # What if there's `newline` before the Stmt
    match 'newline'
    break if exists ['EOF', 'end', 'else']
  new Block(statements)

parseStatement = ->
  if exists 'while'
    parseWhileStatement()
  else if exists 'for'
    parseForStatement()
  else if exists 'match'
    parseMatchStatement()
  else if exists 'if'
    parseIfStatement()
  else if exists 'deeg'
    parseReturnStatement()
  else if exists 'class'
    parseClassDefinition()
  else if exists 'to' # disclaimer, this is not correct
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
  if exists 'newline'
    match 'newline'
    body = parseBlock()
  else
    body = parseStatement()
  if exists('else') and exists 'if', 1
    elseIfStatement = parseElseIfStatement()
  if exists 'else'
    elseStatement = parseElseStatement()
  match 'end'
  new IfStatement(condition, body, elseIfStatement, elseStatement)

parseElseIfStatement = ->
  match 'else'
  match 'if'
  condition = parseExpression()
  match 'then'
  if exists 'newline'
    match 'newline'
    body = parseBlock()
  else
    body = parseStatement()
  if exists 'else if'
    elseIfStatement = parseElseIfStatement()
  new ElseIfStatement(condition, body, elseIfStatement)

parseElseStatement = ->
  match 'else'
  if exists 'newline'
    match 'newline'
    body = parseBlock()
  else
    body = parseStatement()
  new ElseStatement(body)


parseWhileStatement = ->
  match 'while'
  condition = parseExpression()
  match 'then'
  if exists 'newline'
    match 'newline'
    body = parseBlock()
  else
    body = parseStatement()
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
    break if exists 'end'
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
  if exists '_'
    match '_'
    type = optionalTypeMatch()
    pattern = new WildCard(type)
  else
    pattern = parseExp10()
  type = optionalTypeMatch()
  new Pattern(pattern, type)

parseForStatement = ->
  match 'for'
  forIterate = determineForType()
  match 'then'

  if exists 'newline'
    match 'newline'
    body = parseBlock()
  else
    body = parseStatement()
  match 'end'

  new ForStatement(forIterate, body)

determineForType = ->
  if exists 'id' and optionalTypeCheck() # true if StdFor
    # DOES NOT WORK because we can only check one token ahead right now
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
  expression = parseExpression()
  new ReturnStatement(expression)

# NO LONGER USED
# parseType = -> # TODO: needs work for class types, be more generalized
#   if exists ['bool', 'int', 'float', 'string', 'Dict']
#     Type.forName match().lexeme
#   else if exists 'List'
#     Type.forName match 'List'
#     listType = optionalTypeMatch()
#   else if exists 'Function'
#     args = []
#     Type.forName match 'Function('
#     unless exists ')'
#       args.push parseType()
#       while exists ','
#         match ','
#         args.push parseType()
#     match ')'
#     functionType = optionalTypeMatch()
#   else
#     error 'Type expected', tokens[0]

optionalTypeMatch = ->
  if exists 'type'
    match()

# NO LONGER USED
# optionalTypeCheck = ->
#   exists ':'

parseExpression = ->
  if exists 'make'
    parseVariableDeclaration()
  else if exists('id') and exists ['=','+=','-=','*=','/=','%=','++','--'], 1
    # Does not support full Deeg grammer for complex VarExp
    parseVariableAssignment()
  else if exists('(') and areParams()
    parseFunctionExp()
  else
    parseExp0()

areParams = -> # WTF
  parens = 0
  position = 0
  while true
    parens++ if exists '(', position
    parens-- if exists ')', position
    position++
    break if parens is 0
  tokens[position].kind is 'does'

parseVariableDeclaration = ->
  match 'make'
  id = match 'id'
  type = optionalTypeMatch()
  if exists '='
    match '='
    value = parseExpression()
  else
    value = null
  new VariableDeclaration(id, type, value)

parseVariableAssignment = ->
  id = parseVariableExpression()
  if exists '='
    match '='
    value = parseExpression()
  else if exists '+='
    match '+='
    value = parseExpression()
    modifier = '+='
  else if exists '-='
    match '-='
    value = parseExpression()
    modifier = '-='
  else if exists '/='
    match '/='
    value = parseExpression()
    modifier = '/='
  else if exists '*='
    match '*='
    value = parseExpression()
    modifier = '*='
  else if exists '%='
    match '%='
    value = parseExpression()
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

parseVariableExpression = ->
  id = match 'id'
  depth = []
  while exists ['.', '[', '(']
    if exists '.'
      match '.'
      depth.push parseExp8()
    else if exists '['
      match '['
      exp3 = parseExp3()
      match ']'
    else if exists '('
      depth.push parseArgs()
      if exists '.'
        match '.'
        depth.push parseExp8()
      else if exists '['
        match '['
        depth.push parseExp3()
        match ']'
      else
        reportError 'Invalid property/array following function call', tokens[0]
  new VariableExpression(id, depth)

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
  if exists 'newline'
    match 'newline'
    body = parseBlock()
  else
    body = parseStatement()
  match 'end'
  new Function(params, type, body)

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
  # PARAMS NEED WORK on types
  # if exists 'type'
  #   paramList.push optionalTypeMatch()
  while exists ','
    match ','
    if exists 'newline'
      match 'newline'
    paramList.push parseExpression()
    # ^^ PARAMS NEED WORK
    # paramList.push optionalTypeMatch()
  if exists 'newline'
    match 'newline'
  new ParamList(paramList)

parseExp0 = -> # the trailing if and possible else
  direction = parseExp1()
  if exists 'if'
    match 'if'
    condition = parseExp1()
    match 'then'
    if exists 'newline'
      match 'newline'
      instruction = parseBlock()
    else
      instruction = parseStatement()
    direction = new TrailingIf(direction, condition, instruction)
    if exists 'else'
      match 'else'
      instruction = parseExp1()
      direction = new TrailingIf(direction, condition, instruction)
    match 'end'
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
  if exists ['<', '<=', '==', '!=', '>=', '>']
    op = match()
    right = parseExp4()
    left = new BinaryExpression(op, left, right)
  left

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
  while exists ['+', '-']
    op = match()
    right = parseExp6()
    left = new BinaryExpression(op, left, right)
  left

parseExp6 = -> # multiplication division
  left = parseExp7()
  while exists ['*', '/', '%']
    op = match()
    right = parseExp7()
    left = new BinaryExpression op, left, right
  left

parseExp7 = -> # the prefix ops
  if exists ['-', 'not', '!']
    op = match()
    operand = parseExp8()
    new UnaryExpression op, operand
  else
    parseExp8()

parseExp8 = -> # the power (**)
  left = parseExp9()
  if exists '**'
    op = match '**'
    right = parseExp5()
    left = new BinaryExpression op, left, right
  left

parseExp9 = -> # property, set, args
  input = parseExp10()
  while (exists ['.', '[', '('])
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
    expression = parseExpression()
    match ')'
    expression
  else if exists 'strlit'
    new StringLiteral match()
  else if exists '{'
    parseDict()
  else if exists '['
    parseList()
  else
    reportError 'Unlawful start of expression', match()

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

exists = (kind, index=0) ->
  if tokens.length is 0
    error 'Unexpected end of source program'
  else if Array.isArray kind
    return tokens[index].kind in kind
  kind is undefined or (tokens[index] and kind is tokens[index].kind)

reportError = (message, token) ->
  if token.kind is token.lexeme
    message += " with '#{token.kind}'"
  else
    message += " with '#{token.kind}':#{token.lexeme}"
  state.errors.push error message, token

match = (kind, optional=false) ->
  if tokens.length is 0
    reportError 'Unexpected end of source program'
  else if kind is undefined or (tokens[0] and kind is tokens[0].kind)
    tokens.shift()
  else if optional
    return
  else
    reportError "Expected '#{kind}'' but found '#{tokens[0].kind}'", tokens[0]

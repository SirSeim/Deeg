Block = require "#{__dirname}/../entities/block.coffee"

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

Set = require 'es5-set'

module.exports = new Set [
  Block,
  ForStatement,
  StdFor,
  StdForIdExp,
  CountFor,
  CountsFor,
  IfStatement,
  ElseIfStatement,
  MatchStatement,
  PatBlock,
  PatLine,
  Patterns,
  WildCard,
  WhileStatement,
  ClassDefinition,
  VariableDeclaration,
  VariableAssignment,
  VariableExpression,
  Args,
  ExpList,
  FunctionExp,
  Function,
  Params,
  ParamList,
  TrailingIf,
  FieldAccess,
  IterableItem,
  Range,
  IntegerLiteral,
  FloatLiteral,
  StringLiteral,
  List,
  Dict,
  BindingList,
  Binding,
  BinaryExpression,
  UnaryExpression
]
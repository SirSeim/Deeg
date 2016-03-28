Type = require './type'
# generate = require '../generators/jsgenerator'

class Range
  constructor: (@op, @left, @right, @skip) ->

  toString: ->
    "(#{@left}#{@op.lexeme}#{@right} by #{@skip or 1})"

  # analyze: (context) ->
  #   @left.analyze context
  #   @right.analyze context
  #   @skip.analyze context if @skip?
  #   @type = Type.LIST
  #   @mustHaveIntegerOperands()

  # mustHaveIntegerOperands: ->
  #   error = '.. and ... range operators must have all integer operands'
  #   @left.type.mustBeInteger(error, @op.lineNumber)
  #   @right.type.mustBeInteger(error, @op.lineNumber)
  #   @skip.type.mustBeInteger(error, @op.lineNumber) if @skip?

  # length: ->
  #   lb = +@left.lexeme.value
  #   ub = if @op.lexeme is '...' then +@right.lexeme.value else +@right.lexeme.value - 1
  #   skip = if @skip then +@skip else 1
  #   console.log 'lb is ' + lb + ' and ub is ' + ub + ' and skip is ' + skip
  #   console.log Math.floor (ub - lb + 1) / skip
  #   Math.floor (ub - lb + 1) / skip

  # optimize: ->
  #   @length()


module.exports = Range
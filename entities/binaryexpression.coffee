 #  ___________________        ____....-----....____
 # (________________LL_)   ==============================
 #     ______\   \_______.--'.  `---..._____...---'
 #     `-------..__            ` ,/
 #     ___         `-._ -  -  - |
 #    ( /        /     `-------'
 #     / __ (   /_
 #   _/_(_)/_)_/ /_
 #  //
 # (/

Type = require "#{__dirname}/type.coffee"
IntegerLiteral = require "#{__dirname}/integerliteral.coffee"
BooleanLiteral = require "#{__dirname}/booleanliteral.coffee"

class BinaryExpression

  constructor: (@op, @left, @right) ->

  toString: ->
    "(BinaryOp #{@op.lexeme} #{@left} #{@right})"

  analyze: (context) ->
    @left.analyze context
    @right.analyze context
    op = @op.lexeme
    switch op
      when '<', '<=', '>=', '>'
        @mustHaveNumOperands()
        @type = Type.BOOL
      when '==', '!='
        @mustHaveCompatibleOperands()
        @type = Type.BOOL
      when 'and', 'or'
        @mustHaveBooleanOperands()
        @type = Type.BOOL
      else
        # All other binary operators are arithmetic
        @mustHaveNumOperands()
        @type = @getNumType

  # optimize: ->
  #   @left = @left.optimize()
  #   @right = @right.optimize()
  #   if @left instanceof IntegerLiteral and @right instanceof IntegerLiteral
  #     return foldIntegerConstants @op.lexeme, +@left.value, +@right.value
  #   else if @left instanceof BooleanLiteral and
  #     @right instanceof BooleanLiteral
  #     return foldBooleanConstants @op.lexeme, @left.value(), @right.value()
  #   else
  #     switch @op.lexeme
  #       when '+'
  #         return @left if isIntegerLiteral(@right, 0)
  #         return @right if isIntegerLiteral(@left, 0)
  #       when '-'
  #         return @left if isIntegerLiteral(@right, 0)
  #         return new IntegerLiteral 0 if sameVariable(@left, @right)
  #       when '*'
  #         return @left if isIntegerLiteral(@right, 1)
  #         return @right if isIntegerLiteral(@left, 1)
  #         return new IntegerLiteral(0) if isIntegerLiteral(@right, 0)
  #         return new IntegerLiteral(0) if isIntegerLiteral(@left, 0)
  #       when '/'
  #         return @left if isIntegerLiteral(@right, 1)
  #         return new IntegerLiteral(1) if sameVariable(@left, @right)
  #   return this

  getNumType: ->
    if @left.type is Type.FLOAT or @right.type is Type.FLOAT
      return Type.FLOAT
    else
      return Type.INT

  mustHaveNumOperands: () ->
    error = "#{@op.lexeme} must have numeric operands
    -- #{@left.type} and #{@right.type} found --"
    @left.type.mustBeNumeric error, @op.line
    @right.type.mustBeNumeric error, @op.line

  mustHaveBooleanOperands: () ->
    error = "#{@op.lexeme} must have boolean operands"
    @left.type.mustBeBoolean error, @op.line
    @right.type.mustBeBoolean error, @op.line

  mustHaveCompatibleOperands: () ->
    error = "#{@op.lexeme} must have mutually compatible operands"
    @left.type.mustBeMutuallyCompatibleWith @right.type, error, @op.line


foldIntegerConstants = (op, d, g) ->
  switch op
    when '+' then new IntegerLiteral(d + g)
    when '-' then new IntegerLiteral(d - g)
    when '*' then new IntegerLiteral(d * g)
    when '/' then new IntegerLiteral(d / g)
    when '%' then new IntegerLiteral(d % g)
    when '<' then new BooleanLiteral(d < g)
    when '<=' then new BooleanLiteral(d <= g)
    when '==' then new BooleanLiteral(d == g)
    when '!=' then new BooleanLiteral(d != g)
    when '>=' then new BooleanLiteral(d >= g)
    when '>' then new BooleanLiteral(d > g)

foldBooleanConstants = (op, d, g) ->
  switch op
    when '==' then new BooleanLiteral(d == g)
    when '!=' then new BooleanLiteral(d != g)
    when 'and' then new BooleanLiteral(d and g)
    when 'or' then new BooleanLiteral(d or g)

module.exports = BinaryExpression
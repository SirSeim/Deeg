Type = require "#{__dirname}/./type.coffee"
IntegerLiteral = require "#{__dirname}/./integerliteral.coffee"
BooleanLiteral = require "#{__dirname}/./booleanliteral.coffee"

class UnaryExpression

  constructor: (@op, @operand) ->

  toString: ->
    "(UnaryOp #{@op.lexeme} #{@operand})"

  analyze: (context) ->
    @operand.analyze context
    switch @op.lexeme
      when 'not'
        mustBoolean = 'The "not" operator requires a boolean operand'
        @operand.type.mustBeBoolean mustBoolean, @op
        @type = Type.BOOL
      when '!'
        mustBoolean = 'The "!" operator requires a boolean operand'
        @operand.type.mustBeBoolean mustBoolean, @op
        @type = Type.BOOL
      when '-'
        mustBoolean = 'The "negation" operator requires an integer operand'
        @operand.type.mustBeInteger mustBoolean, @op
        @type = Type.INT

  optimize: ->
    @operand = @operand.optimize()
    if @op.lexeme is 'not' and @operand instanceof BooleanLiteral
      new BooleanLiteral(not @operand.value)
    else if @op.lexeme is '!' and @operand instanceof BooleanLiteral
      new BooleanLiteral(! @operand.value)
    else if @op.lexeme is '-' and @operand instanceof IntegerLiteral
      new IntegerLiteral(- @operand.value)
    else
      this

module.exports = UnaryExpression
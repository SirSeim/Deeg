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

class UnaryExpression

  constructor: (@op, @operand) ->

  toString: ->
    "(UnaryOp #{@op.lexeme} #{@operand})"

  analyze: (context) ->
    # make sure the operand is legit
    @operand.analyze context
    # make sure the operands get along with the operators :)
    switch @op.lexeme
      when 'not'
        errmsg = 'The "not" operator requires a boolean operand'
        @operand.type.mustBeBoolean errmsg, @op
        @type = Type.BOOL
      when '!'
        errmsg = 'The "!" operator requires a boolean operand'
        @operand.type.mustBeBoolean errmsg, @op
        @type = Type.BOOL
      when '-'
        errmsg = 'The "negation" operator requires an integer operand'
        @operand.type.mustBeInteger errmsg, @op
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
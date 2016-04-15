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
BooleanLiteral = require "#{__dirname}/./booleanliteral.coffee"

class ElseIfStatement

  constructor: (@condition, @body, @elseIfStatement) ->

  toString: () ->
    res = "(else if #{@condition} then #{@body})"
    if @elseIfStatement
      res += " #{@elseIfStatement}"
    res

  analyze: (context) ->
    @condition.analyze context
    booleanCondition = 'Condition in "else if" statement must be boolean'
    @condition.type.mustBeBoolean booleanCondition
    @body.analyze context
    @elseIfStatement.analyze context

  optimize: () ->
    @condition = @condition.optimize()
    @body = @body.optimize()
    if @elseIfStatement
      @elseIfStatement.optimize()
    if @condition instanceof BooleanLiteral and @condition.value() is false
      return null
    return this

module.exports = ElseIfStatement
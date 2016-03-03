BooleanLiteral = require './booleanliteral.coffee'

class WhileStatement

  constructor: (@condition, @body) ->

  toString: () ->
    "(While #{@condition} #{@body})"

  analyze: (context) ->
    @condition.analyze context
    booleanCondition = 'Condition in "while" statement must be boolean'
    @condition.type.mustBeBoolean booleanCondition
    @body.analyze context

  optimize: () ->
    @condition = @condition.optimize()
    @body = @body.optimize()
    if @condition instanceof BooleanLiteral and @condition.value() is false
      return null
    return this

module.exports = WhileStatement
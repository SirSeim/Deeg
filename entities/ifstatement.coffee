BooleanLiteral = require './booleanliteral.coffee'

class IfStatement

  constructor: (@condition, @body) ->

  toString: () ->
    "(If #{@condition} then #{@body})"

  # analyze: (context) ->
  #   @condition.analyze context
  #   booleanCondition = 'Condition in "if" statement must be boolean'
  #   @condition.type.mustBeBoolean booleanCondition
  #   @body.analyze context

  # optimize: () ->
  #   @condition = @condition.optimize()
  #   @body = @body.optimize()
  #   if @condition instanceof BooleanLiteral and @condition.value() is false
  #     return null
  #   return this

module.exports = IfStatement
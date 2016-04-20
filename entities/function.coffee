Type = require "#{__dirname}/./type.coffee"

class Function

  constructor: (@params, @type, @body) ->

  toString: ->
    "(FunctionDef params:#{@params.toString()} type:#{@type} #{@body})"

  # analyze: (context) ->
  #   @type = Type.FUNCTION
  #   localContext = context.createChildContext()

  #   for param in @params
  #     localContext.variableMustNotBeAlreadyDeclared param,
  #       "Duplicate parameter #{param.lexeme} found in function definition"
  #     param.type = Type.ARBITRARY
  #     localContext.addVariable param.lexeme, param

  #   @body.analyze localContext

  # optimize: ->
    

module.exports = Function
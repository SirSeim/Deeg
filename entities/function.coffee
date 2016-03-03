Type = require './type.coffee'

class Function

  constructor: (@params, @body) ->

  toString: ->
    "(Function (#{(param.lexeme for param in @params).join(', ')})
      does #{@body})"

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
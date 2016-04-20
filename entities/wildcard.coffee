Type = require "#{__dirname}/type.coffee"

class WildCard

  constructor: (@type) ->

  toString: ->
    "(WildCard#{' type:' + @type})"

  # analyze: (context) ->
  #   context.variableMustNotBeAlreadyDeclared @id
  #   context.addVariable @id.lexeme, this

  optimize: -> this

module.exports = WildCard
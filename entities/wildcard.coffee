Type = require "#{__dirname}/type.coffee"

class WildCard

  constructor: (@type) ->

  toString: ->
    "(WildCard#{if @type then ' type:'+@type.lexeme else ''})"

  # analyze: (context) ->
  #   context.variableMustNotBeAlreadyDeclared @id
  #   context.addVariable @id.lexeme, this

  optimize: -> this

module.exports = WildCard
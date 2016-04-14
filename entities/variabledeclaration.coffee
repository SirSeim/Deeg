Type = require './type.coffee'

class VariableDeclaration

  constructor: (@id, @type, @value) ->

  toString: ->
    "(VarDec '#{@id.lexeme}' of type:#{@type} = #{@value})"

  # analyze: (context) ->
  #   context.variableMustNotBeAlreadyDeclared @id
  #   context.addVariable @id.lexeme, this

  optimize: -> this

VariableDeclaration.ARBITRARY =
  new VariableDeclaration '<arbitrary>', Type.ARBITRARY

module.exports = VariableDeclaration
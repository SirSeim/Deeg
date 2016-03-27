Type = require './type.coffee'
error = require '../error/error.coffee'

class VariableAssignment

  constructor: (@id, @value) ->

  toString: ->
    "(VarDec :#{@id.lexeme} of type: #{@type} = #{@value})"

  optimize: -> this

  

module.exports = VariableAssignment
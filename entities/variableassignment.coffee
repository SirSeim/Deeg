Type = require "#{__dirname}/type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class VariableAssignment

  constructor: (@id, @value) ->

  toString: ->
    "(VarDec :#{@id.lexeme} of type: #{@type} = #{@value})"

  optimize: -> this

  

module.exports = VariableAssignment
Type = require "#{__dirname}/type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class VariableAssignment

  constructor: (@id, @value, @modifier) ->

  toString: ->
    "(VarAssign #{@id}
        #{if @modifier then 'modifier:'+@modifier+' ' else ''}value:#{@value})"

  optimize: -> this

  

module.exports = VariableAssignment
Type = require './type.coffee'
error = require '../error/error.coffee'

class VariableExpression

  constructor: (@id, @args, @exp8, @exp3) ->

  toString: ->
    "@id and stuff" # disclaimer: this is wrong

  optimize: -> this

  

module.exports = VariableExpression
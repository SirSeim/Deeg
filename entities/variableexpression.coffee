Type = require "#{__dirname}/type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class VariableExpression

  constructor: (@id, @depth) ->

  toString: -> "#{@id.lexeme}" # disclaimer: THIS NEEDS WORK

  optimize: -> this

  

module.exports = VariableExpression
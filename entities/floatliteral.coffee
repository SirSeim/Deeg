Type = require "#{__dirname}/./type.coffee"

class FloatLiteral

  constructor: (@value) ->

  toString: -> @value.lexeme

  analyze: (context) ->
    @type = Type.FLOAT

  optimize: -> this

  expression: -> true

module.exports = FloatLiteral
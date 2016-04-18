Type = require "#{__dirname}/./type.coffee"

class IntegerLiteral

  constructor: (@value) ->

  toString: -> @value.lexeme

  analyze: (context) ->
    @type = Type.INT

  optimize: -> this

module.exports = IntegerLiteral
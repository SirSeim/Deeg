Type = require './type.coffee'

class StringLiteral

  constructor: (@value) ->

  toString: ->
    @value.lexeme

  analyze: (context) ->
    @type = Type.STRING

  length: ->
    @.value.lexeme.length - 2
    
  optimize: ->
    #DEEG

module.exports = StringLiteral
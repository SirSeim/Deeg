Type = require './type.coffee'

class List

  constructor: (@elements) ->

  toString: ->
    "[#{@elements.join(', ')}]"

  analyze: (context) ->
    element.analyze(context) for element in @elements
    @type = Type.LIST

  length: ->
    console.log @elements.length
    @elements.length

  optimize: ->
    #DEEG

module.exports = List
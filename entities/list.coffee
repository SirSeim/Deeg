Type = require './type.coffee'

class List

  constructor: (@listicles) ->

  toString: ->
    "[#{@listicles.join(', ')}]"

  analyze: (context) ->
    element.analyze(context) for element in @listicles
    @type = Type.LIST

  length: ->
    console.log @listicles.length
    @listicles.length

  optimize: ->
    #DEEG

module.exports = List
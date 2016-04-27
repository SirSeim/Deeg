Type = require "#{__dirname}/./type.coffee"

class List

  constructor: (@listicles) ->

  toString: ->
    "[#{@listicles}]"

  analyze: (context) ->
    element.analyze(context) for element in @listicles
    @type = Type.LIST

  length: ->
    console.log @listicles.length
    @listicles.length

  optimize: ->
    #DEEG

module.exports = List
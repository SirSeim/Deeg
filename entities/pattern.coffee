Type = require './type.coffee'

class Pattern

  constructor: (@pattern, @type)->

  toString: -> "(#{@pattern} #{@type})"


  # analyze: (context) ->
  	
  # optimize: -> this

module.exports = PatLine
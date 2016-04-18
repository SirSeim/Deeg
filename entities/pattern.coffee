Type = require "#{__dirname}/./type.coffee"

class Pattern

  constructor: (@pattern, @type)->

  toString: -> "(#{@pattern} #{@type})"


  # analyze: (context) ->
  	
  # optimize: -> this

module.exports = Pattern
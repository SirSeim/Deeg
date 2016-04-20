Type = require "#{__dirname}/./type.coffee"

class Pattern

  constructor: (@pattern, @type)->

  toString: -> "(Pattern #{@pattern}#{if @type then ' type:'+@type else ''})"


  # analyze: (context) ->
  	
  # optimize: -> this

module.exports = Pattern
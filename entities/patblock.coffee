Type = require "#{__dirname}/type.coffee"

class PatBlock

  constructor: (@patLines)->

  toString: -> "(PatBlock #{@patLines.join(' ')})"


  # analyze: (context) ->
  	
  # optimize: -> this

module.exports = PatBlock
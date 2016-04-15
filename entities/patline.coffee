Type = require "#{__dirname}/./type.coffee"

class PatLine

  constructor: (@patterns, @condition, @instruction)->

  conditional = if @condition == null then "" else "#{@condition}"
  toString: -> "(#{@patterns} #{conditional} then #{@instruction})"


  # analyze: (context) ->
  	
  # optimize: -> this

module.exports = PatLine
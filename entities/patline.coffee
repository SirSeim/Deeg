Type = require "#{__dirname}/type.coffee"

class PatLine

  constructor: (@patterns, @condition, @instruction)->

  conditional = if @condition then " #{@condition} " else ' '
  toString: -> "(PatLine #{@patterns}#{conditional}then #{@instruction})"


  analyze: (context) ->
    @condition.analyze context
  	
  optimize: -> this

module.exports = PatLine
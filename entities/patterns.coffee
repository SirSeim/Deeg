Type = require './type.coffee'

class Patterns

  constructor: (@head, @tails)->

  listElements = "|" #how do we want to deal with these?
  toString: -> "(#{@head} #{listElements} #{@tails})"


  # analyze: (context) ->
  	
  # optimize: -> this

module.exports = Patterns
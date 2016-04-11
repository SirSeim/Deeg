Type = require './type.coffee'

class Pattern

  constructor: (@id, @type)->

  toString: -> "(#{@id} #{@type})" #can we make _ an id? 


  # analyze: (context) ->
  	
  # optimize: -> this

module.exports = PatLine
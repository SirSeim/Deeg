Type = require './type.coffee'

class StdFor

  constructor: (@id, @type, @range, @additionalList)->

  toString: -> "(StdFor idexplist:#{@idexplist.join ' '} body:#{@body})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = StdFor
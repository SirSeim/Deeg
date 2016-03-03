Type = require './type'

class StdFor

  constructor: (@idexplist)->

  toString: -> "(StdFor idexplist:#{idexplist.map toString})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = StdFor
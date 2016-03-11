Type = require './type.coffee'

class StdFor

  constructor: (@idexplist, @body)->

  toString: -> "(StdFor idexplist:#{@idexplist.join(' ')} body:#{@body})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = StdFor
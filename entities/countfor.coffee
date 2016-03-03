Type = require './type.coffee'

class CountFor

  constructor: (@exp)->

  toString: -> "(CountFor count #{@exp})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = CountFor
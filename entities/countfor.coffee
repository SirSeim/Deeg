Type = require './type.coffee'

class CountFor

  constructor: (@tally)->

  toString: -> "(CountFor count #{@tally})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = CountFor
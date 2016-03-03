Type = require './type.coffee'

class CountsFor

  constructor: (@id, @exp)->

  toString: -> "(CountsFor #{@id} counts #{@exp})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = CountsFor
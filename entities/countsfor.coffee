Type = require './type.coffee'

class CountsFor

  constructor: (@id, @tally)->

  toString: -> "(CountsFor #{@id} counts #{@tally})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = CountsFor
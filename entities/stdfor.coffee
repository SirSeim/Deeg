Type = require './type.coffee'

class StdFor

  constructor: (@id, @type, @range, @additionalList)->

  toString: -> "(StdFor #{@id}:#{@type} in #{@range}, #{@additionalList})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = StdFor
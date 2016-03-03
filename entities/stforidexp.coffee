Type = require './type'

class StdForIdExp

  constructor: (@id, @exp)->

  # value: ->
  #   @name is 'true'

  toString: -> "(#{@id.lexeme} in #{@exp})"


  # analyze: (context) ->
  #   @type = Type.BOOL

  # optimize: -> this

module.exports = StdForIdExp
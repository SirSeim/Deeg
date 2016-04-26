Type = require "#{__dirname}/type.coffee"

class StdFor

  constructor: (@id, @type, @range, @additionalList)->

  toString: -> "(StdFor #{@id}:#{@type} in #{@range}#{@additionalList})"


  analyze: (context) ->
    # analyze id
    @id.analyze context
    # analyze expression
    @range.analyze context
    # if there are more, analyze 'em
    if @additionalList
      @additionalList.analyze context

  # optimize: -> this

module.exports = StdFor
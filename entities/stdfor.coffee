 #  ___________________        ____....-----....____
 # (________________LL_)   ==============================
 #     ______\   \_______.--'.  `---..._____...---'
 #     `-------..__            ` ,/
 #     ___         `-._ -  -  - |
 #    ( /        /     `-------'
 #     / __ (   /_
 #   _/_(_)/_)_/ /_
 #  //
 # (/

Type = require "#{__dirname}/type.coffee"

class StdFor

  constructor: (@id, @type, @range, @additionalList)->

  toString: ->
    res = "(StdFor "
    for id in [0...@id.length]
      res += ', ' if id > 0
      res += "#{@id[id].lexeme}:#{@type[id]} in #{@range[id]}"
    res += ')'


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
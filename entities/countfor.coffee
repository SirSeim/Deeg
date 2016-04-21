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

error = require "#{__dirname}/../error/error.coffee"
Type = require "#{__dirname}/../entities/type.coffee"
EntityUtils = require "#{__dirname}/./entityutilities.coffee"

class CountFor

  constructor: (@tally)->

  toString: -> 
    "(For count #{@tally})"

  analyze: (context) ->
    @tally.analyze context
    @mustBeCountable()

  mustBeCountable: ->
    error = 'Expression must be countable (integer)'
    @tally.type.mustBeCompatibleWith Type.INT, error, EntityUtils.findLocation @tally

  optimize: -> this

module.exports = CountFor
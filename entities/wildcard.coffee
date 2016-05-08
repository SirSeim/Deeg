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

class WildCard

  constructor: (@type) ->

  toString: ->
    "(WildCard #{if @type then ' type:'+@type else ''})"

  analyze: (context) -> this

  optimize: -> this

module.exports = WildCard
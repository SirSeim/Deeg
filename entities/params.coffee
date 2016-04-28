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

Type = require "#{__dirname}/./type.coffee"
error = require "#{__dirname}/../error/error.coffee"

class Params

  constructor: (@paramList) ->

  toString: ->
    "(Params #{@paramList.toString()})"

  analyze: (context) ->
    @paramList.analyze context

  optimize: -> this

  
module.exports = Params
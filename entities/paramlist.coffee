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

class ParamList

  constructor: (@paramList) ->

  toString: ->
    "(#{param for param in @paramList})"

  analyze: (context) ->
    # each param can analyze itself
    for param in @paramList
      param.analyze context

  optimize: -> this

  

module.exports = ParamList
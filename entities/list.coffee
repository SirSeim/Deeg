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

class List

  constructor: (@listicles) -> # listicles is an expList

  toString: ->
    "[#{@listicles}]"

  analyze: (context) ->
    # analyze the expList
    @listicles.analyze(context)
    # assign appropriate type
    @type = Type.LIST

  length: ->
    console.log @listicles.length
    @listicles.length

  optimize: ->
    #DEEG

module.exports = List
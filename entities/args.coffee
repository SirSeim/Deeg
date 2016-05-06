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
error = require "#{__dirname}/../error/error.coffee"

class Args

  constructor: (@expList) ->

  toString: ->
    "(#{@expList})"

  analyze: (context) ->
    # expList analysis
    @expList.analyze context

  optimize: -> this

  length: -> @expList.length()


module.exports = Args
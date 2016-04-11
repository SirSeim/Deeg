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

Type = require './type.coffee'
error = require '../error/error.coffee'

class Args

  constructor: (@expList) ->

  toString: ->
    "(#{@expList})"

  analyze: (context) ->
    @expList.analyze context

  optimize: -> this


module.exports = Args
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

class Dict

  constructor: (@bindingList) ->

  toString: ->
    "Dict #{@bindingList}"

  analyze: (context) ->
    @bindingList.analyze context

  size: ->
    console.log @keys.length
    @bindingList.length

  optimize: -> this

module.exports = Dict
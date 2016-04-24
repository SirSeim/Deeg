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

class Binding

  constructor: (@key, @type, @value) ->

  toString: ->
    "Binding #{@key} [#{@type}] to #{@value}"

  analyze: (context) ->
    @key.analyze context
    @value.analyze context

  optimize: -> this
  

module.exports = Binding
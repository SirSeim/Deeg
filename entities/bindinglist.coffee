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

class BindingList

  constructor: (@bindingArray) ->

  toString: ->
    "#{(@bindingArray).join(', ')}"

  analyze: (context) ->
    for binding in @bindingArray
      @bindingArray[binding].analyze context

  optimize: -> this
  

module.exports = BindingList
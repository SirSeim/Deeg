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

class BindingList

  constructor: (@bindingArray) ->

  toString: ->
    "#{(@bindingArray).join(', ')}"

  analyze: (context) ->
    # for each binding in the array, analyze yoself
    for binding in @bindingArray
      @bindingArray[binding].analyze context

  optimize: ->
    for binding in @bindingArray
      @bindingArray[binding].optimize()
  

module.exports = BindingList
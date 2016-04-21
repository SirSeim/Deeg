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

BooleanLiteral = require "#{__dirname}/./booleanliteral.coffee"

class ForStatement

  constructor: (@forIterate, @body) ->

  toString: () ->
    "(#{@forIterate} then #{@body})"

  analyze: (context) ->
    @forIterate.analyze context
    @body.analyze context

  # optimize: () ->


module.exports = ForStatement
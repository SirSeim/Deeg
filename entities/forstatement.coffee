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
    # count, counts or standard for analysis
    @forIterate.analyze context
    # analyze that body
    @body.analyze context

  # optimize: () ->


module.exports = ForStatement
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

BooleanLiteral = require "#{__dirname}/booleanliteral.coffee"

class WhileStatement

  constructor: (@condition, @body) ->

  toString: () ->
    "(While #{@condition} then #{@body})"

  analyze: (context) ->
    # check that condition
    @condition.analyze context
    boolmsg = 'Condition in "while" statement must be boolean'
    # condition's gotta be a boolean
    @condition.type.mustBeBoolean boolmsg
    # analyze the body!
    @body.analyze context

  optimize: () ->
    @condition = @condition.optimize()
    @body = @body.optimize()
    if @condition instanceof BooleanLiteral and @condition.value() is false
      return null
    return this

module.exports = WhileStatement
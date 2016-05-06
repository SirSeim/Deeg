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

class VariableReference

  constructor: (@token) ->

  toString: ->
    "#{@token.lexeme}"

  analyze: (context) ->
    # to what is this variable referring
    @referent = context.lookupVariable @token
    # type of referent is the type of this variable
    @type = @referent.type

  optimize: ->
    this

module.exports = VariableReference
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

class FunctionDef

  constructor: (@params, @type, @body) ->

  toString: ->
    "(FunctionDef params:#{@params.toString()} type:#{@type} #{@body})"

  analyze: (context) ->
    # assign appropriate type
    @type = Type.FUNCTION
    # scoping!
    localContext = context.createChildContext()
    # analyze each parameter
    for param in @params
      localContext.variableMustNotBeAlreadyDeclared param,
        "Duplicate parameter #{param.lexeme} found in function definition"
      param.type = Type.UNKNOWN # shrug
      localContext.addVariable param.lexeme, param

    # body analysis
    @body.analyze localContext

  # optimize: ->
    

module.exports = FunctionDef
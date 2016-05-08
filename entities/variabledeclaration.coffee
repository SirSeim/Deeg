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

class VariableDeclaration

  constructor: (@id, @type, @value) ->

  toString: ->
    res = "(VarDec '#{@id.lexeme}'"
    if @type
      res += " of type:#{@type}"
    if @value
      res += " = #{@value}"
    res += ")"
    res

  analyze: (context) ->
    # make sure variable hasn't been declared
    context.variableMustNotBeAlreadyDeclared @id
    @value.analyze context
    if !@type?
      @type = @value.type
    else
      @typesMustMatch context
    # add that shit
    context.addVariable @id.lexeme, this

  optimize: -> this

  typesMustMatch: (context) ->
    error = "#{@type} does not match #{@value.type}"
    @type.mustBeCompatibleWith [@value.type],
                                error,
                                @id


VariableDeclaration.UNKNOWN =
  new VariableDeclaration '<unknown>', Type.UNKNOWN

module.exports = VariableDeclaration
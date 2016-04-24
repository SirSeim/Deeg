error = require "#{__dirname}/../error/error.coffee"
VariableDeclaration = require "#{__dirname}/../entities/variabledeclaration.coffee"
Type = require "#{__dirname}/../entities/type.coffee"
DeegEntities = require "#{__dirname}/../entities/deegentities"
EntityUtils = require "#{__dirname}/../entities/entityutilities"
# entity utilities doesn't seem to be needed here -josh

class AnalysisContext

  constructor: (@parent, @symbolTable = {}) ->

  @initialContext: ->
    new AnalysisContext null, DeegEntities.entities

  createChildContext: ->
    new AnalysisContext this

  variableMustNotBeAlreadyDeclared: (token, errorMsg) ->
    errorMsg ?= "Variable #{token.lexeme} already declared"
    if @symbolTable[token.lexeme]
      error errorMsg, token.line

  addVariable: (name, entity) ->
    entity.type = Type.UNKNOWN unless entity.type
    @symbolTable[name] = entity

  lookupVariable: (token) ->
    variable = @symbolTable[token.lexeme]
    if variable
      variable
    else if not @parent
      error "Variable #{token.lexeme} not found", token.line
      VariableDeclaration.UNKNOWN
    else
      @parent.lookupVariable token

exports.initialContext = AnalysisContext.initialContext
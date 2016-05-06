error = require "#{__dirname}/../error/error.coffee"
VariableDeclaration = require "#{__dirname}/../entities/variabledeclaration.coffee"
Type = require "#{__dirname}/../entities/type.coffee"
DeegEntities = require "#{__dirname}/../entities/deegentities.coffee"
EntityUtils = require "#{__dirname}/../entities/entityutilities.coffee"
# entity utilities doesn't seem to be needed here -josh

class AnalysisContext

  constructor: (@parent, @symbolTable = {}, @errors) ->

  @initialContext: (errors) ->
    new AnalysisContext null, DeegEntities.entities, errors

  createChildContext: ->
    new AnalysisContext this

  variableMustNotBeAlreadyDeclared: (token, errorMsg) ->
    errorMsg ?= "Variable #{token.lexeme} already declared"
    if @symbolTable[token.lexeme]
      @errors.push error errorMsg, token

  addVariable: (name, entity) ->
    entity.type = Type.UNKNOWN unless entity.type
    @symbolTable[name] = entity

  lookupVariable: (token) ->
    variable = @symbolTable[token.lexeme]
    if variable
      variable
    else if not @parent
      @errors.push error "Variable #{token.lexeme} not found", token.line
      VariableDeclaration.UNKNOWN
    else
      @parent.lookupVariable token

  reportError: (msg, location) ->
    if @parent
      @parent.reportError msg, location
    else
      @errors.push error msg, location

exports.initialContext = AnalysisContext.initialContext
# need to figure out that classDef stuff
# teascript has a class_type.coffee file that extends type
# shrug -Josh

Type = require "#{__dirname}/./type"
VariableReference = require "#{__dirname}/./variablereference.coffee"
EntityUtils = require "#{__dirname}/./entityutilities.coffee"

class FieldAccess

  constructor: (@object, @field) ->

  toString: ->
    "(. #{@object} #{@field})"

  analyze: (context) ->
    @object.analyze context
    @mustBeObject()

    if @field instanceof VariableReference
      @mustBeFieldOfObject()

    else
      @field.analyze context
      @type = @field.type

  mustBeFieldOfObject: ->
    unless @object.type is Type.UNKNOWN or
           @object.type.classDef[@field]
      error "field #{@field} not defined in object #{@object}",
                            EntityUtils.findLocation @field
    else
      @type = @object.type?.classDef?[@field].type or Type.UNKNOWN


  mustBeObject: ->
    unless @object.type instanceof ClassType or
            @object.type is Type.UNKNOWN
      error "can only access fields of
                                 objects (found #{@object.type})",
                                 EntityUtils.findLocation @object

  mustBeStringID: ->
    error = 'field ID must be of type string'
    @field.type.mustBeString error, EntityUtils.findLocation @field

  # optimize: ->
  

module.exports = FieldAccess
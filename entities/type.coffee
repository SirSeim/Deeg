error = require "#{__dirname}/../error/error.coffee"

cache = {}

class Type

  constructor: (@name) ->
    cache[@name] = this

  @BOOL = new Type 'bool'
  @INT = new Type 'int'
  @FLOAT = new Type 'float'
  @STRING = new Type 'string'
  @LIST = new Type 'List'
  @DICT = new Type 'Dict'
  @FUNCTION = new Type 'Function'
  @UNKNOWN = new Type '¯\\_(ツ)_/¯'

  toString: -> @name

  mustBeNumeric: (message, location) ->
    @mustBeCompatibleWith [Type.INT, Type.FLOAT], message, location

  mustBeInteger: (message, location) ->
    @mustBeCompatibleWith [Type.INT], message, location

  mustBeBoolean: (message, location) ->
    @mustBeCompatibleWith [Type.BOOL], message, location

  mustBeString: (message, location) ->
    @mustBeCompatibleWith [Type.STR], message, location

  mustBeCompatibleWith: (otherTypes, message, location) ->
    # @ is passed to callback when invoked, for use as its this value
    unless otherTypes.some(@isCompatibleWith, @)
      error message, location

  mustBeMutuallyCompatibleWith: (otherType, message, location) ->
    if not (@isCompatibleWith otherType or otherType.isCompatibleWith(this))
      error message, location

  isCompatibleWith: (otherType) ->
    return this is otherType or
          this is Type.UNKNOWN or
          otherType is Type.UNKNOWN

module.exports = Type
# module.exports =
#   BOOL: Type.BOOL
#   INT: Type.INT
#   UNKNOWN: Type.UNKNOWN
#   forName: (name) -> cache[name]
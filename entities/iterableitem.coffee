Type = require "#{__dirname}/./type.coffee"

class IterableItem

  constructor: (@iterable, @searcher) ->

  toString: ->
    "(GetItem #{@iterable} #{@searcher})"

  # analyze: (context) ->
  #   @iterable.analyze context
  #   @searcher.analyze context

  #   if @isOrderedIterable @iterable
  #     @mustHaveIntegerIdx()
  #   else if @isMap @iterable
  #     @mustHaveIntOrStrKey()
  #   else
  #     throw new CustomError "cannot [] get item of a #{@iterable.type}
  #                            (not iterable)",
  #                           EntityUtils.findLocation @iterable

  #   @type = Type.ARBITRARY

  # isOrderedIterable: (entity) ->
  #   [Type.STR, Type.LIST, Type.TUPLE, Type.SET]
  #     .some entity.type.isCompatibleWith, entity.type

  # isMap: (entity) ->
  #   entity.type.isCompatibleWith Type.MAP

  # mustHaveIntegerIdx: ->
  #   idx = @searcher
  #   error = "#{@iterable.type.toString()} indices must be integers,
  #            not #{idx.type.toString()}"
  #   idx.type.mustBeInteger error, EntityUtils.findLocation idx

  # mustHaveIntOrStrKey: ->
  #   key = @searcher
  #   error = "key of #{@iterable} must be string or float"
  #   key.type.mustBeCompatibleWith [Type.STR, Type.INT],
  #                                 error,
  #                                 EntityUtils.findLocation key

  optimize: ->
    this


module.exports = IterableItem
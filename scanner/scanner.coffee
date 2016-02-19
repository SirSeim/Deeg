# Scanner module
#
#   scan = require './scanner'
#
#   scan filename, (tokens) -> processTheTokens(tokens)

fs = require 'fs'
byline = require 'byline'
{XRegExp} = require 'xregexp'

module.exports = (filename, callback) ->
    tokens = []
    scanningError = null
    callback scanningError, tokens
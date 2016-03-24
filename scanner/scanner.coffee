# Scanner module
#
#   scan = require './scanner'
#
#   scan filename, (tokens) -> processTheTokens(tokens)

fs = require 'fs'
byline = require 'byline'
XRegExp = require 'xregexp'
error = require '../error/error.coffee'

LETTER = XRegExp '[\\p{L}]'
DIGIT = XRegExp '[\\p{Nd}]'
WORD_CHAR = XRegExp '[\\p{L}\\p{Nd}_]'
KEYWORDS = ///
  (make|to|deeg|end|thru|till|by|exists|and|or|unless|if|else|then|not|
  true|false|for|while|does|count|counts|match|with)
///

module.exports = (filename, callback) ->
    baseStream = fs.createReadStream filename, {encoding: 'utf8'}
    baseStream.on 'error', (err) -> error(err)

    stream = byline baseStream, {keepEmptyLines: true}
    tokens = []
    scanningError = null
    callback scanningError, tokens
    
# Scanner module
#
#   scan = require './scanner'
#
#   scan filename, (tokens) -> processTheTokens(tokens)

fs = require 'fs'
byline = require 'byline'
XRegExp = require 'xregexp'
error = require "#{__dirname}/../error/error.coffee"

LETTER = XRegExp '[\\p{L}]'
DIGIT = XRegExp '[\\p{Nd}]'
QUOTES = XRegExp '\"|\''
WORD_CHAR = XRegExp '[\\p{L}\\p{Nd}_]'
KEYWORDS = ///
  (make|to|deeg|end|thru|till|by|exists|and|or|unless|if|else|then|not|
  true|false|for|while|does|count|counts|match|with)
///
TWOCHAROPS = XRegExp '<=|==|>=|!='
ONECHAROPS = XRegExp '[\\+\\-\\*\\/\\(\\)\\,\\=\\<\\>]'
SPACE = XRegExp '\\s'
DOT = XRegExp '[.]'
TYPE = XRegExp ':'
CLOSECURLEY = XRegExp '(})'
OPENCURLEY = XRegExp '({)'
ESCAPE = XRegExp '[\\\\]'
COMMENTBLOCK = XRegExp '(?:###)'


module.exports = (filename, callback) ->
  scanningError = []
  tokens = []
  baseStream = fs.createReadStream filename, {encoding: 'utf8'}
  baseStream.on 'error', (err) ->
    scanningError.push error err
    callback scanningError, tokens

  stream = byline baseStream, {keepEmptyLines: true}
  lineNumber = 0
  state = {
    blockComment: false,
    interpolation: false,
    tokens: tokens,
    scanningError: scanningError
  }
  stream.on 'readable', () ->
    scan stream.read(), ++lineNumber, state
  stream.once 'end', () ->
    tokens.push {kind: 'EOF', lexeme: 'EOF'}
    callback scanningError, tokens
    
scan = (line, lineNumber, state) ->
  return if not line

  [start, pos] = [0, 0]

  emit = (kind, lexeme) ->
    state.tokens.push {kind, lexeme: lexeme or kind, line: lineNumber, col: start+1}

  emitError = (message, location) ->
    state.scanningError.push error message, location

  run = ->
    # Skip spaces
    pos++ while SPACE.test line[pos]
    start = pos

    # Nothing on the line
    return if pos >= line.length

    # Come back from string interpolation
    if CLOSECURLEY.test(line[pos]) and state.interpolation
      return state.interpolation = false

    # Block Comment
    if COMMENTBLOCK.test line.substring(pos, pos+3)
      state.blockComment = not state.blockComment

    # Inside of Block Comment
    return if state.blockComment

    # Comment
    return if line[pos] is '#'

    # Two-character tokens
    if TWOCHAROPS.test line.substring(pos, pos+2)
      emit line.substring pos, pos+2
      pos += 2

    # One-character tokens
    else if ONECHAROPS.test line[pos]
      emit line[pos++]

    # Reserved words or identifiers
    else if LETTER.test line[pos]
      pos++ while WORD_CHAR.test(line[pos]) and pos < line.length
      word = line.substring start, pos
      emit (if KEYWORDS.test word then word else 'id'), word

    # Numeric literals
    else if DIGIT.test line[pos]
      pos++ while DIGIT.test line[pos]

      if DOT.test line[pos]
        pos++
        pos++ while DIGIT.test line[pos]
        emit 'floatlit', line.substring start, pos
      else
        emit 'intlit', line.substring start, pos

    # Type
    else if TYPE.test line[pos]
      pos++
      pos++ while WORD_CHAR.test(line[pos]) and pos < line.length
      emit 'type', line.substring start+1, pos

    # String Literals
    else if QUOTES.test line[pos]
      pos++
      stringParts = []
      while not QUOTES.test(line[pos]) and pos < line.length
        if ESCAPE.test line[pos]
          pos++
          if /n/.test line[pos]
            stringParts.push "20"
            pos++
          else if OPENCURLEY.test line[pos]
            emit 'strlit', stringParts
            start = pos
            emit '+'
            emit '('
            pos++
            state.interpolation = true
            run()
            emit ')'
            emit '+'
            start = ++pos
            stringParts = []
        else
          stringParts.push line[pos].charCodeAt(0).toString(16)
          pos++
      emit 'strlit', stringParts
      pos++


    else
      emitError "Illegal character: '#{line[pos]}'",
        {line: lineNumber, col: pos+1}
      pos++
    run()
  run()

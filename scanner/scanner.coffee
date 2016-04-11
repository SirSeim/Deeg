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
QUOTES = XRegExp '\"|\''
WORD_CHAR = XRegExp '[\\p{L}\\p{Nd}_]'
KEYWORDS = ///
  (make|to|deeg|end|thru|till|by|exists|and|or|unless|if|else|then|not|
  true|false|for|while|does|count|counts|match|with)
///

module.exports = (filename, callback) ->
  baseStream = fs.createReadStream filename, {encoding: 'utf8'}
  baseStream.on 'error', (err) -> console.log error err

  stream = byline baseStream, {keepEmptyLines: true}
  tokens = []
  scanningError = []
  lineNumber = 0
  blockComment = {
    yes: false
  }
  stream.on 'readable', () ->
    scan stream.read(), ++lineNumber, tokens, blockComment, scanningError
  stream.once 'end', () ->
    tokens.push {kind: 'EOF', lexeme: 'EOF'}
    callback scanningError, tokens
    
scan = (line, lineNumber, tokens, blockComment, scanningError) ->
  return if not line

  [start, pos] = [0, 0]

  emit = (kind, lexeme) ->
    tokens.push {kind, lexeme: lexeme or kind, line: lineNumber, col: start+1}

  toHex = (num) ->
    chars = "0123456789ABCDEFGHIJ"
    result = ""
    while num > 0
      result = chars[num%16] + result
      num = Math.floor(num/16)
    result

  run = ->
    # Skip spaces
    pos++ while /\s/.test line[pos]
    start = pos

    # Nothing on the line
    return if pos >= line.length

    # Come back from string interpolation
    return if /(})/.test line[pos]

    # Block Comment
    if /(?:###)/.test line.substring(pos, pos+3)
      blockComment.yes = not blockComment.yes

    # Inside of Block Comment
    return if blockComment.yes

    # Comment
    return if line[pos] is '#'

    # Two-character tokens
    if /<=|==|>=|!=/.test line.substring(pos, pos+2)
      emit line.substring pos, pos+2
      pos += 2

    # One-character tokens
    else if /[+\-*\/(),=<>]/.test line[pos]
      emit line[pos++]

    # Reserved words or identifiers
    else if LETTER.test line[pos]
      pos++ while WORD_CHAR.test(line[pos]) and pos < line.length
      word = line.substring start, pos
      emit (if KEYWORDS.test word then word else 'id'), word

    # Numeric literals
    else if DIGIT.test line[pos]
      pos++ while DIGIT.test line[pos]

      if /[.]/.test line[pos]
        pos++
        pos++ while DIGIT.test line[pos]
        emit 'floatlit', line.substring start, pos
      else
        emit 'intlit', line.substring start, pos

    # Type
    else if /:/.test line[pos]
      pos++
      pos++ while WORD_CHAR.test(line[pos]) and pos < line.length
      emit 'type', line.substring start+1, pos

    # String Literals
    else if QUOTES.test line[pos]
      pos++
      stringParts = []
      while not QUOTES.test(line[pos]) and pos < line.length
        if /(\\)/.test line[pos]
          pos++
          if /n/.test line[pos]
            stringParts.push "20"
            pos++
          else if /({)/.test line[pos]
            emit 'strlit', stringParts
            start = pos
            emit '+'
            emit '('
            run()
            emit ')'
            emit '+'
            start = ++pos
            stringParts = []
        else
          stringParts.push toHex line[pos].charCodeAt(0)
          pos++
      emit 'strlit', stringParts
      pos++


    else
      scanningError.push error "Illegal character: #{line[pos]}",
        {line: lineNumber, col: pos+1}
      pos++
    run()
  run()

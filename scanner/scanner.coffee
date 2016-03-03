# Scanner module
#
#   scan = require './scanner'
#
#   scan filename, (tokens) -> processTheTokens(tokens)

fs = require 'fs'
byline = require 'byline'
XRegExp = require 'xregexp'
error = require '../error/error'

LETTER = XRegExp '[\\p{L}]'
DIGIT = XRegExp '[\\p{Nd}]'
WORD_CHAR = XRegExp '[\\p{L}\\p{Nd}_]'
KEYWORDS = /^(?:make|to|deeg|end|thru|till|by|exists|and|or|unless|if|else|then|not|true|false|for|while|does|count|counts|match|with)$/

module.exports = (filename, callback) ->
    baseStream = fs.createReadStream filename, {encoding: 'utf8'}
    baseStream.on 'error', (err) -> error(err)

    stream = byline baseStream, {keepEmptyLines: true}
    tokens = []
    lineNumber = 0
    stream.on 'readable', () ->
        scan stream.read(), ++lineNumber, tokens
    stream.once 'end', () ->
        tokens.push {kind: 'EOF', lexeme: 'EOF'}
        callback tokens

    scanningError = null
    callback scanningError, tokens
    
scan = (line, lineNumber, tokens) ->
  return if not line

  [start, pos] = [0, 0]

  blockCommentStarted = false

  emit = (kind, lexeme) ->
    tokens.push {kind, lexeme: lexeme or kind, line: lineNumber, col: start+1}

  loop
    # Skip spaces
    pos++ while /\s/.test line[pos]
    start = pos

    # Nothing on the line
    break if pos >= line.length

    # Block Comment
    if line[pos] is '#' and line[pos+1] is '#' and line[pos+2] is '#'
        if !blockCommentStarted
            blockCommentStarted = true
        else 
            blockCommentStarted = false
        break

    # Inside of Block Comment
    break if blockCommentStarted

    # Comment
    break if line[pos] is '#'

    # Two-character tokens
    if /<=|==|>=|!=/.test line.substring(pos, pos+2)
      emit line.substring pos, pos+2
      pos += 2

    # One-character tokens
    else if /[+\-*\/(),:;=<>]/.test line[pos]
      emit line[pos++]

    # Reserved words or identifiers
    else if LETTER.test line[pos]
      pos++ while WORD_CHAR.test(line[pos]) and pos < line.length
      word = line.substring start, pos
      emit (if KEYWORDS.test word then word else 'id'), word

    # Numeric literals
    else if DIGIT.test line[pos]
      pos++ while DIGIT.test line[pos]
      emit 'intlit', line.substring start, pos

    else
      error "Illegal character: #{line[pos]}", {line: lineNumber, col: pos+1}
      pos++

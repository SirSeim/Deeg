chai = require 'chai'
expect = chai.expect
fs = require 'fs'
parse = require "#{__dirname}/../../parser/parser.coffee"
scan = require "#{__dirname}/../../scanner/scanner.coffee"
validParserPrograms = "#{__dirname}/input_programs/valid_programs"
invalidParserPrograms = "#{__dirname}/input_programs/invalid_programs"
outputASTs = require "#{__dirname}/expected_output/output_ASTs.coffee"


describe 'Parser', ->

  describe 'parsing a valid program', ->
    fs.readdirSync(validParserPrograms).forEach (name) ->
      context "when #{name} is passed through the scanner & parser", ->
        it 'parses correctly', (done) ->
          scan "#{validParserPrograms}/#{name}", (err, tokens) ->
            parse tokens, (err, program) ->
              expect(program.toString()).to.eql outputASTs[name.split('.')[0]]
              done()
        it 'has no errors', (done) ->
          scan "#{validParserPrograms}/#{name}", (err, tokens) ->
            parse tokens, (err, program) ->
              expect(err).to.eql []
              done()
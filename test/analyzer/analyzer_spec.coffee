chai = require 'chai'
expect = chai.expect
fs = require 'fs'
parse = require "#{__dirname}/../../parser/parser.coffee"
scan = require "#{__dirname}/../../scanner/scanner.coffee"
validPrograms = "#{__dirname}/input_programs/valid_programs"
invalidPrograms = "#{__dirname}/input_programs/invalid_programs"
outputErrors = require "#{__dirname}/expected_output/output_errors.coffee"


describe 'Analyzer', ->

  describe 'analyzing valid programs', ->
    fs.readdirSync(validPrograms).forEach (name) ->
      context "when #{name} is passed through the scanner & parser & analyzer", ->
        it 'has no errors', (done) ->
          scan "#{validPrograms}/#{name}", (err, tokens) ->
            parse tokens, (err, program) ->
              errors = []
              program.analyze errors
              expect(errors).to.eql []
              done()

  describe 'analyzing invalid programs', ->
    fs.readdirSync(invalidPrograms).forEach (name) ->
      context "when #{name} is passed through the scanner & parser & analyzer", ->
        it 'has the correct errors', (done) ->
          scan "#{invalidPrograms}/#{name}", (err, tokens) ->
            parse tokens, (err, program) ->
              errors = []
              program.analyze errors
              expect(errors).to.eql outputErrors[name.split('.')[0]]
              done()

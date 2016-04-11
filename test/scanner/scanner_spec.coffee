chai = require 'chai'
expect = chai.expect
fs = require 'fs'
path = require 'path'
scan = require "#{__dirname}/../../scanner/scanner.coffee"
validOutputTokens = require "#{__dirname}/expected_output/output_tokens.coffee"
invalidProgramErrors = require "#{__dirname}/expected_output/output_errors.coffee"
validScannerPrograms = "#{__dirname}/input_programs/valid_programs"
invalidScannerPrograms = "#{__dirname}/input_programs/invalid_programs"

describe 'Scanner', ->

  describe 'scanning valid deeg programs', ->
    fs.readdirSync(validScannerPrograms).forEach (name) ->
      context "when #{name} is passed through the scanner", ->
        it 'returns the appropriate tokens', (done) ->
          scan path.join(validScannerPrograms, name), (err, tokens) ->
            expect(tokens).to.eql(validOutputTokens[name.split(".")[0]])
            done()
        it 'has no errors', (done) ->
          scan path.join(validScannerPrograms, name), (err, tokens) ->
            expect(err).to.be.null
            done()

  describe 'scanning invalid deeg programs', ->
    fs.readdirSync(validScannerPrograms).forEach (name) ->
      context "when #{name} is passed through the scanner", ->
        it 'has the correct errors', (done) ->
          scan path.join(validScannerPrograms, name), (err, tokens) ->
            expect(err).to.eql(invalidProgramErrors[name.split(".")[0]])
            done()


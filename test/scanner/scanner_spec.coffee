chai = require 'chai'
expect = chai.expect
scan = require "#{__dirname}/../../scanner/scanner.coffee"
outputTokens = require "#{__dirname}/expected_output/output_tokens.coffee"
validScannerPrograms = "#{__dirname}/input_programs/valid_programs"
invalidScannerPrograms = "#{__dirname}/input_programs/invalid_programs"

describe 'Scanner', ->

  describe 'scanning valid deeg programs', ->
    describe 'deeg program #1', ->
      context 'when test program1.deeg is passed through the scanner', ->
        expectedTokens1 = outputTokens.program1
        it 'returns the appropriate tokens', (done) ->
          scan "#{validScannerPrograms}/program1.deeg", (err, tokens) ->
            expect(tokens).to.eql(expectedTokens1)
            done()
        it 'has no errors', (done) ->
          scan "#{validScannerPrograms}/program1.deeg", (err, tokens) ->
            expect(err).to.be.null
            done()

    describe 'deeg program #2', ->
      context 'when test program2.deeg is passed through the scanner', ->
        expectedTokens2 = outputTokens.program2
        it 'returns the appropriate tokens', (done) ->
          scan "#{validScannerPrograms}/program2.deeg", (err, tokens) ->
            expect(tokens).to.eql(expectedTokens2)
            done()
        it 'has no errors', (done) ->
          scan "#{validScannerPrograms}/program2.deeg", (err, tokens) ->
            expect(err).to.be.null
            done()

    describe 'deeg program #3', ->
      context 'when test program3.deeg is passed through the scanner', ->
        expectedTokens3 = outputTokens.program3
        it 'returns the appropriate tokens', (done) ->
          scan "#{validScannerPrograms}/program3.deeg", (err, tokens) ->
            expect(tokens).to.eql(expectedTokens3)
            done()
        it 'has no errors', (done) ->
          scan "#{validScannerPrograms}/program3.deeg", (err, tokens) ->
            expect(err).to.be.null
            done()

    describe 'deeg program #4', ->
      context 'when test program4.deeg is passed through the scanner', ->
        expectedTokens4 = outputTokens.program4
        it 'returns the appropriate tokens', (done) ->
          scan "#{validScannerPrograms}/program4.deeg", (err, tokens) ->
            expect(tokens).to.eql(expectedTokens4)
            done()
        it 'has no errors', (done) ->
          scan "#{validScannerPrograms}/program4.deeg", (err, tokens) ->
            expect(err).to.be.null
            done()

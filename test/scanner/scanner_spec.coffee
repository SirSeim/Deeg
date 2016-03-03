chai = require 'chai'
expect = chai.expect
scan = require "#{__dirname}/../../scanner/scanner"
outputTokens = require "#{__dirname}/expected_output/output_tokens"
validScannerPrograms = "#{__dirname}/input_programs/valid_programs"
invalidScannerPrograms = "#{__dirname}/input_programs/invalid_programs"

describe 'Scanner', ->

  describe 'scanning valid deeg programs', ->
    describe 'deeg program #1', ->
      context 'when test program1.deeg is passed through the scanner', ->
        expectedTokens1 = outputTokens.program1

        scan "#{validScannerPrograms}/program1.deeg", (err, tokens) ->
          it 'returns the appropriate tokens', (done) ->
            expect(tokens).to.eql expectedTokens1
            done()
          it 'has no errors', (done) ->
            expect(err).to.be.null
            done()

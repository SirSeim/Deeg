chai = require 'chai'
expect = chai.expect
fs = require 'fs'
parse = require "#{__dirname}/../../parser/parser.coffee"
scan = require "#{__dirname}/../../scanner/scanner.coffee"
generate = require "#{__dirname}/../../generator/jsgenerator.coffee"
validPrograms = "#{__dirname}/input_programs/valid_programs"
expectedOutput = require "#{__dirname}/expected_output/compiled_output.coffee"


describe 'Generator', ->

  describe 'compiling a valid program', ->
    fs.readdirSync(validPrograms).forEach (name) ->
      context "when #{name} is passed through all the way to generation", ->
        it 'has no errors', (done) ->
          scan "#{validPrograms}/#{name}", (err, tokens) ->
            parse tokens, (err, program) ->
              program.analyze []
              generate program, false, (err, output) ->
                expect(err).to.eql []
                done()
        it 'outputs the correct javascript', (done) ->
          scan "#{validPrograms}/#{name}", (err, tokens) ->
            parse tokens, (err, program) ->
              program.analyze []
              generate program, false, (err, output) ->
                expect(output).to.eql expectedOutput[name.split('.')[0]]
                done()

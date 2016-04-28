chai = require 'chai'
expect = chai.expect
fs = require 'fs'
parse = require "#{__dirname}/../../parser/parser.coffee"
scan = require "#{__dirname}/../../scanner/scanner.coffee"
generate = require "#{__dirname}/../../generator/jsgenerator.coffee"
validGeneratorPrograms = "#{__dirname}/input_programs/valid_programs"
expectedOutput = require "#{__dirname}/expected_output/compiled_output.coffee"


describe 'Generator', ->

  describe 'compiling a valid program', ->
    fs.readdirSync(validGeneratorPrograms).forEach (name) ->
      context "when #{name} is passed through the generator", ->
        it 'outputs the correct javascript', (done) ->
          scan "#{validGeneratorPrograms}/#{name}", (err, tokens) ->
            parse tokens, (err, program) ->
              program.analyze()
              generate program, (err, program) ->
                expect(program).to.eql outputASTs[name.split('.')[0]]
                done()

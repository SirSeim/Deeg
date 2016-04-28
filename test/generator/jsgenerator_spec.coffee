chai = require 'chai'
expect = chai.expect
fs = require 'fs'
parse = require "#{__dirname}/../../parser/parser.coffee"
scan = require "#{__dirname}/../../scanner/scanner.coffee"
generate = require "#{__dirname}/../../generator/jsgenerator.coffee"
validGeneratorPrograms = "#{__dirname}/input_programs/valid_programs"
expectedOutput = require "#{__dirname}/expected_output/compiled_output"



describe 'compiling programs with conditionals', ->
    fs.readdirSync(validGeneratorPrograms).forEach (name) ->
        context "when #{name} is passed through the generator", ->
            it 'outputs the correct javascript', (done) ->
                scan "#{validGeneratorPrograms}/#{name}", (err, tokens) ->
                    program = parse tokens
                    program.analyze()
                    program = generate program
                    expect(program).to.eql expectedOutput.#{name}
                    done()

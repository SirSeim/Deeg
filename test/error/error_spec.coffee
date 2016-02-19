chai = require 'chai'
expect = chai.expect
error = require '../../error/error'

describe 'Error', ->

    describe 'basic error testing', ->
        error_message1 = 'an example error'
        context 'given a message without a location', ->
            it 'successfully creates an error', ->
                expect(error error_message1)
                    .to.have.property('message')
                    .to.equal(error_message1)
        context 'given a message with only an empty location', ->
            it 'successfully creates an error', ->
                expect(error error_message1, {})
                    .to.have.property('message')
                    .to.equal(error_message1)
        context 'given a message with only the line location', ->
            it 'successfully creates an error', ->
                expect(error error_message1, {line:1})
                    .to.have.property('message')
                    .to.equal(error_message1 + ' at line 1')
        context 'given a message with line and col location', ->
            it 'successfully creates an error', ->
                expect(error error_message1, {line:1, col:3})
                    .to.have.property('message')
                    .to.equal(error_message1 + ' at line 1, column 3')

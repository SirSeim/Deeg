#!/usr/bin/env coffee

argv = require 'yargs'
    .usage '$0 [-t] [-a] [-o] [-i] [--target js] filename'
    .boolean ['t','a','o','i']
    .describe 't', 'show tokens after scanning then stop'
    .describe 'a', 'show abstract syntax tree after parsing then stop'
    .describe 'o', 'do optimizations'
    .describe 'i', 'generate and show the intermediate code then stop'
    .describe 'target', 'generate code for JavaScript (more to come later)'
    .default {target:'js'}
    .demand(1)
    .argv

scan = require "#{__dirname}/scanner/scanner.coffee"
parse = require "#{__dirname}/parser/parser.coffee"
generate = require "#{__dirname}/generator/#{argv.target}generator.coffee"

scan argv._[0], (errors, tokens) ->
  return (console.log err for err in errors) if errors.length > 0
  if argv.t
    console.log t for t in tokens
    return

  parse tokens, (errors, program) ->
    return (console.log err for err in errors) if errors.length > 0
    if argv.a
      console.log program.toString()
      return

    analyzeErrors = []
    program.analyze analyzeErrors
    return (console.log err for err in analyzeErrors) if analyzeErrors.length > 0

    generate program, (errors, output) ->
      return (console.log err for err in errors) if errors.length > 0
      console.log output

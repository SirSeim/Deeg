
argv = require 'yargs'
    .usage '$0 [-t] [-a] [-o] [-i] [--target [x86|c|js]] filename'
    .boolean ['t','a','o','i']
    .describe 't', 'show tokens after scanning then stop'
    .describe 'a', 'show abstract syntax tree after parsing then stop'
    .describe 'o', 'do optimizations'
    .describe 'i', 'generate and show the intermediate code then stop'
    .describe 'target', 'generate code for x86, C, or JavaScript'
    .default {target:'js'}
    .demand(1)
    .argv

scan = require './scanner/scanner.coffee'

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

scan = require './scanner/scanner.coffee'

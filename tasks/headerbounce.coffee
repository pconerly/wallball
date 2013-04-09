
"use strict"
module.exports = (grunt) ->

  grunt.registerMultiTask "headerbounce", "Integrate with phantomjs.", ->
    phantomjs = require("grunt-lib-phantomjs").init(grunt)
    errorCount = 0
    
    # Handle any number of namespaced events like so.
    phantomjs.on "headerbounce.ok", (msg) ->
      grunt.log.writeln msg

    phantomjs.on "headerbounce.error", (msg) ->
      errorCount++
      grunt.log.error msg

    
    # Create some kind of "all done" event.
    phantomjs.on "headerbounce.done", ->
      phantomjs.halt()

    
    # Built-in error handlers.
    phantomjs.on "fail.load", (url) ->
      phantomjs.halt()
      grunt.warn "PhantomJS unable to load URL."

    phantomjs.on "fail.timeout", ->
      phantomjs.halt()
      grunt.warn "PhantomJS timed out."

    
    # This task is async.
    done = @async()
    
    console.log this.name
    console.log this.data.url
    console.log "====="
    console.log this.data.options
    newopts = {}
    for k, v of this.data.options
      # newopts[k] = '"' + JSON.stringify(v) + '"'
      if k is '--headers'
        newopts[k] = JSON.stringify(v)
      else
        newopts[k] = v
    console.log newopts
    # Spawn phantomjs
    phantomjs.spawn this.data.url,
      
      # Additional PhantomJS options.

      #TODO peter -- add phjs options from the Gruntfile
      options: newopts
      
      # Complete the task when done.
      done: (err) ->
        done err or errorCount is 0




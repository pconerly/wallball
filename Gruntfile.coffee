module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig
    simplemocha:
      options:
        globals: ["should"]
        timeout: 3000
        ignoreLeaks: false
        ui: "bdd"
        reporter: "tap"

      all:
        src: "test/**/*.coffee"

    watch: # TODO(peter): Make this just re-run the changed file
      files: ["Gruntfile.coffee", "lib/**/*.coffee", "test/**/*.coffee"]
      tasks: ["simplemocha"]

    headerbounce:
      hmm:
        url: 'http://localhost:5000'
        options:
          'headers':
            'HTTP-X-SIGNATURE': '______XXXXXXXXXXXXXXXXXXXXX______'
          timeout: 1000

  grunt.loadTasks('tasks')

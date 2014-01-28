module.exports = (grunt) ->
  'use strict'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    concat:
      dist:
        files:
          'dist/dist.js': ['build/js/*.js']

    coffee:
      dev:
        files: [
          expand: true
          cwd: 'js'
          src: ['**/*.coffee', '!**/_*.coffee']
          dest: 'build/js'
          ext: '.js'
        ]

    stylus:
      dev:
        files: [
          expand: true
          cwd: 'css'
          src: ['**/*.styl', '!**/_*.styl']
          dest: 'build/css'
          ext: '.css'
        ]

    sass:
      dev:
        files: [
          expand: true
          cwd: 'css'
          src: ['**/*.sass', '!**/_*.sass']
          dest: 'build/css'
          ext: '.css'
        ]

    slim:
      dev:
        files: [
          expand: true
          src: ['*.slim', '!_*.slim']
          dest: 'build'
          ext: '.html'
        ]

    watch:
      options:
        livereload: true
        spawn: false

      coffee:
        files: ['js/**/*.coffee']
        tasks: ['coffee:dev']

      stylus:
        files: ['css/**/*.styl']
        tasks: ['stylus:dev']

      sass:
        files: ['css/**/*.sass']
        tasks: ['sass:dev']

      slim:
        files: ['*.slim']
        tasks: ['slim:dev']

    compress:
      dev:
        options:
          archive: 'archive.zip'
        files: [
          expand: true
          cwd: 'build'
          src: ['**']
          dest: 'archive'
        ]

    clean:
      dev: ['build/*']

    connect:
      dev:
        options:
          port: 9999
          host: 'localhost'
          base: 'build'
          livereload: true
          open: true

    copy:
      dev:
        files: [ {
          expand: true
          src: ['js/**/*.js']
          dest: 'build'
        }, {
          expand: true
          src: ['css/**/*.css']
          dest: 'build'
        }, {
          expand: true
          src: ['img/**/*']
          dest: 'build'
        }, {
          expand: true
          src: ['fonts/**/*']
          dest: 'build'
        }
        ]

    open:
      dev:
        path: 'http://0:<%= connect.dev.options.port %>'
        app: 'chrome'

    bower:
      dev:
        options:
          targetDir: 'build'
          layout: 'byType'

    notify:
      watch:
        options:
          title: 'grunt watch'
          message: 'changed'

  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-compress'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-slim'

  grunt.registerTask 'dev', ['copy:dev', 'stylus:dev', 'sass:dev', 'slim:dev']
  grunt.registerTask 'default', ['dev', 'connect', 'watch']

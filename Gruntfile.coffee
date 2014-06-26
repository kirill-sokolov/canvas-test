module.exports = (grunt) ->
  BOWER_JS_FILES = [
    # 'app_frontend/bower_components/underscore/underscore.js'
    'app_frontend/bower_components/jquery/dist/jquery.min.js'
  ]

  ###
  META =                               # Metadata
    basePath: 'app_frontend/',
    srcPath: 'src/',
    deployPath: 'app_frontend/build/',
    root: 'C:/project/s4/',
    www: 'C:/project/s4/web/'
  ###

  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    less:                                 # LESS
      options:
        paths: [
          "app_frontend/bower_components/"
          "app_frontend/less"
        ]
        syncImport: true
      app:
        options:
          sourceMap: true
          sourceMapFilename: "app_frontend/build/css/source-maps/main.less.map"
          sourceMapURL: "/source-maps/main.less.map"
          outputSourceFiles: true
        files:
          "app_frontend/build/css/main.css": "app_frontend/less/main.less"
      fonts:
        files:
          "app_frontend/build/css/fonts.css": "app_frontend/less/fonts.less"

    coffee:                               # COFFEE
      app:
        options:
          sourceMap: true
          sourceMapDir: "app_frontend/build/js/source-maps/"
        files: [{
          expand: true
          flatten: false
          cwd: "app_frontend/coffee"
          src: ["**/*.coffee"]
          dest: "app_frontend/build/js/"
          ext: ".js"
        }]

    shell:
      production_js:
        options:
          stdout: true
        command: 'rm -f app_frontend/build/js/production.js'

    concat:                              # Concatanation
      ie:
        files:
          "app_frontend/build/js/ie/ie.js": [
            #'app_frontend/bower_components/modernizr/modernizr.js'
            #'app_frontend/bower_components/html5shiv/dist/html5shiv.min.js'
            #"app_frontend/bower_components/respond/dest/respond.min.js"
            #"app_frontend/bower_components/matchMedia/matchMedia.js"
            #"app_frontend/bower_components/IE9/index.js"
          ]
      libs:
        files:
          "app_frontend/build/js/libs.js": BOWER_JS_FILES
      app:
        files:
          "app_frontend/build/js/production.js": [
            "app_frontend/build/js/libs.js",  # we need to load libs first
            "app_frontend/build/js/*.js"
          ]
        options:
          globals:
            jQuery: true

    uglify:
      app:
        options:
          mangle: true
          compress:
            dead_code: false
          preserveComments: false
        files: [{
          cwd: 'app_frontend/build/js'
          src: 'production.js'        # src: '*.js'
          dest: 'app_frontend/build/js'
          expand: true
        }]
    jade:
      compile:
        options:
          client: false
          pretty: true
        files: [{
          cwd: "app_frontend/jade"
          src: "*.jade"
          #dest: "app_frontend/build/html"
          dest: ""
          expand: true
          ext: ".html"
        }]

    ###
    jade:
      compile:
        options:
          data:
            debug: false
            pretty: true
        files:
          "app_frontend/build/html/dest.html": ["app_frontend//*.jade"]
    ###


    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-jade'

    grunt.registerTask('dev', 'Build assets for dev mode', [
      'jade:compile', 'less:app', 'coffee:app', 'shell:production_js', 'concat:app'
      # 'all', 'copy:less_source_maps', 'copy:coffee_source_maps', 'shell:assetic_dump'
    ])
    grunt.registerTask('full', 'Build assets for full mode', [
      'jade', 'less', 'coffee',
      'shell:production_js',
      'concat', 'uglify'
    ])

    grunt.registerTask('default', ['dev'])
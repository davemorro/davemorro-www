axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
shell        = require 'shelljs'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
yaml         = require 'roots-yaml'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf', '**/.DS_Store']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl', out: 'css/build.css', minify: true),
    yaml()
  ]
  
  dump_dirs: ['views', 'assets']

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  open_browser: false
  
  before: ->
    shell.exec 'rm -rf public_compressed/'
    #shell.exec 'rm -rf public/'

  after: ->
    shell.exec 'mkdir ./public_compressed'
    shell.exec 'cp -R public/ public_compressed/'
    shell.exec 'gzip -r public_compressed'

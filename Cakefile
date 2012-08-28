fs = require 'fs'
path = require 'path'
coffee = require 'coffee-script'
muffin = require 'muffin'
handlebars = require 'handlebars'

fileOutputTemplates = './webapp/public/templates.js'


compileCoffeeFileSync = (src)->
  code = fs.readFileSync src, 'utf8'
  try
    coffee.compile code, bare: no
  catch e
    console.log e



#option '-w', '--watch', 'continue to watch the files and rebuild them when they change'
arCompiledTemplates = {}
compileHandlebars = (matches) ->
  #console.log matches[0]
  name = path.basename matches.input, '.handlebars'
  data = fs.readFileSync matches.input, 'utf8'
  compiledData = handlebars.precompile data
  arCompiledTemplates[name] = compiledData



task 'build', 'build project', (options) ->
  muffin.run
    files: ['./*/*.coffee', './webapp/templates/client/*.handlebars']
    options: options
    map:
    #'\\.coffee' : (matches) -> console.log matches
    #'\\.js': (matches) -> console.log matches
      '\\.handlebars': compileHandlebars
    after: ->
      output = ";(function() { var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};"

      output += compileCoffeeFileSync './webapp/templates/client/helpers.coffee'

      output += "templates['#{template}'] = template(#{arCompiledTemplates[template]});\n" for template of arCompiledTemplates

      output += "})();"
      fs.writeFileSync fileOutputTemplates, output, 'utf8'
      muffin.minifyScript fileOutputTemplates


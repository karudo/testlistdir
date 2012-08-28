Express = require 'express'
Path = require 'path'

onDownload = (fullpath, cb)-> cb 'override function'
init = (App)->
  App.exp = do Express
  App.server = require('http').createServer(App.exp)

  App.exp.configure ->
    App.exp.set 'views', App.config.rootdir+'/webapp/templates'
    App.exp.set 'view engine', 'hbs'
    ###
    App.exp.use Express.bodyParser()
    App.exp.use Express.methodOverride()
    App.exp.use Express.cookieParser()
    App.exp.use Express.session
      key: App.config.session.key
      secret: App.config.session.secret
      store: App.SessionStore
    ###
    App.exp.use Express.static(App.config.rootdir+'/webapp/public')

    App.exp.set 'log level', 1

  App.exp.get '/', (req, res)-> res.render 'index'

  App.exp.get /\/download(\/.+)/, (req, res)->
    fullpath = Path.join(App.config.listdir, req.params[0])
    onDownload fullpath, (err, allow)-> if not err and allow then res.sendfile fullpath else res.render '404'

  App.server.listen App.config.webserver.port

  httpServer


httpServer =
  init: init
  setOnDownload: (f) ->
    onDownload = f
    httpServer

module.exports = (App)-> httpServer.init App

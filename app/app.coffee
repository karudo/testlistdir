Fs = require 'fs'
Path = require 'path'
Async = require 'async'

App = config: require '../config'

App.config.listdir = Path.normalize(App.config.listdir+'/')

App.start = ->
  httpServer = require('./httpServer')(App)
  wsServer = require('./wsServer')(App)

  httpServer.setOnDownload (path, cb)->
    cb(no, path.indexOf(App.config.listdir) is 0 and Fs.existsSync(path) and Fs.statSync(path).isFile())

  filesMapFunc = (item, cb)->
    Fs.stat item, (err, stats)->
      if err then cb err
      else
        cb no, {file: Path.basename(item), isDir: stats.isDirectory(), size: stats.size or no}

  wsServer.setOnDirList (path, cb)->
    if Array.isArray path then path = Path.join.apply(Path, path)
    fullpath = Path.normalize(App.config.listdir+path)
    if fullpath.indexOf(App.config.listdir) is 0 and Fs.existsSync(fullpath) and Fs.statSync(fullpath).isDirectory()
      Fs.readdir fullpath, (err, files)->
        if err then cb err
        else
          Async.map files.map((f)->Path.join(fullpath, f)), filesMapFunc, (err, res)->
            if err then cb err
            else
              cb no, res.map (f)->
                f.fullname = Path.join(path, f.file).replace(new RegExp('\\\\', 'g'), '/')
                f

    else
      cb 'Invalid dir'


module.exports = App

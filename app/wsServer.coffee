Sio = require 'socket.io'


onDirList = (path, cb)-> cb 'override function'
init = (App)->
  io = Sio.listen(App.server)

  io.sockets.on 'connection', (socket)->
    socket.on 'dirlist', (path, webCallback)->
      onDirList path, (err, list)-> webCallback err, list


  wsServer




wsServer =
  init:init
  setOnDirList: (f)->
    onDirList = f
    wsServer

module.exports = (App)-> wsServer.init App
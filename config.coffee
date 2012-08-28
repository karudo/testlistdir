Path = require 'path'

module.exports =
  rootdir: __dirname

  listdir: __dirname + '/webapp/public'

  webserver:
    port: 3000

  session:
    key: 'express.sid'
    secret: 'my HIDDEN secret key !'







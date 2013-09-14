express = require "express"
app = express()

server = require('http').createServer(app)
io = require('socket.io').listen(server);
app.use(express.static(__dirname + '/'))
exec = require('child_process').exec
bash = require("bash")

server.listen(7001)

io.sockets.on "connection", (socket) ->
  socket.on "client-exec", (code, cb) ->
    console.log "THE CODE IS #{code}"
    escaped = bash.escape(code)
    exec "echo #{escaped} | php", (err, output) ->
      console.log "OUTPUT IS"
      cb err, output
    



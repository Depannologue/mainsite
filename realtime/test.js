var app = require('express')();
var server = require('http').createServer(app);
var io = require('socket.io').listen(server);
server.listen(5001);

io.sockets.on('connection', function (socket) {
  socket.on('location', function (data) {
    console.log(data)
    io.sockets.emit('location', data);
  });
});

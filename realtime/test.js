// initializing express-session middleware
var Session = require('express-session');
var SessionStore = require('session-file-store')(Session);
var session = Session({store: new SessionStore({path: __dirname+'/tmp/sessions'}), secret: 'pass', resave: true, saveUninitialized: true});

// creating new express app
var express = require('express');
var app = express();
var redis = require('redis').createClient();

// attaching express app to HTTP server
var http = require('http');
var server = http.createServer(app);
server.listen('5001'); // start listening

// creating new socket.io app
var ios = require('express-socket.io-session');
var io = require('socket.io')(server);
io.use(ios(session)); // session support

redis.subscribe('rt-change');
io.on('connection', function(socket){
  redis.on('message', function(channel, message){
    console.log('ok')
    socket.emit('rt-change', JSON.parse(message));
  });
  socket.on('new-client', function(data){
    socket.handshake.session.client_id = {socket_id: socket.id, email: data}
    console.log(socket.handshake.session.client_id)
  })
});

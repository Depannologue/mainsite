var socketioJwt = require('socketio-jwt');
var express = require('express');
var app = express();
var http = require('http');

var server = http.createServer(app);
var io = require('socket.io')(server);
server.listen(5002); // start listening
var redis = require('redis').createClient();
redis.subscribe('rt-change');
io
  .on('connection', socketioJwt.authorize({
    secret: Buffer('zXdEAHuBMVQ7nTaweLlsMZdTrBnngWVI7IneyrSickwEo0MPW3pDL_E070_VvDrl', 'base64'),
    timeout: 15000 // 15 seconds to send the authentication message
  })).on('authenticated', function(socket) {
    console.log("new client")
    redis.on('message', function(channel, message){
      socket.emit('rt-change', JSON.parse(message));
    });
  });

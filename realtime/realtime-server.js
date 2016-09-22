
var redis = require('redis').createClient();
var io1 = require('socket.io').listen(5001);
var client = require('socket.io-client');

redis.subscribe('rt-change');

io1.on('connection', function(socket){
  console.log("connected client")
  redis.on('message', function(channel, message){
  
    socket.emit('rt-change', JSON.parse(message));
  });


});

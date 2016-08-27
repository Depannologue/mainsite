
var redis = require('redis').createClient();
var io = require('socket.io').listen(5001);
redis.subscribe('rt-change');

io.on('connection', function(socket){
  redis.on('message', function(channel, message){
    socket.emit('rt-change', JSON.parse(message));
  });
});

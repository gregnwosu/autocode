local async = require 'async'


function onClose(client)
  return
    function()
      client.close()
      interval.clear()
    end
end

function onData(client)
  return
    function(data)
      print('received:',data)
    end
end

function onEnd(client)
  return
    function()
      print('client ended')
     end
end

function onClose(client)
  return
    function()
      print('closed.')
    end
end

function clientOp(client)
  return
    function()
      client.write('test_ontimer')
    end
end

function clientOps(client)
 return
   function(client)
     print('new connection:',client)
     client.ondata(onData(client))
     client.onend(onEnd(client))
     client.onclose(onClose(client))
     client.write('test')
     local interval = async.setInterval(200, clientOp(client))
     async.setTimeout(1000, onClose(client))
  end
end

local client = async.tcp.connect(
'tcp://127.0.0.1:8483/',
clientOps)

async.go()

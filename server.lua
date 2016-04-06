require("torch")
local async = require 'async'

function onEnd(client)
  return
    function()
      print('client ended')
    end
end

function onData(client)
  return
    function(data)
      print('received:',data)
      client.write(data)
    end
end
conn = {host='127.0.0.1', port=8483}

function onClose(client)
  return
    function()
      print('closed.')
      collectgarbage()
      print(collectgarbage("count") * 1024)
    end
end

function callBacksFor(client)
   print('new connection:',client)
   client.ondata(onData(client))
   client.onend(onEnd(client))
   client.onclose(onClose(client))
end


local server = async.tcp.listen(
  conn,
  callBacksFor)

async.repl()
async.go()

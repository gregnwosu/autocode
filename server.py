from epc.server import EPCServer
import sys
# dont think  this is necessary
#orig_dlflags = sys.getdlopenflags()
#sys.setdlopenflags(258)


server = EPCServer(('localhost', 0))

import lupa
#sys.setdlopenflags(orig_dlflags)
lua = lupa.LuaRuntime()
posix_module = lua.require('nn')

@server.register_function
def echo(*a):
    return posix

server.print_port()
server.serve_forever()

require('torch')
require('nn')
require('LanguageModel')


local myServer = {
  echo = function (msg) return msg end,
  average = function(codeSoFar)
    local total=0
    local count=0
    for i=1, table.getn(arg) do
      total = total + arg[i]
      count = count + 1
    end
    return { average= total/count, sum = total, n=count }
  end
}

json.rpcserver.serve(myServer)



function getNextText(startText)
   local cmd = torch.CmdLine()
   local checkpoint = 'cv/checkpoint_4000.t7'
   local length= 2000
   local sample=1
   local temperature=1
   local gpu = 0
   local gpu_backend =cuda
   local verbose=0
   local opt=cmd:parse(arg)
   local checkpoint = torch.load(opt.checkpoint)
   local model = checkpoint.model
   local msg
   if gpu >= 0 and gpu_backend == 'cuda' then
      require 'cutorch'
      require 'cunn'
      cutorch.setDevice(opt.gpu + 1)
      model:cuda()
      msg = string.format('Running with CUDA on GPU %d', opt.gpu)
   elseif gpu >= 0 and gpu_backend == 'opencl' then
      require 'cltorch'
      require 'clnn'
      model:cl()
      msg = string.format('Running with OpenCL on GPU %d', opt.gpu)
   else
      msg = 'Running in CPU mode'
   end
   if opt.verbose == 1 then print(msg) end
   model:evaluate()
   local sample = model:sample(opt)
   print(sample)

   return sample
end

function [newCFR, stack] =  setAutoOSK(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 8, bit, lastCFR);
        
end


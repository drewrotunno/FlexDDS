function [newCFR, stack] =  setManOSK(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 23, bit, lastCFR);
        
end


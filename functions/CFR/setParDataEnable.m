function [newCFR, stack] =  setParDataEnable(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 2, 4, bit, lastCFR);
        
end


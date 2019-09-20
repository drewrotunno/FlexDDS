function [newCFR, stack] =  setLoadARRUpdate(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 10, bit, lastCFR);
        
end


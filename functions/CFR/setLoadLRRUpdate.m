function [newCFR, stack] =  setLoadLRRUpdate(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 15, bit, lastCFR);
        
end


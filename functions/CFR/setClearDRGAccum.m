function [newCFR, stack] =  setClearDRGAccum(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 12, bit, lastCFR);
        
end


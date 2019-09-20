function [newCFR, stack] =  setAutoClearDRGAccum(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 14, bit, lastCFR);
        
end


function [newCFR, stack] =  setAutoClearPhaseAccum(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 13, bit, lastCFR);
        
end


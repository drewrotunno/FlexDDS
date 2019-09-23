function [newCFR, stack] =  setClearPhaseAccum(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 11, bit, lastCFR);
        
end


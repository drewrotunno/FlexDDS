function [newCFR, stack] =  setNoDwellLo(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 2, 17, bit, lastCFR);
        
end


function [newCFR, stack] =  setNoDwellHi(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 2, 18, bit, lastCFR);
        
end


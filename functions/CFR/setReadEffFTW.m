function [newCFR, stack] =  setReadEffFTW(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 2, 16, bit, lastCFR);
        
end


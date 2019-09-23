function [newCFR, stack] =  setIOUpdateRate(stack, chan, bit15, bit14, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 2, 15, bit15, lastCFR);
[newCFR, stack] = setCFRbit(stack, chan, 2, 14, bit14, newCFR);
        
end


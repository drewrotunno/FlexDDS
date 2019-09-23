function [newCFR, stack] =  setRAMPolar(stack, chan, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 30, 1, lastCFR);
[newCFR, stack] = setCFRbit(stack, chan, 1, 29, 1, newCFR);
        
end


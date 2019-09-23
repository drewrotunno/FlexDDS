function [newCFR, stack] =  setRAMPhase(stack, chan, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 1, 30, 0, lastCFR);
[newCFR, stack] = setCFRbit(stack, chan, 1, 29, 1, newCFR);
        
end


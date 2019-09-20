function [newCFR, stack] =  setDataAssHold(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack, chan, 2, 6, bit, lastCFR);
        
end


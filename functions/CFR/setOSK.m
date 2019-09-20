function [newCFR, stack] =  setOSK(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,1,9,bit,lastCFR);
        
end


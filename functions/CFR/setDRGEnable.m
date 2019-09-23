function [newCFR, stack] =  setDRGEnable(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,2,19,bit,lastCFR);
        
end


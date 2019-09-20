function [newCFR, stack] =  setRAMenable(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,1,31,bit,lastCFR);
        
end


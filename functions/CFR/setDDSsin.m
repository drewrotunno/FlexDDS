function [newCFR, stack] =  setDDSsin(stack, chan, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,1,16,1,lastCFR);
        
end


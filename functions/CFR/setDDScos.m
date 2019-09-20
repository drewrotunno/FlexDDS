function [newCFR, stack] =  setDDScos(stack, chan, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,1,16,0,lastCFR);
        
end


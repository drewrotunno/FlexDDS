function [newCFR, stack] =  setDRGFreq(stack, chan, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,2,21,0,lastCFR);
[newCFR, stack] = setCFRbit(stack,chan,2,20,0,newCFR);
        
end


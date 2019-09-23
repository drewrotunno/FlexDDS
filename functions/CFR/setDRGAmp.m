function [newCFR, stack] =  setDRGAmp(stack, chan, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,2,21,1,lastCFR);
[newCFR, stack] = setCFRbit(stack,chan,2,20,0,newCFR);
        
end


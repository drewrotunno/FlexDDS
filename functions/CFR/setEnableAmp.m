function [newCFR, stack] =  setEnableAmp(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,2,24,bit,lastCFR);

end


function [newCFR, stack] =  setAutoClearPhase(stack, chan, bit, lastCFR)

[newCFR, stack] = setCFRbit(stack,chan,1,13,bit,lastCFR);

end


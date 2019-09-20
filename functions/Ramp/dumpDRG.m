function [newCFR, stack] = dumpDRG(stack,lastCFR)

[intCFR, stack] = setCFRbit(stack,2,1,12,1,lastCFR);

[newCFR, stack] = setCFRbit(stack,2,1,12,0,intCFR);

end


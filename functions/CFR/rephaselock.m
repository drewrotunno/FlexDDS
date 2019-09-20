function [newCFR, stack] = rephaselock(stack,lastCFR)

[intCFR, stack] = setCFRbit(stack,2,1,11,1,lastCFR);

[newCFR, stack] = setCFRbit(stack,2,1,11,0,intCFR);

end


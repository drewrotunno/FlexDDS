function [newCFR, stack] = rephaselock(stack,lastCFR)

[intCFR, stack] = setCFRbit(stack,2,1,11,1,lastCFR);
% stack = waitforRackA(stack,2);
[newCFR, stack] = setCFRbit(stack,2,1,11,0,intCFR);

end


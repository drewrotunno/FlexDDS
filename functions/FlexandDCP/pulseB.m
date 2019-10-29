function stack = pulseB(stack, time)
%PULSEA Summary of this function goes here

stack = setSlotBNCBhigh(stack);
stack = waitns(stack,0,time);
stack = setSlotBNCBlow(stack);

end


function stack = pulseA(stack, time)
%PULSEA Summary of this function goes here

stack = setSlotBNCAhigh(stack);
stack = waitns(stack,0,time);
stack = setSlotBNCAlow(stack)

end


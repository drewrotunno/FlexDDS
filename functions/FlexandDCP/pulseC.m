function stack = pulseC(stack, time)
%PULSEA Summary of this function goes here

stack = setSlotBNCChigh(stack);
stack = waitns(stack,0,time);
stack = setSlotBNCClow(stack);

end


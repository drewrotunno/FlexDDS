function pulseA(t, time)
%PULSEA Summary of this function goes here

setSlotBNCAhigh(t)
waitns(t,0,time)
setSlotBNCAlow(t)

end


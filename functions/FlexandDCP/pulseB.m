function pulseB(t, time)
%PULSEA Summary of this function goes here

setSlotBNCBhigh(t)
waitns(t,0,time)
setSlotBNCBlow(t)

end


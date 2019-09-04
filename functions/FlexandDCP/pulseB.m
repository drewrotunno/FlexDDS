function pulseB(t, time)
%PULSEA Summary of this function goes here

setSlotBNCBhigh(t)
waitns(t,0,100)
setSlotBNCBlow(t)

end


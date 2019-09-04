function pulseC(t, time)
%PULSEA Summary of this function goes here

setSlotBNCChigh(t)
waitns(t,0,time)
setSlotBNCClow(t)

end


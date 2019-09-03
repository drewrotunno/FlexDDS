function setSlotBNCAhigh(t)
%ENABLESLOTBNCAOUT Summary of this function goes here
%   Detailed explanation goes here
flexsnd(t,'dcp 0 wr:CFG_BNC_A=+0x100')

end


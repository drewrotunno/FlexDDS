function disableSlotBNCCout(t)
%ENABLESLOTBNCAOUT Summary of this function goes here
%   Detailed explanation goes here
flexsnd(t,'dcp 0 wr:CFG_BNC_C=-0x200')

end


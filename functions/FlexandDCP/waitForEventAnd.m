function stack = waitForEventAnd(stack, chan, event1, event2)

switch chan
    case 0
        stack = flexstack(stack, ['dcp 0 wait::', num2str(event1), '&', num2str(event2)]);
    case 1 
        stack = flexstack(stack, ['dcp 1 wait::', num2str(event1), '&', num2str(event2)]);
    case 2
        stack = flexstack(stack, ['dcp wait::', num2str(event1), '&', num2str(event2)]);
end
end
%% Events:
%   0           No Event
%   2           All SPI FIFOs Flushed
%   3           BNC IN A RISING
%   4           BNC IN A FALLING
%   5           BNC IN A LEVEL
%   6,7,8       BNC IN B ...
%   9,10,11     BNC IN C ...
%   15          BP TRIG A
%   16          BP TRIG B
%   same(other) channel
%   32(48)      SPI FIFO FLUSHED
%   33(49)      SPI FIFO EV0
%   34(50)      SPI FIFO EV1
%   35(51)      DROVER
%   36(52)      RAM SWP OVER


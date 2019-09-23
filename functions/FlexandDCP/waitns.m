function stack = waitns(stack, chan, time)
% wait in multiples of 8 ns

timestr = num2str(min(16777215,round(time/8)));

switch chan
    case 0
        stack = flexstack(stack, ['dcp 0 wait:',timestr,'h:']);
    case 1 
        stack = flexstack(stack, ['dcp 1 wait:',timestr,'h:']);
    case 2
        stack = flexstack(stack, ['dcp wait:',timestr,'h:']);
end

end


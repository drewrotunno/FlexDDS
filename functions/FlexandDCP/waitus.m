function stack = waitus(stack, chan, time)
%WAITFORRACKA Wait for slot triggers - events from Wieser Manual

timestr = num2str(min(16777215,round(time/1.024)));

switch chan
    case 0
        stack = flexstack(stack, ['dcp 0 wait:',timestr,':']);

    case 1 
        stack = flexstack(stack, ['dcp 1 wait:',timestr,':']);

    case 2
        stack = flexstack(stack, ['dcp wait:',timestr,':']);

end


end


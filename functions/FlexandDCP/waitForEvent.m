function stack = waitForEvent(stack, chan, eventno)
%WAITFORRACKA Wait for slot triggers - events from Wieser Manual

switch chan
    case 0
        stack = flexstack(stack, ['dcp 0 wait::', num2str(eventno)]);
        stack = flexstack(stack, 'dcp 0 update:u');
    case 1 
        stack = flexstack(stack, ['dcp 1 wait::', num2str(eventno)]);
        stack = flexstack(stack, 'dcp 1 update:u');
    case 2
        stack = flexstack(stack, ['dcp wait::', num2str(eventno)]);
        stack = flexstack(stack, 'dcp update:u');
end


end


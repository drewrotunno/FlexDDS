function stack = waitforRackB(stack, chan)
%WAITFORRACKA Wait for B trigger then update
% 16 is rack trigger B. 

switch chan
    case 0
        stack = flexstack(stack, 'dcp 0 wait::16');
        stack = flexstack(stack, 'dcp 0 update:u');
    case 1 
        stack = flexstack(stack, 'dcp 1 wait::16');
        stack = flexstack(stack, 'dcp 1 update:u');
    case 2
        stack = flexstack(stack, 'dcp wait::16');
        stack = flexstack(stack, 'dcp update:u');
end


end


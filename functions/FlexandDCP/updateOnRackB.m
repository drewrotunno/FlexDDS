function stack = updateOnRackB(stack, chan)
% Wait for B trigger then update
% 16 is rack trigger B. 

switch chan
    case 0
        stack = flexstack(stack, 'dcp 0 wait::16:u');
    case 1 
        stack = flexstack(stack, 'dcp 1 wait::16:u');
    case 2
        stack = flexstack(stack, 'dcp wait::16:u');
end


end


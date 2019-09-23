function stack = updateOnRackA(stack, chan)
% Wait for A trigger then update
% 15 is rack trigger A. 

switch chan
    case 0
        stack = flexstack(stack, 'dcp 0 wait::15:u');
    case 1 
        stack = flexstack(stack, 'dcp 1 wait::15:u');
    case 2
        stack = flexstack(stack, 'dcp wait::15:u');
end

end


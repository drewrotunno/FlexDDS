function stack = togglehold(stack, chan)

switch chan
    case 0 
        stack = flexstack(stack, 'dcp 0 update:^h');
    case 1
        stack = flexstack(stack, 'dcp 1 update:^h');
    case 2
        stack = flexstack(stack, 'dcp update:^h');
end


end


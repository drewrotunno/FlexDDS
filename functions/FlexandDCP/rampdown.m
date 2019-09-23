function stack = rampdown(stack, chan)

switch chan
    case 0 
        stack = flexstack(stack, 'dcp 0 update:-d');
    case 1
        stack = flexstack(stack, 'dcp 1 update:-d');
    case 2
        stack = flexstack(stack, 'dcp update:-d');
end

end


function stack = lastprof(stack, chan)
% increment single tone profile number

switch chan
    case 2
        stack = flexstack(stack,'dcp update:-p');
    case 1
        stack = flexstack(stack,'dcp 1 update:-p');
    case 0
        stack = flexstack(stack,'dcp 0 update:-p');
end

end


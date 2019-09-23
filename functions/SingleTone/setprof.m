function stack = setprof(stack, chan, N)
% change to selected single tone profile


switch chan
    case 2
        stack = flexstack(stack,['dcp update:=',num2str(N),'p']);
    case 1
        stack = flexstack(stack,['dcp 1 update:=',num2str(N),'p']);
    case 0
        stack = flexstack(stack,['dcp 0 update:=',num2str(N),'p']);
end

end


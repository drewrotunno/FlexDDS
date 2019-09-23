function stack = flexstack(stack, command)

%tack that sucker on after the last entry
stack{end+1} = command;

end


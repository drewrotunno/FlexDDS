function stack = flexupdateboth(stack)

% stack = waitForEvent(stack,2,2);
% stack = waitForEvent(stack,0,48);
% stack = waitForEvent(stack,1,48);
% stack = waitforRackA(stack,2);
stack = flexstack(stack,'dcp update:u');

end
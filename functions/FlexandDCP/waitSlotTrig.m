function stack = waitSlotTrig(stack, chan, abc, rfl)
%WAITFORRACKA Wait for slot triggers
% in put numbers for abc, risefalllev
% abc - > 1=a, 2=b, 3=c
% rfl- > 1=rise, 2=falling, 3=level

if abc < 0 || abc > 3 ; disp('abc out of bounds'); return; end
if rfl < 0 || rfl > 3 ; disp('rfl out of bounds'); return; end

trigs = [[3,4,5];[6,7,8];[9,10,11]];

switch chan
    case 0
        stack = flexstack(stack, ['dcp 0 wait::', num2str(trigs(abc,rfl))]);
%         stack = flexstack(stack, 'dcp 0 update:u');
    case 1 
        stack = flexstack(stack, ['dcp 1 wait::', num2str(trigs(abc,rfl))]);
%         stack = flexstack(stack, 'dcp 1 update:u');
    case 2
        stack = flexstack(stack, ['dcp wait::', num2str(trigs(abc,rfl))]);
%         stack = flexstack(stack, 'dcp update:u');
end


end


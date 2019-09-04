function waitforRackB(t, chan)
%WAITFORRACKA Wait for B trigger then update
% 16 is rack trigger B. 

switch chan
    case 0
        flexsnd(t, 'dcp 0 wait::16');
        flexsnd(t, 'dcp 0 update:u');
    case 1 
        flexsnd(t, 'dcp 1 wait::16');
        flexsnd(t, 'dcp 1 update:u');
    case 2
        flexsnd(t, 'dcp wait::16');
        flexsnd(t, 'dcp update:u');
end


end


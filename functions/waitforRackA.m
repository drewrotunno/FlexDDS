function waitforRackA(t, chan)
%WAITFORRACKA Wait for A trigger then update
% 15 is rack trigger A. 

switch chan
    case 0
        flexsnd(t, 'dcp 0 wait::15');
%         flexsnd(t, 'dcp 0 update:u');
    case 1 
        flexsnd(t, 'dcp 1 wait::15');
%         flexsnd(t, 'dcp 1 update:u');
    case 2
        flexsnd(t, 'dcp wait::15');
%         flexsnd(t, 'dcp update:u');
end


end


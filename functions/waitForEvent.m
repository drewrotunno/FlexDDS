function waitForEvent(t, chan, eventno)
%WAITFORRACKA Wait for slot triggers - events from Wieser Manual

switch chan
    case 0
        flexsnd(t, ['dcp 0 wait::', num2str(eventno)]);
        flexsnd(t, 'dcp 0 update:u');
    case 1 
        flexsnd(t, ['dcp 1 wait::', num2str(eventno)]);
        flexsnd(t, 'dcp 1 update:u');
    case 2
        flexsnd(t, ['dcp wait::', num2str(eventno)]);
        flexsnd(t, 'dcp update:u');
end


end


function waitus(t, chan, time)
%WAITFORRACKA Wait for slot triggers - events from Wieser Manual

timestr = num2str(min(16777215,round(time/8)));

switch chan
    case 0
        flexsnd(t, ['dcp 0 wait:',timestr,'h:']);

    case 1 
        flexsnd(t, ['dcp 1 wait:',timestr,'h:']);

    case 2
        flexsnd(t, ['dcp wait:',timestr,'h:']);

end


end


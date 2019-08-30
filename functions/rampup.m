function rampup(t, chan)

switch chan
    case 0 
        flexsnd(t, 'dcp 0 update:+d');
    case 1
        flexsnd(t, 'dcp 1 update:+d');
    case 2
        flexsnd(t, 'dcp update:+d');
end


end


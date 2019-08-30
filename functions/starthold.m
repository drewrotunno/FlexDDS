function starthold(t, chan)

switch chan
    case 0 
        flexsnd(t, 'dcp 0 update:+h');
    case 1
        flexsnd(t, 'dcp 1 update:+h');
    case 2
        flexsnd(t, 'dcp update:+h');
end


end


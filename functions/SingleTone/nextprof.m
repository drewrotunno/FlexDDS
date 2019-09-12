function nextprof(t, chan)
% increment single tone profile number

switch chan
    case 2
        flexsnd(t,'dcp update:+p');
    case 1
        flexsnd(t,'dcp 1 update:+p');
    case 0
        flexsnd(t,'dcp 0 update:+p');
end
% 
% while(~t.BytesAvailable)    
%     % wait for ok's
% end
% 
% % get those OK's
% flexlst(t);

end


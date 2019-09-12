function setprof(t, chan, N)
% change to selected single tone profile


switch chan
    case 2
        flexsnd(t,['dcp update:=',num2str(N),'p']);
    case 1
        flexsnd(t,['dcp 1 update:=',num2str(N),'p']);
    case 0
        flexsnd(t,['dcp 0 update:=',num2str(N),'p']);
end
% 
% while(~t.BytesAvailable)    
%     % wait for ok's
% end
% 
% % get those OK's
% flexlst(t);

end


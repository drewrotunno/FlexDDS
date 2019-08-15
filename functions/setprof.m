function setprof(t, N)
% change to selected single tone profile

flexsnd(t,['dcp update:=',num2str(N),'p']);

while(~t.BytesAvailable)    
    % wait for ok's
end

% get those OK's
flexlst(t);

end

